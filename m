From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v3 1/2] CPPC as a PID controller backend
Date: Mon, 1 Dec 2014 01:23:07 -0500
Message-ID: <CAJ5Y-ebiHC9Nk-T7mA33jfibdA1T-pkO2k4KLnhS=-o6gHSbLw@mail.gmail.com>
References: <1416429381-3839-1-git-send-email-ashwin.chaugule@linaro.org>
	<1416429381-3839-2-git-send-email-ashwin.chaugule@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:64856 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243AbaLAGXJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Dec 2014 01:23:09 -0500
Received: by mail-wg0-f54.google.com with SMTP id l2so13261697wgh.27
        for <linux-pm@vger.kernel.org>; Sun, 30 Nov 2014 22:23:08 -0800 (PST)
In-Reply-To: <1416429381-3839-2-git-send-email-ashwin.chaugule@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "rwells@codeaurora.org" <rwells@codeaurora.org>, Linda Knippers <linda.knippers@hp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Dirk Brandewie <dirk.brandewie@gmail.com>, Patch Tracking <patches@linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ashwin Chaugule <ashwin.chaugule@linaro.org>

On 19 November 2014 at 15:36, Ashwin Chaugule
<ashwin.chaugule@linaro.org> wrote:
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


Ping.

Any comments on these patches?

Thanks,
Ashwin

