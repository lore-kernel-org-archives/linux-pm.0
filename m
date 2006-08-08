From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: [RFC] PoweOP, OMAP1 CpuFreq PowerOP integration 3/3
Date: Tue, 08 Aug 2006 05:36:46 +0400
Message-ID: <44D7EAAE.8040004@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030108090706030400080309"
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------030108090706030400080309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

A minimal example of modifying cpufreq to use PowerOP on OMAP1710.

cpufreq utilizes 2 power parameters out of 8 available on omap1 platform.

The are two patches attached. The patch order is :

mpu.clock.reference.count.fix.patch
omap1.cpufreq.powerop.patch

mpu.clock.reference.count.fix.patch is just a trivial fix for a
minor issue.

--------------030108090706030400080309
Content-Type: text/x-patch;
 name="mpu.clock.reference.count.fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mpu.clock.reference.count.fix.patch"

diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
index a0c71dc..9c74729 100644
--- a/arch/arm/plat-omap/cpu-omap.c
+++ b/arch/arm/plat-omap/cpu-omap.c
@@ -101,12 +101,13 @@ static int __init omap_cpu_init(struct c
 {
 	struct clk * mpu_clk;
 
+	if (policy->cpu != 0)
+		return -EINVAL;
+
 	mpu_clk = clk_get(NULL, MPU_CLK);
 	if (IS_ERR(mpu_clk))
 		return PTR_ERR(mpu_clk);
 
-	if (policy->cpu != 0)
-		return -EINVAL;
 	policy->cur = policy->min = policy->max = omap_getspeed(0);
 	policy->governor = CPUFREQ_DEFAULT_GOVERNOR;
 	policy->cpuinfo.min_freq = clk_round_rate(mpu_clk, 0) / 1000;

--------------030108090706030400080309
Content-Type: text/x-patch;
 name="omap1.cpufreq.powerop.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="omap1.cpufreq.powerop.patch"

diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
index 9c74729..ca2061f 100644
--- a/arch/arm/plat-omap/cpu-omap.c
+++ b/arch/arm/plat-omap/cpu-omap.c
@@ -3,6 +3,8 @@
  *
  *  CPU frequency scaling for OMAP
  *
+ *  PowerOP support by Eugeny S. Mints <eugeny.mints@gmail.com>
+ *
  *  Copyright (C) 2005 Nokia Corporation
  *  Written by Tony Lindgren <tony@atomide.com>
  *
@@ -20,6 +22,7 @@ #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/err.h>
 #include <linux/clk.h>
+#include <linux/powerop.h>
 
 #include <asm/hardware.h>
 #include <asm/io.h>
@@ -33,42 +36,83 @@ #else
 #define MPU_CLK		"virt_prcm_set"
 #endif
 
+
+static char *names[] = {"192", "96", "48", "24"};
+
+#define OP(khz, mv) \
+	{ \
+		.frequency = khz, \
+		.index = mv \
+	} 
+
+/* 
+ * this is representation of operatin points on cpufreq layer: cpufreq
+ * knows and operates on only two power parameters (while an omap1 platform
+ * provides wider range of power parameters)
+ */
+static struct cpufreq_frequency_table opoints[] = {
+#ifdef CONFIG_OMAP_ARM_192MHZ
+	OP(192000, 1300),
+	OP(96000,  1300),
+	OP(48000,  1300),
+	OP(24000,  1300),
+	{ .frequency = CPUFREQ_TABLE_END }
+#else
+#error "please choose OMAP 192MHZ option (exlusively)"
+#endif /* CONFIG_OMAP_ARM_192MHZ */
+};
+
+#define MAX_OP_INDEX    (ARRAY_SIZE(opoints) - 2)
+
+/* 
+ * returns index in opoint array of operating point with closest cpu rate
+ * which(rate) is <= requested rate or EINVAL 
+ */
+static long
+round_max_rate(long rate)
+{
+	int i;
+	for (i = 0; i <= MAX_OP_INDEX; i++)
+		if (opoints[i].frequency <= rate)
+			return i;
+	return -EINVAL;		
+}
+/* 
+ * returns index in opoint array of operating point with closest cpu rate 
+ * which(rate) is >= requested rate or EINVAL 
+ */
+static long
+round_min_rate(long rate)
+{
+	int i;
+	for (i = MAX_OP_INDEX; i >= 0; i--)
+		if (opoints[i].frequency >= rate)
+			return i;
+	return -EINVAL;		
+}
+#
+
 /* TODO: Add support for SDRAM timing changes */
 
 int omap_verify_speed(struct cpufreq_policy *policy)
 {
-	struct clk * mpu_clk;
-
 	if (policy->cpu)
 		return -EINVAL;
-
-	cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
-				     policy->cpuinfo.max_freq);
-	mpu_clk = clk_get(NULL, MPU_CLK);
-	if (IS_ERR(mpu_clk))
-		return PTR_ERR(mpu_clk);
-	policy->min = clk_round_rate(mpu_clk, policy->min * 1000) / 1000;
-	policy->max = clk_round_rate(mpu_clk, policy->max * 1000) / 1000;
+	
 	cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
 				     policy->cpuinfo.max_freq);
-	clk_put(mpu_clk);
-
-	return 0;
+	return cpufreq_frequency_table_verify(policy, opoints);
 }
 
 unsigned int omap_getspeed(unsigned int cpu)
 {
-	struct clk * mpu_clk;
 	unsigned long rate;
 
 	if (cpu)
 		return 0;
 
-	mpu_clk = clk_get(NULL, MPU_CLK);
-	if (IS_ERR(mpu_clk))
+	if (powerop_get_point(NULL, "cpu ", &rate))
 		return 0;
-	rate = clk_get_rate(mpu_clk) / 1000;
-	clk_put(mpu_clk);
 
 	return rate;
 }
