const multer = require('multer');
const path = require('path');
const fs = require('fs');

const pasta = path.join(__dirname, '..', 'public', 'uploads', 'anexos');

// cria pasta se não existir
if (!fs.existsSync(pasta)) {
  fs.mkdirSync(pasta, { recursive: true });
}

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, pasta);
  },
  filename: (req, file, cb) => {
    const nome = Date.now() + '-' + Math.round(Math.random() * 1e9);
    cb(null, nome + path.extname(file.originalname));
  }
});

const tiposPermitidos = [
  'image/jpeg',
  'image/png',
  'image/jpg',
  'image/webp',

  'application/pdf',

  'application/msword',
  'application/vnd.openxmlformats-officedocument.wordprocessingml.document',

  'application/vnd.ms-excel',
  'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
];

function fileFilter(req, file, cb) {
  if (tiposPermitidos.includes(file.mimetype)) {
    cb(null, true);
  } else {
    cb(new Error('Tipo de arquivo não permitido'));
  }
}

module.exports = multer({
  storage,
  fileFilter,
  limits: {
    fileSize: 10 * 1024 * 1024
  }
});