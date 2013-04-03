From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 1/9] ARM: cpuidle: remove useless declaration
Date: Wed,  3 Apr 2013 14:15:14 +0200
Message-ID: <1364991322-20585-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:54617 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758652Ab3DCMP2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Apr 2013 08:15:28 -0400
Received: by mail-wi0-f171.google.com with SMTP id hn17so3547312wib.16
        for <linux-pm@vger.kernel.org>; Wed, 03 Apr 2013 05:15:27 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, rnayak@ti.com, swarren@wwwdotorg.org, linux-tegra@vger.kernel.org, horms+renesas@verge.net.au, santosh.shilimkar@ti.com, arnd@arndb.de, lenb@kernel.org, nsekhar@ti.com, josephl@nvidia.com, deepthi@linux.vnet.ibm.com

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

