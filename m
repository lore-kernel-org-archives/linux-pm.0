From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PULL REQUEST for Rafael] PM / devfreq: pull request-2 bugfixes
Date: Wed, 21 Nov 2012 19:45:43 +0900
Message-ID: <1353494743-4581-1-git-send-email-myungjoo.ham@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:9751 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754173Ab2KUKpp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 21 Nov 2012 05:45:45 -0500
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MDU004SF386K0Z0@mailout1.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 21 Nov 2012 19:45:45 +0900 (KST)
Received: from localhost.localdomain ([10.90.51.65])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MDU00IZL3851M60@mmp1.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 21 Nov 2012 19:45:44 +0900 (KST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, sachin.kamat@linaro.org, myungjoo.ham@gmail.com


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The following changes since commit aa0745b51987fbaf628ee0943907db177335522d:

  Merge branch 'pm-devfreq-next' into linux-next (2012-11-21 01:27:47 +0100)
, which is HEAD of Rafael's linux-pm.git linux-next branch.

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git tags/pull_req_20121121

MyungJoo Ham (2):
      PM / devfreq: remove compiler error when a governor is module
      PM / devfreq: missing rcu_read_lock() added for find_device_opp()

Sachin Kamat (2):
      PM / devfreq: Fix incorrect argument in error message
      PM / devfreq: Fix return value in devfreq_remove_governor()

 drivers/devfreq/devfreq.c |   30 ++++++++++++++++++++++--------
 include/linux/devfreq.h   |    2 +-
 2 files changed, 23 insertions(+), 9 deletions(-)


- ---
The four patches are trivial bugfixes following up the previous pull-request.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJQrK/+AAoJEBOhurvWBoCKFL4P/2OVlI+s3IxG+XmhJbBY6h9N
PLvxP3pTT9o3IvITZ66ASX/ZwYL5HxX0Nq0gT1Z7kNxJ9O0m3o/3+JPPFS8b60GX
LGU/FE5SNgNAG9PsS9cq3CTd9EUUb1YVb6uj0pWNjgCvvGrwZ+UmQKJc/FSdzdiD
weFd6szc4M2chWl7M/EolsWzoZ3r79gOJPal0yw/9G1RbTCUSRnC1dxb1kAEcvmv
bqf4EBk6IToc1REdtQ8bn6ihHBkqHKFM1MygWF+L/Dwowwme9OwraHrg3SehwU4Q
lYlVPkbc1JcsxKhpdEs95Mtz0CFHdhskxo+SM1DpBZ2HpzDzti8gqV8MVyNzpQfw
WqKjFixIaMcAZ9YsKOgmQbBiGtwprTBn8a4OZZC25LNfEmkFHScEoHUYEsp9aakj
xfTgoKZ5qAxBvo/Xyl+aT3VUnyHvPk/TXai7AySBf0wTpk6YDYL2NpRY4dHCf7lL
MUxXQgXBJzIauFZyGZVGTfHBBsLFCkOcWdkymjMZ0usGTKUNT8cYHkbMf1VsLz9w
HGdhpuejhfoInuVQDesXkgmT7NcdBI0mkmIKRbPvAl7nVgRMbJMn13qKvDGzgvWd
VM2ZxZki/PNYf80+8m+oDnHvTvRJ8msy7lti8n6+OGFjlAueweU0B1TsS7Gp3Ths
cexSPLga49rnmf6UyXZ5
=wfji
-----END PGP SIGNATURE-----
