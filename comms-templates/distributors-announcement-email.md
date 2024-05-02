_Use this email template for pre-disclosing security vulnerabilities to distributors-announce._

_Note that distributors-announce@kubernetes.io has moderation enabled. When you send the email, remember to release the email from moderation queue._

TO: `distributors-announce@kubernetes.io`

SUBJECT: `[EMBARGOED] $CVE: $SUMMARY`

---

### EMBARGOED

The information contained in this email is **[under embargo](https://github.com/kubernetes/security/blob/master/private-distributors-list.md#embargo-policy)** until the public disclosure is sent. The disclosure is scheduled to be sent on $DATE at or after 9AM PT.

_Additional details on the embargo conditions._
- _If a patch is provided, can it be deployed?_
- _Is the patch itself under embargo?_

### Issue Details

A security issue was discovered in Kubernetes where $ACTOR may be able to $DO_SOMETHING. <optional> Kubernetes clusters are only affected if $CONDITION </end optional>

This issue has been rated **$SEVERITY** (link to CVSS calculator https://www.first.org/cvss/calculator/3.1) (optional: $SCORE), and assigned **$CVE_NUMBER**

_Additional background and high level description of the vulnerability._

### Affected Components and Configurations

_How to determine if a cluster is impacted. Include:_
- _Vulnerable configuration details_
- _Commands that indicate whether a component, version or configuration is used_

#### Affected Versions

- $COMPONENT $VERSION_RANGE_1
- $COMPONENT $VERSION_RANGE_2 ...
- ...

### Mitigations

_If a patch is provided, describe it here._

_(If fix has side effects)_ **Fix impact:** details of impact.

_(If additional steps required after upgrade)_
**ACTION REQUIRED:** The following steps must be taken to mitigate this
vulnerability: ...

_(If possible):_ Prior to upgrading, this vulnerability can be mitigated by ...

### Detection

_How can exploitation of this vulnerability be detected?_

If you find evidence that this vulnerability has been exploited, please contact security@kubernetes.io

Thank You,

$PERSON on behalf of the Kubernetes Security Response Committee
