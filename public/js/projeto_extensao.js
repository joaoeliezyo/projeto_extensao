let cursosData = [];

function setCursosData(data) {
  cursosData = Array.isArray(data) ? data : [];
}

let geradorIdBloco = 1;
function adicionarBlocoCurso() {
  const id = Date.now() + '-' + geradorIdBloco++;

const selecionados = Array.from(
  document.querySelectorAll('.bloco-curso select')
).map(select => select.value).filter(Boolean);

const cursosDisponiveis = cursosData.filter(curso => {
  return !selecionados.includes(String(curso.id));
});

if (cursosDisponiveis.length === 0) {
  alert('Todos os cursos já foram adicionados.');
  return;
}

const options = cursosDisponiveis.map(curso => `
  <option value="${curso.id}">${curso.nome}</option>
`).join('');

  const html = `
    <div class="border rounded p-3 mb-3 bloco-curso" id="bloco-${id}">
      <div class="d-flex justify-content-between align-items-center mb-2">
        <strong style="font-size:0.875rem"><i class="bi bi-mortarboard"></i> Curso</strong>
        <button type="button" class="btn btn-sm btn-outline-danger" style="font-size:0.688rem; padding:2px 8px" onclick="removerBlocoCurso('${id}')">
          <i class="bi bi-x-lg"></i> Remover
        </button>
      </div>

      <div class="mb-3">
        <select class="form-select" onchange="selecionarCurso('${id}', this.value)">
          <option value="">Selecione o curso</option>
          ${options}
        </select>
      </div>

      <div id="area-coord-${id}" class="d-none" style="background:#e8f3ec; border:1px solid #b6dfc4; border-radius:8px; padding:8px 12px; margin-bottom:12px; font-size:0.813rem"></div>

      <!-- Resumo dos selecionados (visível quando lista está fechada) -->
      <div id="resumo-profs-${id}" style="display:none"></div>

      <!-- Lista de seleção (colapsável) -->
      <div id="lista-profs-${id}" class="mt-2"></div>
    </div>
  `;

  const container = document.getElementById('lista-global-cursos');
  if (container) {
    container.insertAdjacentHTML('beforeend', html);
  }
}

function removerBlocoCurso(id) {
  const bloco = document.getElementById(`bloco-${id}`);
  if (bloco) {
    bloco.remove();
    recalcularSomaCargaHoraria();
  }
}

function filtrarProfessoresPorPeriodo(blocoId, periodo) {
  const containerContador = document.querySelector(`#bloco-${blocoId} .container-contador-${blocoId}`);
  const containerConfirmar = document.querySelector(`#bloco-${blocoId} .container-confirmar-${blocoId}`);
  const chipsContainer = document.getElementById(`chips-container-${blocoId}`);
  
  if (!chipsContainer) return;

  const chips = chipsContainer.querySelectorAll('.prof-chip');
  
  if (!periodo) {
    if (containerContador) containerContador.setAttribute('style', 'display: none !important');
    if (containerConfirmar) containerConfirmar.setAttribute('style', 'display: none !important');
    chips.forEach(chip => {
      chip.style.display = 'none';
    });
    return;
  }

  if (containerContador) containerContador.setAttribute('style', 'display: flex !important');
  if (containerConfirmar) containerConfirmar.setAttribute('style', 'display: block !important');

  chips.forEach(chip => {
    const chipPeriodo = chip.getAttribute('data-periodo');
    if (chipPeriodo === periodo) {
      chip.style.display = 'inline-flex';
    } else {
      chip.style.display = 'none';
    }
  });
}

