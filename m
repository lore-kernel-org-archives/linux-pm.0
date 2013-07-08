From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [GIT PULL 2/3] soc-thermal: introduce IMX thermal driver (for 3.12)
Date: Mon, 8 Jul 2013 11:17:52 -0400
Message-ID: <1373296673-19295-2-git-send-email-eduardo.valentin@ti.com>
References: <1373296673-19295-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33785 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752304Ab3GHPSp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jul 2013 11:18:45 -0400
In-Reply-To: <1373296673-19295-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>

Rui,

Please pull the following change for 3.12.

The changelog is as it follows:

. Add IMX thermal driver.

Cc: Shawn Guo <shawn.guo@linaro.org>

The following changes since commit 9d1968fdabc69981ea98ea82082de1cc12a60385:

  Merge branch 'cpu-package-thermal' of .git into next (2013-06-18 07:26:49 +0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git 

for you to fetch changes up to f68b4939b9146551238aeb228b3b1133bdd4772a:

  thermal: add imx thermal driver support (2013-07-08 10:44:21 -0400)

----------------------------------------------------------------
Shawn Guo (1):
      thermal: add imx thermal driver support

 .../devicetree/bindings/thermal/imx-thermal.txt    |  17 +
 drivers/thermal/Kconfig                            |  11 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/imx_thermal.c                      | 397 +++++++++++++++++++++
 4 files changed, 426 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/imx-thermal.txt
 create mode 100644 drivers/thermal/imx_thermal.c
