From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 3/3] cpufreq: arm_big_little: Add support to register a
 cpufreq cooling device
Date: Tue, 17 Nov 2015 10:13:15 +0530
Message-ID: <CAOh2x=mThxxv1-REBYTyLhtLBY2yKwLqSGjCVSkqP7hO0Fs4tw@mail.gmail.com>
References: <1447702225-13323-1-git-send-email-punit.agrawal@arm.com>
	<1447702225-13323-4-git-send-email-punit.agrawal@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1447702225-13323-4-git-send-email-punit.agrawal-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dawei.chien-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Javi Merino <javi.merino-5wv7dgnIgG8@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 17, 2015 at 1:00 AM, Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org> wrote:
> Register passive cooling devices when initialising cpufreq on
> big.LITTLE systems. If the device tree provides a dynamic power
> coefficient for the CPUs then the bound cooling device will support
> the extensions that allow it to be used with all the existing thermal
> governors including the power allocator governor.
>
> A cooling device will be created per individual frequency domain and
> can be bound to thermal zones via the thermal DT bindings.
>
> Signed-off-by: Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>
> Acked-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Remind me when did I Ack this version of your patch ..

> Cc: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
> Cc: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/cpufreq/Kconfig.arm      |  2 ++
>  drivers/cpufreq/arm_big_little.c | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
>
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 1582c1c..0e0052e 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -6,6 +6,8 @@
>  config ARM_BIG_LITTLE_CPUFREQ
>         tristate "Generic ARM big LITTLE CPUfreq driver"
>         depends on (ARM_CPU_TOPOLOGY || ARM64) && HAVE_CLK
> +       # if CPU_THERMAL is on and THERMAL=m, ARM_BIT_LITTLE_CPUFREQ cannot be =y
> +       depends on !CPU_THERMAL || THERMAL
>         select PM_OPP
>         help
>           This enables the Generic CPUfreq driver for ARM big.LITTLE platforms.
> diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
> index c5d256c..60d09c0 100644
> --- a/drivers/cpufreq/arm_big_little.c
> +++ b/drivers/cpufreq/arm_big_little.c
> @@ -23,6 +23,7 @@
>  #include <linux/cpu.h>
>  #include <linux/cpufreq.h>
>  #include <linux/cpumask.h>
> +#include <linux/cpu_cooling.h>
>  #include <linux/export.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> @@ -55,6 +56,7 @@ static bool bL_switching_enabled;
>  #define ACTUAL_FREQ(cluster, freq)  ((cluster == A7_CLUSTER) ? freq << 1 : freq)
>  #define VIRT_FREQ(cluster, freq)    ((cluster == A7_CLUSTER) ? freq >> 1 : freq)
>
> +static struct thermal_cooling_device *cdev[MAX_CLUSTERS];
>  static struct cpufreq_arm_bL_ops *arm_bL_ops;
>  static struct clk *clk[MAX_CLUSTERS];
>  static struct cpufreq_frequency_table *freq_table[MAX_CLUSTERS + 1];
> @@ -493,6 +495,7 @@ static int bL_cpufreq_init(struct cpufreq_policy *policy)
>  static int bL_cpufreq_exit(struct cpufreq_policy *policy)
>  {
>         struct device *cpu_dev;
> +       int domain;
>
>         cpu_dev = get_cpu_device(policy->cpu);
>         if (!cpu_dev) {
> @@ -501,12 +504,43 @@ static int bL_cpufreq_exit(struct cpufreq_policy *policy)
>                 return -ENODEV;
>         }
>
> +       domain = topology_physical_package_id(cpu_dev->id);

And this is broken.

Have you tested this for IKS ? That's what the primary use-case of
this driver is.
And yeah, I would like to migrate the bL usecase to cpufreq-dt, now that it can
support multiple clusters.

This is broken, because exit() might get called for a CPU from big
cluster, while
read() was called for a CPU on little cluster.

--
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
