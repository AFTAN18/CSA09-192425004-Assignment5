# B2 · Adversarial inputs

The Java demo is restricted to the dedicated csa09_persistence database on loopback and touches an illustrative account. The crafted ID terminates the quoted literal, OR 1=1 makes the WHERE predicate true, and the comment marker hides the remaining password comparison. The prepared query binds the entire text as one ID value and finds no match. The positive control accepts a known fixture, and both reject a wrong password when the input is ordinary.

The full pass store test emits line numbers for a wrong field count, a nonnumeric amount and a blank line, skips them and still finds a later valid record. See B1's captured file test. This is important because a syntactic row shape alone does not validate the business fields.

A regular expression can enforce a business ID alphabet but is context-specific and constrains legitimate text. Escaping must follow driver, character encoding and SQL mode for the applicable context, and manual escaping is easy to omit. Binding addresses SQL interpretation directly and allowlisting can remain independent validation. Basic scanning validation or escaping and parameter encoding all take O(L) work in input length L. Copying escaped text may need O(L) additional memory. Network, server parsing and caching dominate many queries.
