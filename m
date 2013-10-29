From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: [PATCH v3 1/4] ARM: vexpress/TC2: add support for CPU DVFS
Date: Tue, 29 Oct 2013 12:18:37 +0000
Message-ID: <1383049120-8336-2-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1383049120-8336-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1383049120-8336-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep.KarkadaNagesha@arm.com, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
List-Id: linux-pm@vger.kernel.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

SPC(Serial Power Controller) on TC2 also controls the CPU performance
operating points which is essential to provide CPU DVFS. The M3
microcontroller provides two sets of eight performance values, one set
for each cluster (CA15 or CA7). Each of this value contains the
frequency(kHz) and voltage(mV) at that performance level. It expects
these performance level to be passed through the SPC PERF_LVL registers.

This patch adds support to populate these performance levels from M3,
build the mapping to CPU OPPs at the boot and then use it to get and
set the CPU performance level runtime.

Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
Acked-by: Nicolas Pitre <nico@linaro.org>
Acked-by: Pawel Moll <Pawel.Moll@arm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-vexpress/Kconfig  |  12 ++
 arch/arm/mach-vexpress/Makefile |   3 +-
 arch/arm/mach-vexpress/spc.c    | 262 +++++++++++++++++++++++++++++++++++++++-
 arch/arm/mach-vexpress/spc.h    |   2 +-
 arch/arm/mach-vexpress/tc2_pm.c |   7 +-
 5 files changed, 281 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index 3657954..c77170c 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -66,10 +66,22 @@ config ARCH_VEXPRESS_DCSCB
 	  This is needed to provide CPU and cluster power management
 	  on RTSM implementing big.LITTLE.
 
+config ARCH_VEXPRESS_SPC
+	bool "Versatile Express Serial Power Controller (SPC)"
+	select ARCH_HAS_CPUFREQ
+	select ARCH_HAS_OPP
+	select PM_OPP
+	help
+	  The TC2 (A15x2 A7x3) versatile express core tile integrates a logic
+	  block called Serial Power Controller (SPC) that provides the interface
+	  between the dual cluster test-chip and the M3 microcontroller that
+	  carries out power management.
+
 config ARCH_VEXPRESS_TC2_PM
 	bool "Versatile Express TC2 power management"
 	depends on MCPM
 	select ARM_CCI
+	select ARCH_VEXPRESS_SPC
 	help
 	  Support for CPU and cluster power management on Versatile Express
 	  with a TC2 (A15x2 A7x3) big.LITTLE core tile.
diff --git a/arch/arm/mach-vexpress/Makefile b/arch/arm/mach-vexpress/Makefile
index 505e64a..0997e0b 100644
--- a/arch/arm/mach-vexpress/Makefile
+++ b/arch/arm/mach-vexpress/Makefile
@@ -8,7 +8,8 @@ obj-y					:= v2m.o
 obj-$(CONFIG_ARCH_VEXPRESS_CA9X4)	+= ct-ca9x4.o
 obj-$(CONFIG_ARCH_VEXPRESS_DCSCB)	+= dcscb.o	dcscb_setup.o
 CFLAGS_dcscb.o				+= -march=armv7-a
-obj-$(CONFIG_ARCH_VEXPRESS_TC2_PM)	+= tc2_pm.o spc.o
+obj-$(CONFIG_ARCH_VEXPRESS_SPC)		+= spc.o
+obj-$(CONFIG_ARCH_VEXPRESS_TC2_PM)	+= tc2_pm.o
 CFLAGS_tc2_pm.o				+= -march=armv7-a
 obj-$(CONFIG_SMP)			+= platsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)		+= hotplug.o
diff --git a/arch/arm/mach-vexpress/spc.c b/arch/arm/mach-vexpress/spc.c
index eefb029..de0ca36 100644
--- a/arch/arm/mach-vexpress/spc.c
+++ b/arch/arm/mach-vexpress/spc.c
@@ -17,14 +17,27 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/pm_opp.h>
 #include <linux/slab.h>
+#include <linux/semaphore.h>
 
 #include <asm/cacheflush.h>
 
 #define SPCLOG "vexpress-spc: "
 
+#define PERF_LVL_A15		0x00
+#define PERF_REQ_A15		0x04
+#define PERF_LVL_A7		0x08
+#define PERF_REQ_A7		0x0c
+#define COMMS			0x10
+#define COMMS_REQ		0x14
+#define PWC_STATUS		0x18
+#define PWC_FLAG		0x1c
+
 /* SPC wake-up IRQs status and mask */
 #define WAKE_INT_MASK		0x24
 #define WAKE_INT_RAW		0x28
