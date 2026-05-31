/**
 * CEP Auto-fill for Extension Project Management
 * Uses ViaCEP API: https://viacep.com.br/
 */

function buscarCep(event) {
    const cepInput = event.target;
    const cep = cepInput.value.replace(/\D/g, '');

    // Valida se o CEP tem 8 dígitos
    if (cep.length !== 8) return;

    // Busca o container pai para localizar os campos relacionados
    // Isso permite que o script funcione em formulários com múltiplos endereços (ex: plano de extensão)
    const form = cepInput.closest('form') || cepInput.parentElement;
    
    // Tenta encontrar campos por nome ou ID dentro do contexto do formulário
    const enderecoField = form.querySelector('[name="endereco"], #endereco');
    const bairroField = form.querySelector('[name="bairro"], #bairro');
    const cidadeField = form.querySelector('[name="cidade"], #cidade');

    if (!enderecoField || !bairroField || !cidadeField) {
        console.warn('Campos de endereço não encontrados para preenchimento automático.');
        return;
    }

    // Indica carregamento
    const originalPlaceholder = enderecoField.placeholder;
    enderecoField.placeholder = "Buscando...";
    
    fetch(`https://viacep.com.br/ws/${cep}/json/`)
        .then(response => response.json())
        .then(data => {
            if (data.erro) {
                console.error("CEP não encontrado.");
                return;
            }

            // Preenche os campos
            if (enderecoField) enderecoField.value = data.logradouro;
            if (bairroField) bairroField.value = data.bairro;
            if (cidadeField) cidadeField.value = data.localidade;
        })
        .catch(error => console.error("Erro ao buscar CEP:", error))
        .finally(() => {
            enderecoField.placeholder = originalPlaceholder;
        });
}

/**
 * Inicializa os listeners para todos os campos de CEP
 */
function initCepListeners() {
    // Seleciona campos pelo nome ou ID que contenha "cep"
    const cepInputs = document.querySelectorAll('input[name="cep"], #cep, .cep-input');
    
    cepInputs.forEach(input => {
        // Evita duplicar listeners
        if (input.dataset.cepListener) return;
        
        input.addEventListener('blur', buscarCep);
        input.addEventListener('input', (e) => {
            // Se o usuário colar ou digitar 8 dígitos, já tenta buscar
            const val = e.target.value.replace(/\D/g, '');
            if (val.length === 8) buscarCep(e);
        });
        
        input.dataset.cepListener = "true";
    });
}

// Inicializa quando o DOM estiver pronto
document.addEventListener('DOMContentLoaded', () => {
    initCepListeners();
    
    // Observa mudanças no DOM para capturar modais ou campos dinâmicos
    const observer = new MutationObserver((mutations) => {
        mutations.forEach((mutation) => {
            if (mutation.addedNodes.length) {
                initCepListeners();
            }
        });
    });
    
    observer.observe(document.body, { childList: true, subtree: true });
});

// Expondo globalmente para casos de inserção dinâmica manual
window.initCepListeners = initCepListeners;
