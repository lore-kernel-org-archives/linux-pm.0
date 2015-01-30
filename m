From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 0/4] ARM: EXYNOS: cpuidle: add AFTR mode support for
 Exynos3250
Date: Fri, 30 Jan 2015 13:52:48 +0100
Message-ID: <1422622373-24769-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:16027 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753813AbbA3MxH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 30 Jan 2015 07:53:07 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com

Hi,

This patch series adds support for AFTR idle mode on boards with
Exynos3250 SoC and allows EXYNOS cpuidle driver usage on these
boards.

It has been tested on Samsung Rinato board (Gear 2).

Depends on:
- for-next branch (commit: ce275c369a0b) of linux-samsung.git
  kernel tree

Changes since v1:
- rebased on top of for-next branch (commit: ce275c369a0b) of
  linux-samsung.git kernel tree
- fixed lockup on hotplug by using dsb_sev() instead of IPI in
  exynos_boot_secondary() on Exynos3250

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (4):
  ARM: EXYNOS: fix CPU1 hotplug for AFTR mode on Exynos3250
  ARM: EXYNOS: add code for setting/clearing boot flag
  ARM: EXYNOS: cpuidle: add AFTR mode support for Exynos3250
  ARM: EXYNOS: cpuidle: allow driver usage on Exynos3250 SoC

 arch/arm/mach-exynos/common.h   |  6 ++++++
 arch/arm/mach-exynos/exynos.c   | 26 ++++++++++++++++++++++++++
 arch/arm/mach-exynos/firmware.c |  8 +++++++-
 arch/arm/mach-exynos/platsmp.c  | 23 ++++++++++++++++++++---
 arch/arm/mach-exynos/pm.c       | 12 +++++++++++-
 arch/arm/mach-exynos/regs-pmu.h |  3 +++
 arch/arm/mach-exynos/smc.h      |  9 +++++++++
 7 files changed, 82 insertions(+), 5 deletions(-)

-- 
1.8.2.3

