function calculTTC(ht, taux) {
  if (typeof ht !== number || ht < 0) throw new Error(montant invalide);
  return Math.round(ht * (1 + taux) * 100) / 100;
}
module.exports = { calculTTC };
