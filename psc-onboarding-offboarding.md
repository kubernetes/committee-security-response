# On-boarding / Off-boarding Procedure for Product Security Committee Members

This document outlines the process for individual(s) both joining or leaving
the Kubernetes PSC (Product Security Committee).

The key differentiator between on-boarding and off-boarding PSC members, is that
individuals joining are first required to have completed the [Associate Role](#associate-role)
before a nomination can be made from by any existing PSC members.

For the purpose of example, we will use a placeholder name of **Jane Doe** with
a github username **`jdoe`** and a company name of **ACME LTD**.

### Associate Role

Once a candidate has completed a 3 month rotation in the [Associate](https://github.com/kubernetes/security/blob/master/security-release-process.md#Associate) role, existing PSC Members can
nominate said individual(s) for promotion from Associate to full PSC members. See
[joining](https://github.com/kubernetes/security/blob/master/security-release-process.md#joining)
for further details on the PSC selection process.

This selection process is initiated with an email sent to the
[kubernetes-security-discuss mailing list](https://groups.google.com/forum/#!forum/kubernetes-security-discuss)
once the three month Associate Role period is complete.

The following template may be used:

```
I want to nominate Jane Doe to join the Product Security Committee as
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

Once the PSC has promoted an individual(s)  to a full PSC member, various
systems require updating. Likewise, should a PSC member leave the PSC - the
reverse is required, with the user being removed from each system.

#### kubernetes/security repository

All PSC member discussion & approval must happen on the `kubernetes/security`
repository first and only once approved by means of the pull request being
merged, should pull requests be approved / merged in the `kubernetes/community`
repository, and the user added to the mailing lists and ACLs.

##### file: https://github.com/kubernetes/security/blob/master/README.md

Add / remove the PSC member(s) github name from `security/README.md`
to the appropriate list of committee members, according to the usernames
alphabetical placing.

If adding a PSC member, you will also need to remove the associate role:

```
The initial Product Security Committee will consist of volunteers subscribed to the private [Kubernetes Security](https://groups.google.com/a/kubernetes.io/forum/#!forum/security) list. These are the people who have been involved in the initial discussion and volunteered:

- Jane Doe (**[@jdoe](https://github.com/jdoe)**) `<jdoe@acme.com>` [GPG_KEY]
```

If removing a PSC member, move them to the list of emeritus members.

##### file: https://github.com/kubernetes/security/blob/master/OWNERS_ALIASES

Add / remove the PSC member(s) github name from `security/OWNERS_ALIASES` to the
existing `product-security-committee` field, according to the usernames
alphabetical placing:

```yaml
aliases:
  product-security-committee:
    - jdoe
```

#### kubernetes/k8s.io repository

##### file: https://github.com/kubernetes/k8s.io/blob/master/groups/groups.yaml

`groups.yaml` is the source of truth for membership to the
product-security-committee mailing lists. Update the `owners` field for the
following lists:

- `security@kubernetes.io`
- `security-discuss-private@kubernetes.io`
- `distributors-announce@kubernetes.io`

Ensure the 3 lists match.

#### kubernetes/community repository

##### file: https://github.com/kubernetes/community/blob/master/sigs.yaml

Add / remove the PSC member(s)  github name from `community/sigs.yaml` to the
existing `label`| `leadership` field, according to the usernames alphabetical
placing:

```yaml
label: product-security
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
* kubernetes/community/committee-product-security/README.md
* kubernetes/community/sig-list.md

####  Add/remove from HackerOne

To add or remove members from the Kubernetes HackerOne project, navigate to
https://hackerone.com/kubernetes/team_members

Click `Remove` next to a member to remove.

Click `Invite user` to add a new PSC member. Add them to the `Kubernetes Team`,
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

####  Add/ Remove PSC Owner permission from Kubernetes Security Mailing Lists

New PSC members are added to various security lists and upgraded to "owner" (or
downgraded to member if they are leaving the PSC)

To add members and assign the "owner" role:

1. Visit the groups URL as a user authenticated as an existing "owner".
2. Select the 'Manage group' or 'Manage Members' link.
3. Within the left side panel, select 'Direct add member'.
4. Enter the new PSC members email address
5. Select the 'All members' link, or search for the new member in the search box.
6. Select the new member and change the drop down role to "Owner"

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
| Kubernetes Announce | https://groups.google.com/forum/#!forum/kubernetes-announce          |
| Kubernetes Dev      | https://groups.google.com/forum/#!forum/kubernetes-dev (Member)      |

_Note: the @kubernetes.io addresses are now managed through `groups.yaml`_

#### Discuss Account

A verified [discuss account](https://discuss.kubernetes.io/) is required.

#### kubernetes-security github org

Update the kubernetes-security github org team members for the additions or
removals.

Navigate to https://github.com/orgs/kubernetes-security/people, and invite new
members or remove existing members. Note that several non-PSC members have
access to this org (primarily release managers).

Once a new PSC member has accepted the invite, they should be granted `Owner`
permissions.
