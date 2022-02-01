# On-boarding / Off-boarding Procedure for Security Response Committee Members

This document outlines the process for individual(s) both joining or leaving
the Kubernetes SRC (Security Response Committee).

The key differentiator between on-boarding and off-boarding SRC members, is that
individuals joining are first required to have completed the [Associate Role](#associate-role)
before a nomination can be made from by any existing SRC members.

For the purpose of example, we will use a placeholder name of **Jane Doe** with
a github username **`jdoe`** and a company name of **ACME LTD**.

### Associate Role

Once a candidate has completed a 3 month rotation in the [Associate](https://github.com/kubernetes/security/blob/master/security-release-process.md#Associate) role, existing SRC Members can
nominate said individual(s) for promotion from Associate to full SRC members. See
[joining](https://github.com/kubernetes/security/blob/master/security-release-process.md#joining)
for further details on the SRC selection process.

This selection process is initiated with an email sent to the
[kubernetes-security-discuss mailing list](https://groups.google.com/forum/#!forum/kubernetes-security-discuss)
once the three month Associate Role period is complete.

The following template may be used:

```
I want to nominate Jane Doe to join the Security Response Committee as
a full member. She has been an associate member since December 4th 2018
and in that role over the last three months he has helped on a number of
tasks including:

<list work carried out as associate>

Our process for accepting this nomination is lazy consensus and I will
close the round of consensus on March 15th, 2019 to leave time for any
comments or question. If the nomination is accepted Jane will take on
the full responsibilities of a Security Committee member and take on a
weekly rotation for security@kubernetes.io on-call rotation.
```

### Required file and access grant updates.

Once the SRC has promoted an individual(s)  to a full SRC member, various
systems require updating. Likewise, should a SRC member leave the SRC - the
reverse is required, with the user being removed from each system.

#### kubernetes/security repository

All SRC member discussion & approval must happen on the `kubernetes/security`
repository first and only once approved by means of the pull request being
merged, should pull requests be approved / merged in the `kubernetes/community`
repository, and the user added to the mailing lists and ACLs.

##### file: https://github.com/kubernetes/security/blob/master/README.md

Add / remove the SRC member(s) github name from `security/README.md`
to the appropriate list of committee members, according to the usernames
alphabetical placing.

If adding a SRC member, you will also need to remove the associate role:

```
The initial Security Response Committee will consist of volunteers subscribed to the private [Kubernetes Security](https://groups.google.com/a/kubernetes.io/forum/#!forum/security) list. These are the people who have been involved in the initial discussion and volunteered:

- Jane Doe (**[@jdoe](https://github.com/jdoe)**) `<jdoe@acme.com>` [GPG_KEY]
```

If removing a SRC member, move them to the list of emeritus members.

##### file: https://github.com/kubernetes/security/blob/master/OWNERS_ALIASES

Add / remove the SRC member(s) github name from `security/OWNERS_ALIASES` to the
existing `security-response-committee` field, according to the usernames
alphabetical placing:

```yaml
aliases:
  security-response-committee:
    - jdoe
```

#### kubernetes/k8s.io repository

##### file: https://github.com/kubernetes/k8s.io/blob/main/groups/committee-security-response/groups.yaml

`groups.yaml` is the source of truth for membership to the
security-response-committee mailing lists. Update the `owners` field for the
following lists:

- `security@kubernetes.io`
- `security-discuss-private@kubernetes.io`
- `distributors-announce@kubernetes.io`

Ensure the 3 lists match.

##### file: https://github.com/kubernetes/k8s.io/blob/main/OWNERS_ALIASES

```yaml
aliases:
  security-response-committee:
    - jdoe
```

#### kubernetes/community repository

##### file: https://github.com/kubernetes/community/blob/master/sigs.yaml

Add / remove the SRC member(s)  github name from `community/sigs.yaml` to the
existing `label`| `leadership` field, according to the usernames alphabetical
placing:

```yaml
label: security-response
  leadership:
    chairs:
    - github: jdoe
      name: Jane Doe
      company: Acme LTD
```

Once the yaml is updated, run `make generate` to regenerate the markdown
versions.

This will then automatically create the following files:

* kubernetes/community/OWNERS_ALIASES
* kubernetes/community/security-response-committee/README.md
* kubernetes/community/sig-list.md

##### file: https://github.com/kubernetes/community/blob/master/communication/slack-config/usergroups.yaml

Add / remove the SRC member(s) github name from the `security-response-committee` user group.

#### kubernetes/org repository

##### file: https://github.com/kubernetes/org/blob/master/config/kubernetes/org.yaml

Add / remove the SRC member(s) github username from `config/kubernetes/org.yaml`
to the existing `security-response-committee` | `members` field. The usernames
should be alphabetized:

```yaml
  security-response-committee:
    description: Please report security issues to https://kubernetes.io/security
    members:
    - alice
    - bob
    - jdoe
```

Once merged, [peribolos](https://git.k8s.io/test-infra/prow/cmd/peribolos) will
automatically run and update the members of the GitHub group
https://github.com/orgs/kubernetes/teams/security-response-committee

####  Add/remove from HackerOne

To add or remove members from the Kubernetes HackerOne project, navigate to
https://hackerone.com/kubernetes/team_members

Click `Remove` next to a member to remove.

Click `Invite user` to add a new SRC member. Add them to the `Kubernetes Team`,
`Standard` and `Admin` groups.

We also request that new members enable 2-factor auth. Once they've accepted the
invitation, you can verify the status in the `2FA` column on the user management
page.


####  Add/remove from OpsGenie rotation

##### url: https://app.opsgenie.com/teams/dashboard/633ac733-665f-4d62-871e-cbc011f37037

Once the user account has been created in OpsGenie, they must add a
`github=GITHUB_USERNAME` tag to their OpsGenie profile for the tool to work.

See the below example.

![User Configuration](/images/user-tag.png)

##### url: https://kubernetes.app.opsgenie.com/settings/schedule/detail/f835cdef-8df9-4ddc-9a39-911cb9e521b5

Click `Edit Rotation` next to "PST Rotation", and add/remove the new member from the participants list.

![Edit Rotation](/images/opsgenie-edit-rotation.png)

####  Add/ Remove SRC Owner permission from Kubernetes Security Mailing Lists

New SRC members are added to various security lists and upgraded to "owner" (or
downgraded to member if they are leaving the SRC)

To add members and assign the "owner" role:

1. Visit the groups URL as a user authenticated as an existing "owner".
2. Select the 'Manage group' or 'Manage Members' link.
3. Within the left side panel, select 'Direct add member'.
4. Enter the new SRC members email address
5. Select the 'All members' link, or search for the new member in the search box.
6. Select the new member and change the drop down role to "Owner" (or "Manager" in the case of kubernetes-announce)

---

**Existing Accounts**

It may be the case, that the user has already joined the group / mailing list.
If this is the case, steps 1 to 4 can be ignored and you can proceed to change
the role of their existing account.

---

To downgrade existing owners to members:

1. Visit the groups URL as a user authenticated as an existing "owner".
2. Select the 'All members' link, or search for the existing owner in the search box.
3. Select the owner and change the drop down role to "Member".

| Mailing List        | URL                                                                  |
| -------------       | -------------                                                        |
| Security Discuss    | https://groups.google.com/forum/#!forum/kubernetes-security-discuss  |
| Security Announce   | https://groups.google.com/forum/#!forum/kubernetes-security-announce |
| Kubernetes Announce | https://groups.google.com/forum/#!forum/kubernetes-announce (Manager)|
| Kubernetes Dev      | https://groups.google.com/forum/#!forum/kubernetes-dev (Member)      |

_Note: the @kubernetes.io addresses are now managed through `groups.yaml`_

#### Discuss Account

A verified [discuss account](https://discuss.kubernetes.io/) is required.

#### kubernetes-security github org

Update the kubernetes-security github org team members for the additions or
removals.

Navigate to https://github.com/orgs/kubernetes-security/people, and invite new
members or remove existing members. Note that several non-SRC members have
access to this org (primarily release managers).

Once a new SRC member has accepted the invite, they should be granted `Owner`
permissions.

For members stepping down, please ensure they are not assigned any issues in
the vulnerability trackers:

- https://github.com/kubernetes-security/security-disclosures/issues
- https://github.com/kubernetes-security/security-disclosures-low/issues

#### Slack

SRC members must enable slack 2-factor authentication: https://slack.com/help/articles/204509068-Set-up-two-factor-authentication

New members must be manually added to the private channels on slack by someone
who is already a member of those channels:

1. `#SRC-private` for private SRC-only discussion
2. `#security-release-team` for private discussions with the security-release-team and SRC associates

Members who are stepping down must leave the channels themselves.

#### Calendar

Update the Google calendar entries to add or remove the member:

1. SRC Monthly (monthly, first Thursday)
2. HackerOne sync (every 3 months, second Thursday)

#### Google Docs

Update the sharing settings for the following docs:

- "SRC Monthly Agenda & Notes" (owner: timallclair@gmail.com)
- "Kubernetes CNA Tracker" (owner: timallclair@gmail.com) - Only for [CNA trained members](https://github.com/kubernetes/security/blob/master/cna-handbook.md)

### Checklist

The following checklist can be pasted into an onboarding issue to track all the steps that need to be taken:

```
- [ ] kubernetes/security PR:
  - [ ] README.md
  - [ ] OWNERS_ALIASES
  - [ ] SECURITY_CONTACTS
- [ ] kubernetes/k8s.io PR:
  - [ ] groups/security-response-committee/groups.yaml
    - `security@kubernetes.io`
    - `security-discuss-private@kubernetes.io`
    - `distributors-announce@kubernetes.io`
  - [ ] OWNERS_ALIASES
- [ ] kubernetes/community PR:
  - [ ] sigs.yaml
  - [ ] communication/slack-config/usergroups.yaml
    - [ ] Verify slack 2-factor auth
  - [ ] `make generate`
- [ ] kubernetes/org PR:
  - [ ] config/kubernetes/org.yaml
- [ ] HackerOne project membership
  - [ ] Verify 2-factor auth
- [ ] OpsGenie rotation
  - [ ] Add new user
  - [ ] Update rotation
- [ ] Mailing lists
  - [ ] [Security Discuss](https://groups.google.com/forum/#!forum/kubernetes-security-discuss) - owner
  - [ ] [Security Announce](https://groups.google.com/forum/#!forum/kubernetes-security-announce) - owner
  - [ ] [Kubernetes Announce](https://groups.google.com/forum/#!forum/kubernetes-announce) - manager
  - [ ] [Kubernetes Dev](https://groups.google.com/forum/#!forum/kubernetes-dev) - member
- [ ] Verify Discuss account
- [ ] github.com/kubernetes-security membership
- [ ] Slack
  - [ ] Verify 2-factor auth
  - [ ] `#SRC-private` membership
  - [ ] `#security-release-team` membership
- [ ] Calendar meetings
- [ ] Google Docs access
```
