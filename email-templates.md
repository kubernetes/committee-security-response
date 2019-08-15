# Kubernetes Security Process Email Templates

This is a collection of email templates to handle various situations the PSC needs to handle.

## Security Fix Announcement

Subject: [ANNOUNCE] Security release of $COMPONENT $VERSION - $CVE
To: kubernetes-announce@googlegroups.com, kubernetes-dev@googlegroups.com, kubernetes-security-announce@googlegroups.com, kubernetes-security-discuss@googlegroups.com, oss-security@lists.openwall.com, kubernetes+announcements@discoursemail.com

Hello Kubernetes Community-

A security issue was discovered in versions of $COMPONENT versions $OLDVERSION or older. The issue is $SEVERITY and upgrading to $VERSION of $COMPONENT is encouraged to fix this issue.

**Am I vulnerable?**

Run `$COMPONENT version` and if it says $OLDVERSION or older you are running a vulnerable version.

**How do I mitigate the vulnerability?**

<!--
[This is an optional section. Remove if there are no mitigations.]
-->

Run `kubectl delete deployment cookie-monster -n gibson` to temporarily disable the feature.

**How do I upgrade?**

Run `$COMPONENT upgrade` or follow the upgrade instructions at https://kubernetes.io/docs

**Vulnerability Details**

When $COMPONENT $OLDVERSION is run with default settings it will immediately shut the internet off.

This issue is filed as $CVE. [See the GitHub issue for more details]($GITHUBISSUEURL)

**Thank you**

Thank you to $REPORTER, $DEVELOPERS, and the $RELEASEMANAGERS for the coordination is making this release.

Thank You,

$PERSON on behalf of the Kubernetes Product Security Committee


## Distributor List Removal

Subject: Kubernetes Disclosure List Removal Due to Uncertified Status

Hello $MEMBER-

The [Kubernetes Product Security Committee][psc] has removed $EMAIL from the distributors-announce@kubernetes.io Google Group.

This is because $PRODUCT is no longer a [certified Kubernetes Distribution][conformance], a requirement for membership to this list.

If $PRODUCT recertifies, and meets all other criteria, please submit a [request to re-join using the normal process][join-process].

Thank You,

$PERSON on behalf of the Kubernetes Product Security Committee

[psc]: https://git.k8s.io/security/security-release-process.md#product-security-committee-psc
[conformance]: https://www.cncf.io/certification/software-conformance/
[criteria]: https://git.k8s.io/security/private-distributors-list.md#membership-criteria
[join-process]: https://git.k8s.io/security/private-distributors-list.md#request-to-join
