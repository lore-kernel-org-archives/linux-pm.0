From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 2/9] ARM: shmobile: pm: fix init sections
Date: Fri, 29 Mar 2013 11:31:28 +0100
Message-ID: <1364553095-25110-2-git-send-email-daniel.lezcano@linaro.org>
References: <1364553095-25110-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:34792 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167Ab3C2Kbm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 29 Mar 2013 06:31:42 -0400
Received: by mail-we0-f171.google.com with SMTP id d46so264883wer.16
        for <linux-pm@vger.kernel.org>; Fri, 29 Mar 2013 03:31:41 -0700 (PDT)
In-Reply-To: <1364553095-25110-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, rnayak@ti.com, swarren@wwwdotorg.org, linux-tegra@vger.kernel.org, horms+renesas@verge.net.au, santosh.shilimkar@ti.com, arnd@arndb.de, lenb@kernel.org, nsekhar@ti.com

Add the __init section for the functions which are called
at init time.

Signed-off-by: Daniel Lezcano <daniel.linaro.org>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
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

