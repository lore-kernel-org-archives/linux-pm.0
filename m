From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH 2/5] ARM: vexpress/TC2: add support for CPU DVFS
Date: Fri, 18 Oct 2013 14:27:03 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1310181346270.1951@syhkavp.arg>
References: <1381931563-16785-1-git-send-email-Sudeep.KarkadaNagesha@arm.com> <1381931563-16785-3-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1381931563-16785-3-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Sender: cpufreq-owner@vger.kernel.org
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Pawel Moll <Pawel.Moll@arm.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 16 Oct 2013, Sudeep KarkadaNagesha wrote:

> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> 
> SPC(Serial Power Controller) on TC2 also controls the CPU performance
> operating points which is essential to provide CPU DVFS. The M3
> microcontroller provides two sets of eight performance values, one set
> for each cluster (CA15 or CA7). Each of this value contains the
> frequency(kHz) and voltage(mV) at that performance level. It expects
> these performance level to be passed through the SPC PERF_LVL registers.
> 
> This patch adds support to populate these performance levels from M3,
> build the mapping to CPU OPPs at the boot and then use it to get and
> set the CPU performance level runtime.
> 
> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> Cc: Pawel Moll <Pawel.Moll@arm.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>

Minor comments below.  With those addressed, you may add

Acked-by: Nicolas Pitre <nico@linaro.org>

> ---
>  arch/arm/mach-vexpress/Kconfig  |   2 +
>  arch/arm/mach-vexpress/spc.c    | 240 +++++++++++++++++++++++++++++++++++++++-
>  arch/arm/mach-vexpress/spc.h    |   2 +-
>  arch/arm/mach-vexpress/tc2_pm.c |   7 +-
>  4 files changed, 247 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
> index 3657954..5989187 100644
> --- a/arch/arm/mach-vexpress/Kconfig
> +++ b/arch/arm/mach-vexpress/Kconfig
> @@ -1,5 +1,7 @@
>  config ARCH_VEXPRESS
>  	bool "ARM Ltd. Versatile Express family" if ARCH_MULTI_V7
> +	select ARCH_HAS_CPUFREQ
> +	select ARCH_HAS_OPP
>  	select ARCH_REQUIRE_GPIOLIB
>  	select ARM_AMBA
>  	select ARM_GIC

This is probably a bit too wide a selection for all CONFIG_ARCH_VEXPRESS 
targets.

I'd suggest creating a new CONFIG_VEXPRESS_SPC entry, making the build 
of spc.o depend on it, and that config entry could select
ARCH_HAS_CPUFREQ, ARCH_HAS_OPP and (as discussed in private) PM_OPP.  

Then this VEXPRESS_SPC would be selected by ARCH_VEXPRESS_TC2_PM.

Also the config dependency for ARM_VEXPRESS_SPC_CPUFREQ (in the later 
patch) would be better represented by VEXPRESS_SPC rather than 
ARCH_VEXPRESS_TC2_PM.

> diff --git a/arch/arm/mach-vexpress/spc.c b/arch/arm/mach-vexpress/spc.c
> index eefb029..ef7e652 100644
> --- a/arch/arm/mach-vexpress/spc.c
> +++ b/arch/arm/mach-vexpress/spc.c
> @@ -17,14 +17,26 @@
>   * GNU General Public License for more details.
>   */
>  
> +#include <linux/delay.h>
>  #include <linux/err.h>
> +#include <linux/interrupt.h>
>  #include <linux/io.h>
> +#include <linux/opp.h>
>  #include <linux/slab.h>
> +#include <linux/semaphore.h>
>  
>  #include <asm/cacheflush.h>
>  
>  #define SPCLOG "vexpress-spc: "
>  
> +#define PERF_LVL_A15		0x00
> +#define PERF_REQ_A15		0x04
> +#define PERF_LVL_A7		0x08
> +#define PERF_REQ_A7		0x0c
> +#define COMMS			0x10
> +#define COMMS_REQ		0x14
> +#define PWC_STATUS		0x18
> +#define PWC_FLAG		0x1c

Maybe a blank line here?

>  /* SPC wake-up IRQs status and mask */
>  #define WAKE_INT_MASK		0x24
>  #define WAKE_INT_RAW		0x28
> @@ -35,6 +47,18 @@
>  /* SPC per-CPU mailboxes */
>  #define A15_BX_ADDR0		0x68
>  #define A7_BX_ADDR0		0x78

