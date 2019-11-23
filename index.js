const faker = require("faker");
const fs = require("fs");
const stream = fs.WriteStream("inserts.sql");

// Endereços
let streetInserts = [];
for (let i = 0; i < 20; i++) {
  const query = `INSERT INTO ENDERECO(ID, RUA, BAIRRO, CIDADE, CEP) VALUES (${i}, '${faker.address.streetName()}', '${faker.address.city()}', '${faker.address.city()}', '${faker.address.zipCode()}' );\n`;
  stream.write(query, "utf8");
  streetInserts.push(query);
}

// Telefones
let phoneInserts = [];
for (let i = 0; i < 20; i++) {
  const query = `INSERT INTO TELEFONE(ID, NUMERO) VALUES (${i}, '${faker.phone.phoneNumber()}');\n`;
  phoneInserts.push(query);
  stream.write(query, "utf8");
}
console.log(phoneInserts[0]);

// Autores
let authorInserts = [];
for (let i = 0; i < 20; i++) {
  const query = `INSERT INTO AUTOR(ID, NOME)	VALUES (${i}, '${faker.name.firstName()}');\n`;
  authorInserts.push(query);
  stream.write(query, "utf8");
}
console.log(authorInserts[0]);

// Editora
let publishingCompany = [];
for (let i = 0; i < 20; i++) {
  const query = `INSERT INTO EDITORA(ID, NOME, CPNJ_EDITORA, ENDERECO_ID, TELEFONE_ID) VALUES (${i}, '${faker.name.firstName()}', '${faker.finance.account(
    4
  )}', ${faker.random.number(20)}, ${faker.random.number(20)});\n`;
  publishingCompany.push(query);
  stream.write(query, "utf8");
}
console.log(publishingCompany[0]);

// Generos
let genderInserts = [];
for (let i = 0; i < 20; i++) {
  const query = `INSERT INTO GENERO (ID, GENERO) VALUES (${i}, '${faker.name.jobArea()}');\n`;
  genderInserts.push(query);
  stream.write(query, "utf8");
}
console.log(genderInserts[0]);

// Usuários
let usersInserts = [];
for (let i = 0; i < 20; i++) {
  const query = `INSERT INTO USUARIO (ID, NOME, LOGIN, PASSWORD, ENDERECO_ID, TELEFONE_ID) VALUES (${i}, '${faker.name.firstName()}', '${faker.name.lastName()}', '${faker.internet.userName()}', '${faker.internet.password()}', ${faker.random.number(
    20
  )}, ${faker.random.number(20)});\n`;
  usersInserts.push(query);
  stream.write(query, "utf8");
}
console.log(usersInserts[0]);

// Livros
let booksInserts = [];
for (let i = 0; i < 20; i++) {
  const query = `INSERT INTO LIVRO (ID, TITULO, EXEMPLAR, USUARIO_ID, AUTOR_ID, EDITORA_ID, GENERO_ID) VALUES (${i}, '${faker.name.title()}', ${i +
    1}, ${faker.random.number(20)}, ${faker.random.number(
    20
  )}, ${faker.random.number(20)}, ${faker.random.number(20)});\n`;
  booksInserts.push(query);
  stream.write(query, "utf8");
}
console.log(booksInserts[0]);

// Genero Livro
let bookGender = [];
let bookGenderId = 0;
for (let i = 0; i < 20; i++) {
  for (let j = 0; j < 2; j++) {
    const query = `INSERT INTO GENERO_LIVRO (ID, LIVRO_ID, GENERO_ID) VALUES (${j +
      bookGenderId}, ${i}, ${faker.random.number(20)});\n`;
    bookGender.push(query);
    stream.write(query, "utf8");
  }
  bookGenderId += 2;
}
// console.log(bookGender);

// Genero Usuario
let userGender = [];
let userGenderId = 0;
for (let i = 0; i < 20; i++) {
  for (let j = 0; j < 2; j++) {
    const query = `INSERT INTO GENERO_USUARIO (ID, USUARIO_ID, GENERO_ID) VALUES (${j +
      userGenderId}, ${i}, ${faker.random.number(20)});\n`;
    userGender.push(query);
    stream.write(query, "utf8");
  }
  userGenderId += 2;
}
console.log(userGender);

// Evento

let event = [];
let eventId = [];
for (let i = 0; i < 20; i++) {
  for (let j = 0; j < 2; j++) {
    const query = `INSERT INTO GENERO_USUARIO (ID, USUARIO_ID, GENERO_ID) VALUES (${j +
      userGenderId}, ${i}, ${faker.random.number(20)});\n`;
    event.push(query);

    stream.write(query, "utf8");
  }
  userGenderId += 2;
}

stream.on("finish", () => {
  console.log("wrote all data to file");
});

stream.end();
