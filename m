From: kernel@martin.sperl.org
Subject: [PATCH-V2 5/5] ARM: multi_v7_defconfig: bcm2835: add bcm2835-thermal driver
Date: Fri, 13 May 2016 13:13:06 +0000
Message-ID: <1463145186-12906-6-git-send-email-kernel@martin.sperl.org>
References: <1463145186-12906-1-git-send-email-kernel@martin.sperl.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from 212-186-180-163.dynamic.surfer.at ([212.186.180.163]:54635 "EHLO
	cgate.sperl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932217AbcEMNNW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 May 2016 09:13:22 -0400
In-Reply-To: <1463145186-12906-1-git-send-email-kernel@martin.sperl.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Russell King <linux@arm.linux.org.uk>, linux-pm@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>, linux-arm-kernel@lists.infradead.org
Cc: Martin Sperl <kernel@martin.sperl.org>

From: Martin Sperl <kernel@martin.sperl.org>

Add the thermal driver to list of compiled modules in
multi_v7_defconfig.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 2823490..5f0f5a3 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -422,6 +422,7 @@ CONFIG_CPU_THERMAL=y
 CONFIG_ROCKCHIP_THERMAL=y
 CONFIG_RCAR_THERMAL=y
 CONFIG_ARMADA_THERMAL=y
+CONFIG_BCM2835_THERMAL=y
 CONFIG_DAVINCI_WATCHDOG=m
 CONFIG_EXYNOS_THERMAL=m
 CONFIG_ST_THERMAL_SYSCFG=y
-- 
2.1.4

