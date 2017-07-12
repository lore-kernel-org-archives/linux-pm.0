From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PULL REQUEST] for Linux-PM (rc-X) from PM/Devfreq
Date: Wed, 12 Jul 2017 05:14:35 +0000
Message-ID: <20170712051435epcms1p71763f426ee4cf7ab8c760ac130db1178@epcms1p7>
References: <CGME20170712051435epcms1p71763f426ee4cf7ab8c760ac130db1178@epcms1p7>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:44200 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751313AbdGLFOh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jul 2017 01:14:37 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20170712051436epoutp01e15acde79c307533d5c2fec7d27b72e0~QfVQYES8G3071730717epoutp01q
        for <linux-pm@vger.kernel.org>; Wed, 12 Jul 2017 05:14:36 +0000 (GMT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "arvind.yadav.cs@gmail.com" <arvind.yadav.cs@gmail.com>, "garsilva@embeddedor.com" <garsilva@embeddedor.com>

Dear Rafael,


Here goes pull-request from PM / devfreq with a few fixes.


Cheers,
MyungJoo


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The following changes since commit 6f7da290413ba713f0cdd9ff1a2a9bb129ef4f6c:

  Linux 4.12 (2017-07-02 16:07:02 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git for-rc

for you to fetch changes up to 37d644aa01c092686af8a96f34df93c74e55b480:

  PM / devfreq: constify attribute_group structures. (2017-07-06 10:17:24 +0900)

- ----------------------------------------------------------------
Arvind Yadav (1):
      PM / devfreq: constify attribute_group structures.

Gustavo A. R. Silva (2):
      PM / devfreq: rk3399_dmc: fix error return code in rk3399_dmcfreq_probe()
      PM / devfreq: tegra: fix error return code in tegra_devfreq_probe()

 drivers/devfreq/governor_userspace.c | 2 +-
 drivers/devfreq/rk3399_dmc.c         | 5 +++--
 drivers/devfreq/tegra-devfreq.c      | 6 +++---
 3 files changed, 7 insertions(+), 6 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZZa4jAAoJEBOhurvWBoCK1bYQAJ/7Y8Vcmy5QBRfDnhj6wayR
gazEJsd20eFKIpHSw2Y9FTEOKgnYM36rGXnk7N5tbD+hKsslspi+NsjU+XrTpQ6s
fQGa6wGFMCeJF0baDB2dD5cJE7VRHJ7RPdzgxsY5AIflYnsrILGbet4M2Sk88kKJ
sz/yXtyPWTRFogGaOr4MlbTJqdYHds0K5PIjmToRDXWmSaLufCEXKtlFP/zXl1u6
0O+GcZyQs0LbmY2FApQaQMfYs9HYOjW0OjvsbywXlG+RZhFTMgGO1rDCB9YfxkQs
AndtZGNzXj4dniHFg4nmGANmJYXSkKFsVeISttdE7aLfHKkHmsAtAuu6bx9x/jig
HJZdWoczkdSAk7KixOm4dTSbrceySsi/dRZvZNFRf4A/BDJbSGQeRgXrgWE+5i9O
gPL7VBK27tKZIG53aBYCrOW6mYkq35sueuH5aoc3+vYgJ0KMKZXz5m2ioyrwPycV
DcGE9cebBQt8OYD4/lkJSvizXmm/AzymhAPN/OUHvtjHVZHTwi9bJqPj+DDzSxHo
5BMtcWq/rJtQEUV6r6K4YfI/8Wp2aQDz3/z6Ph1xSYFNwPvnlXUmdmWqGGGQjfCr
TFqrflESRnFL+8YNNrbiEdOCVrPIyceYHJQiWAhaHw0cpH0AoTIJlkjWYiiZEgqi
vkvl5ZrezpBxq3pOizaL
=56Ox
-----END PGP SIGNATURE-----