function selecionarCurso(id, cursoId) {
  const curso = cursosData.find(c => String(c.id) === String(cursoId));
  const areaCoord = document.getElementById(`area-coord-${id}`);
  const listaProfs = document.getElementById(`lista-profs-${id}`);
  const resumoProfs = document.getElementById(`resumo-profs-${id}`);

  if (!areaCoord || !listaProfs || !resumoProfs) return;

  if (!curso) {
    areaCoord.classList.add('d-none');
    areaCoord.innerHTML = '';
    listaProfs.innerHTML = '';
    resumoProfs.style.display = 'none';
    resumoProfs.innerHTML = '';
    return;
  }

  areaCoord.innerHTML = curso.coordenador
    ? `<i class="bi bi-person-badge" style="color:#1c6e36"></i> <strong>Coordenador:</strong> ${curso.coordenador.nome}`
    : `<i class="bi bi-person-badge" style="color:#9ca3af"></i> <strong>Coordenador:</strong> <span class="text-muted">Não definido</span>`;
  areaCoord.classList.remove('d-none');

  if (!Array.isArray(curso.professores) || curso.professores.length === 0) {
    listaProfs.innerHTML = `<p class="text-muted mb-0" style="font-size:0.75rem"><i class="bi bi-info-circle"></i> Nenhum professor vinculado a este curso.</p>`;
    resumoProfs.style.display = 'none';
    return;
  }

  // Extrai períodos letivos únicos dos professores deste curso
  const periods = [...new Set(curso.professores.map(p => p.periodo_letivo).filter(Boolean))]
    .sort((a, b) => b.localeCompare(a));

  const periodOptions = periods.map(p => `<option value="${p}">${p}</option>`).join('');

  // Render the selectable list with a Periodo Letivo select dropdown (starts visible)
  listaProfs.innerHTML = `
    <div style="border:1px solid #e5e7eb; border-radius:8px; padding:12px; background:#fafbfc">
      <!-- Select do Período Letivo -->
      <div class="mb-3">
        <label class="form-label fw-semibold" style="font-size:0.75rem; color:#374151" for="periodo_${id}">
          <i class="bi bi-calendar-event"></i> Período Letivo da Disciplina
        </label>
        <select class="form-select form-select-sm" id="periodo_${id}" onchange="filtrarProfessoresPorPeriodo('${id}', this.value)" style="font-size:0.813rem">
          <option value="">-- Selecione o Período Letivo --</option>
          ${periodOptions}
        </select>
      </div>

      <div class="d-flex justify-content-between align-items-center mb-2 container-contador-${id}" style="display:none !important">
        <span style="font-size:0.75rem; font-weight:600; color:#374151">
          <i class="bi bi-people"></i> Selecione os professores
        </span>
        <span class="text-muted" style="font-size:0.688rem" id="contador-${id}">0 selecionado(s)</span>
      </div>
      
      <!-- Container dos Chips -->
      <div style="display:flex; flex-wrap:wrap; gap:6px;" id="chips-container-${id}">
        ${curso.professores.map(prof => `
          <label class="prof-chip" for="prof_${id}_${prof.id_pessoa}" data-periodo="${prof.periodo_letivo}" style="
            display:none; align-items:center; gap:6px;
            padding:6px 12px; border-radius:20px;
            border:1.5px solid #d1d5db; background:#fff;
            font-size:0.813rem; cursor:pointer;
            transition:all 0.15s ease; user-select:none;
          ">
            <input class="form-check-input" type="checkbox" value="${prof.id_pessoa}" id="prof_${id}_${prof.id_pessoa}"
              data-nome="${prof.nome}" style="width:14px; height:14px; margin:0; flex-shrink:0"
              onchange="toggleProfChip(this, '${id}')">
            <span>${prof.nome}</span>
          </label>
        `).join('')}
      </div>

      <div style="margin-top:10px; text-align:right; display:none !important" class="container-confirmar-${id}">
        <button type="button" class="btn btn-sm btn-primary" style="font-size:0.688rem; padding:4px 14px; border-radius:6px" onclick="confirmarProfessores('${id}')">
          <i class="bi bi-check-lg"></i> Confirmar
        </button>
      </div>
    </div>
  `;

  resumoProfs.style.display = 'none';
  resumoProfs.innerHTML = '';
}

