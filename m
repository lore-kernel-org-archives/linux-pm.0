From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH 0/6] thermal:exynos4: Thermal Measurement Unit fixes for
 Samsung SoCs
Date: Fri, 19 Apr 2013 18:38:07 +0200
Message-ID: <1366389493-8239-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:51136 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030782Ab3DSQiZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Apr 2013 12:38:25 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: Mike Turquette <mturquette@linaro.org>, Zhang Rui <rui.zhang@intel.com>, devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Amit Daniel Kachhap <amit.kachhap@linaro.org>, Lukasz Majewski <l.majewski@samsung.com>

This patch series provide various fixes for TMU block.
Namely, support for common clock framework and proper regulator VDD_TS has been 
added.
Moreover device tree definitions and documentation entry are now in place.

Lukasz Majewski (6):
  clk:exynos4:TMU Thermal Measurement Unit clock added to common clock
    framework
  thermal:exynos4: TMU Common clock framework support for TMU (Thermal
    Monitoring Unit)
  thermal:exynos4: TMU device tree support for Exynos4412 targets
  thermal: Support for TMU regulator defined at device tree
  thermal:exynos4: Enable support for Exynos4412 SoCs
  thermal:exynos4: Add documentation for Exynos SoC thermal bindings

 .../devicetree/bindings/clock/exynos4-clock.txt    |    1 +
 .../devicetree/bindings/thermal/exynos-thermal.txt |   22 +++++++++++
 arch/arm/boot/dts/exynos4x12.dtsi                  |   10 +++++
 drivers/clk/samsung/clk-exynos4.c                  |    6 ++-
 drivers/thermal/exynos_thermal.c                   |   41 +++++++++++++++-----
 5 files changed, 70 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/exynos-thermal.txt

-- 
1.7.10.4

