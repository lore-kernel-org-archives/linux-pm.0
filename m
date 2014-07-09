From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCHv2 08/17] ARM: mvebu: make the snoop disabling optional in mvebu_v7_pmsu_idle_prepare()
Date: Wed,  9 Jul 2014 15:40:12 +0200
Message-ID: <1404913221-17343-9-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:47333 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756007AbaGINkk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Jul 2014 09:40:40 -0400
In-Reply-To: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>
Cc: Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

On some mvebu v7 SoCs (the ones using a Cortex-A9 core and not a PJ4B
core), the snoop disabling feature does not exist as the hardware
coherency is handled in a different way. Therefore, in preparation to
the introduction of the cpuidle support for those SoCs, this commit
modifies the mvebu_v7_psmu_idle_prepare() function to take several
flags, which allow to decide whether snooping should be disabled, and
whether we should use the deep idle mode or not.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/pmsu.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index ab525b7..15e67bf 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -191,8 +191,14 @@ static void mvebu_v7_pmsu_enable_l2_powerdown_onidle(void)
 	writel(reg, pmsu_mp_base + L2C_NFABRIC_PM_CTL);
 }
 
+enum pmsu_idle_prepare_flags {
+	PMSU_PREPARE_NORMAL = 0,
+	PMSU_PREPARE_DEEP_IDLE = BIT(0),
+	PMSU_PREPARE_SNOOP_DISABLE = BIT(1),
+};
+
 /* No locking is needed because we only access per-CPU registers */
-static int mvebu_v7_pmsu_idle_prepare(bool deepidle)
+static int mvebu_v7_pmsu_idle_prepare(unsigned long flags)
 {
 	unsigned int hw_cpu = cpu_logical_map(smp_processor_id());
 	u32 reg;
@@ -216,26 +222,32 @@ static int mvebu_v7_pmsu_idle_prepare(bool deepidle)
 
 	reg = readl(pmsu_mp_base + PMSU_CONTROL_AND_CONFIG(hw_cpu));
 	/* ask HW to power down the L2 Cache if needed */
-	if (deepidle)
+	if (flags & PMSU_PREPARE_DEEP_IDLE)
 		reg |= PMSU_CONTROL_AND_CONFIG_L2_PWDDN;
 
 	/* request power down */
 	reg |= PMSU_CONTROL_AND_CONFIG_PWDDN_REQ;
 	writel(reg, pmsu_mp_base + PMSU_CONTROL_AND_CONFIG(hw_cpu));
 
-	/* Disable snoop disable by HW - SW is taking care of it */
-	reg = readl(pmsu_mp_base + PMSU_CPU_POWER_DOWN_CONTROL(hw_cpu));
-	reg |= PMSU_CPU_POWER_DOWN_DIS_SNP_Q_SKIP;
-	writel(reg, pmsu_mp_base + PMSU_CPU_POWER_DOWN_CONTROL(hw_cpu));
+	if (flags & PMSU_PREPARE_SNOOP_DISABLE) {
+		/* Disable snoop disable by HW - SW is taking care of it */
+		reg = readl(pmsu_mp_base + PMSU_CPU_POWER_DOWN_CONTROL(hw_cpu));
+		reg |= PMSU_CPU_POWER_DOWN_DIS_SNP_Q_SKIP;
+		writel(reg, pmsu_mp_base + PMSU_CPU_POWER_DOWN_CONTROL(hw_cpu));
+	}
 
 	return 0;
 }
 
 int armada_370_xp_pmsu_idle_enter(unsigned long deepidle)
 {
+	unsigned long flags = PMSU_PREPARE_SNOOP_DISABLE;
 	int ret;
 
-	ret = mvebu_v7_pmsu_idle_prepare(deepidle);
+	if (deepidle)
+		flags |= PMSU_PREPARE_DEEP_IDLE;
+
+	ret = mvebu_v7_pmsu_idle_prepare(flags);
 	if (ret)
 		return ret;
 
-- 
2.0.0

