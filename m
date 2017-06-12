From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PULL-REQUEST] PM / devfreq for next
Date: Mon, 12 Jun 2017 09:01:30 +0000
Message-ID: <20170612090130epcms1p1073b77da56448af9f6e88f937bcd0675@epcms1p1>
References: <CGME20170612090130epcms1p1073b77da56448af9f6e88f937bcd0675@epcms1p1>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:27777 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750868AbdFLJBd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2017 05:01:33 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20170612090131epoutp0277b0b3808791deb62024de39a5474ab5~HVE0aWEnz1277412774epoutp02j
        for <linux-pm@vger.kernel.org>; Mon, 12 Jun 2017 09:01:31 +0000 (GMT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "krzk@kernel.org" <krzk@kernel.org>, "arvind.yadav.cs@gmail.com" <arvind.yadav.cs@gmail.com>

Dear Rafael,

Here goes pull-request from PM / devfreq with trivial fixes.


Cheers,
MyungJoo

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The following changes since commit 32c1431eea4881a6b17bd7c639315010aeefa452:

  Linux 4.12-rc5 (2017-06-11 16:48:20 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git for-next

for you to fetch changes up to 6b1355f9ace06a65443c607e1b70872a5f613f80:

  PM / devfreq: exynos-ppmu: Staticize event list (2017-06-12 10:12:07 +0900)

- ----------------------------------------------------------------
Arvind Yadav (2):
      PM / devfreq: exynos-nocp: Handle return value of clk_prepare_enable
      PM / devfreq: exynos-ppmu: Handle return value of clk_prepare_enable

Krzysztof Kozlowski (1):
      PM / devfreq: exynos-ppmu: Staticize event list

 drivers/devfreq/event/exynos-nocp.c | 6 +++++-
 drivers/devfreq/event/exynos-ppmu.c | 8 ++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZPjmsAAoJEBOhurvWBoCKL4EP/003qfsc+vuulJuDtWjbwuOr
WdzNRjqPqkmExz61kLmMVBhwB/vkraFrQfOR8k/XYd2RSzNxtYE973r7HKzsoh51
9io8jQHJNpqn8k62rFV/mJymGGrhKRrHJ+iHwvol5gTapJtV3ZCFUYjYDnsG8TIg
b2eax+xhpc9S8Agg1/2e8I0atFWVDkWFtzQ6hMserQ1tyomSPfyFe5v/jZV8gANA
ZSAfEvEv0+8hAIi79R6zF09CV1uiBi/DrBRjlujyVOIttbRkUhV1yZfSf4vISL0m
1pXWuutUrU8qhu5WKZJpl82AQm59AuTrj12Ha43M7SnRSrvzpHfQ9Bi0tPSj406u
H7yaOhgU3BsJ/QSiDzMmAMFOx7sOcN6witwSNJxT2IDVBPSUJ3Ze98WaS2gQkTap
AMfIhVAzFKPQHfz8oItSSn0dj3R5DpTwkkBTwKyp7Z/jXwpuSCQV5EdBjV67ncr0
M82S8k9vLck/b4HipW0LlvgNOP4n4eLYFw4RuZlSufFh7m1fbb6wVeJHNNiYZiW4
hTz+/zXGcX/ThaJXMUxAJvSvbWPOhyaNvuIVWxxkyA0Ck657AtMBL2sORaaTp4rZ
BwYCdkyaftIlVBeoZZeP/NQpT8VFq0bUD/f39h9mjose1Pf1K+z2QKjrUSMIgEqI
p28ax3Q8zjUXprFcfLA8
=qNcN
-----END PGP SIGNATURE-----