>
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index ffe350f..1237104 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -196,6 +196,18 @@ config GENERIC_CPUFREQ_CPU0
>
>           If in doubt, say N.
>
> +config ACPI_PID
> +       bool "ACPI based PID controller"
> +       depends on PCC && !X86
> +       help
> +         The ACPI PID driver is an implementation of the CPPC (Collaborative
> +         Processor Performance Controls) as defined in the ACPI 5.0+ spec. The
> +         PID governor is derived from the intel_pstate driver and is used as a
> +         standalone governor for CPPC. CPPC allows the OS to request CPU performance
> +         with an abstract metric and lets the platform (e.g. BMC) interpret and
> +         optimize it for power and performance in a platform specific manner. See
> +         the ACPI 5.0+ specification for more details on CPPC.
> +
>  menu "x86 CPU frequency scaling drivers"
>  depends on X86
>  source "drivers/cpufreq/Kconfig.x86"
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index db6d9a2..6717cca 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -92,6 +92,7 @@ obj-$(CONFIG_POWERNV_CPUFREQ)         += powernv-cpufreq.o
>
>  ##################################################################################
>  # Other platform drivers
> +obj-$(CONFIG_ACPI_PID) += acpi_pid.o
>  obj-$(CONFIG_AVR32_AT32AP_CPUFREQ)     += at32ap-cpufreq.o
>  obj-$(CONFIG_BFIN_CPU_FREQ)            += blackfin-cpufreq.o
>  obj-$(CONFIG_CRIS_MACH_ARTPEC3)                += cris-artpec3-cpufreq.o
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
> +
> +#include <asm/div64.h>
> +
> +#define FRAC_BITS 8
> +#define int_tofp(X) ((int64_t)(X) << FRAC_BITS)
> +#define fp_toint(X) ((X) >> FRAC_BITS)
> +
> +#define CPPC_EN                                1
> +#define PCC_CMD_COMPLETE       1
> +#define MAX_CPC_REG_ENT        19
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
> +       int32_t core_pct_busy;
> +       u64 reference;
> +       u64 delivered;
> +       int freq;
> +       ktime_t time;
> +};
> +
> +struct pstate_data {
> +       int     current_pstate;
> +       int     min_pstate;
> +       int     max_pstate;
> +};
> +
> +struct _pid {
> +       int setpoint;
> +       int32_t integral;
> +       int32_t p_gain;
> +       int32_t i_gain;
> +       int32_t d_gain;
> +       int deadband;
> +       int32_t last_err;
> +};
> +
> +struct cpudata {
> +       int cpu;
> +
> +       struct timer_list timer;
> +
> +       struct pstate_data pstate;
> +       struct _pid pid;
> +
> +       ktime_t last_sample_time;
> +       u64     prev_reference;
> +       u64     prev_delivered;
> +       struct sample sample;
> +};
> +
> +static struct cpudata **all_cpu_data;
> +struct pstate_adjust_policy {
> +       int sample_rate_ms;
> +       int deadband;
> +       int setpoint;
> +       int p_gain_pct;
> +       int d_gain_pct;
> +       int i_gain_pct;
> +};
> +
> +struct pstate_funcs {
> +       int (*get_sample)(struct cpudata*);
> +       int (*get_pstates)(struct cpudata*);
> +       int (*set)(struct cpudata*, int pstate);
> +};
> +
> +struct cpu_defaults {
> +       struct pstate_adjust_policy pid_policy;
> +       struct pstate_funcs funcs;
> +};
> +
> +static struct pstate_adjust_policy pid_params;
> +static struct pstate_funcs pstate_funcs;
> +
> +struct perf_limits {
> +       int max_perf_pct;
> +       int min_perf_pct;
> +       int32_t max_perf;
> +       int32_t min_perf;
> +       int max_policy_pct;
> +       int max_sysfs_pct;
> +};
> +
> +static struct perf_limits limits = {
> +       .max_perf_pct = 100,
> +       .max_perf = int_tofp(1),
> +       .min_perf_pct = 0,
> +       .min_perf = 0,
> +       .max_policy_pct = 100,
> +       .max_sysfs_pct = 100,
> +};
> +
> +/* PCC Commands used by CPPC */
> +enum cppc_ppc_cmds {
> +       PCC_CMD_READ,
> +       PCC_CMD_WRITE,
> +       RESERVED,
> +};
> +
> +/* These are indexes into the per-cpu cpc_regs[]. Order is important. */
> +enum cppc_pcc_regs {
> +       HIGHEST_PERF,                   /* Highest Performance                                          */
> +       NOMINAL_PERF,                   /* Nominal Performance                                          */
> +       LOW_NON_LINEAR_PERF,    /* Lowest Nonlinear Performance                         */
> +       LOWEST_PERF,                    /* Lowest Performance                                           */
> +       GUARANTEED_PERF,                /* Guaranteed Performance Register                      */
> +       DESIRED_PERF,                   /* Desired Performance Register                         */
> +       MIN_PERF,                               /* Minimum Performance Register                         */
> +       MAX_PERF,                               /* Maximum Performance Register                         */
> +       PERF_REDUC_TOLERANCE,   /* Performance Reduction Tolerance Register     */
> +       TIME_WINDOW,                    /* Time Window Register                                         */
> +       CTR_WRAP_TIME,                  /* Counter Wraparound Time                                      */
> +       REFERENCE_CTR,                  /* Reference Counter Register                           */
> +       DELIVERED_CTR,                  /* Delivered Counter Register                           */
> +       PERF_LIMITED,                   /* Performance Limited Register                         */
> +       ENABLE,                                 /* Enable Register                                                      */
> +       AUTO_SEL_ENABLE,                /* Autonomous Selection Enable                          */
> +       AUTO_ACT_WINDOW,                /* Autonomous Activity Window                           */
> +       ENERGY_PERF,                    /* Energy Performance Preference Register       */
> +       REFERENCE_PERF,                 /* Reference Performance                                        */
> +};
> +
> +/* Each register in the CPC table has the following format */
> +struct cpc_register_resource {
> +       u8 descriptor;
> +       u16 length;
> +       u8 space_id;
> +       u8 bit_width;
> +       u8 bit_offset;
> +       u8 access_width;
> +       u64 __iomem address;
> +}__attribute__((packed));
> +
> +/* Container to hold the CPC details for each CPU */
> +struct cpc_desc {
> +       unsigned int num_entries;
> +       unsigned int version;
> +       struct cpc_register_resource cpc_regs[MAX_CPC_REG_ENT];
> +};
> +
> +static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
> +
> +static int cpc_read64(u64 *val, struct cpc_register_resource *reg)
> +{
> +       struct acpi_pcct_subspace *cppc_ss = pcc_channel->con_priv;
> +       u64 addr = (u64)cppc_ss->base_address;
> +       int err = 0;
> +       int cmd;
> +
> +       switch (reg->space_id) {
> +               case ACPI_ADR_SPACE_PLATFORM_COMM:
> +                       {
> +                               cmd = PCC_CMD_READ;
> +                               err = mbox_send_message(pcc_channel, &cmd);
> +                               if (err < 0) {
> +                                       pr_err("Failed PCC READ: (%d)\n", err);
> +                                       return err;
> +                               }
> +
> +                               *val = readq((void *) (reg->address + addr));
> +                       }
> +                       break;
> +
> +               case ACPI_ADR_SPACE_FIXED_HARDWARE:
> +                       break;
> +
> +               default:
> +                       pr_err("Unknown space_id detected in cpc reg: %d\n", reg->space_id);
> +                       err = -EINVAL;
> +                       break;
> +       }
> +
> +       return err;
> +}
> +
> +static int cpc_write64(u64 val, struct cpc_register_resource *reg)
> +{
> +       struct acpi_pcct_subspace *cppc_ss = pcc_channel->con_priv;
> +       u64 addr = (u64)cppc_ss->base_address;
> +       int err = 0;
> +       int cmd;
> +
> +       switch (reg->space_id) {
> +               case ACPI_ADR_SPACE_PLATFORM_COMM:
> +                       {
> +                               writeq(val, (void *)(reg->address + addr));
> +
> +                               cmd = PCC_CMD_WRITE;
> +                               err = mbox_send_message(pcc_channel, &cmd);
> +                               if (err < 0) {
> +                                       pr_err("Failed PCC WRITE: (%d)\n", err);
> +                                       return err;
> +                               }
> +                       }
> +                       break;
> +
> +               case ACPI_ADR_SPACE_FIXED_HARDWARE:
> +                       break;
> +
> +               default:
> +                       pr_err("Unknown space_id detected in cpc reg: %d\n", reg->space_id);
> +                       err = -EINVAL;
> +                       break;
> +       }
> +
> +       return err;
> +}
> +
> +static inline int32_t mul_fp(int32_t x, int32_t y)
> +{
> +       return ((int64_t)x * (int64_t)y) >> FRAC_BITS;
> +}
> +
> +static inline int32_t div_fp(int32_t x, int32_t y)
> +{
> +       return div_s64((int64_t)x << FRAC_BITS, y);
> +}
> +
> +static inline void pid_reset(struct _pid *pid, int setpoint, int busy,
> +               int deadband, int integral) {
> +       pid->setpoint = setpoint;
> +       pid->deadband  = deadband;
> +       pid->integral  = int_tofp(integral);
> +       pid->last_err  = int_tofp(setpoint) - int_tofp(busy);
> +}
> +
> +static inline void pid_p_gain_set(struct _pid *pid, int percent)
> +{
> +       pid->p_gain = div_fp(int_tofp(percent), int_tofp(100));
> +}
> +
> +static inline void pid_i_gain_set(struct _pid *pid, int percent)
> +{
> +       pid->i_gain = div_fp(int_tofp(percent), int_tofp(100));
> +}
> +
> +static inline void pid_d_gain_set(struct _pid *pid, int percent)
> +{
> +       pid->d_gain = div_fp(int_tofp(percent), int_tofp(100));
> +}
> +
> +static signed int pid_calc(struct _pid *pid, int32_t busy)
> +{
> +       signed int result;
> +       int32_t pterm, dterm, fp_error;
> +       int32_t integral_limit;
> +
> +       fp_error = int_tofp(pid->setpoint) - busy;
> +
> +       if (abs(fp_error) <= int_tofp(pid->deadband))
> +               return 0;
> +
> +       pterm = mul_fp(pid->p_gain, fp_error);
> +
> +       pid->integral += fp_error;
> +
> +       /* limit the integral term */
> +       integral_limit = int_tofp(30);
> +       if (pid->integral > integral_limit)
> +               pid->integral = integral_limit;
> +       if (pid->integral < -integral_limit)
> +               pid->integral = -integral_limit;
> +
> +       dterm = mul_fp(pid->d_gain, fp_error - pid->last_err);
> +       pid->last_err = fp_error;
> +
> +       result = pterm + mul_fp(pid->integral, pid->i_gain) + dterm;
> +       result = result + (1 << (FRAC_BITS-1));
> +       return (signed int)fp_toint(result);
> +}
> +
> +static inline void acpi_pid_busy_pid_reset(struct cpudata *cpu)
> +{
> +       pid_p_gain_set(&cpu->pid, pid_params.p_gain_pct);
> +       pid_d_gain_set(&cpu->pid, pid_params.d_gain_pct);
> +       pid_i_gain_set(&cpu->pid, pid_params.i_gain_pct);
> +
> +       pid_reset(&cpu->pid, pid_params.setpoint, 100, pid_params.deadband, 0);
> +}
> +
> +static inline void acpi_pid_reset_all_pid(void)
> +{
> +       unsigned int cpu;
> +
> +       for_each_online_cpu(cpu) {
> +               if (all_cpu_data[cpu])
> +                       acpi_pid_busy_pid_reset(all_cpu_data[cpu]);
> +       }
> +}
> +
> +/************************** debugfs begin ************************/
> +static int pid_param_set(void *data, u64 val)
> +{
> +       *(u32 *)data = val;
> +       acpi_pid_reset_all_pid();
> +       return 0;
> +}
> +
> +static int pid_param_get(void *data, u64 *val)
> +{
> +       *val = *(u32 *)data;
> +       return 0;
> +}
> +DEFINE_SIMPLE_ATTRIBUTE(fops_pid_param, pid_param_get, pid_param_set, "%llu\n");
> +
> +struct pid_param {
> +       char *name;
> +       void *value;
> +};
> +
> +static struct pid_param pid_files[] = {
> +       {"sample_rate_ms", &pid_params.sample_rate_ms},
> +       {"d_gain_pct", &pid_params.d_gain_pct},
> +       {"i_gain_pct", &pid_params.i_gain_pct},
> +       {"deadband", &pid_params.deadband},
> +       {"setpoint", &pid_params.setpoint},
> +       {"p_gain_pct", &pid_params.p_gain_pct},
> +       {NULL, NULL}
> +};
> +
> +static void __init acpi_pid_debug_expose_params(void)
> +{
> +       struct dentry *debugfs_parent;
> +       int i = 0;
> +
> +       debugfs_parent = debugfs_create_dir("acpi_pid_snb", NULL);
> +       if (IS_ERR_OR_NULL(debugfs_parent))
> +               return;
> +       while (pid_files[i].name) {
> +               debugfs_create_file(pid_files[i].name, 0660,
> +                               debugfs_parent, pid_files[i].value,
> +                               &fops_pid_param);
> +               i++;
> +       }
> +}
> +
> +/************************** debugfs end ************************/
> +
> +/************************** sysfs begin ************************/
> +#define show_one(file_name, object)                                    \
> +       static ssize_t show_##file_name                                 \
> +(struct kobject *kobj, struct attribute *attr, char *buf)      \
> +{                                                              \
> +       return sprintf(buf, "%u\n", limits.object);             \
> +}
> +
> +static ssize_t store_max_perf_pct(struct kobject *a, struct attribute *b,
> +               const char *buf, size_t count)
> +{
> +       unsigned int input;
> +       int ret;
> +
> +       ret = sscanf(buf, "%u", &input);
> +       if (ret != 1)
> +               return -EINVAL;
> +
> +       limits.max_sysfs_pct = clamp_t(int, input, 0 , 100);
> +       limits.max_perf_pct = min(limits.max_policy_pct, limits.max_sysfs_pct);
> +       limits.max_perf = div_fp(int_tofp(limits.max_perf_pct), int_tofp(100));
> +
> +       return count;
> +}
> +
> +static ssize_t store_min_perf_pct(struct kobject *a, struct attribute *b,
> +               const char *buf, size_t count)
> +{
> +       unsigned int input;
> +       int ret;
> +
> +       ret = sscanf(buf, "%u", &input);
> +       if (ret != 1)
> +               return -EINVAL;
> +       limits.min_perf_pct = clamp_t(int, input, 0 , 100);
> +       limits.min_perf = div_fp(int_tofp(limits.min_perf_pct), int_tofp(100));
> +
> +       return count;
> +}
> +
> +show_one(max_perf_pct, max_perf_pct);
> +show_one(min_perf_pct, min_perf_pct);
> +
> +define_one_global_rw(max_perf_pct);
> +define_one_global_rw(min_perf_pct);
> +
> +static struct attribute *acpi_pid_attributes[] = {
> +       &max_perf_pct.attr,
> +       &min_perf_pct.attr,
> +       NULL
> +};
> +
> +static struct attribute_group acpi_pid_attr_group = {
> +       .attrs = acpi_pid_attributes,
> +};
> +
> +static void __init acpi_pid_sysfs_expose_params(void)
> +{
> +       struct kobject *acpi_pid_kobject;
> +       int rc;
> +
> +       acpi_pid_kobject = kobject_create_and_add("acpi_pid",
> +                       &cpu_subsys.dev_root->kobj);
> +       BUG_ON(!acpi_pid_kobject);
> +       rc = sysfs_create_group(acpi_pid_kobject, &acpi_pid_attr_group);
> +       BUG_ON(rc);
> +}
> +
> +/************************** sysfs end ************************/
> +
> +static void acpi_pid_get_min_max(struct cpudata *cpu, int *min, int *max)
> +{
> +       int max_perf = cpu->pstate.max_pstate;
> +       int max_perf_adj;
> +       int min_perf;
> +
> +       max_perf_adj = fp_toint(mul_fp(int_tofp(max_perf), limits.max_perf));
> +       *max = clamp_t(int, max_perf_adj,
> +                       cpu->pstate.min_pstate, cpu->pstate.max_pstate);
> +
> +       min_perf = fp_toint(mul_fp(int_tofp(max_perf), limits.min_perf));
> +       *min = clamp_t(int, min_perf, cpu->pstate.min_pstate, max_perf);
> +}
> +
> +static int acpi_pid_set_pstate(struct cpudata *cpu, int pstate)
> +{
> +       int max_perf, min_perf;
> +
> +       acpi_pid_get_min_max(cpu, &min_perf, &max_perf);
> +
> +       pstate = clamp_t(int, pstate, min_perf, max_perf);
> +
> +       if (pstate == cpu->pstate.current_pstate)
> +               return 0;
> +
> +       trace_cpu_frequency(pstate * 100000, cpu->cpu);
> +
> +       cpu->pstate.current_pstate = pstate;
> +
> +       return pstate_funcs.set(cpu, pstate);
> +}
> +
> +static int acpi_pid_get_cpu_pstates(struct cpudata *cpu)
> +{
> +       int ret = 0;
> +       ret = pstate_funcs.get_pstates(cpu);
> +
> +       if (ret < 0)
> +               return ret;
> +
> +       return acpi_pid_set_pstate(cpu, cpu->pstate.min_pstate);
> +}
> +
> +static inline void acpi_pid_calc_busy(struct cpudata *cpu)
> +{
> +       struct sample *sample = &cpu->sample;
> +       int64_t core_pct;
> +
> +       core_pct = int_tofp(sample->delivered) * int_tofp(100);
> +       core_pct = div64_u64(core_pct, int_tofp(sample->reference));
> +
> +       sample->freq = fp_toint(
> +                       mul_fp(int_tofp(cpu->pstate.max_pstate * 1000), core_pct));
> +
> +       sample->core_pct_busy = (int32_t)core_pct;
> +}
> +
> +static inline int acpi_pid_sample(struct cpudata *cpu)
> +{
> +       int ret = 0;
> +
> +       cpu->last_sample_time = cpu->sample.time;
> +       cpu->sample.time = ktime_get();
> +
> +       ret = pstate_funcs.get_sample(cpu);
> +
> +       if (ret < 0)
> +               return ret;
> +
> +       acpi_pid_calc_busy(cpu);
> +
> +       return ret;
> +}
> +
> +static inline void acpi_pid_set_sample_time(struct cpudata *cpu)
> +{
> +       int delay;
> +
> +       delay = msecs_to_jiffies(pid_params.sample_rate_ms);
> +       mod_timer_pinned(&cpu->timer, jiffies + delay);
> +}
> +
> +static inline int32_t acpi_pid_get_scaled_busy(struct cpudata *cpu)
> +{
> +       int32_t core_busy, max_pstate, current_pstate, sample_ratio;
> +       u32 duration_us;
> +       u32 sample_time;
> +
> +       core_busy = cpu->sample.core_pct_busy;
> +       max_pstate = int_tofp(cpu->pstate.max_pstate);
> +       current_pstate = int_tofp(cpu->pstate.current_pstate);
> +       core_busy = mul_fp(core_busy, div_fp(max_pstate, current_pstate));
> +
> +       sample_time = pid_params.sample_rate_ms * USEC_PER_MSEC;
> +       duration_us = (u32) ktime_us_delta(cpu->sample.time,
> +                       cpu->last_sample_time);
> +       if (duration_us > sample_time * 3) {
> +               sample_ratio = div_fp(int_tofp(sample_time),
> +                               int_tofp(duration_us));
> +               core_busy = mul_fp(core_busy, sample_ratio);
> +       }
> +
> +       return core_busy;
> +}
> +
> +static inline int acpi_pid_adjust_busy_pstate(struct cpudata *cpu)
> +{
> +       int32_t busy_scaled;
> +       struct _pid *pid;
> +       signed int ctl;
> +
> +       pid = &cpu->pid;
> +       busy_scaled = acpi_pid_get_scaled_busy(cpu);
> +
> +       ctl = pid_calc(pid, busy_scaled);
> +
> +       /* Negative values of ctl increase the pstate and vice versa */
> +       return acpi_pid_set_pstate(cpu, cpu->pstate.current_pstate - ctl);
> +}
> +
> +static void acpi_pid_timer_func(unsigned long __data)
> +{
> +       struct cpudata *cpu = (struct cpudata *) __data;
> +       struct sample *sample;
> +
> +       acpi_pid_sample(cpu);
> +
> +       sample = &cpu->sample;
> +
> +       acpi_pid_adjust_busy_pstate(cpu);
> +
> +       trace_pstate_sample(fp_toint(sample->core_pct_busy),
> +                       fp_toint(acpi_pid_get_scaled_busy(cpu)),
> +                       cpu->pstate.current_pstate,
> +                       sample->delivered,
> +                       sample->reference,
> +                       sample->freq);
> +
> +       acpi_pid_set_sample_time(cpu);
> +}
> +
> +static int acpi_pid_init_cpu(unsigned int cpunum)
> +{
> +       struct cpudata *cpu;
> +       int ret = 0;
> +
> +       all_cpu_data[cpunum] = kzalloc(sizeof(struct cpudata), GFP_KERNEL);
> +       if (!all_cpu_data[cpunum])
> +               return -ENOMEM;
> +
> +       cpu = all_cpu_data[cpunum];
> +
> +       cpu->cpu = cpunum;
> +       ret = acpi_pid_get_cpu_pstates(cpu);
> +
> +       if (ret < 0)
> +               return ret;
> +
> +       init_timer_deferrable(&cpu->timer);
> +       cpu->timer.function = acpi_pid_timer_func;
> +       cpu->timer.data = (unsigned long)cpu;
> +       cpu->timer.expires = jiffies + HZ/100;
> +       acpi_pid_busy_pid_reset(cpu);
> +       ret = acpi_pid_sample(cpu);
> +
> +       if (ret < 0)
> +               return ret;
> +
> +       add_timer_on(&cpu->timer, cpunum);
> +
> +       pr_debug("ACPI PID controlling: cpu %d\n", cpunum);
> +
> +       return ret;
> +}
> +
> +static unsigned int acpi_pid_get(unsigned int cpu_num)
> +{
> +       struct sample *sample;
> +       struct cpudata *cpu;
> +
> +       cpu = all_cpu_data[cpu_num];
> +       if (!cpu)
> +               return 0;
> +       sample = &cpu->sample;
> +       return sample->freq;
> +}
> +
> +static int acpi_pid_set_policy(struct cpufreq_policy *policy)
> +{
> +       if (!policy->cpuinfo.max_freq)
> +               return -ENODEV;
> +
> +       if (policy->policy == CPUFREQ_POLICY_PERFORMANCE) {
> +               limits.min_perf_pct = 100;
> +               limits.min_perf = int_tofp(1);
> +               limits.max_perf_pct = 100;
> +               limits.max_perf = int_tofp(1);
> +               return 0;
> +       }
> +       limits.min_perf_pct = (policy->min * 100) / policy->cpuinfo.max_freq;
> +       limits.min_perf_pct = clamp_t(int, limits.min_perf_pct, 0 , 100);
> +       limits.min_perf = div_fp(int_tofp(limits.min_perf_pct), int_tofp(100));
> +
> +       limits.max_policy_pct = (policy->max * 100) / policy->cpuinfo.max_freq;
> +       limits.max_policy_pct = clamp_t(int, limits.max_policy_pct, 0 , 100);
> +       limits.max_perf_pct = min(limits.max_policy_pct, limits.max_sysfs_pct);
> +       limits.max_perf = div_fp(int_tofp(limits.max_perf_pct), int_tofp(100));
> +
> +       return 0;
> +}
> +
> +static int acpi_pid_verify_policy(struct cpufreq_policy *policy)
> +{
> +       cpufreq_verify_within_cpu_limits(policy);
> +
> +       if (policy->policy != CPUFREQ_POLICY_POWERSAVE &&
> +                       policy->policy != CPUFREQ_POLICY_PERFORMANCE)
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
> +static void acpi_pid_stop_cpu(struct cpufreq_policy *policy)
> +{
> +       int cpu_num = policy->cpu;
> +       struct cpudata *cpu = all_cpu_data[cpu_num];
> +
> +       pr_info("acpi_pid CPU %d exiting\n", cpu_num);
> +
> +       del_timer_sync(&all_cpu_data[cpu_num]->timer);
> +       acpi_pid_set_pstate(cpu, cpu->pstate.min_pstate);
> +       kfree(all_cpu_data[cpu_num]);
> +       all_cpu_data[cpu_num] = NULL;
> +}
> +
> +static int acpi_pid_cpu_init(struct cpufreq_policy *policy)
> +{
> +       struct cpudata *cpu;
> +       int rc;
> +
> +       rc = acpi_pid_init_cpu(policy->cpu);
> +       if (rc)
> +               return rc;
> +
> +       cpu = all_cpu_data[policy->cpu];
> +
> +       if (limits.min_perf_pct == 100 && limits.max_perf_pct == 100)
> +               policy->policy = CPUFREQ_POLICY_PERFORMANCE;
> +       else
> +               policy->policy = CPUFREQ_POLICY_POWERSAVE;
> +
> +       policy->min = cpu->pstate.min_pstate * 100000;
> +       policy->max = cpu->pstate.max_pstate * 100000;
> +
> +       /* cpuinfo and default policy values */
> +       policy->cpuinfo.min_freq = cpu->pstate.min_pstate * 100000;
> +       policy->cpuinfo.max_freq = cpu->pstate.max_pstate * 100000;
> +       policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
> +       cpumask_set_cpu(policy->cpu, policy->cpus);
> +
> +       return 0;
> +}
> +
> +static struct cpufreq_driver acpi_pid_driver = {
> +       .flags = CPUFREQ_CONST_LOOPS,
> +       .verify = acpi_pid_verify_policy,
> +       .setpolicy = acpi_pid_set_policy,
> +       .get = acpi_pid_get,
> +       .init = acpi_pid_cpu_init,
> +       .stop_cpu = acpi_pid_stop_cpu,
> +       .name = "acpi_pid",
> +};
> +
> +static void copy_pid_params(struct pstate_adjust_policy *policy)
> +{
> +       pid_params.sample_rate_ms = policy->sample_rate_ms;
> +       pid_params.p_gain_pct = policy->p_gain_pct;
> +       pid_params.i_gain_pct = policy->i_gain_pct;
> +       pid_params.d_gain_pct = policy->d_gain_pct;
> +       pid_params.deadband = policy->deadband;
> +       pid_params.setpoint = policy->setpoint;
> +}
> +
> +static void copy_cpu_funcs(struct pstate_funcs *funcs)
> +{
> +       pstate_funcs.get_sample = funcs->get_sample;
> +       pstate_funcs.get_pstates = funcs->get_pstates;
> +       pstate_funcs.set = funcs->set;
> +}
> +
> +static void cppc_chan_tx_done(struct mbox_client *cl, void *mssg, int ret)
> +{
> +       if (!ret)
> +               pr_debug("PCC TX successfully completed. CMD sent = %x\n", *(u16*)mssg);
> +       else
> +               pr_warn("PCC channel TX did not complete: CMD sent = %x\n", *(u16*)mssg);
> +}
> +
> +struct mbox_client cppc_mbox_cl = {
> +       .tx_done = cppc_chan_tx_done,
> +       .tx_block = true,
> +       .tx_tout = 10,
> +};
> +
> +/*
> + * The _CPC table is a per CPU table that describes all the PCC registers.
> + * An example table looks like the following. The complete list of registers
> + * one would expect is above cppc_pcc_regs[].
> + *
> + *     Name(_CPC, Package()
> + *                     {
> + *                     17,
> + *                     NumEntries
> + *                     1,
> + *                     // Revision
> + *                     ResourceTemplate(){Register(PCC, 32, 0, 0x120, 2)},
> + *                     // Highest Performance
> + *                     ResourceTemplate(){Register(PCC, 32, 0, 0x124, 2)},
> + *                     // Nominal Performance
> + *                     ResourceTemplate(){Register(PCC, 32, 0, 0x128, 2)},
> + *                     // Lowest Nonlinear Performance
> + *                     ResourceTemplate(){Register(PCC, 32, 0, 0x12C, 2)},
> + *                     // Lowest Performance
> + *                     ResourceTemplate(){Register(PCC, 32, 0, 0x130, 2)},
> + *                     // Guaranteed Performance Register
> + *                     ResourceTemplate(){Register(PCC, 32, 0, 0x110, 2)},
> + *                     // Desired Performance Register
> + *                     ResourceTemplate(){Register(SystemMemory, 0, 0, 0, 0)},
> + *                     ..
> + *                     ..
> + *                     ..
> + *
> + *             }
> + * Each Register() encodes how to access that specific register.
> + * e.g. a sample PCC entry has the following encoding:
> + *
> + *     Register (
> + *             PCC,
> + *             AddressSpaceKeyword
> + *             8,
> + *             //RegisterBitWidth
> + *             8,
> + *             //RegisterBitOffset
> + *             0x30,
> + *             //RegisterAddress
> + *             9
> + *             //AccessSize (subspace ID)
> + *             0
> + *             )
> + *             }
> + *
> + *     This function walks through all the per CPU _CPC entries and extracts
> + *     the Register details. See cpc_read64/write64() to see how these registers
> + *     are accessed.
> + */
> +static int acpi_cppc_processor_probe(void)
> +{
> +       struct acpi_buffer output = {ACPI_ALLOCATE_BUFFER, NULL};
> +       union acpi_object *out_obj, *cpc_obj;
> +       struct cpc_desc *current_cpu_cpc;
> +       struct cpc_register_resource *gas_t;
> +       struct acpi_pcct_subspace *cppc_ss;
> +       char proc_name[11];
> +       unsigned int num_ent, ret = 0, i, cpu, len;
> +       acpi_handle handle;
> +       acpi_status status;
> +
> +       /* Parse the ACPI _CPC table for each cpu. */
> +       for_each_possible_cpu(cpu) {
> +               sprintf(proc_name, "\\_PR.CPU%d", cpu);
> +
> +               status = acpi_get_handle(NULL, proc_name, &handle);
> +               if (ACPI_FAILURE(status)) {
> +                       ret = -ENODEV;
> +                       goto out_free;
> +               }
> +
> +               if (!acpi_has_method(handle, "_CPC")) {
> +                       ret = -ENODEV;
> +                       goto out_free;
> +               }
> +
> +               status = acpi_evaluate_object(handle, "_CPC", NULL, &output);
> +               if (ACPI_FAILURE(status)) {
> +                       ret = -ENODEV;
> +                       goto out_free;
> +               }
> +
> +               out_obj = (union acpi_object *) output.pointer;
> +               if (out_obj->type != ACPI_TYPE_PACKAGE) {
> +                       ret = -ENODEV;
> +                       goto out_free;
> +               }
> +
> +               current_cpu_cpc = kzalloc(sizeof(struct cpc_desc), GFP_KERNEL);
> +               if (!current_cpu_cpc) {
> +                       pr_err("Could not allocate per cpu CPC descriptors\n");
> +                       return -ENOMEM;
> +               }
> +
> +               num_ent = out_obj->package.count;
> +               current_cpu_cpc->num_entries = num_ent;
> +
> +               pr_info("num_ent in CPC table:%d\n", num_ent);
> +
> +               /* Iterate through each entry in _CPC */
> +               for (i = 2; i < num_ent; i++) {
> +                       cpc_obj = &out_obj->package.elements[i];
> +
> +                       if (cpc_obj->type != ACPI_TYPE_BUFFER) {
> +                               pr_err("Error in PCC entry in CPC table\n");
> +                               ret = -EINVAL;
> +                               goto out_free;
> +                       }
> +
> +                       gas_t = (struct cpc_register_resource *) cpc_obj->buffer.pointer;
> +
> +                       /*
> +                        * The PCC Subspace index is encoded inside the CPC table entries.
> +                        * The same PCC index will be used for all the entries, so extract
> +                        * it only once.
> +                        */
> +                       if (gas_t->space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
> +                               if (pcc_subspace_idx < 0)
> +                                       pcc_subspace_idx = gas_t->access_width;
> +                       }
> +
> +                       /*
> +                        * First two entires are Version and num of entries.
> +                        * Rest of them are PCC registers. Hence the loop
> +                        * begins at 2. Get each reg info.
> +                        */
> +                       current_cpu_cpc->cpc_regs[i-2] = (struct cpc_register_resource) {
> +                               .space_id = gas_t->space_id,
> +                               .length = gas_t->length,
> +                               .bit_width = gas_t->bit_width,
> +                               .bit_offset = gas_t->bit_offset,
> +                               .address = gas_t->address,
> +                               .access_width = gas_t->access_width,
> +                       };
> +               }
> +               /* Plug it into this CPUs CPC descriptor. */
> +               per_cpu(cpc_desc_ptr, cpu) = current_cpu_cpc;
> +       }
> +
> +       /*
> +        * Now that we have all the information from the CPC table,
> +        * lets get a mailbox channel from the mailbox controller.
> +        * The channel for client is indexed using the subspace id
> +        * which was encoded in the Register(PCC.. entries.
> +        */
> +       pr_debug("Completed parsing, now onto PCC init\n");
> +
> +       if (pcc_subspace_idx >= 0) {
> +               pcc_channel = pcc_mbox_request_channel(&cppc_mbox_cl,
> +                               pcc_subspace_idx);
> +
> +               if (IS_ERR(pcc_channel)) {
> +                       pr_err("No PCC communication channel found\n");
> +                       ret = -ENODEV;
> +                       goto out_free;
> +               }
> +
> +
> +               /*
> +                * The PCC mailbox controller driver should
> +                * have parsed the PCCT (global table of all
> +                * PCC channels) and stored pointers to the
> +                * subspace communication region in con_priv.
> +                */
> +               cppc_ss = pcc_channel->con_priv;
> +
> +               /*
> +                * This is the shared communication region
> +                * for the OS and Platform to communicate over.
> +                */
> +               comm_base_addr = cppc_ss->base_address;
> +               len = cppc_ss->length;
> +
> +               pr_debug("From PCCT: CPPC subspace addr:%llx, len: %d\n", comm_base_addr, len);
> +               pcc_comm_addr = ioremap(comm_base_addr, len);
> +               if (!pcc_comm_addr) {
> +                       ret = -ENOMEM;
> +                       pr_err("Failed to ioremap PCC comm region mem\n");
> +                       goto out_free;
> +               }
> +
> +               cppc_ss->base_address = (u64)pcc_comm_addr;
> +               pr_debug("New PCC comm space addr: %llx\n", (u64)pcc_comm_addr);
> +
> +       } else {
> +               pr_err("No PCC subspace detected in any CPC structure!\n");
> +               ret = -EINVAL;
> +               goto out_free;
> +       }
> +
> +       /* Everything looks okay */
> +       pr_info("Successfully parsed all CPC structs\n");
> +
> +       kfree(output.pointer);
> +       return 0;
> +
> +out_free:
> +       for_each_online_cpu(cpu) {
> +               current_cpu_cpc = per_cpu(cpc_desc_ptr, cpu);
> +               if (current_cpu_cpc)
> +                       kfree(current_cpu_cpc);
> +       }
> +
> +       kfree(output.pointer);
> +       return -ENODEV;
> +}
> +
> +static int cppc_get_pstates(struct cpudata *cpu)
> +{
> +       unsigned int cpunum = cpu->cpu;
> +       struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
> +       struct cpc_register_resource *highest_reg, *lowest_reg;
> +       u64 min, max;
> +       int ret;
> +
> +       if (!cpc_desc) {
> +               pr_err("No CPC descriptor for CPU:%d\n", cpunum);
> +               return -ENODEV;
> +       }
> +
> +       highest_reg = &cpc_desc->cpc_regs[HIGHEST_PERF];
> +       lowest_reg = &cpc_desc->cpc_regs[LOWEST_PERF];
> +
> +       ret = cpc_read64(&max, highest_reg);
> +       if (ret < 0) {
> +               pr_err("Err getting max pstate\n");
> +               return ret;
> +       }
> +
> +       cpu->pstate.max_pstate = max;
> +
> +       ret = cpc_read64(&min, lowest_reg);
> +       if (ret < 0) {
> +               pr_err("Err getting min pstate\n");
> +               return ret;
> +       }
> +
> +       cpu->pstate.min_pstate = min;
> +
> +       if (!cpu->pstate.max_pstate || !cpu->pstate.min_pstate) {
> +               pr_err("Err reading CPU performance limits\n");
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static int cppc_get_sample(struct cpudata *cpu)
> +{
> +       unsigned int cpunum = cpu->cpu;
> +       struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
> +       struct cpc_register_resource *delivered_reg, *reference_reg;
> +       u64 delivered, reference;
> +       int ret;
> +
> +       if (!cpc_desc) {
> +               pr_err("No CPC descriptor for CPU:%d\n", cpunum);
> +               return -ENODEV;
> +       }
> +
> +       delivered_reg = &cpc_desc->cpc_regs[DELIVERED_CTR];
> +       reference_reg = &cpc_desc->cpc_regs[REFERENCE_CTR];
> +
> +       ret = cpc_read64(&delivered, delivered_reg);
> +       if (ret < 0) {
> +               pr_err("Err getting Delivered ctr\n");
> +               return ret;
> +       }
> +
> +       ret = cpc_read64(&reference, reference_reg);
> +       if (ret < 0) {
> +               pr_err("Err getting Reference ctr\n");
> +               return ret;
> +       }
> +
> +       if (!delivered || !reference) {
> +               pr_err("Bogus values from Delivered or Reference counters\n");
> +               return -EINVAL;
> +       }
> +
> +       cpu->sample.delivered = delivered;
> +       cpu->sample.reference = reference;
> +
> +       cpu->sample.delivered -= cpu->prev_delivered;
> +       cpu->sample.reference -= cpu->prev_reference;
> +
> +       cpu->prev_delivered = delivered;
> +       cpu->prev_reference = reference;
> +
> +       return 0;
> +}
> +
> +static int cppc_set_pstate(struct cpudata *cpudata, int state)
> +{
> +       unsigned int cpu = cpudata->cpu;
> +       struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
> +       struct cpc_register_resource *desired_reg;
> +
> +       if (!cpc_desc) {
> +               pr_err("No CPC descriptor for CPU:%d\n", cpu);
> +               return -ENODEV;
> +       }
> +
> +       desired_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
> +       return cpc_write64(state, desired_reg);
> +}
> +
> +static struct cpu_defaults acpi_pid_cppc = {
> +       .pid_policy = {
> +               .sample_rate_ms = 10,
> +               .deadband = 0,
> +               .setpoint = 97,
> +               .p_gain_pct = 14,
> +               .d_gain_pct = 0,
> +               .i_gain_pct = 4,
> +       },
> +       .funcs = {
> +               .get_sample = cppc_get_sample,
> +               .get_pstates = cppc_get_pstates,
> +               .set = cppc_set_pstate,
> +       },
> +};
> +
> +static int __init acpi_cppc_init(void)
> +{
> +       if (acpi_disabled || acpi_cppc_processor_probe()) {
> +               pr_err("Err initializing CPC structures or ACPI is disabled\n");
> +               return -ENODEV;
> +       }
> +
> +       copy_pid_params(&acpi_pid_cppc.pid_policy);
> +       copy_cpu_funcs(&acpi_pid_cppc.funcs);
> +
> +       return 0;
> +}
> +
> +static int __init acpi_pid_init(void)
> +{
> +       int cpu, rc = 0;
> +
> +       rc = acpi_cppc_init();
> +
> +       if (rc)
> +               return -ENODEV;
> +
> +       pr_info("ACPI PID driver initializing.\n");
> +
> +       all_cpu_data = vzalloc(sizeof(void *) * num_possible_cpus());
> +       if (!all_cpu_data)
> +               return -ENOMEM;
> +
> +       rc = cpufreq_register_driver(&acpi_pid_driver);
> +       if (rc)
> +               goto out;
> +
> +       acpi_pid_debug_expose_params();
> +       acpi_pid_sysfs_expose_params();
> +
> +       return rc;
> +out:
> +       get_online_cpus();
> +       for_each_online_cpu(cpu) {
> +               if (all_cpu_data[cpu]) {
> +                       del_timer_sync(&all_cpu_data[cpu]->timer);
> +                       kfree(all_cpu_data[cpu]);
> +               }
> +       }
> +
> +       put_online_cpus();
> +       vfree(all_cpu_data);
> +       return -ENODEV;
> +}
> +
> +late_initcall(acpi_pid_init);
> --
> 1.9.1
>
