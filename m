From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 1/2] CPPC as a PID controller backend
Date: Mon, 15 Dec 2014 16:21:20 +0100
Message-ID: <6251973.kCIHGsD2QL@vostro.rjw.lan>
References: <1416429381-3839-1-git-send-email-ashwin.chaugule@linaro.org> <1416429381-3839-2-git-send-email-ashwin.chaugule@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61426 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753559AbaLOO7i (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Dec 2014 09:59:38 -0500
In-Reply-To: <1416429381-3839-2-git-send-email-ashwin.chaugule@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: viresh.kumar@linaro.org, rwells@codeaurora.org, linda.knippers@hp.com, linux-pm@vger.kernel.org, Catalin.Marinas@arm.com, dirk.brandewie@gmail.com, patches@linaro.org, linaro-acpi@lists.linaro.org

On Wednesday, November 19, 2014 03:36:20 PM Ashwin Chaugule wrote:
> CPPC (Collaborative Processor Performance Control) is defined
> in the ACPI 5.0+ spec. It is a method for controlling CPU
> performance on a continuous scale using performance feedback
> registers. In contrast to the legacy "pstate" scale which is
> discretized, and tied to CPU frequency, CPPC works off of an
> abstract continuous scale. This lets the platforms freely interpret
> the abstract unit and optimize it for power and performance given
> its knowledge of thermal budgets and other constraints.
> 
> The PID governor operates on similar concepts and can use CPPC
> semantics to acquire the information it needs. This information
> may be provided by various platforms via MSRs, CP15s or memory
> mapped registers. CPPC helps to wrap all these variations into a
> common framework.
> 
> This patch introduces CPPC using PID as its governor for CPU
> performance management.
> 
> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> ---
>  drivers/cpufreq/Kconfig    |   12 +
>  drivers/cpufreq/Makefile   |    1 +
>  drivers/cpufreq/acpi_pid.c | 1156 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1169 insertions(+)
>  create mode 100644 drivers/cpufreq/acpi_pid.c
> 
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index ffe350f..1237104 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -196,6 +196,18 @@ config GENERIC_CPUFREQ_CPU0
>  
>  	  If in doubt, say N.
>  
> +config ACPI_PID
> +	bool "ACPI based PID controller"

Sorry, but what sense does this make?  How's the user supposed to understand
what the choice is about?

> +	depends on PCC && !X86
> +	help
> +	  The ACPI PID driver is an implementation of the CPPC (Collaborative
> +	  Processor Performance Controls) as defined in the ACPI 5.0+ spec. The

OK, so this is a cpufreq driver based on ACPI CPPC and using a PID controller
as a built-in governor, right?

> +	  PID governor is derived from the intel_pstate driver and is used as a
> +	  standalone governor for CPPC. CPPC allows the OS to request CPU performance
> +	  with an abstract metric and lets the platform (e.g. BMC) interpret and
> +	  optimize it for power and performance in a platform specific manner. See
> +	  the ACPI 5.0+ specification for more details on CPPC.
> +
>  menu "x86 CPU frequency scaling drivers"
>  depends on X86
>  source "drivers/cpufreq/Kconfig.x86"
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index db6d9a2..6717cca 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -92,6 +92,7 @@ obj-$(CONFIG_POWERNV_CPUFREQ)		+= powernv-cpufreq.o
>  
>  ##################################################################################
>  # Other platform drivers
> +obj-$(CONFIG_ACPI_PID)	+= acpi_pid.o
>  obj-$(CONFIG_AVR32_AT32AP_CPUFREQ)	+= at32ap-cpufreq.o
>  obj-$(CONFIG_BFIN_CPU_FREQ)		+= blackfin-cpufreq.o
>  obj-$(CONFIG_CRIS_MACH_ARTPEC3)		+= cris-artpec3-cpufreq.o
> diff --git a/drivers/cpufreq/acpi_pid.c b/drivers/cpufreq/acpi_pid.c
> new file mode 100644
> index 0000000..f8d8376
> --- /dev/null
> +++ b/drivers/cpufreq/acpi_pid.c
> @@ -0,0 +1,1156 @@
> +/*
> + * CPPC (Collaborative Processor Performance Control) implementation
> + * using PID governor derived from intel_pstate.
> + *
> + * (C) Copyright 2014 Linaro Ltd.
> + * Author: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; version 2
> + * of the License.
> + *
> + * CPPC describes a few methods for controlling CPU performance using
> + * information from a per CPU table called CPC. This table is described in
> + * the ACPI v5.0+ specification. The table consists of a list of
> + * registers which may be memory mapped or hardware registers. A complete
> + * list of registers as described in v5.1 is in cppc_pcc_regs.
> + *
> + * CPU performance is on an abstract continous scale as against a discretized
> + * P-state scale which is tied to CPU frequency only. It is defined in the
> + * ACPI 5.0+ spec. In brief, the basic operation involves:
> + *
> + * - OS makes a CPU performance request. (Can provide min and max bounds)
> + *
> + * - Platform (such as BMC) is free to optimize request within requested bounds
> + *   depending on power/thermal budgets etc.
> + *
> + * - Platform conveys its decision back to OS
> + *
> + * The communication between OS and platform occurs through another medium
> + * called (PCC) Platform communication Channel. This is a generic mailbox like
> + * mechanism which includes doorbell semantics to indicate register updates.
> + * See drivers/mailbox/pcc.c for details on PCC.
> + *
> + * Finer details about the PCC and CPPC spec are available in the latest ACPI 5.1
> + * specification.
> + *
> + * The PID governor adapted from intel_pstate maps very well onto CPPC methods.
> + * See the cpc_read64/write64 calls for the ones which have been used by PID.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/kernel_stat.h>
> +#include <linux/module.h>
> +#include <linux/ktime.h>
> +#include <linux/hrtimer.h>
> +#include <linux/tick.h>
> +#include <linux/slab.h>
> +#include <linux/sched.h>
> +#include <linux/list.h>
> +#include <linux/cpu.h>
> +#include <linux/cpufreq.h>
> +#include <linux/sysfs.h>
> +#include <linux/types.h>
> +#include <linux/fs.h>
> +#include <linux/debugfs.h>
> +#include <linux/acpi.h>
> +#include <linux/mailbox_controller.h>
> +#include <linux/mailbox_client.h>
> +#include <trace/events/power.h>

Are all of the headers really necessary?  Doesn't the file compile without any of them?

> +
> +#include <asm/div64.h>
> +
> +#define FRAC_BITS 8
> +#define int_tofp(X) ((int64_t)(X) << FRAC_BITS)
> +#define fp_toint(X) ((X) >> FRAC_BITS)
> +
> +#define CPPC_EN				1
> +#define PCC_CMD_COMPLETE	1
> +#define MAX_CPC_REG_ENT 	19
> +
> +extern struct mbox_chan *pcc_mbox_request_channel(struct mbox_client *, unsigned int);
> +extern int mbox_send_message(struct mbox_chan *chan, void *mssg);
> +
> +static struct mbox_chan *pcc_channel;
> +static void __iomem *pcc_comm_addr;
> +static u64 comm_base_addr;
> +static int pcc_subspace_idx = -1;
> +
> +struct sample {
> +	int32_t core_pct_busy;
> +	u64 reference;
> +	u64 delivered;
> +	int freq;
> +	ktime_t time;
> +};
> +
> +struct pstate_data {
> +	int	current_pstate;
> +	int	min_pstate;
> +	int	max_pstate;
> +};
> +
> +struct _pid {
> +	int setpoint;
> +	int32_t integral;
> +	int32_t p_gain;
> +	int32_t i_gain;
> +	int32_t d_gain;
> +	int deadband;
> +	int32_t last_err;
> +};
> +
> +struct cpudata {
> +	int cpu;
> +
> +	struct timer_list timer;
> +
> +	struct pstate_data pstate;
> +	struct _pid pid;
> +
> +	ktime_t last_sample_time;
> +	u64	prev_reference;
> +	u64	prev_delivered;
> +	struct sample sample;
> +};
> +
> +static struct cpudata **all_cpu_data;
> +struct pstate_adjust_policy {
> +	int sample_rate_ms;
> +	int deadband;
> +	int setpoint;
> +	int p_gain_pct;
> +	int d_gain_pct;
> +	int i_gain_pct;
> +};
> +
> +struct pstate_funcs {
> +	int (*get_sample)(struct cpudata*);
> +	int (*get_pstates)(struct cpudata*);
> +	int (*set)(struct cpudata*, int pstate);
> +};
> +
> +struct cpu_defaults {
> +	struct pstate_adjust_policy pid_policy;
> +	struct pstate_funcs funcs;
> +};
> +
> +static struct pstate_adjust_policy pid_params;
> +static struct pstate_funcs pstate_funcs;
> +
> +struct perf_limits {
> +	int max_perf_pct;
> +	int min_perf_pct;
> +	int32_t max_perf;
> +	int32_t min_perf;
> +	int max_policy_pct;
> +	int max_sysfs_pct;
> +};
> +
> +static struct perf_limits limits = {
> +	.max_perf_pct = 100,
> +	.max_perf = int_tofp(1),
> +	.min_perf_pct = 0,
> +	.min_perf = 0,
> +	.max_policy_pct = 100,
> +	.max_sysfs_pct = 100,
> +};
> +
> +/* PCC Commands used by CPPC */
> +enum cppc_ppc_cmds {
> +	PCC_CMD_READ,
> +	PCC_CMD_WRITE,
> +	RESERVED,
> +};
> +
> +/* These are indexes into the per-cpu cpc_regs[]. Order is important. */
> +enum cppc_pcc_regs {
> +	HIGHEST_PERF,			/* Highest Performance						*/
> +	NOMINAL_PERF,			/* Nominal Performance						*/
> +	LOW_NON_LINEAR_PERF,	/* Lowest Nonlinear Performance				*/
> +	LOWEST_PERF,			/* Lowest Performance						*/
> +	GUARANTEED_PERF,		/* Guaranteed Performance Register			*/
> +	DESIRED_PERF,			/* Desired Performance Register				*/
> +	MIN_PERF,				/* Minimum Performance Register				*/
> +	MAX_PERF,				/* Maximum Performance Register				*/
> +	PERF_REDUC_TOLERANCE,	/* Performance Reduction Tolerance Register	*/
> +	TIME_WINDOW, 			/* Time Window Register						*/
> +	CTR_WRAP_TIME, 			/* Counter Wraparound Time					*/
> +	REFERENCE_CTR, 			/* Reference Counter Register				*/
> +	DELIVERED_CTR, 			/* Delivered Counter Register				*/
> +	PERF_LIMITED, 			/* Performance Limited Register				*/
> +	ENABLE,					/* Enable Register							*/
> +	AUTO_SEL_ENABLE,		/* Autonomous Selection Enable				*/
> +	AUTO_ACT_WINDOW,		/* Autonomous Activity Window				*/
> +	ENERGY_PERF,			/* Energy Performance Preference Register	*/
> +	REFERENCE_PERF,			/* Reference Performance					*/
> +};
> +
> +/* Each register in the CPC table has the following format */
> +struct cpc_register_resource {
> +	u8 descriptor;
> +	u16 length;
> +	u8 space_id;
> +	u8 bit_width;
> +	u8 bit_offset;
> +	u8 access_width;
> +	u64 __iomem address;
> +}__attribute__((packed));
> +
> +/* Container to hold the CPC details for each CPU */
> +struct cpc_desc {
> +	unsigned int num_entries;
> +	unsigned int version;
> +	struct cpc_register_resource cpc_regs[MAX_CPC_REG_ENT];
> +};
> +
> +static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
> +
> +static int cpc_read64(u64 *val, struct cpc_register_resource *reg)
> +{
> +	struct acpi_pcct_subspace *cppc_ss = pcc_channel->con_priv;
> +	u64 addr = (u64)cppc_ss->base_address;
> +	int err = 0;
> +	int cmd;
> +
> +	switch (reg->space_id) {
> +		case ACPI_ADR_SPACE_PLATFORM_COMM:
> +			{
> +				cmd = PCC_CMD_READ;
> +				err = mbox_send_message(pcc_channel, &cmd);
> +				if (err < 0) {
> +					pr_err("Failed PCC READ: (%d)\n", err);
> +					return err;
> +				}
> +
> +				*val = readq((void *) (reg->address + addr));
> +			}
> +			break;
> +
> +		case ACPI_ADR_SPACE_FIXED_HARDWARE:
> +			break;
> +
> +		default:
> +			pr_err("Unknown space_id detected in cpc reg: %d\n", reg->space_id);
> +			err = -EINVAL;
> +			break;
> +	}
> +
> +	return err;
> +}
> +
> +static int cpc_write64(u64 val, struct cpc_register_resource *reg)
> +{
> +	struct acpi_pcct_subspace *cppc_ss = pcc_channel->con_priv;
> +	u64 addr = (u64)cppc_ss->base_address;
> +	int err = 0;
> +	int cmd;
> +
> +	switch (reg->space_id) {
> +		case ACPI_ADR_SPACE_PLATFORM_COMM:
> +			{
> +				writeq(val, (void *)(reg->address + addr));
> +
> +				cmd = PCC_CMD_WRITE;
> +				err = mbox_send_message(pcc_channel, &cmd);
> +				if (err < 0) {
> +					pr_err("Failed PCC WRITE: (%d)\n", err);
> +					return err;
> +				}
> +			}
> +			break;
> +
> +		case ACPI_ADR_SPACE_FIXED_HARDWARE:
> +			break;
> +
> +		default:
> +			pr_err("Unknown space_id detected in cpc reg: %d\n", reg->space_id);
> +			err = -EINVAL;
> +			break;
> +	}
> +
> +	return err;
> +}

There seems to be quite a lot of code duplication between the two functions
above.  Any chance to combine them somehow?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