function toggleProfChip(checkbox, blocoId) {
  const chip = checkbox.closest('.prof-chip');
  if (!chip) return;

  if (checkbox.checked) {
    chip.style.borderColor = '#1c6e36';
    chip.style.background = '#e8f3ec';
    chip.style.fontWeight = '600';
  } else {
    chip.style.borderColor = '#d1d5db';
    chip.style.background = '#fff';
    chip.style.fontWeight = 'normal';
  }

  // Update counter
  const bloco = document.getElementById(`bloco-${blocoId}`);
  if (bloco) {
    const total = bloco.querySelectorAll('input.form-check-input:checked').length;
    const contador = document.getElementById(`contador-${blocoId}`);
    if (contador) {
      contador.textContent = total + ' selecionado(s)';
      contador.style.color = total > 0 ? '#1c6e36' : '';
      contador.style.fontWeight = total > 0 ? '600' : '';
    }
  }
}

function escapeHtml(str) {
  if (!str) return '';
  return String(str)
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&#039;");
}

function updateProfDados(blocoId, profId, campo, valor) {
  const input = document.getElementById(`prof_${blocoId}_${profId}`);
  if (input) {
    input.setAttribute(`data-${campo}`, valor);
    if (campo === 'cargahoraria') {
      recalcularSomaCargaHoraria();
    }
  }
}

function confirmarProfessores(id) {
  const listaProfs = document.getElementById(`lista-profs-${id}`);
  const resumoProfs = document.getElementById(`resumo-profs-${id}`);
  if (!listaProfs || !resumoProfs) return;

  const checks = listaProfs.querySelectorAll('input.form-check-input:checked');
  const selecionados = Array.from(checks).map(cb => {
    const nomeCompleto = cb.getAttribute('data-nome') || '';
    const idx = nomeCompleto.indexOf(' - ');
    const profNome = idx !== -1 ? nomeCompleto.substring(0, idx).trim() : nomeCompleto;
    
    let disciplinaPadrao = '';
    if (idx !== -1) {
      disciplinaPadrao = nomeCompleto.substring(idx + 3).trim();
    }
    
    const disciplina = cb.getAttribute('data-disciplina') || disciplinaPadrao;
    
    // Salva de volta no checkbox para persistência e envio
    if (!cb.getAttribute('data-disciplina')) {
      cb.setAttribute('data-disciplina', disciplina);
    }

    return {
      id: cb.value,
      nome: profNome,
      disciplina: disciplina,
      cargahoraria: cb.getAttribute('data-cargahoraria') || 0
    };
  });

  // Hide the full list
  listaProfs.style.display = 'none';

  // Build summary with tags + edit button
  if (selecionados.length === 0) {
    resumoProfs.innerHTML = `
      <div style="border:1px solid #e5e7eb; border-radius:8px; padding:10px 12px; background:#fafbfc; display:flex; justify-content:space-between; align-items:center">
        <span style="font-size:0.75rem; color:#9ca3af"><i class="bi bi-person-x"></i> Nenhum professor selecionado</span>
        <button type="button" class="btn btn-sm btn-outline-primary" style="font-size:0.688rem; padding:2px 10px; border-radius:6px" onclick="editarProfessores('${id}')">
          <i class="bi bi-pencil"></i> Editar
        </button>
      </div>
    `;
  } else {
    const rows = selecionados.map(p => {
      const discVal = p.disciplina || '';
      const chVal = p.cargahoraria || 0;
      return `
        <div style="display:flex; flex-wrap:wrap; align-items:center; justify-content:space-between; gap:10px; padding:8px 0; border-bottom:1px solid #f3f4f6">
          <div style="flex:1; min-width:200px; display:flex; align-items:center; gap:6px;">
            <i class="bi bi-person-check-fill" style="color:#1c6e36; font-size:0.875rem"></i>
            <span style="font-size:0.813rem; font-weight:600; color:#1f2937">${p.nome}</span>
          </div>
          <div style="display:flex; gap:10px; flex-wrap:wrap; align-items:center;">
            <div style="display:flex; align-items:center; gap:4px;">
              <span style="font-size:0.75rem; color:#4b5563">Disciplina:</span>
              <input type="text" class="form-control form-control-sm" style="width:160px; font-size:0.75rem; padding:2px 6px" 
                value="${escapeHtml(discVal)}" placeholder="Ex: Estatística" 
                oninput="updateProfDados('${id}', '${p.id}', 'disciplina', this.value)">
            </div>
            <div style="display:flex; align-items:center; gap:4px;">
              <span style="font-size:0.75rem; color:#4b5563">Qtd Horas:</span>
              <input type="number" class="form-control form-control-sm" style="width:70px; font-size:0.75rem; padding:2px 6px" 
                value="${chVal}" min="0" placeholder="0" 
                oninput="updateProfDados('${id}', '${p.id}', 'cargahoraria', this.value)">
            </div>
          </div>
        </div>
      `;
    }).join('');

    resumoProfs.innerHTML = `
      <div style="border:1px solid #e5e7eb; border-radius:8px; padding:12px; background:#fafbfc">
        <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:12px; border-bottom:1.5px solid #e5e7eb; padding-bottom:8px">
          <span style="font-size:0.813rem; font-weight:700; color:#374151">
            <i class="bi bi-people-fill" style="color:#1c6e36"></i> Equipe Docente Selecionada (${selecionados.length})
          </span>
          <button type="button" class="btn btn-sm btn-outline-primary" style="font-size:0.688rem; padding:2px 10px; border-radius:6px" onclick="editarProfessores('${id}')">
            <i class="bi bi-pencil"></i> Editar Seleção
          </button>
        </div>
        <div style="display:flex; flex-direction:column; gap:4px">${rows}</div>
      </div>
    `;
  }

  resumoProfs.style.display = 'block';
  recalcularSomaCargaHoraria();
}

