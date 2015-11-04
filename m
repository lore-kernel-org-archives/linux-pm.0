From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [GIT PULL] Samsung Thermal for v4.4-rc1
Date: Wed, 04 Nov 2015 12:54:20 +0100
Message-ID: <20151104125420.6d733c3e@amdc2363>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:45253 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819AbbKDLye (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2015 06:54:34 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Rui Zhang <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>

Dear Eduardo,

Please find my pull request for Samsung Thermal development code
(v4.4-rc1):

The following changes since commit
8fb2b9ac2aadd6d87f89071c2c85f8c12b41c943:

  thermal: underflow bug in imx_set_trip_temp() (2015-10-30 11:35:50
  -0700)

are available in the git repository at:

  https://github.com/lmajewski/linux-samsung-thermal.git/next 
  git@github.com:lmajewski/linux-samsung-thermal.git/next

for you to fetch changes up to 2cbe45bee4df3cac65fdefde4756fb949bc8278c:

  thermal: exynos: Directly return 0 instead of using local ret
  variable (2015-11-04 12:21:58 +0100)

----------------------------------------------------------------
Krzysztof Kozlowski (5):
      thermal: exynos: Fix unbalanced regulator disable on probe failure
      thermal: exynos: Fix first temperature read after registering
      sensor thermal: exynos: Use IS_ERR() because regulator cannot be
                      NULL 
      thermal: exynos: Remove unneeded semicolon
      thermal: exynos: Directly return 0 instead of using local ret
                       variable

 drivers/thermal/samsung/exynos_tmu.c | 68
 ++++++++++++++++++++++++++++++++++++++------------------------------ 
 1 file changed, 38 insertions(+), 30 deletions(-)

Test HW: Exynos5433 - Odroid XU3 board.
Build GCC: 4.9.2
SHA1: 2cbe45b
[I've rebased on top of kernel_linux-soc-thermal/next branch at your
repository]


-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
