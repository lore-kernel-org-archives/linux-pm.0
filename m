From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 2/3] ARM: ux500: cpuidle: Remove pointless include
Date: Tue, 16 Jul 2013 01:25:25 +0200
Message-ID: <1373930726-15475-2-git-send-email-daniel.lezcano@linaro.org>
References: <1373930726-15475-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:45624 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755007Ab3GOXZb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jul 2013 19:25:31 -0400
Received: by mail-we0-f175.google.com with SMTP id t59so21505wes.34
        for <linux-pm@vger.kernel.org>; Mon, 15 Jul 2013 16:25:30 -0700 (PDT)
In-Reply-To: <1373930726-15475-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linus.walleij@linaro.org, patches@linaro.org

From: Linus Walleij <linus.walleij@linaro.org>

The db8500-regs.h file does not need to be included by the cpuidle
driver.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-ux500/cpuidle.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-ux500/cpuidle.c b/arch/arm/mach-ux500/cpuidle.c
index c0cb37c..e056465 100644
--- a/arch/arm/mach-ux500/cpuidle.c
+++ b/arch/arm/mach-ux500/cpuidle.c
@@ -21,8 +21,6 @@
 #include <asm/cpuidle.h>
 #include <asm/proc-fns.h>
 
-#include "db8500-regs.h"
-
 static atomic_t master = ATOMIC_INIT(0);
 static DEFINE_SPINLOCK(master_lock);
 
-- 
1.7.9.5

