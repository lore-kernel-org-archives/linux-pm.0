From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] cpufreq: Remove the pm_message_t argument from
	driver suspend
Date: Thu, 10 Mar 2011 21:13:05 +0100
Message-ID: <201103102113.05946.rjw__28733.4407832988$1299788218$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dave Jones <davej@redhat.com>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, cpufreq@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

None of the existing cpufreq drivers uses the second argument of
its .suspend() callback (which isn't useful anyway), so remove it.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---

Hi,

This patch is requisite for sysdevs rework discussed here:
https://lkml.org/lkml/2011/3/9/439
Please apply or let me know if I can take it to the suspend tree.

Thanks,
Rafael

---
 arch/arm/mach-s5pv210/cpufreq.c              |    3 +--
 arch/arm/mach-s5pv310/cpufreq.c              |    3 +--
 arch/arm/plat-s3c24xx/cpu-freq.c             |    2 +-
 arch/powerpc/platforms/powermac/cpufreq_32.c |    2 +-
 drivers/cpufreq/cpufreq.c                    |    2 +-
 include/linux/cpufreq.h                      |    2 +-
 6 files changed, 6 insertions(+), 8 deletions(-)

Index: linux-2.6/include/linux/cpufreq.h
===================================================================
--- linux-2.6.orig/include/linux/cpufreq.h
+++ linux-2.6/include/linux/cpufreq.h
@@ -230,7 +230,7 @@ struct cpufreq_driver {
 	int	(*bios_limit)	(int cpu, unsigned int *limit);
 
 	int	(*exit)		(struct cpufreq_policy *policy);
-	int	(*suspend)	(struct cpufreq_policy *policy, pm_message_t pmsg);
+	int	(*suspend)	(struct cpufreq_policy *policy);
 	int	(*resume)	(struct cpufreq_policy *policy);
 	struct freq_attr	**attr;
 };
Index: linux-2.6/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-2.6.orig/drivers/cpufreq/cpufreq.c
+++ linux-2.6/drivers/cpufreq/cpufreq.c
@@ -1371,7 +1371,7 @@ static int cpufreq_suspend(struct sys_de
 		goto out;
 
 	if (cpufreq_driver->suspend) {
-		ret = cpufreq_driver->suspend(cpu_policy, pmsg);
+		ret = cpufreq_driver->suspend(cpu_policy);
 		if (ret)
 			printk(KERN_ERR "cpufreq: suspend failed in ->suspend "
 					"step on CPU %u\n", cpu_policy->cpu);
Index: linux-2.6/arch/powerpc/platforms/powermac/cpufreq_32.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/powermac/cpufreq_32.c
+++ linux-2.6/arch/powerpc/platforms/powermac/cpufreq_32.c
@@ -429,7 +429,7 @@ static u32 read_gpio(struct device_node
 	return offset;
 }
 
-static int pmac_cpufreq_suspend(struct cpufreq_policy *policy, pm_message_t pmsg)
+static int pmac_cpufreq_suspend(struct cpufreq_policy *policy)
 {
 	/* Ok, this could be made a bit smarter, but let's be robust for now. We
 	 * always force a speed change to high speed before sleep, to make sure
Index: linux-2.6/arch/arm/mach-s5pv210/cpufreq.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-s5pv210/cpufreq.c
+++ linux-2.6/arch/arm/mach-s5pv210/cpufreq.c
@@ -390,8 +390,7 @@ static int s5pv210_target(struct cpufreq
 }
 
 #ifdef CONFIG_PM
-static int s5pv210_cpufreq_suspend(struct cpufreq_policy *policy,
-				   pm_message_t pmsg)
+static int s5pv210_cpufreq_suspend(struct cpufreq_policy *policy)
 {
 	return 0;
 }
Index: linux-2.6/arch/arm/mach-s5pv310/cpufreq.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-s5pv310/cpufreq.c
+++ linux-2.6/arch/arm/mach-s5pv310/cpufreq.c
@@ -458,8 +458,7 @@ static int s5pv310_target(struct cpufreq
 }
 
 #ifdef CONFIG_PM
-static int s5pv310_cpufreq_suspend(struct cpufreq_policy *policy,
-				   pm_message_t pmsg)
+static int s5pv310_cpufreq_suspend(struct cpufreq_policy *policy)
 {
 	return 0;
 }
Index: linux-2.6/arch/arm/plat-s3c24xx/cpu-freq.c
===================================================================
--- linux-2.6.orig/arch/arm/plat-s3c24xx/cpu-freq.c
+++ linux-2.6/arch/arm/plat-s3c24xx/cpu-freq.c
@@ -433,7 +433,7 @@ static int s3c_cpufreq_verify(struct cpu
 static struct cpufreq_frequency_table suspend_pll;
 static unsigned int suspend_freq;
 
-static int s3c_cpufreq_suspend(struct cpufreq_policy *policy, pm_message_t pmsg)
+static int s3c_cpufreq_suspend(struct cpufreq_policy *policy)
 {
 	suspend_pll.frequency = clk_get_rate(_clk_mpll);
 	suspend_pll.index = __raw_readl(S3C2410_MPLLCON);
