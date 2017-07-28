From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 06/10] drivers base/arch_topology: allow inlining
 cpu-invariant accounting support
Date: Fri, 28 Jul 2017 13:57:39 +0530
Message-ID: <20170728082739.GD352@vireshk-i7>
References: <20170727193312.9849-1-dietmar.eggemann@arm.com>
 <20170727193312.9849-7-dietmar.eggemann@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52]:37805 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751613AbdG1I1m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jul 2017 04:27:42 -0400
Received: by mail-pg0-f52.google.com with SMTP id y129so108396227pgy.4
        for <linux-pm@vger.kernel.org>; Fri, 28 Jul 2017 01:27:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170727193312.9849-7-dietmar.eggemann@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>

On 27-07-17, 20:33, Dietmar Eggemann wrote:
> Allow inlining of topology_get_cpu_scale() into the task
> scheduler fast path (e.g. __update_load_avg_se()) by coding it as a
> static inline function in the arch topology header file.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Juri Lelli <juri.lelli@arm.com>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  drivers/base/arch_topology.c  | 7 +------
>  include/linux/arch_topology.h | 8 +++++++-
>  2 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index af9ab98a233e..c8cd92ba4cc0 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -37,12 +37,7 @@ void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
>  }
>  
>  static DEFINE_MUTEX(cpu_scale_mutex);
> -static DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
> -
> -unsigned long topology_get_cpu_scale(struct sched_domain *sd, int cpu)
> -{
> -	return per_cpu(cpu_scale, cpu);
> -}
> +DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
>  
>  void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity)
>  {
> diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
> index 3e3c2657c9a1..0c4e43d6a3bb 100644
> --- a/include/linux/arch_topology.h
> +++ b/include/linux/arch_topology.h
> @@ -11,8 +11,14 @@ void topology_normalize_cpu_scale(void);
>  struct device_node;
>  int topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu);
>  
> +DECLARE_PER_CPU(unsigned long, cpu_scale);
> +
>  struct sched_domain;
> -unsigned long topology_get_cpu_scale(struct sched_domain *sd, int cpu);
> +static inline
> +unsigned long topology_get_cpu_scale(struct sched_domain *sd, int cpu)
> +{
> +	return per_cpu(cpu_scale, cpu);
> +}
>  
>  void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