@@ -77,43 +121,57 @@ static int omap_target(struct cpufreq_po
 		       unsigned int target_freq,
 		       unsigned int relation)
 {
-	struct clk * mpu_clk;
 	struct cpufreq_freqs freqs;
 	int ret = 0;
+	unsigned int idx;
 
-	mpu_clk = clk_get(NULL, MPU_CLK);
-	if (IS_ERR(mpu_clk))
-		return PTR_ERR(mpu_clk);
-
+	/*FIXME: check 0 as error */
 	freqs.old = omap_getspeed(0);
-	freqs.new = clk_round_rate(mpu_clk, target_freq * 1000) / 1000;
+
+	/* 
+	 * doing w/o error checking since assuming ->target is called 
+	 * withing limits
+	 */
+	if (relation == CPUFREQ_RELATION_L)
+		idx = round_min_rate(target_freq);
+	else if (relation == CPUFREQ_RELATION_H)
+		idx = round_max_rate(target_freq);
+	else
+		return -EINVAL;
+	freqs.new = opoints[idx].frequency;
 	freqs.cpu = 0;
 
 	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
-	ret = clk_set_rate(mpu_clk, target_freq * 1000);
+	
+	ret = powerop_set_point(names[idx]);
+	
 	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
-	clk_put(mpu_clk);
 
 	return ret;
 }
 
 static int __init omap_cpu_init(struct cpufreq_policy *policy)
 {
-	struct clk * mpu_clk;
-
 	if (policy->cpu != 0)
 		return -EINVAL;
 
-	mpu_clk = clk_get(NULL, MPU_CLK);
-	if (IS_ERR(mpu_clk))
-		return PTR_ERR(mpu_clk);
-
 	policy->cur = policy->min = policy->max = omap_getspeed(0);
+
+	/* omap_getspeed returns 0 on error */
+	if (policy->cur == 0)
+		return -EIO;
+
 	policy->governor = CPUFREQ_DEFAULT_GOVERNOR;
-	policy->cpuinfo.min_freq = clk_round_rate(mpu_clk, 0) / 1000;
-	policy->cpuinfo.max_freq = clk_round_rate(mpu_clk, VERY_HI_RATE) / 1000;
 	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
-	clk_put(mpu_clk);
+
+	/* 
+	 * FIXME: it's hardcoded for this example having the assumption that 
+	 * operating points in opoints array are sorted out in descending
+	 * order. May be improved by fetching the values from the opoints 
+	 * array with necessary algo
+	 */
+	policy->cpuinfo.min_freq = opoints[MAX_OP_INDEX].frequency;
+	policy->cpuinfo.max_freq = opoints[0].frequency;
 
 	return 0;
 }
@@ -129,7 +187,19 @@ static struct cpufreq_driver omap_driver
 
 static int __init omap_cpufreq_init(void)
 {
+	int i = 0;
+	/* 
+	 * map cpufreq layer representation of power control to 
+	 * omap1 platform operating points
+	 */
+	for (i = 0; i <=MAX_OP_INDEX; i++ )
+		if (powerop_register_point(names[i], "cpu_vltg cpu ",
+					   opoints[i].index, 
+					   opoints[i].frequency))
+			return -EINVAL;
+
 	return cpufreq_register_driver(&omap_driver);
 }
 
 arch_initcall(omap_cpufreq_init);
+

--------------030108090706030400080309
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--------------030108090706030400080309--
