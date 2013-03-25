From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 06/15] ARM: cpuidle: remove useless declaration
Date: Mon, 25 Mar 2013 18:55:31 +0100
Message-ID: <1364234140-514-7-git-send-email-daniel.lezcano@linaro.org>
References: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:64279 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758819Ab3CYRz4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Mar 2013 13:55:56 -0400
Received: by mail-wg0-f52.google.com with SMTP id 15so1069044wgd.7
        for <linux-pm@vger.kernel.org>; Mon, 25 Mar 2013 10:55:55 -0700 (PDT)
In-Reply-To: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl, tglx@linutronix.de
Cc: patches@linaro.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, lenb@kernel.org, nsekhar@ti.com, kevin.hilman@linaro.org, horms@verge.net.au, magnus.damm@gmail.com, kernel@pengutronix.de, ben-linux@fluff.org, kgene.kim@samsung.com, rob.herring@calxeda.com, jason@lakedaemon.net, andrew@lunn.ch, linus.walleij@linaro.org, linux@arm.linux.org.uk

The noop functions code is not necessary because the header file is
included in files which are compiled when CONFIG_CPU_IDLE is on.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/include/asm/cpuidle.h |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/cpuidle.h b/arch/arm/include/asm/cpuidle.h
index 2fca60a..7367787 100644
--- a/arch/arm/include/asm/cpuidle.h
+++ b/arch/arm/include/asm/cpuidle.h
@@ -1,13 +1,8 @@
 #ifndef __ASM_ARM_CPUIDLE_H
 #define __ASM_ARM_CPUIDLE_H
 
-#ifdef CONFIG_CPU_IDLE
 extern int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
-		struct cpuidle_driver *drv, int index);
-#else
-static inline int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
-		struct cpuidle_driver *drv, int index) { return -ENODEV; }
-#endif
+				    struct cpuidle_driver *drv, int index);
 
 /* Common ARM WFI state */
 #define ARM_CPUIDLE_WFI_STATE_PWR(p) {\
-- 
1.7.9.5

