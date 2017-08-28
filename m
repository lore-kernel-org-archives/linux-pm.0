From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PULL REQUEST] for Rafael's Linux-PM / For-Next
Date: Mon, 28 Aug 2017 02:56:52 +0000
Message-ID: <20170828025652epcms1p26fcf887eb41cf3a620b0ef40baa9eb5b@epcms1p2>
References: <CGME20170828025652epcms1p26fcf887eb41cf3a620b0ef40baa9eb5b@epcms1p2>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:36481 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751799AbdH1C4z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Aug 2017 22:56:55 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20170828025653epoutp0429ebd22a621cf309e3ac833cd995baf7~e4xcP7IP50606206062epoutp04p
        for <linux-pm@vger.kernel.org>; Mon, 28 Aug 2017 02:56:53 +0000 (GMT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "rafael@kernel.org" <rafael@kernel.org>, "robh@kernel.org" <robh@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "myungjoo.ham@gmail.com" <myungjoo.ham@gmail.com>

Dear Rafael,

Here goes a pull request from PM/devfreq with trivial fixes
- printk formatting error
- move private function from shared header to priviate header
- add dependency (Kconfig) on OPP as it becomes mandatory (OPP being widely adopted)
- fix memory leak

Cheers,
MyungJoo

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The following changes since commit 14ccee78fc82f5512908f4424f541549a5705b89:

  Linux 4.13-rc6 (2017-08-20 14:13:52 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git for-next

for you to fetch changes up to 9e14de1077e9c34f141cf98bdba60cdd5193d962:

  PM / devfreq: Fix memory leak when fail to register device (2017-08-28 10:31:08 +0900)

- ----------------------------------------------------------------
Chanwoo Choi (3):
      PM / devfreq: Move private devfreq_update_stats() into devfreq
      PM / devfreq: Add dependency on PM_OPP
      PM / devfreq: Fix memory leak when fail to register device

Rob Herring (1):
      PM / devfreq: Convert to using %pOF instead of full_name

 drivers/devfreq/Kconfig         |  1 +
 drivers/devfreq/devfreq-event.c |  4 ++--
 drivers/devfreq/devfreq.c       |  5 ++++-
 drivers/devfreq/governor.h      |  4 ++++
 include/linux/devfreq.h         | 13 -------------
 5 files changed, 11 insertions(+), 16 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZo3Y1AAoJEBOhurvWBoCK40EP/iwDOHQGyNGZbTGxpkGkFBeH
h2Az1RG2Ww5Xa5zvUM5WZZwTkDEvmGbWVf0GAHOeIpTxNCOZ4VPC+1JInjECY5+J
wkQjESQicLFPbTSj7qAia197VdN551RpFo3UvCH3Ryv1EEfjlfBboeSh5V/ZMkDE
ACm0A+9EMMhHQXhWMRn5MrT/uWxBtHSeu8lQcgK4ynELXmGOfkiodZ1+xErdVR1m
dmf0/V97Mbs8gEYf/pBDmsibZCtqRtkh55aan/I7Z667weiu45/FHMYl0N5DCzV9
aKnhhqcF2E4Ug5POrI9u+NLKDN4r9AHGG7n97bAXEtdk36yp49uUamPVGGq3HM9e
YGfqTswlr6Df8RKtfpOxJHy9D2sjhr47973QIqPZ4igad9Dr96BK0/B1rOj7TATH
s6WJK9Y8Hasqjzr+eroWxtBkrEnbT4YwBRQGiP8MDjGUmtmwGVlMEqQI8ga0Wex/
UYSQWXd3etVyjejgXTBKYVekiszQs3E5D3n5lNaKqdv+Yx3dIInnSTdLRhe/cKpd
MsgHgIt75rqlspzw22iN3NrMv1Vcm6cwZQwdx5FbKplvR0g1vShUs3DVCV7u0lUc
JrxYT2Pd69Ec/vG7zlgHaX8E6jJlwqRdhfj86gPbyM5h+22Wr+Q2kym30Vvrgzoh
gRctHBaSrh1FaaLKjyBc
=VD87
-----END PGP SIGNATURE-----