function editarProfessores(id) {
  const listaProfs = document.getElementById(`lista-profs-${id}`);
  const resumoProfs = document.getElementById(`resumo-profs-${id}`);
  if (!listaProfs || !resumoProfs) return;

  resumoProfs.style.display = 'none';
  listaProfs.style.display = 'block';
}

function recalcularSomaCargaHoraria() {
  const inputs = document.querySelectorAll('.bloco-curso input.form-check-input:checked');
  let total = 0;
  inputs.forEach(input => {
    total += parseInt(input.getAttribute('data-cargahoraria')) || 0;
  });
  const campoCH = document.getElementById('campo-ch');
  if (campoCH) {
    campoCH.value = total;
  }
}

function prepararEnvio() {
  const blocos = document.querySelectorAll('.bloco-curso');
  const resultado = [];

  blocos.forEach(bloco => {
    const select = bloco.querySelector('select');
    const cursoId = select ? select.value : '';
    if (!cursoId) return;

    const professores = Array.from(
      bloco.querySelectorAll('input.form-check-input:checked')
    ).map(input => ({
      id_pessoa: input.value,
      disciplina: input.getAttribute('data-disciplina') || '',
      cargahoraria: parseInt(input.getAttribute('data-cargahoraria')) || 0
    }));

    resultado.push({ cursoId, professores });
  });

  const hidden = document.getElementById('dadosCursos');
  if (hidden) {
    hidden.value = JSON.stringify(resultado);
  }
}

let arquivosSelecionados = [];
const MAX_TOTAL_ANEXOS = 20;
const MAX_SIZE_ANEXO = 10 * 1024 * 1024;

function formatSize(bytes) {
  if (bytes < 1024) return bytes + " B";
  if (bytes < 1024 * 1024) return (bytes / 1024).toFixed(1) + " KB";
  return (bytes / (1024 * 1024)).toFixed(2) + " MB";
}

function sincronizarInputArquivos() {
  const fileInput = document.getElementById('fileInput');
  if (!fileInput) return;

  const dataTransfer = new DataTransfer();
  arquivosSelecionados.forEach(file => dataTransfer.items.add(file));
  fileInput.files = dataTransfer.files;
}

