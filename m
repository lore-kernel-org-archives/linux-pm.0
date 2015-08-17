From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [RFCv5 PATCH 01/46] arm: Frequency invariant scheduler load-tracking
 support
Date: Mon, 17 Aug 2015 16:59:29 +0100
Message-ID: <55D204E1.3000008@arm.com>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com> <1436293469-25707-2-git-send-email-morten.rasmussen@arm.com> <CAKfTPtBsx++wuWjT8XwpUS68ip=_d9BzqXb3SB7Un92WzJo-Gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKfTPtBsx++wuWjT8XwpUS68ip=_d9BzqXb3SB7Un92WzJo-Gg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <Morten.Rasmussen@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Yuyang Du <yuyang.du@intel.com>, Michael Turquette <mturquette@baylibre.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Juri Lelli <Juri.Lelli@arm.com>, "sgurrappadi@nvidia.com" <sgurrappadi@nvidia.com>, "pang.xunlei@zte.com.cn" <pang.xunlei@zte.com.cn>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

Hi Vincent,

On 03/08/15 10:22, Vincent Guittot wrote:
> Hi Morten,
> 
> 
> On 7 July 2015 at 20:23, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
>> From: Morten Rasmussen <Morten.Rasmussen@arm.com>
>>
> 
> [snip]
> 
>> -
>>  #endif
>> diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
>> index 08b7847..9c09e6e 100644
>> --- a/arch/arm/kernel/topology.c
>> +++ b/arch/arm/kernel/topology.c
>> @@ -169,6 +169,23 @@ static void update_cpu_capacity(unsigned int cpu)
>>                 cpu, arch_scale_cpu_capacity(NULL, cpu));
>>  }
>>
>> +/*
>> + * Scheduler load-tracking scale-invariance
>> + *
>> + * Provides the scheduler with a scale-invariance correction factor that
>> + * compensates for frequency scaling (arch_scale_freq_capacity()). The scaling
>> + * factor is updated in smp.c
>> + */
>> +unsigned long arm_arch_scale_freq_capacity(struct sched_domain *sd, int cpu)
>> +{
>> +       unsigned long curr = atomic_long_read(&per_cpu(cpu_freq_capacity, cpu));
> 
> access to cpu_freq_capacity to should be put under #ifdef CONFIG_CPU_FREQ.

True, in case we keep everything related to frequency scaling under
CONFIG_CPU_FREQ, then we should also put the
  #define arch_scale_freq_capacity arm_arch_scale_freq_capacity
in topology.h under CONFIG_CPU_FREQ.

> Why haven't you moved arm_arch_scale_freq_capacity in smp.c as
> everything else for frequency in-variance is already in this file ?
> This should also enable you to remove
> DECLARE_PER_CPU(atomic_long_t, cpu_freq_capacity); from topology.h

True, arm_arch_scale_freq_capacity() should be in smp.c so we don't have
to export cpu_freq_capacity which btw. does not have to be a atomic.

OTHA, we could also put the whole 'Frequency Invariance Engine' into
cpufreq.c as cpufreq_scale_freq_capacity() and let the interested ARCH
do a
  #include <linux/cpufreq.h>
  #define arch_scale_freq_capacity cpufreq_scale_freq_capacity
This would allow us to implement this 'Frequency Invariance Engine'
only once and not couple of times for different ARCHs.

Something like this: (only compile tested on ARM64 w/ and w/o
CONFIG_CPU_FREQ)

diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index a8a69a1f3c4c..f25341170749 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -4,6 +4,7 @@
 #ifdef CONFIG_SMP
 
 #include <linux/cpumask.h>
+#include <linux/cpufreq.h>
 
 struct cpu_topology {
        int thread_id;
@@ -26,9 +27,7 @@ const struct cpumask *cpu_coregroup_mask(int cpu);
 
 struct sched_domain;
 #ifdef CONFIG_CPU_FREQ
-#define arch_scale_freq_capacity arm_arch_scale_freq_capacity
-extern
-unsigned long arm_arch_scale_freq_capacity(struct sched_domain *sd, int cpu);
+#define arch_scale_freq_capacity cpufreq_scale_freq_capacity
 #endif
 
 #define arch_scale_cpu_capacity arm_arch_scale_cpu_capacity
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b612411655f9..97f4391d0f55 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2400,6 +2400,12 @@ static int cpufreq_cpu_callback(struct notifier_block *nfb,
        return NOTIFY_OK;
 }
 
+unsigned long cpufreq_scale_freq_capacity(struct sched_domain *sd, int cpu)
+{
+       return 1024; /* Implementation missing !!! */
+}
+EXPORT_SYMBOL(cpufreq_scale_freq_capacity);
+
 static struct notifier_block __refdata cpufreq_cpu_notifier = {
        .notifier_call = cpufreq_cpu_callback,
 };
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 29ad97c34fd5..a4516d53a3cc 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -604,4 +604,11 @@ unsigned int cpufreq_generic_get(unsigned int cpu);
 int cpufreq_generic_init(struct cpufreq_policy *policy,
                struct cpufreq_frequency_table *table,
                unsigned int transition_latency);
+/*
+ * In case we delete unused sd pointer in arch_scale_freq_capacity()
+ * [kernel/sched/sched.h] this can become:
+ * unsigned long cpufreq_scale_freq_capacity(int cpu);
+ */
+struct sched_domain;
+unsigned long cpufreq_scale_freq_capacity(struct sched_domain *sd, int cpu);

[...]
