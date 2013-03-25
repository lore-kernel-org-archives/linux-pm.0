From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 05/15] cpuidle: imx6: remove timer broadcast initialization
Date: Mon, 25 Mar 2013 18:55:30 +0100
Message-ID: <1364234140-514-6-git-send-email-daniel.lezcano@linaro.org>
References: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:52638 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758819Ab3CYRzy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Mar 2013 13:55:54 -0400
Received: by mail-wi0-f177.google.com with SMTP id hm14so7019873wib.16
        for <linux-pm@vger.kernel.org>; Mon, 25 Mar 2013 10:55:53 -0700 (PDT)
In-Reply-To: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl, tglx@linutronix.de
Cc: patches@linaro.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, lenb@kernel.org, nsekhar@ti.com, kevin.hilman@linaro.org, horms@verge.net.au, magnus.damm@gmail.com, kernel@pengutronix.de, ben-linux@fluff.org, kgene.kim@samsung.com, rob.herring@calxeda.com, jason@lakedaemon.net, andrew@lunn.ch, linus.walleij@linaro.org, linux@arm.linux.org.uk

The initialization is done from the cpuidle framework.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
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

