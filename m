From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 08/16] ARM: mvebu: Use a local variable to store the resume address
Date: Fri, 27 Jun 2014 15:22:49 +0200
Message-ID: <1403875377-940-9-git-send-email-gregory.clement@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:42099 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753157AbaF0NX6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Jun 2014 09:23:58 -0400
In-Reply-To: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>

The resume address used by the cpu idle code will not always be the
same. Using a local variable to store the resume address allows to
keep the same function for the pm notifier but with a different
address. This address will be set during the initialization.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/pmsu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 454f0f9ede6b..8bf737fb3aac 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -79,6 +79,8 @@ extern void armada_370_xp_cpu_resume(void);
 static unsigned long pmsu_mp_phys_base;
 static void __iomem *pmsu_mp_base;
 
+static void *mvebu_cpu_resume;
+
 static struct platform_device mvebu_v7_cpuidle_device = {
 	.name = "cpuidle-armada-370-xp",
 };
@@ -281,7 +283,7 @@ static int mvebu_v7_cpu_pm_notify(struct notifier_block *self,
 {
 	if (action == CPU_PM_ENTER) {
 		unsigned int hw_cpu = cpu_logical_map(smp_processor_id());
-		mvebu_pmsu_set_cpu_boot_addr(hw_cpu, armada_370_xp_cpu_resume);
+		mvebu_pmsu_set_cpu_boot_addr(hw_cpu, mvebu_cpu_resume);
 	} else if (action == CPU_PM_EXIT) {
 		mvebu_v7_pmsu_idle_restore();
 	}
@@ -304,6 +306,7 @@ static __init bool armada_xp_cpuidle_init(void)
 		return false;
 	of_node_put(np);
 
+	mvebu_cpu_resume = armada_370_xp_cpu_resume;
 	mvebu_v7_cpuidle_device.dev.platform_data = armada_xp_370_cpu_suspend;
 	return true;
 }
-- 
1.8.1.2

