From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH 2/6] drivers base/arch_topology: frequency-invariant
 load-tracking support
Date: Mon, 26 Jun 2017 09:28:30 +0100
Message-ID: <7c6decdf-42e2-b5f3-6497-8a2d99a95435@arm.com>
References: <20170608075513.12475-1-dietmar.eggemann@arm.com>
 <20170608075513.12475-3-dietmar.eggemann@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40218 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751364AbdFZI2e (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 26 Jun 2017 04:28:34 -0400
In-Reply-To: <20170608075513.12475-3-dietmar.eggemann@arm.com>
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>

On 08/06/17 08:55, Dietmar Eggemann wrote:
> Implements an arch-specific frequency-scaling function
> topology_get_freq_scale() which provides the following frequency
> scaling factor:
> 
>   current_freq(cpu) << SCHED_CAPACITY_SHIFT / max_supported_freq(cpu)

[...]

Frequency and cpu-invariant load tracking are part of the task
schedulers hot path:

e.g.:
 
 __update_load_avg_se()-> ___update_load_avg() -> accumulate_sum()

That's why function calls should be avoided here.

I would like to fold the following changes into patch 2/6 in v2:

commit 1397770fe47ce5d34511e7062bd3a8bc96a74590
Author: Dietmar Eggemann <dietmar.eggemann@arm.com>
Date:   Sat Jun 24 16:46:45 2017 +0100

    drivers base/arch_topology: eliminate function call for cpu and
    frequency-invariant accounting
    
    topology_get_cpu_scale() and topology_get_freq_scale() are the arm/arm64
    architecture specific implementations to provide cpu-invariant and
    frequency-invariant accounting support up to the task scheduler.
    
    Define them as static inline functions to allow cpu-invariant and
    frequency-invariant accounting to happen without an extra function call
    involved.
    
    Test results on JUNO (arm64):
    
    root@juno:~# grep
    "__update_load_avg_\|update_group_capacity\|topology_get"
    available_filter_functions > set_ftrace_filter
    
    root@juno:~# echo function_graph > current_tracer
    
    root@juno:~# cat trace | tail -50
    
    w/ this patch:
    
     ...
     3)   0.700 us    |  __update_load_avg_se.isra.5();
     ...
     3)   0.750 us    |  __update_load_avg_cfs_rq();
     ...
     3)   0.780 us    |  update_group_capacity();
     ...
    
    w/o this patch:
    
     4)               |  __update_load_avg_cfs_rq() {
     4)   0.380 us    |    topology_get_freq_scale();
     4)   0.340 us    |    topology_get_cpu_scale();
     4)   6.420 us    |  }
     ...
     4)               |  __update_load_avg_se.isra.4() {
     4)   0.300 us    |    topology_get_freq_scale();
     4)   0.260 us    |    topology_get_cpu_scale();
     4)   5.800 us    |  }
     ...
     4)               |  update_group_capacity() {
     4)   0.260 us    |    topology_get_cpu_scale();
     4)   3.540 us    |  }
     ...
    
    So these extra function calls cost ~2.5us each (on Cortex A53,
    cpu0,3,4,5). Since this happens in the task scheduler hot-path,
    they have to be avoided.
    
    Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index d7e130c268fb..8dfa4c3dbfc2 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -23,18 +23,8 @@
 #include <linux/sched/topology.h>
 
 static DEFINE_MUTEX(cpu_scale_mutex);
-static DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
-static DEFINE_PER_CPU(unsigned long, freq_scale) = SCHED_CAPACITY_SCALE;
-
-unsigned long topology_get_cpu_scale(struct sched_domain *sd, int cpu)
-{
-       return per_cpu(cpu_scale, cpu);
-}
-
-unsigned long topology_get_freq_scale(struct sched_domain *sd, int cpu)
-{
-       return per_cpu(freq_scale, cpu);
-}
+DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
+DEFINE_PER_CPU(unsigned long, freq_scale) = SCHED_CAPACITY_SCALE;
 
 void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity)
 {
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index 3fb4d8ccb179..cf22631e6765 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -9,10 +9,21 @@ void topology_normalize_cpu_scale(void);
 struct device_node;
 int topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu);
 
+DECLARE_PER_CPU(unsigned long, cpu_scale);
+DECLARE_PER_CPU(unsigned long, freq_scale);
+
 struct sched_domain;
-unsigned long topology_get_cpu_scale(struct sched_domain *sd, int cpu);
+static inline
+unsigned long topology_get_cpu_scale(struct sched_domain *sd, int cpu)
+{
+       return per_cpu(cpu_scale, cpu);
+}
 
-unsigned long topology_get_freq_scale(struct sched_domain *sd, int cpu);
+static inline
+unsigned long topology_get_freq_scale(struct sched_domain *sd, int cpu)
+{
+       return per_cpu(freq_scale, cpu);
+}
 
 void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity);

[...]
