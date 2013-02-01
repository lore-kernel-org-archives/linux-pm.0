From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v8 3/3] PM: Introduce Intel PowerClamp Driver
Date: Fri, 01 Feb 2013 13:46:18 +0800
Message-ID: <1359697578.2241.96.camel@rzhang1-mobl4>
References: <1358771877-15203-1-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:28082 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751671Ab3BAFqX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 1 Feb 2013 00:46:23 -0500
In-Reply-To: <1358771877-15203-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, Arjan van de Ven <arjan@linux.intel.com>

On Mon, 2013-01-21 at 04:37 -0800, Jacob Pan wrote:
> Intel PowerClamp driver performs synchronized idle injection across
> all online CPUs. The goal is to maintain a given package level C-stat=
e
> ratio.
>=20
> Compared to other throttling methods already exist in the kernel,
> such as ACPI PAD (taking CPUs offline) and clock modulation, this is =
often
> more efficient in terms of performance per watt.
>=20
> Please refer to Documentation/thermal/intel_powerclamp.txt for more d=
etails.
>=20
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

applied to thermal -next.

thanks,
rui
> ---
>  Documentation/thermal/intel_powerclamp.txt |  307 +++++++++++
>  drivers/thermal/Kconfig                    |   10 +
>  drivers/thermal/Makefile                   |    2 +
>  drivers/thermal/intel_powerclamp.c         |  794 ++++++++++++++++++=
++++++++++
>  4 files changed, 1113 insertions(+)
>  create mode 100644 Documentation/thermal/intel_powerclamp.txt
>  create mode 100644 drivers/thermal/intel_powerclamp.c
>=20
> diff --git a/Documentation/thermal/intel_powerclamp.txt b/Documentati=
on/thermal/intel_powerclamp.txt
> new file mode 100644
> index 0000000..332de4a
> --- /dev/null
> +++ b/Documentation/thermal/intel_powerclamp.txt
> @@ -0,0 +1,307 @@
> +			 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +			 INTEL POWERCLAMP DRIVER
> +			 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +By: Arjan van de Ven <arjan@linux.intel.com>
> +    Jacob Pan <jacob.jun.pan@linux.intel.com>
> +
> +Contents:
> +	(*) Introduction
> +	    - Goals and Objectives
> +
> +	(*) Theory of Operation
> +	    - Idle Injection
> +	    - Calibration
> +
> +	(*) Performance Analysis
> +	    - Effectiveness and Limitations
> +	    - Power vs Performance
> +	    - Scalability
> +	    - Calibration
> +	    - Comparison with Alternative Techniques
> +
> +	(*) Usage and Interfaces
> +	    - Generic Thermal Layer (sysfs)
> +	    - Kernel APIs (TBD)
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +INTRODUCTION
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Consider the situation where a system=E2=80=99s power consumption mu=
st be
> +reduced at runtime, due to power budget, thermal constraint, or nois=
e
> +level, and where active cooling is not preferred. Software managed
> +passive power reduction must be performed to prevent the hardware
> +actions that are designed for catastrophic scenarios.
> +
> +Currently, P-states, T-states (clock modulation), and CPU offlining
> +are used for CPU throttling.
> +
> +On Intel CPUs, C-states provide effective power reduction, but so fa=
r
> +they=E2=80=99re only used opportunistically, based on workload. With=
 the
