 ## Main changes made to Patho_typing scheme

 In silico pathogenic typing of a sample is based on raw read sequences of gene(s). More variants of some of the genes as well as new target genes are becoming available and consequnetly patho_tyiping schema needs to be updated. [Read more about the path_typing tool](https://github.com/B-UMMI/patho_typing)

 ### Updated typing rules:
- **STEC, tEPEC and aEPEC**: No update on patho_typing rules was done.
- **ETEC**: There are about 60 new target genes have been identified for ETEC patho_typing. Updated rule for patho_typing is that there should be at least one ETEC target and no stx
- **EAEC**: New marker gene aggR is added and removed aaiC, aap, aat from old list. Then, EAEC patho_typing is based on "aggR only, NO stx, NO eae"
- **EIEC**: Removed icsA. added ipaH7.8, ipaH9.8 and ipaD. ETEC patho_typing is based on the presence of at least one from the list:ipaH, ipaH7.8, ipaH9.8, ipaD.
- **Shigella ST1**: Removed icsA. added ipaH7.8 and ipaH9.8. Patho_typing is based on at least one of ipaH, ipaH7.8, ipaH9.8 AND stx1
- **STEC-ETEC**:At least one stx type with/without eae AND at least one ETEC marker gene
- **STEC-EAEC**: At least one stx type with/without eae AND aggR

Updated typing rules are reflected in "typing_rules.tab".

### Managing large variants

Various combinations of 60+ ETEC genes posed some challenge in designing the matrix needed to define each phenotype. We have clustered various ETEC genes and clustered according to their similarity of sequences. We found five clusters and picked one variant (preferably, longer one) from each cluster for ETEC variants.

### Changes in config and fasta files
- proposed to use changed config settings (#minimum_gene_coverage: 70 (previous value 60)  #minimum_gene_identity: 60 (previous value: 70). Gene_identi value was changed based on the minimum similarity value in the clusters.
- fasta file is updated.