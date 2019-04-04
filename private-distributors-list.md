## Private Distributors List

This list is used to provide actionable information to multiple distribution
vendors at once. This list is not intended for individuals to find out about
security issues.

### Embargo Policy

The information members receive on distributors-announce@kubernetes.io must not be
made public, shared, nor even hinted at anywhere beyond the need-to-know within
your specific team except with the list's explicit approval. This holds
true until the public disclosure date/time that was agreed upon by the list.
Members of the list and others may not use the information for anything other
than getting the issue fixed for your respective distribution's users.

Before any information from the list is shared with respective members of your
team required to fix said issue, they must agree to the same terms and only
find out information on a need-to-know basis.

In the unfortunate event you share the information beyond what is allowed by
this policy, you _must_ urgently inform the security@kubernetes.io
mailing list of exactly what information
leaked and to whom. A retrospective will take place after the leak so
we can assess how to not make the same mistake in the future.

If you continue to leak information and break the policy outlined here, you
will be removed from the list.

### Contributing Back

This is a team effort. As a member of the list you must carry some water. This
could be in the form of the following:

**Technical**

- Review and/or test the proposed patches and point out potential issues with
  them (such as incomplete fixes for the originally reported issues, additional
  issues you might notice, and newly introduced bugs), and inform the list of the
  work done even if no issues were encountered.

**Administrative**

- Help draft emails to the public disclosure mailing list.
- Help with release notes.

### Membership


| Email		| Organization	|
| ------------- |:-------------:|
| argoprod@us.ibm.com | IBM |
| aws-k8s-embargo-notification@amazon.com | AWS |
| k8s_security_grp@oracle.com | Oracle |
| k8s-security@suse.de | SUSE |
| kops-security-response@googlegroups.com | Kops |
| kubernetes-security-disclosure@google.com | Google |
| kubernetes-security-team@ml.ovh.net | OVH |
| kubernetes-security@docker.com | Docker |
| kubernetes-security@huawei.com | Huawei |
| kubernetes-security@service.aliyun.com | Aliyun |
| kubernetes-security@service.microsoft.com | Microsoft |
| kubernetes-security@weave.works | WeaveWorks |
| mke-security@mesosphere.com | Mesosphere |
| secalert@redhat.com | Red Hat |
| secure@sap.com | SAP |
| security-release-team@kubernetes.io | Kubernetes PSC |
| security@gravitational.com | Gravitational |
| security@kubernetes.io | Kubernetes PSC |
| security@platform9.com | Platform9 |
| security@rancher.com | Rancher |
| security@vmware.com | VMware |
| upstream-security@heptio.com | Heptio |
| vulnerabilityreports@cloudfoundry.org | Cloud Foundry |
| test@example.com | brandon testing PR template |

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

Open a Pull Request to add your organization to the membership table above. Use
the [Distributors Application][distributors-app] template, and fill in the
membership criteria. Once the PR is approved, a Product Security Committee
member will add the alias to the email list.

[distributors-app]: https://github.com/kubernetes/kubernetes/pull/new/master?template=distributors-application.md
