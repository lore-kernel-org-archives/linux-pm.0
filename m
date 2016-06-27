From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [RFC PATCH 0/4] ARM: remove big.LITTLE switcher support
Date: Mon, 27 Jun 2016 13:26:06 +0200
Message-ID: <1467026770-5699-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:51367 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661AbcF0L07 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jun 2016 07:26:59 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicolas Pitre <nico@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>
Cc: Dave Martin <dave.martin@linaro.org>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com

Hi,

It seems that in mainline kernel big.LITTLE switcher support
may be usable only on ARM Versatile Express TC2 platform
(but even this platform doesn't enable it in its defconfig).

The following patchset removes big.LITTLE switcher support
(from both ARM core and arm_big_little CPUfreq driver) in
favor of using HMP.

Since HMP support at scheduler level is not yet merged this
patchset is probably premature and thus is marked as RFC.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (4):
  ARM: remove big.LITTLE switcher support
  cpufreq: arm_big_little: remove big.LITTLE switcher support
  cpufreq: exynos: remove big.LITTLE switcher dependency
  irqchip/gic: remove big.LITTLE switcher support

 arch/arm/Kconfig                       |  19 +-
 arch/arm/common/Makefile               |   2 -
 arch/arm/common/bL_switcher.c          | 802 ---------------------------------
 arch/arm/common/bL_switcher_dummy_if.c |  71 ---
 arch/arm/include/asm/bL_switcher.h     |  77 ----
 drivers/cpufreq/arm_big_little.c       | 379 +---------------
 drivers/cpufreq/cpufreq-dt-platdev.c   |   2 -
 drivers/irqchip/irq-gic.c              | 137 ------
 8 files changed, 25 insertions(+), 1464 deletions(-)
 delete mode 100644 arch/arm/common/bL_switcher.c
 delete mode 100644 arch/arm/common/bL_switcher_dummy_if.c
 delete mode 100644 arch/arm/include/asm/bL_switcher.h

-- 
1.9.1