@@ -36,12 +49,45 @@
 #define A15_BX_ADDR0		0x68
 #define A7_BX_ADDR0		0x78
 
+/* SPC system config interface registers */
+#define SYSCFG_WDATA		0x70
+#define SYSCFG_RDATA		0x74
+
+/* A15/A7 OPP virtual register base */
+#define A15_PERFVAL_BASE	0xC10
+#define A7_PERFVAL_BASE		0xC30
+
+/* Config interface control bits */
+#define SYSCFG_START		(1 << 31)
+#define SYSCFG_SCC		(6 << 20)
+#define SYSCFG_STAT		(14 << 20)
+
 /* wake-up interrupt masks */
 #define GBL_WAKEUP_INT_MSK	(0x3 << 10)
 
 /* TC2 static dual-cluster configuration */
 #define MAX_CLUSTERS		2
 
+/*
+ * Even though the SPC takes max 3-5 ms to complete any OPP/COMMS
+ * operation, the operation could start just before jiffie is about
+ * to be incremented. So setting timeout value of 20ms = 2jiffies@100Hz
+ */
+#define TIMEOUT_US	20000
+
+#define MAX_OPPS	8
+#define CA15_DVFS	0
+#define CA7_DVFS	1
+#define SPC_SYS_CFG	2
+#define STAT_COMPLETE(type)	((1 << 0) << (type << 2))
+#define STAT_ERR(type)		((1 << 1) << (type << 2))
+#define RESPONSE_MASK(type)	(STAT_COMPLETE(type) | STAT_ERR(type))
+
+struct ve_spc_opp {
+	unsigned long freq;
+	unsigned long u_volt;
+};
+
 struct ve_spc_drvdata {
 	void __iomem *baseaddr;
 	/*
@@ -49,6 +95,12 @@ struct ve_spc_drvdata {
 	 * It corresponds to A15 processors MPIDR[15:8] bitfield
 	 */
 	u32 a15_clusid;
+	uint32_t cur_rsp_mask;
+	uint32_t cur_rsp_stat;
+	struct semaphore sem;
+	struct completion done;
+	struct ve_spc_opp *opps[MAX_CLUSTERS];
+	int num_opps[MAX_CLUSTERS];
 };
 
 static struct ve_spc_drvdata *info;
@@ -157,8 +209,197 @@ void ve_spc_powerdown(u32 cluster, bool enable)
 	writel_relaxed(enable, info->baseaddr + pwdrn_reg);
 }
 
