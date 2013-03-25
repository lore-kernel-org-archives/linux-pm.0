From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 13/15] ARM: shmobile: pm: fix init sections
Date: Mon, 25 Mar 2013 18:55:38 +0100
Message-ID: <1364234140-514-14-git-send-email-daniel.lezcano@linaro.org>
References: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:48032 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758320Ab3CYR4Q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Mar 2013 13:56:16 -0400
Received: by mail-we0-f169.google.com with SMTP id x43so939538wey.0
        for <linux-pm@vger.kernel.org>; Mon, 25 Mar 2013 10:56:15 -0700 (PDT)
In-Reply-To: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl, tglx@linutronix.de
Cc: patches@linaro.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, lenb@kernel.org, nsekhar@ti.com, kevin.hilman@linaro.org, horms@verge.net.au, magnus.damm@gmail.com, kernel@pengutronix.de, ben-linux@fluff.org, kgene.kim@samsung.com, rob.herring@calxeda.com, jason@lakedaemon.net, andrew@lunn.ch, linus.walleij@linaro.org, linux@arm.linux.org.uk

Add the __init section for the functions which are called
at init time.

Signed-off-by: Daniel Lezcano <daniel.linaro.org>
---
 arch/arm/mach-shmobile/cpuidle.c   |    4 ++--
 arch/arm/mach-shmobile/pm-sh7372.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/cpuidle.c b/arch/arm/mach-shmobile/cpuidle.c
index 9e05026..068f9ca 100644
--- a/arch/arm/mach-shmobile/cpuidle.c
+++ b/arch/arm/mach-shmobile/cpuidle.c
@@ -36,12 +36,12 @@ static struct cpuidle_driver shmobile_cpuidle_default_driver = {
 
 static struct cpuidle_driver *cpuidle_drv = &shmobile_cpuidle_default_driver;
 
-void shmobile_cpuidle_set_driver(struct cpuidle_driver *drv)
+void __init shmobile_cpuidle_set_driver(struct cpuidle_driver *drv)
 {
 	cpuidle_drv = drv;
 }
 
-int shmobile_cpuidle_init(void)
+int __init shmobile_cpuidle_init(void)
 {
 	struct cpuidle_device *dev = &shmobile_cpuidle_dev;
 
diff --git a/arch/arm/mach-shmobile/pm-sh7372.c b/arch/arm/mach-shmobile/pm-sh7372.c
index a0826a4..f6b14ca 100644
--- a/arch/arm/mach-shmobile/pm-sh7372.c
+++ b/arch/arm/mach-shmobile/pm-sh7372.c
@@ -450,12 +450,12 @@ static struct cpuidle_driver sh7372_cpuidle_driver = {
 	},
 };
 
-static void sh7372_cpuidle_init(void)
+static void __init sh7372_cpuidle_init(void)
 {
 	shmobile_cpuidle_set_driver(&sh7372_cpuidle_driver);
 }
 #else
-static void sh7372_cpuidle_init(void) {}
+static void __init sh7372_cpuidle_init(void) {}
 #endif
 
 #ifdef CONFIG_SUSPEND
-- 
1.7.9.5