function renderArquivos() {
  const fileList = document.getElementById('fileList');
  const totalCounter = document.getElementById('totalCounter');

  if (!fileList || !totalCounter) return;

  fileList.innerHTML = '';

  if (arquivosSelecionados.length === 0) {
    totalCounter.textContent = 'Nenhum arquivo';
    fileList.innerHTML = `
      <li class="list-group-item text-muted" style="font-size:0.8rem">
        Nenhum arquivo adicionado.
      </li>
    `;
    return;
  }

  totalCounter.textContent = `${arquivosSelecionados.length} arquivo(s)`;

  arquivosSelecionados.forEach((arquivo, index) => {
    const li = document.createElement('li');
    li.className = 'list-group-item d-flex justify-content-between align-items-center anexo-item';
    li.innerHTML = `
      <div class="d-flex flex-column">
        <span class="anexo-name" title="${arquivo.name}">${arquivo.name}</span>
        <span class="anexo-size">${formatSize(arquivo.size)}</span>
      </div>
      <button type="button" class="anexo-remove" onclick="removerAnexo(${index})" title="Remover">
        <i class="bi bi-trash"></i>
      </button>
    `;
    fileList.appendChild(li);
  });
}

function adicionarArquivos(files) {
  for (const file of files) {
    if (arquivosSelecionados.length >= MAX_TOTAL_ANEXOS) {
      alert(`Máximo de ${MAX_TOTAL_ANEXOS} anexos atingido.`);
      break;
    }

    if (file.size > MAX_SIZE_ANEXO) {
      alert(`O arquivo "${file.name}" excede 10 MB.`);
      continue;
    }

    const duplicado = arquivosSelecionados.some(
      f => f.name === file.name && f.size === file.size && f.lastModified === file.lastModified
    );

    if (duplicado) continue;

    arquivosSelecionados.push(file);
  }

  sincronizarInputArquivos();
  renderArquivos();
}

function removerAnexo(index) {
  arquivosSelecionados.splice(index, 1);
  sincronizarInputArquivos();
  renderArquivos();
}

function limparAnexos() {
  arquivosSelecionados = [];
  sincronizarInputArquivos();
  renderArquivos();
}

function inicializarAnexos() {
  const fileInput = document.getElementById('fileInput');
  const btnAddFile = document.getElementById('btnAddFile');
  const btnClearFiles = document.getElementById('btnClearFiles');

  if (!fileInput || !btnAddFile || !btnClearFiles) return;

  btnAddFile.addEventListener('click', () => {
    fileInput.click();
  });

  fileInput.addEventListener('change', (e) => {
    adicionarArquivos(e.target.files);
  });

  btnClearFiles.addEventListener('click', () => {
    limparAnexos();
  });

  renderArquivos();
}