-int __init ve_spc_init(void __iomem *baseaddr, u32 a15_clusid)
+static int ve_spc_get_performance(int cluster, u32 *freq)
+{
+	struct ve_spc_opp *opps = info->opps[cluster];
+	u32 perf_cfg_reg = 0;
+	u32 perf;
+
+	perf_cfg_reg = cluster_is_a15(cluster) ? PERF_LVL_A15 : PERF_LVL_A7;
+
+	perf = readl_relaxed(info->baseaddr + perf_cfg_reg);
+	if (perf >= info->num_opps[cluster])
+		return -EINVAL;
+
+	opps += perf;
+	*freq = opps->freq;
+
+	return 0;
+}
+
+/* find closest match to given frequency in OPP table */
+static int ve_spc_round_performance(int cluster, u32 freq)
+{
+	int idx, max_opp = info->num_opps[cluster];
+	struct ve_spc_opp *opps = info->opps[cluster];
+	u32 fmin = 0, fmax = ~0, ftmp;
+
+	freq /= 1000; /* OPP entries in kHz */
+	for (idx = 0; idx < max_opp; idx++, opps++) {
+		ftmp = opps->freq;
+		if (ftmp >= freq) {
+			if (ftmp <= fmax)
+				fmax = ftmp;
+		} else {
+			if (ftmp >= fmin)
+				fmin = ftmp;
+		}
+	}
+	if (fmax != ~0)
+		return fmax * 1000;
+	else
+		return fmin * 1000;
+}
+
+static int ve_spc_find_performance_index(int cluster, u32 freq)
+{
+	int idx, max_opp = info->num_opps[cluster];
+	struct ve_spc_opp *opps = info->opps[cluster];
+
+	for (idx = 0; idx < max_opp; idx++, opps++)
+		if (opps->freq == freq)
+			break;
+	return (idx == max_opp) ? -EINVAL : idx;
+}
+
+static int ve_spc_waitforcompletion(int req_type)
+{
+	int ret = wait_for_completion_interruptible_timeout(
+			&info->done, usecs_to_jiffies(TIMEOUT_US));
+	if (ret == 0)
+		ret = -ETIMEDOUT;
+	else if (ret > 0)
+		ret = info->cur_rsp_stat & STAT_COMPLETE(req_type) ? 0 : -EIO;
+	return ret;
+}
+
+static int ve_spc_set_performance(int cluster, u32 freq)
+{
+	u32 perf_cfg_reg, perf_stat_reg;
+	int ret, perf, req_type;
+
+	if (cluster_is_a15(cluster)) {
+		req_type = CA15_DVFS;
+		perf_cfg_reg = PERF_LVL_A15;
+		perf_stat_reg = PERF_REQ_A15;
+	} else {
+		req_type = CA7_DVFS;
+		perf_cfg_reg = PERF_LVL_A7;
+		perf_stat_reg = PERF_REQ_A7;
+	}
+
+	perf = ve_spc_find_performance_index(cluster, freq);
+
+	if (perf < 0)
+		return perf;
+
+	if (down_timeout(&info->sem, usecs_to_jiffies(TIMEOUT_US)))
+		return -ETIME;
+
+	init_completion(&info->done);
+	info->cur_rsp_mask = RESPONSE_MASK(req_type);
+
+	writel(perf, info->baseaddr + perf_cfg_reg);
+	ret = ve_spc_waitforcompletion(req_type);
+
+	info->cur_rsp_mask = 0;
+	up(&info->sem);
+
+	return ret;
+}
+
+static int ve_spc_read_sys_cfg(int func, int offset, uint32_t *data)
+{
+	int ret;
+
+	if (down_timeout(&info->sem, usecs_to_jiffies(TIMEOUT_US)))
+		return -ETIME;
+
+	init_completion(&info->done);
+	info->cur_rsp_mask = RESPONSE_MASK(SPC_SYS_CFG);
+
+	/* Set the control value */
+	writel(SYSCFG_START | func | offset >> 2, info->baseaddr + COMMS);
+	ret = ve_spc_waitforcompletion(SPC_SYS_CFG);
+
+	if (ret == 0)
+		*data = readl(info->baseaddr + SYSCFG_RDATA);
+
+	info->cur_rsp_mask = 0;
+	up(&info->sem);
+
+	return ret;
+}
+
+static irqreturn_t ve_spc_irq_handler(int irq, void *data)
+{
+	struct ve_spc_drvdata *drv_data = data;
+	uint32_t status = readl_relaxed(drv_data->baseaddr + PWC_STATUS);
+
+	if (info->cur_rsp_mask & status) {
+		info->cur_rsp_stat = status;
+		complete(&drv_data->done);
+	}
+
+	return IRQ_HANDLED;
+}
+
+/*
+ *  +--------------------------+
+ *  | 31      20 | 19        0 |
+ *  +--------------------------+
+ *  |   u_volt   |  freq(kHz)  |
+ *  +--------------------------+
+ */
+#define MULT_FACTOR	20
+#define VOLT_SHIFT	20
+#define FREQ_MASK	(0xFFFFF)
+static int ve_spc_populate_opps(uint32_t cluster)
+{
+	uint32_t data = 0, off, ret, idx;
+	struct ve_spc_opp *opps;
+
+	opps = kzalloc(sizeof(*opps) * MAX_OPPS, GFP_KERNEL);
+	if (!opps)
+		return -ENOMEM;
+
+	info->opps[cluster] = opps;
+
+	off = cluster_is_a15(cluster) ? A15_PERFVAL_BASE : A7_PERFVAL_BASE;
+	for (idx = 0; idx < MAX_OPPS; idx++, off += 4, opps++) {
+		ret = ve_spc_read_sys_cfg(SYSCFG_SCC, off, &data);
+		if (!ret) {
+			opps->freq = (data & FREQ_MASK) * MULT_FACTOR;
+			opps->u_volt = data >> VOLT_SHIFT;
+		} else {
+			break;
+		}
+	}
+	info->num_opps[cluster] = idx;
+
+	return ret;
+}
+
+static int ve_init_opp_table(struct device *cpu_dev)
+{
+	int cluster = topology_physical_package_id(cpu_dev->id);
+	int idx, ret = 0, max_opp = info->num_opps[cluster];
+	struct ve_spc_opp *opps = info->opps[cluster];
+
+	for (idx = 0; idx < max_opp; idx++, opps++) {
+		ret = dev_pm_opp_add(cpu_dev, opps->freq * 1000, opps->u_volt);
+		if (ret) {
+			dev_warn(cpu_dev, "failed to add opp %lu %lu\n",
+				 opps->freq, opps->u_volt);
+			return ret;
+		}
+	}
+	return ret;
+}
+
+int __init ve_spc_init(void __iomem *baseaddr, u32 a15_clusid, int irq)
 {
+	int ret;
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info) {
 		pr_err(SPCLOG "unable to allocate mem\n");
@@ -168,6 +409,25 @@ int __init ve_spc_init(void __iomem *baseaddr, u32 a15_clusid)
 	info->baseaddr = baseaddr;
 	info->a15_clusid = a15_clusid;
 
+	if (irq <= 0) {
+		pr_err(SPCLOG "Invalid IRQ %d\n", irq);
+		kfree(info);
+		return -EINVAL;
+	}
+
+	init_completion(&info->done);
+
+	readl_relaxed(info->baseaddr + PWC_STATUS);
+
+	ret = request_irq(irq, ve_spc_irq_handler, IRQF_TRIGGER_HIGH
+				| IRQF_ONESHOT, "vexpress-spc", info);
+	if (ret) {
+		pr_err(SPCLOG "IRQ %d request failed\n", irq);
+		kfree(info);
+		return -ENODEV;
+	}
+
+	sema_init(&info->sem, 1);
 	/*
 	 * Multi-cluster systems may need this data when non-coherent, during
 	 * cluster power-up/power-down. Make sure driver info reaches main
diff --git a/arch/arm/mach-vexpress/spc.h b/arch/arm/mach-vexpress/spc.h
index 5f7e4a4..dbd44c3 100644
--- a/arch/arm/mach-vexpress/spc.h
+++ b/arch/arm/mach-vexpress/spc.h
@@ -15,7 +15,7 @@
 #ifndef __SPC_H_
 #define __SPC_H_
 
-int __init ve_spc_init(void __iomem *base, u32 a15_clusid);
+int __init ve_spc_init(void __iomem *base, u32 a15_clusid, int irq);
 void ve_spc_global_wakeup_irq(bool set);
 void ve_spc_cpu_wakeup_irq(u32 cluster, u32 cpu, bool set);
 void ve_spc_set_resume_addr(u32 cluster, u32 cpu, u32 addr);
diff --git a/arch/arm/mach-vexpress/tc2_pm.c b/arch/arm/mach-vexpress/tc2_pm.c
index e6eb481..d38130a 100644
--- a/arch/arm/mach-vexpress/tc2_pm.c
+++ b/arch/arm/mach-vexpress/tc2_pm.c
@@ -16,6 +16,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <linux/spinlock.h>
 #include <linux/errno.h>
 #include <linux/irqchip/arm-gic.h>
@@ -311,7 +312,7 @@ static void __naked tc2_pm_power_up_setup(unsigned int affinity_level)
 
 static int __init tc2_pm_init(void)
 {
-	int ret;
+	int ret, irq;
 	void __iomem *scc;
 	u32 a15_cluster_id, a7_cluster_id, sys_info;
 	struct device_node *np;
@@ -336,13 +337,15 @@ static int __init tc2_pm_init(void)
 	tc2_nr_cpus[a15_cluster_id] = (sys_info >> 16) & 0xf;
 	tc2_nr_cpus[a7_cluster_id] = (sys_info >> 20) & 0xf;
 
+	irq = irq_of_parse_and_map(np, 0);
+
 	/*
 	 * A subset of the SCC registers is also used to communicate
 	 * with the SPC (power controller). We need to be able to
 	 * drive it very early in the boot process to power up
 	 * processors, so we initialize the SPC driver here.
 	 */
-	ret = ve_spc_init(scc + SPC_BASE, a15_cluster_id);
+	ret = ve_spc_init(scc + SPC_BASE, a15_cluster_id, irq);
 	if (ret)
 		return ret;
 
-- 
1.8.1.2

