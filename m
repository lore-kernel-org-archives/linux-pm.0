From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 5/5] cpuidle: imx6: remove timer broadcast initialization
Date: Wed, 27 Mar 2013 11:22:13 +0100
Message-ID: <1364379733-23725-5-git-send-email-daniel.lezcano@linaro.org>
References: <1364379733-23725-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:50633 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753610Ab3C0KW1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Mar 2013 06:22:27 -0400
Received: by mail-we0-f169.google.com with SMTP id x43so2744434wey.14
        for <linux-pm@vger.kernel.org>; Wed, 27 Mar 2013 03:22:26 -0700 (PDT)
In-Reply-To: <1364379733-23725-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: tglx@linutronix.de, linus.walleij@linaro.org, kernel@pengutronix.de, santosh.shilimkar@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, patches@linaro.org

The initialization is done from the cpuidle framework.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/cpuidle-imx6q.c |   15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/arm/mach-imx/cpuidle-imx6q.c b/arch/arm/mach-imx/cpuidle-imx6q.c
index 5ae22f7..a783a63 100644
--- a/arch/arm/mach-imx/cpuidle-imx6q.c
+++ b/arch/arm/mach-imx/cpuidle-imx6q.c
@@ -6,7 +6,6 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/clockchips.h>
 #include <linux/cpuidle.h>
 #include <linux/module.h>
 #include <asm/cpuidle.h>
@@ -43,17 +42,6 @@ done:
 	return index;
 }
 
-/*
- * For each cpu, setup the broadcast timer because local timer
- * stops for the states other than WFI.
- */
-static void imx6q_setup_broadcast_timer(void *arg)
-{
-	int cpu = smp_processor_id();
-
-	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ON, &cpu);
-}
-
 static struct cpuidle_driver imx6q_cpuidle_driver = {
 	.name = "imx6q_cpuidle",
 	.owner = THIS_MODULE,
@@ -84,8 +72,5 @@ int __init imx6q_cpuidle_init(void)
 	/* Set chicken bit to get a reliable WAIT mode support */
 	imx6q_set_chicken_bit();
 
-	/* Configure the broadcast timer on each cpu */
-	on_each_cpu(imx6q_setup_broadcast_timer, NULL, 1);
-
 	return imx_cpuidle_init(&imx6q_cpuidle_driver);
 }
-- 
1.7.9.5

