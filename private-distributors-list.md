## Private Distributors List

This list is used to provide actionable information to multiple distribution
vendors at once. This list is not intended for individuals to find out about
security issues.

### Embargo Policy

The patch files and any derived patched binaries are included in the embargo, 
and must not be distributed or made available to external parties before the 
public disclosure is made.

However, a fully-hosted patched kube-apiserver can be deployed 
prior to the embargo lift date if users do not have direct access to the binary and if the patch only applies to the kube-apiserver.

Other fully-hosted patched components can also be deployed prior to the embargo 
lift date only if all users with access to the components and/or
clusters are internal to the Kubernetes distributor.

Members of distributors-announce@kubernetes.io must share list information only
within their teams, on a need-to-know basis to get the related issue fixed in
their distribution. The information members and others receive from the list
must not be made public, shared, nor even hinted at otherwise, except with the
list's explicit approval. This holds true until the public disclosure date/time
that was agreed upon by the list.

Before any information from the list is shared with respective members of your
team required to fix an issue, they must agree to the same terms and only
find out information on a need-to-know basis.

As a clarifying example, this policy forbids SRC members (or others who don't
work on a distribution) from sharing list information with their non-distributor
employers.

In the unfortunate event you share the information beyond what is allowed by
this policy, you _must_ urgently inform the security@kubernetes.io mailing list
of exactly what information leaked and to whom, as well as the steps that will
be taken to prevent future leaks.

Repeated offenses may lead to the removal from the distributors list.

### Contributing Back

This is a team effort. As a member of the list you must carry some water. This
could be in the form of the following:

- Review and/or test the proposed patches and point out potential issues with
  them (such as incomplete fixes for the originally reported issues, additional
  issues you might notice, and newly introduced bugs), and inform the list of the
  work done even if no issues were encountered.

### Membership

Group membership is managed through the Kubernetes domain group administration
configuration: http://git.k8s.io/k8s.io/groups/committee-security-response/groups.yaml,
under the `distributors-announce` section.

### Membership Criteria

To be eligible for the distributors-announce@kubernetes.io mailing list, your
distribution should:

0. Have an actively monitored security email alias for our project.
1. Be an actively maintained and [CNCF certified distribution of
   Kubernetes][conformance] components.
2. Have a user base not limited to your own organization.
3. Have a publicly verifiable track record up to present day of fixing security
   issues.
4. Not be a downstream or rebuild of another distribution.
5. Be a participant and active contributor in the community.
6. Accept the [Embargo Policy](#embargo-policy) that is outlined above.
7. Be willing to [contribute back](#contributing-back) as outlined above.
8. Have someone already on the list vouch for the person requesting membership
   on behalf of your distribution.

[conformance]: https://www.cncf.io/certification/software-conformance/

**Removal**: If your distribution stops meeting one or more of these criteria
after joining the list then you will be unsubscribed.

### Request to Join

File an issue
[here](https://github.com/kubernetes/security/issues/new?template=distributors-application.md),
filling in the criteria template.