document.addEventListener('DOMContentLoaded', function () {
  const el = document.getElementById('cursos-data');
  if (el) {
    try {
      setCursosData(JSON.parse(el.textContent));
    } catch (error) {
      console.error('Erro ao carregar cursosData:', error);
      setCursosData([]);
    }
  }

  window.adicionarBlocoCurso = adicionarBlocoCurso;
  window.removerBlocoCurso = removerBlocoCurso;
  window.selecionarCurso = selecionarCurso;
  window.prepararEnvio = prepararEnvio;
  window.toggleProfChip = toggleProfChip;
  window.confirmarProfessores = confirmarProfessores;
  window.editarProfessores = editarProfessores;
  window.removerAnexo = removerAnexo;
  window.updateProfDados = updateProfDados;
  window.filtrarProfessoresPorPeriodo = filtrarProfessoresPorPeriodo;
  window.recalcularSomaCargaHoraria = recalcularSomaCargaHoraria;
  
  inicializarAnexos();

  const preSelecionadosEl = document.getElementById('cursos-selecionados-data');
  if (preSelecionadosEl) {
    try {
      const preData = JSON.parse(preSelecionadosEl.textContent);
      if (Array.isArray(preData) && preData.length > 0) {
        preData.forEach(item => {
          adicionarBlocoCurso();

          const blocos = document.querySelectorAll('.bloco-curso');
          if (blocos.length === 0) return;
          const ultimoBloco = blocos[blocos.length - 1];

          const select = ultimoBloco.querySelector('select');
          if (select) {
            select.value = item.cursoId;
            const idDoBloco = ultimoBloco.id.replace('bloco-', '');
            selecionarCurso(idDoBloco, item.cursoId);

            if (Array.isArray(item.professores)) {
              item.professores.forEach(profObj => {
                const isObj = typeof profObj === 'object' && profObj !== null;
                const profId = isObj ? profObj.id_pessoa : profObj;
                const checkbox = ultimoBloco.querySelector(`input.form-check-input[value="${profId}"]`);
                if (checkbox) {
                  checkbox.checked = true;
                  if (isObj) {
                    checkbox.setAttribute('data-disciplina', profObj.disciplina || '');
                    checkbox.setAttribute('data-cargahoraria', profObj.cargahoraria || '0');
                  }
                  toggleProfChip(checkbox, idDoBloco);

                  // Seleciona o período letivo com base no professor restaurado
                  const chip = checkbox.closest('.prof-chip');
                  if (chip) {
                    const period = chip.getAttribute('data-periodo');
                    const selectPeriod = ultimoBloco.querySelector(`#periodo_${idDoBloco}`);
                    if (selectPeriod && period) {
                      selectPeriod.value = period;
                      filtrarProfessoresPorPeriodo(idDoBloco, period);
                    }
                  }
                }
              });
              // Auto-confirm to show summary
              confirmarProfessores(idDoBloco);
            }
          }
        });
      }
    } catch (error) {
      console.error('Erro ao carregar seleções prévias:', error);
    }
  }
  recalcularSomaCargaHoraria();
});
function removerAnexoSalvo(idProjeto, idAnexo, from) {
  if (!confirm('Deseja remover este anexo?')) return;

  const form = document.createElement('form');
  form.method = 'POST';
  form.action = `/projeto_extensao/${idProjeto}/anexo/${idAnexo}/delete`;

  const input = document.createElement('input');
  input.type = 'hidden';
  input.name = 'from';
  input.value = from;

  form.appendChild(input);
  document.body.appendChild(form);
  form.submit();
}

function editarLocal(id, endereco, bairro, cidade, cep) {
  const div = document.getElementById('form-add-local');
  const form = div.querySelector('form');
  div.style.display = 'block';
  form.action = form.action.replace(/\/local(\/.*)?$/, '') + '/local/' + id + '/edit';
  form.querySelector('[name="endereco"]').value = endereco;
  form.querySelector('[name="bairro"]').value = bairro;
  form.querySelector('[name="cidade"]').value = cidade;
  form.querySelector('[name="cep"]').value = cep;
  form.querySelector('button[type="submit"]').innerHTML = '<i class="bi bi-check-lg"></i> Salvar Alterações';
  div.scrollIntoView({ behavior: 'smooth' });
}

function preencherDadosInstituicao(select) {
  const opt = select.options[select.selectedIndex];
  document.getElementById('display-inst-sigla').value = opt ? (opt.dataset.sigla || '') : '';
  document.getElementById('display-inst-tipo').value = opt ? (opt.dataset.tipo || '') : '';
}

function editarInstituicao(id) {
  const div = document.getElementById('form-add-inst');
  const form = div.querySelector('form');
  div.style.display = 'block';
  form.action = form.action.replace(/\/instituicao(\/.*)?$/, '') + '/instituicao/' + id + '/edit';
  const select = form.querySelector('#select-instituicao');
  select.value = id;
  preencherDadosInstituicao(select);
  form.querySelector('button[type="submit"]').innerHTML = '<i class="bi bi-check-lg"></i> Salvar Alterações';
  div.scrollIntoView({ behavior: 'smooth' });
}

function editarCronograma(id, etapa, data, hora, local) {
  const div = document.getElementById('form-add-cronograma');
  const form = div.querySelector('form');
  div.style.display = 'block';
  form.action = form.action.replace(/\/cronograma(\/.*)?$/, '') + '/cronograma/' + id + '/edit';
  form.querySelector('[name="etapa"]').value = etapa;
  // Format date to yyyy-mm-dd
  if (data) {
    const d = new Date(data);
    if (!isNaN(d.getTime())) {
      form.querySelector('[name="data"]').value = d.toISOString().split('T')[0];
    }
  }
  form.querySelector('[name="hora"]').value = hora;
  form.querySelector('[name="local"]').value = local;
  form.querySelector('button[type="submit"]').innerHTML = '<i class="bi bi-check-lg"></i> Salvar Alterações';
  div.scrollIntoView({ behavior: 'smooth' });
}

