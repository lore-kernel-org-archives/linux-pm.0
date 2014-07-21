From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 3/3] ARM: exynos_defconfig: Enable cpuidle driver
Date: Mon, 21 Jul 2014 10:36:11 +0200
Message-ID: <1405931771-24100-3-git-send-email-k.kozlowski@samsung.com>
References: <1405931771-24100-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:31028 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256AbaGUIgh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jul 2014 04:36:37 -0400
In-reply-to: <1405931771-24100-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Kukjin Kim <kgene.kim@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, Sachin Kamat <sachin.kamat@samsung.com>, Tushar Behera <tushar.behera@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>

The cpuidle driver for Exynos supports all SoCs now. AFTR is supported
only on Exynos4210 and Exynos5250 (WFI is used on other). Add the driver
to default exynos config.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/configs/exynos_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index fc7d1683bf67..237434e26565 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -24,6 +24,12 @@ CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_CMDLINE="root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M console=ttySAC1,115200 init=/linuxrc mem=256M"
+CONFIG_CPU_IDLE=y
+CONFIG_CPU_IDLE_MULTIPLE_DRIVERS=y
+CONFIG_CPU_IDLE_GOV_LADDER=y
+CONFIG_CPU_IDLE_GOV_MENU=y
+CONFIG_ARM_BIG_LITTLE_CPUIDLE=y
+CONFIG_ARM_EXYNOS_CPUIDLE=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_PM_RUNTIME=y
-- 
1.9.1

