From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PULL REQUEST for Rafael] PM / devfreq: pull request
Date: Fri, 21 Mar 2014 11:34:49 +0900
Message-ID: <1395369289-6416-1-git-send-email-myungjoo.ham@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, myungjoo.ham@gmail.com
List-Id: linux-pm@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Dear Rafael,


Here goes bugfix devfreq patch.

Recent patchset of device-tree support / exynos driver updates is omitted in this pull request
as there could be further updates on the patchset.


Cheers,
MyungJoo


The following changes since commit dcb99fd9b08cfe1afe426af4d8d3cbc429190f15:

  Linux 3.14-rc7 (2014-03-16 18:51:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git for-rafael

for you to fetch changes up to e35d35a1c0b3a7317d77e03e686a4a205cdd4eed:

  PM / devfreq: Rewrite devfreq_update_status() to fix multiple bugs (2014-03-21 11:16:30 +0900)

- ----------------------------------------------------------------
Pull request for Rafael. Bugfix only.
(recence changes of DT/Exynos drivers need further work)

- ----------------------------------------------------------------
Saravana Kannan (1):
      PM / devfreq: Rewrite devfreq_update_status() to fix multiple bugs

 drivers/devfreq/devfreq.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTK6S5AAoJEBOhurvWBoCKuoQQAJjAVcoCzlrjUSSr8y++mXfU
UIJCrJrJR7jFIBc2ykACYXG9zrHg0/OL3VgJHd8Yj9NWtRCNv6shOZ7vk2XZ7M2r
19Lf3+wDR3zBKvCCKoSoh+crywIgXHhpI8Bgxi+rAZmxkDdv/vlFZAlPWt0pxjQG
M19zb0Y+VDgWinfwrR0kP5sPCGSoUQVU085h4Kf+OjeB2ZMWDeR/49fAlSVPFFi6
XDU68mhwytmUdLpqOv/q5c0sNEBgaj00oKyAkco5eccQ8g3+ZwFWdxzLwCoARW/N
beXz/Tr6fc/7x9l1xSdBcuxmH8Lv6OxXUMrewGx2nIyBxgDzHCQ4tKbi1URWuzyy
4LnTqNZbsgQi3EzeNdb5CqFqCIhR63uGfBtyLUTWi9QPgj4CBffgAigcXLZVkL6e
/dpiRHEQGjijRuJxVqdx8WqR0ucMOYHa890Du6l50LlI9uoiyr8I24/+qVPTZBmN
CgSloQe748k2+IXckjNa4TivEDqMCMtn1YPQu23OODg2b98n+gDnwYQFsvi52WH+
Ue5Uidv14o0M/rCYDCkBHdv+Xh+VIRdAhrX/OeAv5xxi996JG8gJW5uXBWX4BdWu
6BugMPW0dmIUnfTTUfeekfLYA+VdN44Rv2L0CdgeMr29qvkT991GBEs6w1wkyI6Z
CpjCdg3UclJ78WVIr+KJ
=CYyn
-----END PGP SIGNATURE-----
