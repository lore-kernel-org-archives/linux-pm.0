From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCHv2 07/17] ARM: mvebu: use a local variable to store the resume address
Date: Wed,  9 Jul 2014 15:40:11 +0200
Message-ID: <1404913221-17343-8-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:47342 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756047AbaGINkj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Jul 2014 09:40:39 -0400
In-Reply-To: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>
Cc: Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

The resume address used by the cpuidle code will not always be the
same depending on the SoC. Using a local variable to store the resume
address allows to keep the same function for the PM notifier but with
a different address. This address will be set during the
initialization of the cpuidle logic in pmsu.c.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/pmsu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index e976c3e..ab525b7 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -73,6 +73,8 @@ extern void ll_enable_coherency(void);
 
 extern void armada_370_xp_cpu_resume(void);
 
+static void *mvebu_cpu_resume;
+
 static struct platform_device mvebu_v7_cpuidle_device = {
 	.name = "cpuidle-armada-370-xp",
 };
@@ -299,7 +301,7 @@ static int mvebu_v7_cpu_pm_notify(struct notifier_block *self,
 {
 	if (action == CPU_PM_ENTER) {
 		unsigned int hw_cpu = cpu_logical_map(smp_processor_id());
-		mvebu_pmsu_set_cpu_boot_addr(hw_cpu, armada_370_xp_cpu_resume);
+		mvebu_pmsu_set_cpu_boot_addr(hw_cpu, mvebu_cpu_resume);
 	} else if (action == CPU_PM_EXIT) {
 		mvebu_v7_pmsu_idle_exit();
 	}
@@ -320,6 +322,7 @@ static int __init armada_xp_cpuidle_init(void)
 		return -ENODEV;
 	of_node_put(np);
 
+	mvebu_cpu_resume = armada_370_xp_cpu_resume;
 	mvebu_v7_cpuidle_device.dev.platform_data = armada_370_xp_cpu_suspend;
 
 	return 0;
-- 
2.0.0

