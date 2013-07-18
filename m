From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 4/4] ARM: exynos: cpuidle: Remove useless headers
Date: Thu, 18 Jul 2013 14:54:30 +0200
Message-ID: <1374152070-21008-4-git-send-email-daniel.lezcano@linaro.org>
References: <1374152070-21008-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:40831 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754440Ab3GRMyk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2013 08:54:40 -0400
Received: by mail-wi0-f174.google.com with SMTP id k10so6591878wiv.13
        for <linux-pm@vger.kernel.org>; Thu, 18 Jul 2013 05:54:39 -0700 (PDT)
In-Reply-To: <1374152070-21008-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kgene.kim@samsung.com, rjw@sisk.pl
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org

The headers:

#include <linux/kernel.h>
#include <linux/export.h>
#include <linux/time.h>
#include <asm/unified.h>

are not needed. Removed them.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-exynos/cpuidle.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index 8d06128..027f5e7 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -8,18 +8,14 @@
  * published by the Free Software Foundation.
 */
 
-#include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/cpuidle.h>
 #include <linux/cpu_pm.h>
 #include <linux/io.h>
-#include <linux/export.h>
-#include <linux/time.h>
 
 #include <asm/proc-fns.h>
 #include <asm/smp_scu.h>
 #include <asm/suspend.h>
-#include <asm/unified.h>
 #include <asm/cpuidle.h>
 #include <mach/regs-clock.h>
 #include <mach/regs-pmu.h>
-- 
1.7.9.5

