From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH v4 3/3] cpufreq: arm_big_little: Add support to register a cpufreq cooling device
Date: Tue, 17 Nov 2015 10:58:16 +0000
Message-ID: <9hhsi44q4dz.fsf@e105922-lin.cambridge.arm.com>
References: <1447702225-13323-1-git-send-email-punit.agrawal@arm.com>
	<1447702225-13323-4-git-send-email-punit.agrawal@arm.com>
	<CAOh2x=mThxxv1-REBYTyLhtLBY2yKwLqSGjCVSkqP7hO0Fs4tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:53186 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751456AbbKQK6c (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Nov 2015 05:58:32 -0500
In-Reply-To: <CAOh2x=mThxxv1-REBYTyLhtLBY2yKwLqSGjCVSkqP7hO0Fs4tw@mail.gmail.com>
	(Viresh Kumar's message of "Tue, 17 Nov 2015 10:13:15 +0530")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, dawei.chien@mediatek.com, Javi Merino <javi.merino@arm.com>, Sudeep Holla <sudeep.holla@arm.com>

Viresh Kumar <viresh.kumar@linaro.org> writes:

> On Tue, Nov 17, 2015 at 1:00 AM, Punit Agrawal <punit.agrawal@arm.com> wrote:
>> Register passive cooling devices when initialising cpufreq on
>> big.LITTLE systems. If the device tree provides a dynamic power
>> coefficient for the CPUs then the bound cooling device will support
>> the extensions that allow it to be used with all the existing thermal
>> governors including the power allocator governor.
>>
>> A cooling device will be created per individual frequency domain and
>> can be bound to thermal zones via the thermal DT bindings.
>>
>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> Remind me when did I Ack this version of your patch ..

You didn't - I missed removing the tag before sending the patch
out. Dropped locally now.

>
>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>> Cc: Eduardo Valentin <edubezval@gmail.com>
>> ---
>>  drivers/cpufreq/Kconfig.arm      |  2 ++
>>  drivers/cpufreq/arm_big_little.c | 35 +++++++++++++++++++++++++++++++++++
>>  2 files changed, 37 insertions(+)
>>
>> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
>> index 1582c1c..0e0052e 100644
>> --- a/drivers/cpufreq/Kconfig.arm
>> +++ b/drivers/cpufreq/Kconfig.arm
>> @@ -6,6 +6,8 @@
>>  config ARM_BIG_LITTLE_CPUFREQ
>>         tristate "Generic ARM big LITTLE CPUfreq driver"
>>         depends on (ARM_CPU_TOPOLOGY || ARM64) && HAVE_CLK
>> +       # if CPU_THERMAL is on and THERMAL=m, ARM_BIT_LITTLE_CPUFREQ cannot be =y
>> +       depends on !CPU_THERMAL || THERMAL
>>         select PM_OPP
>>         help
>>           This enables the Generic CPUfreq driver for ARM big.LITTLE platforms.
>> diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
>> index c5d256c..60d09c0 100644
>> --- a/drivers/cpufreq/arm_big_little.c
>> +++ b/drivers/cpufreq/arm_big_little.c
>> @@ -23,6 +23,7 @@
>>  #include <linux/cpu.h>
>>  #include <linux/cpufreq.h>
>>  #include <linux/cpumask.h>
>> +#include <linux/cpu_cooling.h>
>>  #include <linux/export.h>
>>  #include <linux/module.h>
>>  #include <linux/mutex.h>
>> @@ -55,6 +56,7 @@ static bool bL_switching_enabled;
>>  #define ACTUAL_FREQ(cluster, freq)  ((cluster == A7_CLUSTER) ? freq << 1 : freq)
>>  #define VIRT_FREQ(cluster, freq)    ((cluster == A7_CLUSTER) ? freq >> 1 : freq)
>>
>> +static struct thermal_cooling_device *cdev[MAX_CLUSTERS];
>>  static struct cpufreq_arm_bL_ops *arm_bL_ops;
>>  static struct clk *clk[MAX_CLUSTERS];
>>  static struct cpufreq_frequency_table *freq_table[MAX_CLUSTERS + 1];
>> @@ -493,6 +495,7 @@ static int bL_cpufreq_init(struct cpufreq_policy *policy)
>>  static int bL_cpufreq_exit(struct cpufreq_policy *policy)
>>  {
>>         struct device *cpu_dev;
>> +       int domain;
>>
>>         cpu_dev = get_cpu_device(policy->cpu);
>>         if (!cpu_dev) {
>> @@ -501,12 +504,43 @@ static int bL_cpufreq_exit(struct cpufreq_policy *policy)
>>                 return -ENODEV;
>>         }
>>
>> +       domain = topology_physical_package_id(cpu_dev->id);
>
> And this is broken.
>
> Have you tested this for IKS ? That's what the primary use-case of
> this driver is.

Juno dvfs uses this driver - which is where I've been testing the
changes. Unfortunately, there is no IKS there.

> And yeah, I would like to migrate the bL usecase to cpufreq-dt, now that it can
> support multiple clusters.

It would be great to have a unified cpufreq driver servicing multiple
dvfs domains. If I understand correctly, we can drop $SUBJECT when that
happens. In the meanwhile...

>
> This is broken, because exit() might get called for a CPU from big
> cluster, while
> read() was called for a CPU on little cluster.

Good catch. The patch will definitely not do the right thing when IKS is
enabled. Looking at the code, it looks like you can switch in and out of
IKS at run time.

The cpu_cooling device doesn't cope with different types of cores, so
I'll just have to skip registering (and un-registering) the cooling
device when IKS is enabled.

I'll send out a new version addressing the issues you've pointed out.

Thanks for your comments.

Punit
>
> --
> viresh
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