> +development of intel_powerclamp driver, the method of synchronizing
> +idle injection across all online CPU threads was introduced. The goa=
l
> +is to achieve forced and controllable C-state residency.
> +
> +Test/Analysis has been made in the areas of power, performance,
> +scalability, and user experience. In many cases, clear advantage is
> +shown over taking the CPU offline or modulating the CPU clock.
> +
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +THEORY OF OPERATION
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Idle Injection
> +--------------
> +
> +On modern Intel processors (Nehalem or later), package level C-state
> +residency is available in MSRs, thus also available to the kernel.
> +
> +These MSRs are:
> +      #define MSR_PKG_C2_RESIDENCY	0x60D
> +      #define MSR_PKG_C3_RESIDENCY	0x3F8
> +      #define MSR_PKG_C6_RESIDENCY	0x3F9
> +      #define MSR_PKG_C7_RESIDENCY	0x3FA
> +
> +If the kernel can also inject idle time to the system, then a
> +closed-loop control system can be established that manages package
> +level C-state. The intel_powerclamp driver is conceived as such a
> +control system, where the target set point is a user-selected idle
> +ratio (based on power reduction), and the error is the difference
> +between the actual package level C-state residency ratio and the tar=
get idle
> +ratio.
> +
> +Injection is controlled by high priority kernel threads, spawned for
> +each online CPU.
> +
> +These kernel threads, with SCHED_FIFO class, are created to perform
> +clamping actions of controlled duty ratio and duration. Each per-CPU
> +thread synchronizes its idle time and duration, based on the roundin=
g
> +of jiffies, so accumulated errors can be prevented to avoid a jitter=
y
> +effect. Threads are also bound to the CPU such that they cannot be
> +migrated, unless the CPU is taken offline. In this case, threads
> +belong to the offlined CPUs will be terminated immediately.
> +
> +Running as SCHED_FIFO and relatively high priority, also allows such
> +scheme to work for both preemptable and non-preemptable kernels.
> +Alignment of idle time around jiffies ensures scalability for HZ
> +values. This effect can be better visualized using a Perf timechart.
> +The following diagram shows the behavior of kernel thread
> +kidle_inject/cpu. During idle injection, it runs monitor/mwait idle
> +for a given "duration", then relinquishes the CPU to other tasks,
> +until the next time interval.
> +
> +The NOHZ schedule tick is disabled during idle time, but interrupts
> +are not masked. Tests show that the extra wakeups from scheduler tic=
k
> +have a dramatic impact on the effectiveness of the powerclamp driver
> +on large scale systems (Westmere system with 80 processors).
> +
> +CPU0
> +		  ____________          ____________
> +kidle_inject/0   |   sleep    |  mwait |  sleep     |
> +	_________|            |________|            |_______
> +			       duration
> +CPU1
> +		  ____________          ____________
> +kidle_inject/1   |   sleep    |  mwait |  sleep     |
> +	_________|            |________|            |_______
> +			      ^
> +			      |
> +			      |
> +			      roundup(jiffies, interval)
> +
> +Only one CPU is allowed to collect statistics and update global
> +control parameters. This CPU is referred to as the controlling CPU i=
n
> +this document. The controlling CPU is elected at runtime, with a
> +policy that favors BSP, taking into account the possibility of a CPU
> +hot-plug.
> +
> +In terms of dynamics of the idle control system, package level idle
> +time is considered largely as a non-causal system where its behavior
> +cannot be based on the past or current input. Therefore, the
> +intel_powerclamp driver attempts to enforce the desired idle time
> +instantly as given input (target idle ratio). After injection,
> +powerclamp moniors the actual idle for a given time window and adjus=
t
> +the next injection accordingly to avoid over/under correction.
> +
> +When used in a causal control system, such as a temperature control,
> +it is up to the user of this driver to implement algorithms where
> +past samples and outputs are included in the feedback. For example, =
a
> +PID-based thermal controller can use the powerclamp driver to
> +maintain a desired target temperature, based on integral and
> +derivative gains of the past samples.
> +
> +
> +
> +Calibration
> +-----------
> +During scalability testing, it is observed that synchronized actions
> +among CPUs become challenging as the number of cores grows. This is
> +also true for the ability of a system to enter package level C-state=
s.
> +
> +To make sure the intel_powerclamp driver scales well, online
> +calibration is implemented. The goals for doing such a calibration
> +are:
> +
> +a) determine the effective range of idle injection ratio
> +b) determine the amount of compensation needed at each target ratio
> +
> +Compensation to each target ratio consists of two parts:
> +
> +        a) steady state error compensation
> +	This is to offset the error occurring when the system can
> +	enter idle without extra wakeups (such as external interrupts).
> +
> +	b) dynamic error compensation
> +	When an excessive amount of wakeups occurs during idle, an
> +	additional idle ratio can be added to quiet interrupts, by
> +	slowing down CPU activities.
> +
> +A debugfs file is provided for the user to examine compensation
> +progress and results, such as on a Westmere system.
> +[jacob@nex01 ~]$ cat
> +/sys/kernel/debug/intel_powerclamp/powerclamp_calib
> +controlling cpu: 0
> +pct confidence steady dynamic (compensation)
> +0	0	0	0
> +1	1	0	0
> +2	1	1	0
> +3	3	1	0
> +4	3	1	0
> +5	3	1	0
> +6	3	1	0
> +7	3	1	0
> +8	3	1	0
> +...
> +30	3	2	0
> +31	3	2	0
> +32	3	1	0
> +33	3	2	0
> +34	3	1	0
> +35	3	2	0
> +36	3	1	0
> +37	3	2	0
> +38	3	1	0
> +39	3	2	0
> +40	3	3	0
> +41	3	1	0
> +42	3	2	0
> +43	3	1	0
> +44	3	1	0
> +45	3	2	0
> +46	3	3	0
> +47	3	0	0
> +48	3	2	0
> +49	3	3	0
> +
> +Calibration occurs during runtime. No offline method is available.
> +Steady state compensation is used only when confidence levels of all
> +adjacent ratios have reached satisfactory level. A confidence level
> +is accumulated based on clean data collected at runtime. Data
> +collected during a period without extra interrupts is considered
> +clean.
> +
> +To compensate for excessive amounts of wakeup during idle, additiona=
l
> +idle time is injected when such a condition is detected. Currently,
> +we have a simple algorithm to double the injection ratio. A possible
> +enhancement might be to throttle the offending IRQ, such as delaying
> +EOI for level triggered interrupts. But it is a challenge to be
> +non-intrusive to the scheduler or the IRQ core code.
> +
> +
> +CPU Online/Offline
> +------------------
> +Per-CPU kernel threads are started/stopped upon receiving
> +notifications of CPU hotplug activities. The intel_powerclamp driver
> +keeps track of clamping kernel threads, even after they are migrated
> +to other CPUs, after a CPU offline event.
> +
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Performance Analysis
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +This section describes the general performance data collected on
> +multiple systems, including Westmere (80P) and Ivy Bridge (4P, 8P).
> +
> +Effectiveness and Limitations
> +-----------------------------
> +The maximum range that idle injection is allowed is capped at 50
> +percent. As mentioned earlier, since interrupts are allowed during
> +forced idle time, excessive interrupts could result in less
> +effectiveness. The extreme case would be doing a ping -f to generate=
d
> +flooded network interrupts without much CPU acknowledgement. In this
> +case, little can be done from the idle injection threads. In most
> +normal cases, such as scp a large file, applications can be throttle=
d
> +by the powerclamp driver, since slowing down the CPU also slows down
> +network protocol processing, which in turn reduces interrupts.
> +
> +When control parameters change at runtime by the controlling CPU, it
> +may take an additional period for the rest of the CPUs to catch up
> +with the changes. During this time, idle injection is out of sync,
> +thus not able to enter package C- states at the expected ratio. But
> +this effect is minor, in that in most cases change to the target
> +ratio is updated much less frequently than the idle injection
> +frequency.
> +
> +Scalability
> +-----------
> +Tests also show a minor, but measurable, difference between the 4P/8=
P
> +Ivy Bridge system and the 80P Westmere server under 50% idle ratio.
> +More compensation is needed on Westmere for the same amount of
> +target idle ratio. The compensation also increases as the idle ratio
> +gets larger. The above reason constitutes the need for the
> +calibration code.
> +
> +On the IVB 8P system, compared to an offline CPU, powerclamp can
> +achieve up to 40% better performance per watt. (measured by a spin
> +counter summed over per CPU counting threads spawned for all running
> +CPUs).
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Usage and Interfaces
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +The powerclamp driver is registered to the generic thermal layer as =
a
> +cooling device. Currently, it=E2=80=99s not bound to any thermal zon=
es.
> +
> +jacob@chromoly:/sys/class/thermal/cooling_device14$ grep . *
> +cur_state:0
> +max_state:50
> +type:intel_powerclamp
> +
> +Example usage:
> +- To inject 25% idle time
> +$ sudo sh -c "echo 25 > /sys/class/thermal/cooling_device80/cur_stat=
e
> +"
> +
> +If the system is not busy and has more than 25% idle time already,
> +then the powerclamp driver will not start idle injection. Using Top
> +will not show idle injection kernel threads.
> +
> +If the system is busy (spin test below) and has less than 25% natura=
l
> +idle time, powerclamp kernel threads will do idle injection, which
> +appear running to the scheduler. But the overall system idle is stil=
l
> +reflected. In this example, 24.1% idle is shown. This helps the
> +system admin or user determine the cause of slowdown, when a
> +powerclamp driver is in action.
> +
> +
> +Tasks: 197 total,   1 running, 196 sleeping,   0 stopped,   0 zombie
> +Cpu(s): 71.2%us,  4.7%sy,  0.0%ni, 24.1%id,  0.0%wa,  0.0%hi,  0.0%s=
i,  0.0%st
> +Mem:   3943228k total,  1689632k used,  2253596k free,    74960k buf=
fers
> +Swap:  4087804k total,        0k used,  4087804k free,   945336k cac=
hed
> +
> +  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
> + 3352 jacob     20   0  262m  644  428 S  286  0.0   0:17.16 spin
> + 3341 root     -51   0     0    0    0 D   25  0.0   0:01.62 kidle_i=
nject/0
> + 3344 root     -51   0     0    0    0 D   25  0.0   0:01.60 kidle_i=
nject/3
> + 3342 root     -51   0     0    0    0 D   25  0.0   0:01.61 kidle_i=
nject/1
> + 3343 root     -51   0     0    0    0 D   25  0.0   0:01.60 kidle_i=
nject/2
> + 2935 jacob     20   0  696m 125m  35m S    5  3.3   0:31.11 firefox
> + 1546 root      20   0  158m  20m 6640 S    3  0.5   0:26.97 Xorg
> + 2100 jacob     20   0 1223m  88m  30m S    3  2.3   0:23.68 compiz
> +
> +Tests have shown that by using the powerclamp driver as a cooling
> +device, a PID based userspace thermal controller can manage to
> +control CPU temperature effectively, when no other thermal influence
> +is added. For example, a UltraBook user can compile the kernel under
> +certain temperature (below most active trip points).
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index c2c77d1..7d90ab8 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -122,4 +122,14 @@ config DB8500_CPUFREQ_COOLING
>  	  bound cpufreq cooling device turns active to set CPU frequency lo=
w to
>  	  cool down the CPU.
> =20
> +config INTEL_POWERCLAMP
> +	tristate "Intel PowerClamp idle injection driver"
> +	depends on THERMAL
> +	depends on X86
> +	depends on CPU_SUP_INTEL
> +	help
> +	  Enable this to enable Intel PowerClamp idle injection driver. Thi=
s
> +	  enforce idle time which results in more package C-state residency=
=2E The
> +	  user interface is exposed via generic thermal framework.
> +
>  endif
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index d8da683..574f5f5 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -18,3 +18,5 @@ obj-$(CONFIG_RCAR_THERMAL)	+=3D rcar_thermal.o
>  obj-$(CONFIG_EXYNOS_THERMAL)	+=3D exynos_thermal.o
>  obj-$(CONFIG_DB8500_THERMAL)	+=3D db8500_thermal.o
>  obj-$(CONFIG_DB8500_CPUFREQ_COOLING)	+=3D db8500_cpufreq_cooling.o
> +obj-$(CONFIG_INTEL_POWERCLAMP)	+=3D intel_powerclamp.o
> +
> diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/int=
el_powerclamp.c
> new file mode 100644
> index 0000000..a85ff38
> --- /dev/null
> +++ b/drivers/thermal/intel_powerclamp.c
> @@ -0,0 +1,794 @@
> +/*
> + * intel_powerclamp.c - package c-state idle injection
> + *
> + * Copyright (c) 2012, Intel Corporation.
> + *
> + * Authors:
> + *     Arjan van de Ven <arjan@linux.intel.com>
> + *     Jacob Pan <jacob.jun.pan@linux.intel.com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WI=
THOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILIT=
Y or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Lic=
ense for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License=
 along with
> + * this program; if not, write to the Free Software Foundation, Inc.=
,
> + * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
> + *
> + *
> + *	TODO:
> + *           1. better handle wakeup from external interrupts, curre=
ntly a fixed
> + *              compensation is added to clamping duration when exce=
ssive amount
> + *              of wakeups are observed during idle time. the reason=
 is that in
> + *              case of external interrupts without need for ack, cl=
amping down
> + *              cpu in non-irq context does not reduce irq. for majo=
rity of the
> + *              cases, clamping down cpu does help reduce irq as wel=
l, we should
> + *              be able to differenciate the two cases and give a qu=
antitative
> + *              solution for the irqs that we can control. perhaps b=
ased on
> + *              get_cpu_iowait_time_us()
> + *
> + *	     2. synchronization with other hw blocks
> + *
> + *
> + */
> +
> +#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/delay.h>
> +#include <linux/kthread.h>
> +#include <linux/freezer.h>
> +#include <linux/cpu.h>
> +#include <linux/thermal.h>
> +#include <linux/slab.h>
> +#include <linux/tick.h>
> +#include <linux/debugfs.h>
> +#include <linux/seq_file.h>
> +
> +#include <asm/nmi.h>
> +#include <asm/msr.h>
> +#include <asm/mwait.h>
> +#include <asm/cpu_device_id.h>
> +#include <asm/idle.h>
> +#include <asm/hardirq.h>
> +
> +#define MAX_TARGET_RATIO (50U)
> +/* For each undisturbed clamping period (no extra wake ups during id=
le time),
> + * we increment the confidence counter for the given target ratio.
> + * CONFIDENCE_OK defines the level where runtime calibration results=
 are
> + * valid.
> + */
> +#define CONFIDENCE_OK (3)
> +/* Default idle injection duration, driver adjust sleep time to meet=
 target
> + * idle ratio. Similar to frequency modulation.
> + */
> +#define DEFAULT_DURATION_JIFFIES (6)
> +
> +static unsigned int target_mwait;
> +static struct dentry *debug_dir;
> +
> +/* user selected target */
> +static unsigned int set_target_ratio;
> +static unsigned int current_ratio;
> +static bool should_skip;
> +static bool reduce_irq;
> +static atomic_t idle_wakeup_counter;
> +static unsigned int control_cpu; /* The cpu assigned to collect stat=
 and update
> +				  * control parameters. default to BSP but BSP
> +				  * can be offlined.
> +				  */
> +static bool clamping;
> +
> +
> +static struct task_struct * __percpu *powerclamp_thread;
> +static struct thermal_cooling_device *cooling_dev;
> +static unsigned long *cpu_clamping_mask;  /* bit map for tracking pe=
r cpu
> +					   * clamping thread
> +					   */
> +
> +static unsigned int duration;
> +static unsigned int pkg_cstate_ratio_cur;
> +static unsigned int window_size;
> +
> +static int duration_set(const char *arg, const struct kernel_param *=
kp)
> +{
> +	int ret =3D 0;
> +	unsigned long new_duration;
> +
> +	ret =3D kstrtoul(arg, 10, &new_duration);
> +	if (ret)
> +		goto exit;
> +	if (new_duration > 25 || new_duration < 6) {
> +		pr_err("Out of recommended range %lu, between 6-25ms\n",
> +			new_duration);
> +		ret =3D -EINVAL;
> +	}
> +
> +	duration =3D clamp(new_duration, 6ul, 25ul);
> +	smp_mb();
> +
> +exit:
> +
> +	return ret;
> +}
> +
> +static struct kernel_param_ops duration_ops =3D {
> +	.set =3D duration_set,
> +	.get =3D param_get_int,
> +};
> +
> +
> +module_param_cb(duration, &duration_ops, &duration, 0644);
> +MODULE_PARM_DESC(duration, "forced idle time for each attempt in mse=
c.");
> +
> +struct powerclamp_calibration_data {
> +	unsigned long confidence;  /* used for calibration, basically a cou=
nter
> +				    * gets incremented each time a clamping
> +				    * period is completed without extra wakeups
> +				    * once that counter is reached given level,
> +				    * compensation is deemed usable.
> +				    */
> +	unsigned long steady_comp; /* steady state compensation used when
> +				    * no extra wakeups occurred.
> +				    */
> +	unsigned long dynamic_comp; /* compensate excessive wakeup from idl=
e
> +				     * mostly from external interrupts.
> +				     */
> +};
> +
> +static struct powerclamp_calibration_data cal_data[MAX_TARGET_RATIO]=
;
> +
> +static int window_size_set(const char *arg, const struct kernel_para=
m *kp)
> +{
> +	int ret =3D 0;
> +	unsigned long new_window_size;
> +
> +	ret =3D kstrtoul(arg, 10, &new_window_size);
> +	if (ret)
> +		goto exit_win;
> +	if (new_window_size > 10 || new_window_size < 2) {
> +		pr_err("Out of recommended window size %lu, between 2-10\n",
> +			new_window_size);
> +		ret =3D -EINVAL;
> +	}
> +
> +	window_size =3D clamp(new_window_size, 2ul, 10ul);
> +	smp_mb();
> +
> +exit_win:
> +
> +	return ret;
> +}
> +
> +static struct kernel_param_ops window_size_ops =3D {
> +	.set =3D window_size_set,
> +	.get =3D param_get_int,
> +};
> +
> +module_param_cb(window_size, &window_size_ops, &window_size, 0644);
> +MODULE_PARM_DESC(window_size, "sliding window in number of clamping =
cycles\n"
> +	"\tpowerclamp controls idle ratio within this window. larger\n"
> +	"\twindow size results in slower response time but more smooth\n"
> +	"\tclamping results. default to 2.");
> +
> +static void find_target_mwait(void)
> +{
> +	unsigned int eax, ebx, ecx, edx;
> +	unsigned int highest_cstate =3D 0;
> +	unsigned int highest_subcstate =3D 0;
> +	int i;
> +
> +	if (boot_cpu_data.cpuid_level < CPUID_MWAIT_LEAF)
> +		return;
> +
> +	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &edx);
> +
> +	if (!(ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED) ||
> +	    !(ecx & CPUID5_ECX_INTERRUPT_BREAK))
> +		return;
> +
> +	edx >>=3D MWAIT_SUBSTATE_SIZE;
> +	for (i =3D 0; i < 7 && edx; i++, edx >>=3D MWAIT_SUBSTATE_SIZE) {
> +		if (edx & MWAIT_SUBSTATE_MASK) {
> +			highest_cstate =3D i;
> +			highest_subcstate =3D edx & MWAIT_SUBSTATE_MASK;
> +		}
> +	}
> +	target_mwait =3D (highest_cstate << MWAIT_SUBSTATE_SIZE) |
> +		(highest_subcstate - 1);
> +
> +}
> +
> +static u64 pkg_state_counter(void)
> +{
> +	u64 val;
> +	u64 count =3D 0;
> +
> +	static bool skip_c2;
> +	static bool skip_c3;
> +	static bool skip_c6;
> +	static bool skip_c7;
> +
> +	if (!skip_c2) {
> +		if (!rdmsrl_safe(MSR_PKG_C2_RESIDENCY, &val))
> +			count +=3D val;
> +		else
> +			skip_c2 =3D true;
> +	}
> +
> +	if (!skip_c3) {
> +		if (!rdmsrl_safe(MSR_PKG_C3_RESIDENCY, &val))
> +			count +=3D val;
> +		else
> +			skip_c3 =3D true;
> +	}
> +
> +	if (!skip_c6) {
> +		if (!rdmsrl_safe(MSR_PKG_C6_RESIDENCY, &val))
> +			count +=3D val;
> +		else
> +			skip_c6 =3D true;
> +	}
> +
> +	if (!skip_c7) {
> +		if (!rdmsrl_safe(MSR_PKG_C7_RESIDENCY, &val))
> +			count +=3D val;
> +		else
> +			skip_c7 =3D true;
> +	}
> +
> +	return count;
> +}
> +
> +static void noop_timer(unsigned long foo)
> +{
> +	/* empty... just the fact that we get the interrupt wakes us up */
> +}
> +
> +static unsigned int get_compensation(int ratio)
> +{
> +	unsigned int comp =3D 0;
> +
> +	/* we only use compensation if all adjacent ones are good */
> +	if (ratio =3D=3D 1 &&
> +		cal_data[ratio].confidence >=3D CONFIDENCE_OK &&
> +		cal_data[ratio + 1].confidence >=3D CONFIDENCE_OK &&
> +		cal_data[ratio + 2].confidence >=3D CONFIDENCE_OK) {
> +		comp =3D (cal_data[ratio].steady_comp +
> +			cal_data[ratio + 1].steady_comp +
> +			cal_data[ratio + 2].steady_comp) / 3;
> +	} else if (ratio =3D=3D MAX_TARGET_RATIO - 1 &&
> +		cal_data[ratio].confidence >=3D CONFIDENCE_OK &&
> +		cal_data[ratio - 1].confidence >=3D CONFIDENCE_OK &&
> +		cal_data[ratio - 2].confidence >=3D CONFIDENCE_OK) {
> +		comp =3D (cal_data[ratio].steady_comp +
> +			cal_data[ratio - 1].steady_comp +
> +			cal_data[ratio - 2].steady_comp) / 3;
> +	} else if (cal_data[ratio].confidence >=3D CONFIDENCE_OK &&
> +		cal_data[ratio - 1].confidence >=3D CONFIDENCE_OK &&
> +		cal_data[ratio + 1].confidence >=3D CONFIDENCE_OK) {
> +		comp =3D (cal_data[ratio].steady_comp +
> +			cal_data[ratio - 1].steady_comp +
> +			cal_data[ratio + 1].steady_comp) / 3;
> +	}
> +
> +	/* REVISIT: simple penalty of double idle injection */
> +	if (reduce_irq)
> +		comp =3D ratio;
> +	/* do not exceed limit */
> +	if (comp + ratio >=3D MAX_TARGET_RATIO)
> +		comp =3D MAX_TARGET_RATIO - ratio - 1;
> +
> +	return comp;
> +}
> +
> +static void adjust_compensation(int target_ratio, unsigned int win)
> +{
> +	int delta;
> +	struct powerclamp_calibration_data *d =3D &cal_data[target_ratio];
> +
> +	/*
> +	 * adjust compensations if confidence level has not been reached or
> +	 * there are too many wakeups during the last idle injection period=
, we
> +	 * cannot trust the data for compensation.
> +	 */
> +	if (d->confidence >=3D CONFIDENCE_OK ||
> +		atomic_read(&idle_wakeup_counter) >
> +		win * num_online_cpus())
> +		return;
> +
> +	delta =3D set_target_ratio - current_ratio;
> +	/* filter out bad data */
> +	if (delta >=3D 0 && delta <=3D (1+target_ratio/10)) {
> +		if (d->steady_comp)
> +			d->steady_comp =3D
> +				roundup(delta+d->steady_comp, 2)/2;
> +		else
> +			d->steady_comp =3D delta;
> +		d->confidence++;
> +	}
> +}
> +
> +static bool powerclamp_adjust_controls(unsigned int target_ratio,
> +				unsigned int guard, unsigned int win)
> +{
> +	static u64 msr_last, tsc_last;
> +	u64 msr_now, tsc_now;
> +	u64 val64;
> +
> +	/* check result for the last window */
> +	msr_now =3D pkg_state_counter();
> +	rdtscll(tsc_now);
> +
> +	/* calculate pkg cstate vs tsc ratio */
> +	if (!msr_last || !tsc_last)
> +		current_ratio =3D 1;
> +	else if (tsc_now-tsc_last) {
> +		val64 =3D 100*(msr_now-msr_last);
> +		do_div(val64, (tsc_now-tsc_last));
> +		current_ratio =3D val64;
> +	}
> +
> +	/* update record */
> +	msr_last =3D msr_now;
> +	tsc_last =3D tsc_now;
> +
> +	adjust_compensation(target_ratio, win);
> +	/*
> +	 * too many external interrupts, set flag such
> +	 * that we can take measure later.
> +	 */
> +	reduce_irq =3D atomic_read(&idle_wakeup_counter) >=3D
> +		2 * win * num_online_cpus();
> +
> +	atomic_set(&idle_wakeup_counter, 0);
> +	/* if we are above target+guard, skip */
> +	return set_target_ratio + guard <=3D current_ratio;
> +}
> +
> +static int clamp_thread(void *arg)
> +{
> +	int cpunr =3D (unsigned long)arg;
> +	DEFINE_TIMER(wakeup_timer, noop_timer, 0, 0);
> +	static const struct sched_param param =3D {
> +		.sched_priority =3D MAX_USER_RT_PRIO/2,
> +	};
> +	unsigned int count =3D 0;
> +	unsigned int target_ratio;
> +
> +	set_bit(cpunr, cpu_clamping_mask);
> +	set_freezable();
> +	init_timer_on_stack(&wakeup_timer);
> +	sched_setscheduler(current, SCHED_FIFO, &param);
> +
> +	while (true =3D=3D clamping && !kthread_should_stop() &&
> +		cpu_online(cpunr)) {
> +		int sleeptime;
> +		unsigned long target_jiffies;
> +		unsigned int guard;
> +		unsigned int compensation =3D 0;
> +		int interval; /* jiffies to sleep for each attempt */
> +		unsigned int duration_jiffies =3D msecs_to_jiffies(duration);
> +		unsigned int window_size_now;
> +
> +		try_to_freeze();
> +		/*
> +		 * make sure user selected ratio does not take effect until
> +		 * the next round. adjust target_ratio if user has changed
> +		 * target such that we can converge quickly.
> +		 */
> +		target_ratio =3D set_target_ratio;
> +		guard =3D 1 + target_ratio/20;
> +		window_size_now =3D window_size;
> +		count++;
> +
> +		/*
> +		 * systems may have different ability to enter package level
> +		 * c-states, thus we need to compensate the injected idle ratio
> +		 * to achieve the actual target reported by the HW.
> +		 */
> +		compensation =3D get_compensation(target_ratio);
> +		interval =3D duration_jiffies*100/(target_ratio+compensation);
> +
> +		/* align idle time */
> +		target_jiffies =3D roundup(jiffies, interval);
> +		sleeptime =3D target_jiffies - jiffies;
> +		if (sleeptime <=3D 0)
> +			sleeptime =3D 1;
> +		schedule_timeout_interruptible(sleeptime);
> +		/*
> +		 * only elected controlling cpu can collect stats and update
> +		 * control parameters.
> +		 */
> +		if (cpunr =3D=3D control_cpu && !(count%window_size_now)) {
> +			should_skip =3D
> +				powerclamp_adjust_controls(target_ratio,
> +							guard, window_size_now);
> +			smp_mb();
> +		}
> +
> +		if (should_skip)
> +			continue;
> +
> +		target_jiffies =3D jiffies + duration_jiffies;
> +		mod_timer(&wakeup_timer, target_jiffies);
> +		if (unlikely(local_softirq_pending()))
> +			continue;
> +		/*
> +		 * stop tick sched during idle time, interrupts are still
> +		 * allowed. thus jiffies are updated properly.
> +		 */
> +		preempt_disable();
> +		tick_nohz_idle_enter();
> +		/* mwait until target jiffies is reached */
> +		while (time_before(jiffies, target_jiffies)) {
> +			unsigned long ecx =3D 1;
> +			unsigned long eax =3D target_mwait;
> +
> +			/*
> +			 * REVISIT: may call enter_idle() to notify drivers who
> +			 * can save power during cpu idle. same for exit_idle()
> +			 */
> +			local_touch_nmi();
> +			stop_critical_timings();
> +			__monitor((void *)&current_thread_info()->flags, 0, 0);
> +			cpu_relax(); /* allow HT sibling to run */
> +			__mwait(eax, ecx);
> +			start_critical_timings();
> +			atomic_inc(&idle_wakeup_counter);
> +		}
> +		tick_nohz_idle_exit();
> +		preempt_enable_no_resched();
> +	}
> +	del_timer_sync(&wakeup_timer);
> +	clear_bit(cpunr, cpu_clamping_mask);
> +
> +	return 0;
> +}
> +
> +/*
> + * 1 HZ polling while clamping is active, useful for userspace
> + * to monitor actual idle ratio.
> + */
> +static void poll_pkg_cstate(struct work_struct *dummy);
> +static DECLARE_DELAYED_WORK(poll_pkg_cstate_work, poll_pkg_cstate);
> +static void poll_pkg_cstate(struct work_struct *dummy)
> +{
> +	static u64 msr_last;
> +	static u64 tsc_last;
> +	static unsigned long jiffies_last;
> +
> +	u64 msr_now;
> +	unsigned long jiffies_now;
> +	u64 tsc_now;
> +	u64 val64;
> +
> +	msr_now =3D pkg_state_counter();
> +	rdtscll(tsc_now);
> +	jiffies_now =3D jiffies;
> +
> +	/* calculate pkg cstate vs tsc ratio */
> +	if (!msr_last || !tsc_last)
> +		pkg_cstate_ratio_cur =3D 1;
> +	else {
> +		if (tsc_now - tsc_last) {
> +			val64 =3D 100 * (msr_now - msr_last);
> +			do_div(val64, (tsc_now - tsc_last));
> +			pkg_cstate_ratio_cur =3D val64;
> +		}
> +	}
> +
> +	/* update record */
> +	msr_last =3D msr_now;
> +	jiffies_last =3D jiffies_now;
> +	tsc_last =3D tsc_now;
> +
> +	if (true =3D=3D clamping)
> +		schedule_delayed_work(&poll_pkg_cstate_work, HZ);
> +}
> +
> +static int start_power_clamp(void)
> +{
> +	unsigned long cpu;
> +	struct task_struct *thread;
> +
> +	/* check if pkg cstate counter is completely 0, abort in this case =
*/
> +	if (!pkg_state_counter()) {
> +		pr_err("pkg cstate counter not functional, abort\n");
> +		return -EINVAL;
> +	}
> +
> +	set_target_ratio =3D clamp(set_target_ratio, 0U, MAX_TARGET_RATIO);
> +	/* prevent cpu hotplug */
> +	get_online_cpus();
> +
> +	/* prefer BSP */
> +	control_cpu =3D 0;
> +	if (!cpu_online(control_cpu))
> +		control_cpu =3D smp_processor_id();
> +
> +	clamping =3D true;
> +	schedule_delayed_work(&poll_pkg_cstate_work, 0);
> +
> +	/* start one thread per online cpu */
> +	for_each_online_cpu(cpu) {
> +		struct task_struct **p =3D
> +			per_cpu_ptr(powerclamp_thread, cpu);
> +
> +		thread =3D kthread_create_on_node(clamp_thread,
> +						(void *) cpu,
> +						cpu_to_node(cpu),
> +						"kidle_inject/%ld", cpu);
> +		/* bind to cpu here */
> +		if (likely(!IS_ERR(thread))) {
> +			kthread_bind(thread, cpu);
> +			wake_up_process(thread);
> +			*p =3D thread;
> +		}
> +
> +	}
> +	put_online_cpus();
> +
> +	return 0;
> +}
> +
> +static void end_power_clamp(void)
> +{
> +	int i;
> +	struct task_struct *thread;
> +
> +	clamping =3D false;
> +	/*
> +	 * make clamping visible to other cpus and give per cpu clamping th=
reads
> +	 * sometime to exit, or gets killed later.
> +	 */
> +	smp_mb();
> +	msleep(20);
> +	if (bitmap_weight(cpu_clamping_mask, num_possible_cpus())) {
> +		for_each_set_bit(i, cpu_clamping_mask, num_possible_cpus()) {
> +			pr_debug("clamping thread for cpu %d alive, kill\n", i);
> +			thread =3D *per_cpu_ptr(powerclamp_thread, i);
> +			kthread_stop(thread);
> +		}
> +	}
> +}
> +
> +static int powerclamp_cpu_callback(struct notifier_block *nfb,
> +				unsigned long action, void *hcpu)
> +{
> +	unsigned long cpu =3D (unsigned long)hcpu;
> +	struct task_struct *thread;
> +	struct task_struct **percpu_thread =3D
> +		per_cpu_ptr(powerclamp_thread, cpu);
> +
> +	if (false =3D=3D clamping)
> +		goto exit_ok;
> +
> +	switch (action) {
> +	case CPU_ONLINE:
> +		thread =3D kthread_create_on_node(clamp_thread,
> +						(void *) cpu,
> +						cpu_to_node(cpu),
> +						"kidle_inject/%lu", cpu);
> +		if (likely(!IS_ERR(thread))) {
> +			kthread_bind(thread, cpu);
> +			wake_up_process(thread);
> +			*percpu_thread =3D thread;
> +		}
> +		/* prefer BSP as controlling CPU */
> +		if (cpu =3D=3D 0) {
> +			control_cpu =3D 0;
> +			smp_mb();
> +		}
> +		break;
> +	case CPU_DEAD:
> +		if (test_bit(cpu, cpu_clamping_mask)) {
> +			pr_err("cpu %lu dead but powerclamping thread is not\n",
> +				cpu);
> +			kthread_stop(*percpu_thread);
> +		}
> +		if (cpu =3D=3D control_cpu) {
> +			control_cpu =3D smp_processor_id();
> +			smp_mb();
> +		}
> +	}
> +
> +exit_ok:
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block powerclamp_cpu_notifier =3D {
> +	.notifier_call =3D powerclamp_cpu_callback,
> +};
> +
> +static int powerclamp_get_max_state(struct thermal_cooling_device *c=
dev,
> +				 unsigned long *state)
> +{
> +	*state =3D MAX_TARGET_RATIO;
> +
> +	return 0;
> +}
> +
> +static int powerclamp_get_cur_state(struct thermal_cooling_device *c=
dev,
> +				 unsigned long *state)
> +{
> +	if (true =3D=3D clamping)
> +		*state =3D pkg_cstate_ratio_cur;
> +	else
> +		/* to save power, do not poll idle ratio while not clamping */
> +		*state =3D -1; /* indicates invalid state */
> +
> +	return 0;
> +}
> +
> +static int powerclamp_set_cur_state(struct thermal_cooling_device *c=
dev,
> +				 unsigned long new_target_ratio)
> +{
> +	int ret =3D 0;
> +
> +	new_target_ratio =3D clamp(new_target_ratio, 0UL,
> +				(unsigned long) (MAX_TARGET_RATIO-1));
> +	if (set_target_ratio =3D=3D 0 && new_target_ratio > 0) {
> +		pr_info("Start idle injection to reduce power\n");
> +		set_target_ratio =3D new_target_ratio;
> +		ret =3D start_power_clamp();
> +		goto exit_set;
> +	} else	if (set_target_ratio > 0 && new_target_ratio =3D=3D 0) {
> +		pr_info("Stop forced idle injection\n");
> +		set_target_ratio =3D 0;
> +		end_power_clamp();
> +	} else	/* adjust currently running */ {
> +		set_target_ratio =3D new_target_ratio;
> +		/* make new set_target_ratio visible to other cpus */
> +		smp_mb();
> +	}
> +
> +exit_set:
> +	return ret;
> +}
> +
> +/* bind to generic thermal layer as cooling device*/
> +static struct thermal_cooling_device_ops powerclamp_cooling_ops =3D =
{
> +	.get_max_state =3D powerclamp_get_max_state,
> +	.get_cur_state =3D powerclamp_get_cur_state,
> +	.set_cur_state =3D powerclamp_set_cur_state,
> +};
> +
> +/* runs on Nehalem and later */
> +static const struct x86_cpu_id intel_powerclamp_ids[] =3D {
> +	{ X86_VENDOR_INTEL, 6, 0x1a},
> +	{ X86_VENDOR_INTEL, 6, 0x1c},
> +	{ X86_VENDOR_INTEL, 6, 0x1e},
> +	{ X86_VENDOR_INTEL, 6, 0x1f},
> +	{ X86_VENDOR_INTEL, 6, 0x25},
> +	{ X86_VENDOR_INTEL, 6, 0x26},
> +	{ X86_VENDOR_INTEL, 6, 0x2a},
> +	{ X86_VENDOR_INTEL, 6, 0x2c},
> +	{ X86_VENDOR_INTEL, 6, 0x2d},
> +	{ X86_VENDOR_INTEL, 6, 0x2e},
> +	{ X86_VENDOR_INTEL, 6, 0x2f},
> +	{ X86_VENDOR_INTEL, 6, 0x3a},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(x86cpu, intel_powerclamp_ids);
> +
> +static int powerclamp_probe(void)
> +{
> +	if (!x86_match_cpu(intel_powerclamp_ids)) {
> +		pr_err("Intel powerclamp does not run on family %d model %d\n",
> +				boot_cpu_data.x86, boot_cpu_data.x86_model);
> +		return -ENODEV;
> +	}
> +	if (!boot_cpu_has(X86_FEATURE_NONSTOP_TSC) ||
> +		!boot_cpu_has(X86_FEATURE_CONSTANT_TSC) ||
> +		!boot_cpu_has(X86_FEATURE_MWAIT) ||
> +		!boot_cpu_has(X86_FEATURE_ARAT))
> +		return -ENODEV;
> +
> +	/* find the deepest mwait value */
> +	find_target_mwait();
> +
> +	return 0;
> +}
> +
> +static int powerclamp_debug_show(struct seq_file *m, void *unused)
> +{
> +	int i =3D 0;
> +
> +	seq_printf(m, "controlling cpu: %d\n", control_cpu);
> +	seq_printf(m, "pct confidence steady dynamic (compensation)\n");
> +	for (i =3D 0; i < MAX_TARGET_RATIO; i++) {
> +		seq_printf(m, "%d\t%lu\t%lu\t%lu\n",
> +			i,
> +			cal_data[i].confidence,
> +			cal_data[i].steady_comp,
> +			cal_data[i].dynamic_comp);
> +	}
> +
> +	return 0;
> +}
> +
> +static int powerclamp_debug_open(struct inode *inode,
> +			struct file *file)
> +{
> +	return single_open(file, powerclamp_debug_show, inode->i_private);
> +}
> +
> +static const struct file_operations powerclamp_debug_fops =3D {
> +	.open		=3D powerclamp_debug_open,
> +	.read		=3D seq_read,
> +	.llseek		=3D seq_lseek,
> +	.release	=3D single_release,
> +	.owner		=3D THIS_MODULE,
> +};
> +
> +static inline void powerclamp_create_debug_files(void)
> +{
> +	debug_dir =3D debugfs_create_dir("intel_powerclamp", NULL);
> +	if (!debug_dir)
> +		return;
> +
> +	if (!debugfs_create_file("powerclamp_calib", S_IRUGO, debug_dir,
> +					cal_data, &powerclamp_debug_fops))
> +		goto file_error;
> +
> +	return;
> +
> +file_error:
> +	debugfs_remove_recursive(debug_dir);
> +}
> +
> +static int powerclamp_init(void)
> +{
> +	int retval;
> +	int bitmap_size;
> +
> +	bitmap_size =3D BITS_TO_LONGS(num_possible_cpus()) * sizeof(long);
> +	cpu_clamping_mask =3D kzalloc(bitmap_size, GFP_KERNEL);
> +	if (!cpu_clamping_mask)
> +		return -ENOMEM;
> +
> +	/* probe cpu features and ids here */
> +	retval =3D powerclamp_probe();
> +	if (retval)
> +		return retval;
> +	/* set default limit, maybe adjusted during runtime based on feedba=
ck */
> +	window_size =3D 2;
> +	register_hotcpu_notifier(&powerclamp_cpu_notifier);
> +	powerclamp_thread =3D alloc_percpu(struct task_struct *);
> +	cooling_dev =3D thermal_cooling_device_register("intel_powerclamp",=
 NULL,
> +						&powerclamp_cooling_ops);
> +	if (IS_ERR(cooling_dev))
> +		return -ENODEV;
> +
> +	if (!duration)
> +		duration =3D jiffies_to_msecs(DEFAULT_DURATION_JIFFIES);
> +	powerclamp_create_debug_files();
> +
> +	return 0;
> +}
> +module_init(powerclamp_init);
> +
> +static void powerclamp_exit(void)
> +{
> +	unregister_hotcpu_notifier(&powerclamp_cpu_notifier);
> +	end_power_clamp();
> +	free_percpu(powerclamp_thread);
> +	thermal_cooling_device_unregister(cooling_dev);
> +	kfree(cpu_clamping_mask);
> +
> +	cancel_delayed_work_sync(&poll_pkg_cstate_work);
> +	debugfs_remove_recursive(debug_dir);
> +}
> +module_exit(powerclamp_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Arjan van de Ven <arjan@linux.intel.com>");
> +MODULE_AUTHOR("Jacob Pan <jacob.jun.pan@linux.intel.com>");
> +MODULE_DESCRIPTION("Package Level C-state Idle Injection for Intel C=
PUs");


