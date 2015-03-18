From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 0/5] cpuidle: exynos: add coupled cpuidle support for
 Exynos3250
Date: Wed, 18 Mar 2015 14:09:52 +0100
Message-ID: <1426684197-22281-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:25885 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756331AbbCRNKx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Mar 2015 09:10:53 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Colin Cross <ccross@google.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com

Hi,

The following patchset adds coupled cpuidle support for Exynos3250
to an existing cpuidle-exynos driver.  As a result it enables AFTR
mode to be used by default on Exynos3250 without the need to hot
unplug CPU1 first.

The patchset depends on:
- for-next branch (commit: 77105c882ba6) of linux-samsung.git
  kernel tree
- "[PATCH] ARM: EXYNOS: Fix failed second suspend on Exynos4"
  (https://lkml.org/lkml/2015/2/3/481)
- "[PATCH v3 0/4] ARM: EXYNOS: cpuidle: add AFTR mode support for
  Exynos3250"
  (https://lkml.org/lkml/2015/3/18/282)

Changes since v1:
- rebased on top of for-next branch (commit: 77105c882ba6) of
  linux-samsung.git kernel tree

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (5):
  ARM: EXYNOS: fix exynos_boot_secondary() return value on timeout
  ARM: EXYNOS: make exynos_core_restart() less verbose
  ARM: EXYNOS: add exynos_set_boot_addr() helper
  ARM: EXYNOS: add exynos_get_boot_addr() helper
  cpuidle: exynos: add coupled cpuidle support for Exynos3250

 arch/arm/include/asm/firmware.h |  4 ++
 arch/arm/mach-exynos/common.h   |  4 +-
 arch/arm/mach-exynos/exynos.c   |  3 +-
 arch/arm/mach-exynos/firmware.c | 18 +++++++++
 arch/arm/mach-exynos/platsmp.c  | 86 ++++++++++++++++++++++++++++-------------
 arch/arm/mach-exynos/pm.c       | 51 ++++++++++++++++++++----
 6 files changed, 129 insertions(+), 37 deletions(-)

-- 
1.8.2.3

