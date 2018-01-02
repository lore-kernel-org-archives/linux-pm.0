From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PULL REQ] Linux-PM / Devfreq
Date: Tue, 02 Jan 2018 02:11:02 +0000
Message-ID: <20180102021102epcms1p50fc5fe42844cb879479e2f4ea20d4b73@epcms1p5>
References: <CAJZ5v0iY932ZFzbCr=nXeR1SaRyFL1WoVVm3YmKvt1JykTfs=A@mail.gmail.com>
        <CGME20171228115707epcas1p1a09ad8507de22f2e2c04f73308a7954c@epcms1p5>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:10276 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751400AbeABCLI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jan 2018 21:11:08 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20180102021106epoutp014d07b7d3fcd9702cbea3d131bf1d5b2d~F3EtpRbD02023120231epoutp01N
        for <linux-pm@vger.kernel.org>; Tue,  2 Jan 2018 02:11:06 +0000 (GMT)
In-Reply-To: <CAJZ5v0iY932ZFzbCr=nXeR1SaRyFL1WoVVm3YmKvt1JykTfs=A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: "garsilva@embeddedor.com" <garsilva@embeddedor.com>, "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>

Dear Rafael,

Here goes a pull request for you from PM / Devfreq, which consists of a few trivial fixes on error handlings.


Cheers,
MyungJoo

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The following changes since commit 30a7acd573899fd8b8ac39236eff6468b195ac7d:

  Linux 4.15-rc6 (2017-12-31 14:47:43 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git for-next

for you to fetch changes up to 63f1e05f7fe9ca509c60154d6a833abf96eecdc9:

  PM / devfreq: Fix potential NULL pointer dereference in governor_store (2018-01-02 09:36:54 +0900)

- ----------------------------------------------------------------
Bjorn Andersson (1):
      PM / devfreq: Propagate error from devfreq_add_device()

Gustavo A. R. Silva (1):
      PM / devfreq: Fix potential NULL pointer dereference in governor_store

 drivers/devfreq/devfreq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJaStbRAAoJEBOhurvWBoCKWpgQAILaN0YCMfQgNy24eVpnRFLW
Ei2WjtymCiANrXx15yyD5qoedjc6GhPSM1yNT9RBnmNpHpgjEIybZiyom7cHc5zZ
wIDKSZ31Ah7zs4AWcR3S9OTxNUlnsUPQhdAIVuOWQUQfhRqdnBqIIZ6T0E7lvidt
PLrAhUjtW+2PkhxK9mT0apoJtVlqRWGjaRy5G4r3g8qdpv9T4omMvCp9ocrASPiV
QV1KHv7LTIEfImdRBPVN8P7/7/gc2TX2on33NiYaNbz+hAq5g3HSFnQvusorJU44
rSJq5NW9gZJNSaE3rOjsCtM6U6IS/K4XC1TNWAbSm6FAAp5DkJ3fVpFA1o2X0aa/
Ca42GKn63xiYyhzkFF96i9U810U2ydc7CDy1R8eQOY+X2PGzbOYIZQkwQgT2QnHH
OcpfrTKA2tr+h8OQfY2qz3DVoQgmP/ESHLMI9pNlcSI4cqiXddnr9n4vn2YUqxlI
HyMJGUiEl9WfbSy07MIqekp7vfNK+9riMLbZoQJaZF9W8sqzfga+ku5kkIMBLj86
dWmRjKMUnFAwF519eURRlfUNku8llZFdf7gf62/iVBL0XiAWq5+/5B0Spt1C3wfe
jNe18XrcR77h0jrNuDQNiN6NztUSOAFWN2Qf4+uSpXga6nAp8BDdGdUci6EvaZZa
8N7T+dsHrusI0SZZAGWM
=yODl
-----END PGP SIGNATURE-----
