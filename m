From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [GIT PULL] Samsung Thermal FIXES for v4.2-rc1
Date: Mon, 06 Jul 2015 17:26:57 +0200
Message-ID: <20150706172657.3af87d97@amdc2363>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:51788 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874AbbGFP1D (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jul 2015 11:27:03 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Rui Zhang <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>

Dear Eduardo,

Please find my pull request for Samsung Thermal fixes (v4.2-rc1):

The following changes since commit
efa86858e1d8970411a140fa1e0c4dd18a8f2a89:

  thermal: armada: Update Armada 380 thermal sensor coefficients
  (2015-05-09 01:00:31 -0700)

are available in the git repository at:

  git@github.com:lmajewski/linux-samsung-thermal.git fixes

for you to fetch changes up to e4dc28277205cfb02f8dd96fe694a1bcc2dc41b1:

  thermal: exynos: Remove unused code related to platform_data on
  probe() (2015-07-06 17:09:15 +0200)

----------------------------------------------------------------
Chanwoo Choi (2):
      thermal: exynos: Add the dependency of CONFIG_THERMAL_OF instead
of CONFIG_OF thermal: exynos: Remove unused code related to
platform_data on probe()

Krzysztof Kozlowski (1):
      thermal: exynos: Disable the regulator on probe failure

 drivers/thermal/samsung/Kconfig      | 2 +-
 drivers/thermal/samsung/exynos_tmu.c | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)


Test HW: Exynos4412 - Trats2 board.
Build GCC: 4.9.2
SHA1: e4dc28277205cfb02f8dd96fe694a1bcc2dc41b1
[I've rebased on top of kernel_linux-soc-thermal/fixes branch at your
repository]

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
