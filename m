From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [V3 patch 05/19] ARM: ux500: cpuidle: replace for_each_online_cpu by for_each_possible_cpu
Date: Fri, 12 Apr 2013 14:35:51 +0200
Message-ID: <1365770165-27096-6-git-send-email-daniel.lezcano@linaro.org>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:38718 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753703Ab3DLMg0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Apr 2013 08:36:26 -0400
Received: by mail-wi0-f182.google.com with SMTP id hi18so1529568wib.15
        for <linux-pm@vger.kernel.org>; Fri, 12 Apr 2013 05:36:25 -0700 (PDT)
In-Reply-To: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linus.walleij@linaro.org, jason@lakedaemon.net, andrew@lunn.ch, kernel@pengutronix.de, swarren@wwwdotorg.org, santosh.shilimkar@ti.com, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, rob.herring@calxeda.com, nsekhar@ti.com, horms@verge.net.au, magnus.damm@gmail.com, deepthi@linux.vnet.ibm.com, lethal@linux-sh.org, jkosina@suse.cz, kgene.kim@samsung.com, khilman@deeprootsystems.com, tony@atomide.com, linux-pm@vger.kernel.org, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, josephl@nvidia.com

All the drivers are using, in their initialization function, the
for_each_possible_cpu macro.

Using for_each_online_cpu means the driver must handle the initialization
of the cpuidle device when a cpu is up which is not the case here.

Change the macro to for_each_possible_cpu as that fix the hotplug
initialization and make the initialization routine consistent with the
rest of the code in the different drivers.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-ux500/cpuidle.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ux500/cpuidle.c b/arch/arm/mach-ux500/cpuidle.c
index c29c1bf..5657d4a 100644
--- a/arch/arm/mach-ux500/cpuidle.c
+++ b/arch/arm/mach-ux500/cpuidle.c
@@ -125,7 +125,7 @@ int __init ux500_idle_init(void)
 		return ret;
 	}
 
-	for_each_online_cpu(cpu) {
+	for_each_possible(cpu) {
 		device = &per_cpu(ux500_cpuidle_device, cpu);
 		device->cpu = cpu;
 		ret = cpuidle_register_device(device);
@@ -139,7 +139,7 @@ out:
 	return ret;
 
 out_unregister:
-	for_each_online_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		device = &per_cpu(ux500_cpuidle_device, cpu);
 		cpuidle_unregister_device(device);
 	}
-- 
1.7.9.5

