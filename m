From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCHv2 01/17] ARM: mvebu: split again armada_370_xp_pmsu_idle_enter() in PMSU code
Date: Wed,  9 Jul 2014 15:40:05 +0200
Message-ID: <1404913221-17343-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:47286 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756007AbaGINkc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Jul 2014 09:40:32 -0400
In-Reply-To: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>
Cc: Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

do_armada_370_xp_cpu_suspend() and armada_370_xp_pmsu_idle_prepare(),
have been merged into a single function called
armada_370_xp_pmsu_idle_enter() by the commit "bbb92284b6c8 ARM:
mvebu: slightly refactor/rename PMSU idle related functions", in
prepare for the introduction of the CPU hotplug support for Armada XP.

But for cpuidle the prepare function will be common to all the mvebu
SoCs that use the PMSU, while the suspend function will be specific to
each SoC. Keeping the prepare function separate will help reducing
code duplication while new SoC support is added.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/pmsu.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index b31a829..5fda549 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -143,7 +143,7 @@ static void armada_370_xp_pmsu_enable_l2_powerdown_onidle(void)
 }
 
 /* No locking is needed because we only access per-CPU registers */
-int armada_370_xp_pmsu_idle_enter(unsigned long deepidle)
+static int armada_370_xp_prepare(unsigned long deepidle)
 {
 	unsigned int hw_cpu = cpu_logical_map(smp_processor_id());
 	u32 reg;
@@ -179,6 +179,17 @@ int armada_370_xp_pmsu_idle_enter(unsigned long deepidle)
 	reg |= PMSU_CPU_POWER_DOWN_DIS_SNP_Q_SKIP;
 	writel(reg, pmsu_mp_base + PMSU_CPU_POWER_DOWN_CONTROL(hw_cpu));
 
+	return 0;
+}
+
+int armada_370_xp_pmsu_idle_enter(unsigned long deepidle)
+{
+	int ret;
+
+	ret = armada_370_xp_prepare(deepidle);
+	if (ret)
+		return ret;
+
 	v7_exit_coherency_flush(all);
 
 	ll_disable_coherency();
-- 
2.0.0