Ditto.

> +/* SPC system config interface registers */
> +#define SYSCFG_WDATA		0x70
> +#define SYSCFG_RDATA		0x74
> +
> +/* A15/A7 OPP virtual register base */
> +#define A15_PERFVAL_BASE	0xC10
> +#define A7_PERFVAL_BASE		0xC30
> +
> +/* Config interface control bits */
> +#define SYSCFG_START		(1 << 31)
> +#define SYSCFG_SCC		(6 << 20)
> +#define SYSCFG_STAT		(14 << 20)
>  
>  /* wake-up interrupt masks */
>  #define GBL_WAKEUP_INT_MSK	(0x3 << 10)
> @@ -42,6 +66,26 @@
>  /* TC2 static dual-cluster configuration */
>  #define MAX_CLUSTERS		2
>  
> +/*
> + * Even though the SPC takes max 3-5 ms to complete any OPP/COMMS
> + * operation, the operation could start just before jiffie is about
> + * to be incremented. So setting timeout value of 20ms = 2jiffies@100Hz
> + */
> +#define TIMEOUT_US	20000
> +
> +#define MAX_OPPS	8
> +#define CA15_DVFS	0
> +#define CA7_DVFS	1
> +#define SPC_SYS_CFG	2
> +#define STAT_COMPLETE(type)	((1 << 0) << (type << 2))
> +#define STAT_ERR(type)		((1 << 1) << (type << 2))
> +#define RESPONSE_MASK(type)	(STAT_COMPLETE(type) | STAT_ERR(type))
> +
> +struct ve_spc_opp {
> +	unsigned long freq;
> +	unsigned long u_volt;
> +};
> +
>  struct ve_spc_drvdata {
>  	void __iomem *baseaddr;
>  	/*
> @@ -49,6 +93,12 @@ struct ve_spc_drvdata {
>  	 * It corresponds to A15 processors MPIDR[15:8] bitfield
>  	 */
>  	u32 a15_clusid;
> +	uint32_t cur_rsp_mask;
> +	uint32_t cur_rsp_stat;
> +	struct semaphore sem;
> +	struct completion done;
> +	struct ve_spc_opp *opps[MAX_CLUSTERS];
> +	int num_opps[MAX_CLUSTERS];
>  };
>  
>  static struct ve_spc_drvdata *info;
> @@ -157,8 +207,177 @@ void ve_spc_powerdown(u32 cluster, bool enable)
>  	writel_relaxed(enable, info->baseaddr + pwdrn_reg);
>  }
>  
> -int __init ve_spc_init(void __iomem *baseaddr, u32 a15_clusid)
> +static int ve_spc_get_performance(int cluster, u32 *freq)
> +{
> +	struct ve_spc_opp *opps = info->opps[cluster];
> +	u32 perf_cfg_reg = 0;
> +	int perf;
> +
> +	perf_cfg_reg = cluster_is_a15(cluster) ? PERF_LVL_A15 : PERF_LVL_A7;
> +
> +	perf = readl_relaxed(info->baseaddr + perf_cfg_reg);
> +	opps += perf;

This might be a good idea to validate the hardware returned index before 
dereferencing memory i.e "if (perf >= info->num_opps[cluster]) ..." with 
perf declared as an unsigned int.

> +	*freq = opps->freq;
> +
> +	return 0;
> +}
> +
> +/* find closest match to given frequency in OPP table */
> +static int ve_spc_round_performance(int cluster, u32 freq)
> +{
> +	int idx, max_opp = info->num_opps[cluster];
> +	struct ve_spc_opp *opps = info->opps[cluster];
> +	u32 fmin = 0, fmax = ~0, ftmp;
> +
> +	freq /= 1000; /* OPP entries in kHz */
> +	for (idx = 0; idx < max_opp; idx++, opps++) {
> +		ftmp = opps->freq;
> +		if (ftmp >= freq) {
> +			if (ftmp <= fmax)
> +				fmax = ftmp;
> +		} else {
> +			if (ftmp >= fmin)
> +				fmin = ftmp;
> +		}
> +	}
> +	if (fmax != ~0)
> +		return fmax * 1000;
> +	else
> +		return fmin * 1000;
> +}
> +
> +static int ve_spc_find_performance_index(int cluster, u32 freq)
> +{
> +	int idx, max_opp = info->num_opps[cluster];
> +	struct ve_spc_opp *opps = info->opps[cluster];
> +
> +	for (idx = 0; idx < max_opp; idx++, opps++)
> +		if (opps->freq == freq)
> +			break;
> +	return (idx == max_opp) ? -EINVAL : idx;
> +}
> +
> +static int ve_spc_waitforcompletion(int req_type)
> +{
> +	int ret = wait_for_completion_interruptible_timeout(
> +			&info->done, usecs_to_jiffies(TIMEOUT_US));
> +	if (ret == 0)
> +		ret = -ETIMEDOUT;
> +	else if (ret > 0)
> +		ret = info->cur_rsp_stat & STAT_COMPLETE(req_type) ? 0 : -EIO;
> +	return ret;
> +}
> +
> +static int ve_spc_set_performance(int cluster, u32 freq)
> +{
> +	u32 perf_cfg_reg, perf_stat_reg;
> +	int ret, perf, req_type;
> +
> +	if (cluster_is_a15(cluster)) {
> +		req_type = CA15_DVFS;
> +		perf_cfg_reg = PERF_LVL_A15;
> +		perf_stat_reg = PERF_REQ_A15;
> +	} else {
> +		req_type = CA7_DVFS;
> +		perf_cfg_reg = PERF_LVL_A7;
> +		perf_stat_reg = PERF_REQ_A7;
> +	}
> +
> +	perf = ve_spc_find_performance_index(cluster, freq);
> +
> +	if (perf < 0)
> +		return perf;
> +
> +	if (down_timeout(&info->sem, usecs_to_jiffies(TIMEOUT_US)))
> +		return -ETIME;
> +
> +	init_completion(&info->done);
> +	info->cur_rsp_mask = RESPONSE_MASK(req_type);
> +
> +	writel(perf, info->baseaddr + perf_cfg_reg);
> +	ret = ve_spc_waitforcompletion(req_type);
> +
> +	info->cur_rsp_mask = 0;
> +	up(&info->sem);
> +
> +	return ret;
> +}
> +
> +static int ve_spc_read_sys_cfg(int func, int offset, uint32_t *data)
> +{
> +	int ret;
> +
> +	if (down_timeout(&info->sem, usecs_to_jiffies(TIMEOUT_US)))
> +		return -ETIME;
> +
> +	init_completion(&info->done);
> +	info->cur_rsp_mask = RESPONSE_MASK(SPC_SYS_CFG);
> +
> +	/* Set the control value */
> +	writel(SYSCFG_START | func | offset >> 2, info->baseaddr + COMMS);
> +	ret = ve_spc_waitforcompletion(SPC_SYS_CFG);
> +
> +	if (ret == 0)
> +		*data = readl(info->baseaddr + SYSCFG_RDATA);
> +
> +	info->cur_rsp_mask = 0;
> +	up(&info->sem);
> +
> +	return ret;
> +}
> +
> +static irqreturn_t ve_spc_irq_handler(int irq, void *data)
> +{
> +	struct ve_spc_drvdata *drv_data = data;
> +	uint32_t status = readl_relaxed(drv_data->baseaddr + PWC_STATUS);
> +
> +	if (info->cur_rsp_mask & status) {
> +		info->cur_rsp_stat = status;
> +		complete(&drv_data->done);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/*
> + *  +--------------------------+
> + *  | 31      20 | 19        0 |
> + *  +--------------------------+
> + *  |   u_volt   |  freq(kHz)  |
> + *  +--------------------------+
> + */
> +#define MULT_FACTOR	20
> +#define VOLT_SHIFT	20
> +#define FREQ_MASK	(0xFFFFF)
> +static int ve_spc_populate_opps(uint32_t cluster)
> +{
> +	uint32_t data = 0, off, ret, idx;
> +	struct ve_spc_opp *opps;
> +
> +	opps = kzalloc(sizeof(*opps) * MAX_OPPS, GFP_KERNEL);
> +	if (!opps)
> +		return -ENOMEM;
> +
> +	info->opps[cluster] = opps;
> +
> +	off = cluster_is_a15(cluster) ? A15_PERFVAL_BASE : A7_PERFVAL_BASE;
> +	for (idx = 0; idx < MAX_OPPS; idx++, off += 4, opps++) {
> +		ret = ve_spc_read_sys_cfg(SYSCFG_SCC, off, &data);
> +		if (!ret) {
> +			opps->freq = (data & FREQ_MASK) * MULT_FACTOR;
> +			opps->u_volt = data >> VOLT_SHIFT;
> +		} else {
> +			break;
> +		}
> +	}
> +	info->num_opps[cluster] = idx;
> +
> +	return ret;
> +}
> +
> +int __init ve_spc_init(void __iomem *baseaddr, u32 a15_clusid, int irq)
>  {
> +	int ret;
>  	info = kzalloc(sizeof(*info), GFP_KERNEL);
>  	if (!info) {
>  		pr_err(SPCLOG "unable to allocate mem\n");
> @@ -168,6 +387,25 @@ int __init ve_spc_init(void __iomem *baseaddr, u32 a15_clusid)
>  	info->baseaddr = baseaddr;
>  	info->a15_clusid = a15_clusid;
>  
> +	if (irq <= 0) {
> +		pr_err(SPCLOG "Invalid IRQ %d\n", irq);
> +		kfree(info);
> +		return -EINVAL;
> +	}
> +
> +	init_completion(&info->done);
> +
> +	readl_relaxed(info->baseaddr + PWC_STATUS);
> +
> +	ret = request_irq(irq, ve_spc_irq_handler, IRQF_TRIGGER_HIGH
> +				| IRQF_ONESHOT, "vexpress-spc", info);
> +	if (ret) {
> +		pr_err(SPCLOG "IRQ %d request failed\n", irq);
> +		kfree(info);
> +		return -ENODEV;
> +	}
> +
> +	sema_init(&info->sem, 1);
>  	/*
>  	 * Multi-cluster systems may need this data when non-coherent, during
>  	 * cluster power-up/power-down. Make sure driver info reaches main
> diff --git a/arch/arm/mach-vexpress/spc.h b/arch/arm/mach-vexpress/spc.h
> index 5f7e4a4..dbd44c3 100644
> --- a/arch/arm/mach-vexpress/spc.h
> +++ b/arch/arm/mach-vexpress/spc.h
> @@ -15,7 +15,7 @@
>  #ifndef __SPC_H_
>  #define __SPC_H_
>  
> -int __init ve_spc_init(void __iomem *base, u32 a15_clusid);
> +int __init ve_spc_init(void __iomem *base, u32 a15_clusid, int irq);
>  void ve_spc_global_wakeup_irq(bool set);
>  void ve_spc_cpu_wakeup_irq(u32 cluster, u32 cpu, bool set);
>  void ve_spc_set_resume_addr(u32 cluster, u32 cpu, u32 addr);
> diff --git a/arch/arm/mach-vexpress/tc2_pm.c b/arch/arm/mach-vexpress/tc2_pm.c
> index e6eb481..d38130a 100644
> --- a/arch/arm/mach-vexpress/tc2_pm.c
> +++ b/arch/arm/mach-vexpress/tc2_pm.c
> @@ -16,6 +16,7 @@
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/of_address.h>
> +#include <linux/of_irq.h>
>  #include <linux/spinlock.h>
>  #include <linux/errno.h>
>  #include <linux/irqchip/arm-gic.h>
> @@ -311,7 +312,7 @@ static void __naked tc2_pm_power_up_setup(unsigned int affinity_level)
>  
>  static int __init tc2_pm_init(void)
>  {
> -	int ret;
> +	int ret, irq;
>  	void __iomem *scc;
>  	u32 a15_cluster_id, a7_cluster_id, sys_info;
>  	struct device_node *np;
> @@ -336,13 +337,15 @@ static int __init tc2_pm_init(void)
>  	tc2_nr_cpus[a15_cluster_id] = (sys_info >> 16) & 0xf;
>  	tc2_nr_cpus[a7_cluster_id] = (sys_info >> 20) & 0xf;
>  
> +	irq = irq_of_parse_and_map(np, 0);
> +
>  	/*
>  	 * A subset of the SCC registers is also used to communicate
>  	 * with the SPC (power controller). We need to be able to
>  	 * drive it very early in the boot process to power up
>  	 * processors, so we initialize the SPC driver here.
>  	 */
> -	ret = ve_spc_init(scc + SPC_BASE, a15_cluster_id);
> +	ret = ve_spc_init(scc + SPC_BASE, a15_cluster_id, irq);
>  	if (ret)
>  		return ret;
>  
> -- 
> 1.8.1.2
> 