function formatBR(valor) {
  const num = Number(valor);
  if (Number.isNaN(num)) return valor ?? '';
  return num.toLocaleString('pt-BR', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
}

function editarCusto(id, descricao, qtd, unit, just) {
  const div = document.getElementById('form-add-custo');
  const form = div.querySelector('form');
  div.style.display = 'block';
  form.action = form.action.replace(/\/custo(\/.*)?$/, '') + '/custo/' + id + '/edit';
  form.querySelector('[name="descricao"]').value = descricao;
  form.querySelector('[name="quantitativo"]').value = qtd;
  form.querySelector('[name="valor_unitario"]').value = formatBR(unit);
  form.querySelector('[name="justificativa"]').value = just;
  form.querySelector('button[type="submit"]').innerHTML = '<i class="bi bi-check-lg"></i> Salvar Alterações';
  div.scrollIntoView({ behavior: 'smooth' });
}

function aplicarMascaraValorUnitario(input) {
  let value = input.value.replace(/\D/g, '');
  if (!value) {
    input.value = '';
    return;
  }
  let numberValue = parseFloat(value) / 100;
  input.value = numberValue.toLocaleString('pt-BR', {
    minimumFractionDigits: 2,
    maximumFractionDigits: 2
  });
}

window.editarLocal = editarLocal;
window.editarInstituicao = editarInstituicao;
window.editarCronograma = editarCronograma;
window.editarCusto = editarCusto;
window.aplicarMascaraValorUnitario = aplicarMascaraValorUnitario;

// --- AJAX Form Submission & Scroll Restoration ---
// 1. Fallback Scroll Restoration (for manual reloads or fallback navigations)
function salvarPosicaoScroll() {
  if (window.location.pathname.endsWith('/plano')) {
    sessionStorage.setItem('scroll_position_' + window.location.pathname, window.scrollY);
  }
}
window.addEventListener('beforeunload', salvarPosicaoScroll);

document.addEventListener('DOMContentLoaded', function () {
  if (window.location.pathname.endsWith('/plano')) {
    const key = 'scroll_position_' + window.location.pathname;
    const savedScroll = sessionStorage.getItem(key);
    if (savedScroll !== null) {
      window.scrollTo(0, parseFloat(savedScroll));
      setTimeout(() => {
        window.scrollTo(0, parseFloat(savedScroll));
        sessionStorage.removeItem(key);
      }, 10);
    }
  }
});

// 2. Seamless AJAX Submissions (zeros full page reloads for dynamic updates)
function showDynamicAlert(message, type = 'success') {
  const oldAlert = document.getElementById('floating-alert-container');
  if (oldAlert) {
    oldAlert.remove();
  }
  
  const wrapper = document.createElement('div');
  wrapper.id = 'floating-alert-container';
  wrapper.className = `alert alert-${type === 'error' ? 'danger' : type} alert-dismissible fade show d-flex align-items-center mb-0`;
  
  wrapper.style.position = 'fixed';
  wrapper.style.top = '24px';
  wrapper.style.right = '24px';
  wrapper.style.zIndex = '99999';
  wrapper.style.minWidth = '300px';
  wrapper.style.maxWidth = '450px';
  wrapper.style.boxShadow = '0 0.5rem 1rem rgba(0, 0, 0, 0.15)';
  wrapper.style.borderRadius = '8px';
  wrapper.style.fontSize = '0.85rem';
  wrapper.style.padding = '12px 20px';
  
  const borderColor = (type === 'danger' || type === 'error') ? '#842029' : '#1c6e36';
  wrapper.style.border = `1.5px solid ${borderColor}`;
  
  wrapper.style.transition = 'all 0.35s cubic-bezier(0.175, 0.885, 0.32, 1.275)';
  
  const icon = type === 'danger' ? 'bi-exclamation-triangle' : 'bi-check-circle';
  
  wrapper.innerHTML = `
    <i class="bi ${icon} me-2" style="font-size: 1.1rem; flex-shrink: 0;"></i>
    <span style="flex-grow: 1; padding-right: 12px;">${message}</span>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close" style="font-size:0.65rem; margin-top: -2px;"></button>
  `;
  
  document.body.appendChild(wrapper);
  
  // Slide in from right micro-animation
  wrapper.style.transform = 'translateX(120%)';
  wrapper.style.opacity = '0';
  wrapper.offsetHeight; // force reflow
  wrapper.style.transform = 'translateX(0)';
  wrapper.style.opacity = '1';
  
  wrapper.addEventListener('closed.bs.alert', () => {
    wrapper.remove();
  });
  
  setTimeout(function() {
    wrapper.style.transition = 'all 0.3s ease';
    wrapper.style.transform = 'translateX(120%)';
    wrapper.style.opacity = '0';
    setTimeout(() => {
      wrapper.remove();
    }, 300);
  }, 4000);
}

function getSuccessMessage(action, form) {
  const url = action.toLowerCase();
  
  if (url.includes('/delete')) {
    return 'Registro excluído com sucesso!';
  }
  
  if (url.includes('/local')) {
    return 'Local de execução salvo com sucesso!';
  }
  
  if (url.includes('/instituicao')) {
    return 'Instituição parceira salva com sucesso!';
  }
  
  if (url.includes('/cronograma')) {
    return 'Atividade do cronograma salva com sucesso!';
  }
  
  if (url.includes('/custo')) {
    return 'Custo do projeto salvo com sucesso!';
  }
  
  if (url.includes('/plano')) {
    return 'Alterações do plano de extensão salvas com sucesso!';
  }
  
  return 'Alterações salvas com sucesso!';
}

document.addEventListener('submit', async function(e) {
  const form = e.target;
  
  if (window.location.pathname.endsWith('/plano')) {
    if (form.getAttribute('target') === '_blank') return;
    
    e.preventDefault();
    
    const submitBtn = form.querySelector('button[type="submit"]');
    const originalBtnHTML = submitBtn ? submitBtn.innerHTML : '';
    if (submitBtn) {
      submitBtn.disabled = true;
      submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Salvando...';
    }
    
    try {
      let body;
      let headers = {};
      
      if (form.enctype === 'multipart/form-data') {
        body = new FormData(form);
      } else {
        body = new URLSearchParams(new FormData(form));
        headers['Content-Type'] = 'application/x-www-form-urlencoded';
      }
      
      const response = await fetch(form.action || window.location.href, {
        method: form.method || 'POST',
        headers: headers,
        body: body
      });
      
      if (response.ok) {
        const responseHTML = await response.text();
        const parser = new DOMParser();
        const newDoc = parser.parseFromString(responseHTML, 'text/html');
        
        const currentMain = document.querySelector('main');
        const newMain = newDoc.querySelector('main');
        if (currentMain && newMain) {
          const scrollY = window.scrollY;
          currentMain.innerHTML = newMain.innerHTML;
          window.scrollTo(0, scrollY);
          
          // Check if there is a flash alert in the newly rendered HTML
          let message = '';
          const newAlert = newDoc.querySelector('.alert-dismissible');
          if (newAlert) {
            const textSpan = newAlert.querySelector('span');
            message = textSpan ? textSpan.textContent.trim() : newAlert.textContent.replace('×', '').trim();
          } else {
            message = getSuccessMessage(form.action || window.location.href, form);
          }
          
          showDynamicAlert(message, 'success');
        }
      } else {
        console.error('Error on submit:', response.statusText);
        showDynamicAlert('Ocorreu um erro ao salvar as alterações.', 'danger');
        if (submitBtn) {
          submitBtn.disabled = false;
          submitBtn.innerHTML = originalBtnHTML;
        }
      }
    } catch (err) {
      console.error('Fetch error:', err);
      showDynamicAlert('Erro de conexão com o servidor.', 'danger');
      if (submitBtn) {
        submitBtn.disabled = false;
        submitBtn.innerHTML = originalBtnHTML;
      }
    }
  }
});
