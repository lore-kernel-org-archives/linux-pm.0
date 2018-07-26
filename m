From: Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH v5 06/14] sched/topology: Lowest energy aware balancing
 sched_domain level pointer
Date: Thu, 26 Jul 2018 17:00:50 +0100
Message-ID: <76777be2-0f70-ca54-21a8-5af77a47ea86@arm.com>
References: <20180724122521.22109-1-quentin.perret@arm.com>
 <20180724122521.22109-7-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180724122521.22109-7-quentin.perret@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>, peterz@infradead.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 24/07/18 13:25, Quentin Perret wrote:
> Add another member to the family of per-cpu sched_domain shortcut
> pointers. This one, sd_ea, points to the lowest level at which energy
> aware scheduling should be used.
> 
> Generally speaking, the largest opportunity to save energy via scheduling
> comes from a smarter exploitation of heterogeneous platforms (i.e.
> big.LITTLE). Consequently, the sd_ea shortcut is wired to the lowest
> scheduling domain at which the SD_ASYM_CPUCAPACITY flag is set. For
> example, it is possible to apply Energy-Aware Scheduling within a socket
> on a multi-socket system, as long as each socket has an asymmetric
> topology. Cross-sockets wake-up balancing will only happen when the
> system is over-utilized, or this_cpu and prev_cpu are in different
> sockets.
> 
> cc: Ingo Molnar <mingo@redhat.com>
> cc: Peter Zijlstra <peterz@infradead.org>
> Suggested-by: Morten Rasmussen <morten.rasmussen@arm.com>
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> ---
>  kernel/sched/sched.h    | 1 +
>  kernel/sched/topology.c | 4 ++++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index fdf6924d53e7..25d64a0b6fe0 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1198,6 +1198,7 @@ DECLARE_PER_CPU(int, sd_llc_id);
>  DECLARE_PER_CPU(struct sched_domain_shared *, sd_llc_shared);
>  DECLARE_PER_CPU(struct sched_domain *, sd_numa);
>  DECLARE_PER_CPU(struct sched_domain *, sd_asym);
> +DECLARE_PER_CPU(struct sched_domain *, sd_ea);

There's already the asym-packing shortcut which is making naming a bit more
tedious, but should that really be named energy-aware? IMO it's just the
lowest level at which we can see asymmetry, so perhaps it should be named
as such, i.e. something like sd_asym_capa (and perhaps rename the other one
as sd_asym_pack)?

>  
>  struct sched_group_capacity {
>  	atomic_t		ref;
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index ade1eae9d21b..8f3f746b0d5e 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -514,6 +514,7 @@ DEFINE_PER_CPU(int, sd_llc_id);
>  DEFINE_PER_CPU(struct sched_domain_shared *, sd_llc_shared);
>  DEFINE_PER_CPU(struct sched_domain *, sd_numa);
>  DEFINE_PER_CPU(struct sched_domain *, sd_asym);
> +DEFINE_PER_CPU(struct sched_domain *, sd_ea);
>  
>  static void update_top_cache_domain(int cpu)
>  {
> @@ -539,6 +540,9 @@ static void update_top_cache_domain(int cpu)
>  
>  	sd = highest_flag_domain(cpu, SD_ASYM_PACKING);
>  	rcu_assign_pointer(per_cpu(sd_asym, cpu), sd);
> +
> +	sd = lowest_flag_domain(cpu, SD_ASYM_CPUCAPACITY);
> +	rcu_assign_pointer(per_cpu(sd_ea, cpu), sd);
>  }
>  
>  /*
> 
