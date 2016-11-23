From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v8 1/8] sched: Extend scheduler's asym packing
Date: Wed, 23 Nov 2016 14:09:11 +0100
Message-ID: <20161123130911.GT3092@twins.programming.kicks-ass.net>
References: <cover.1479844244.git.tim.c.chen@linux.intel.com>
 <0e73ae12737dfaafa46c07066cc7c5d3f1675e46.1479844244.git.tim.c.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0e73ae12737dfaafa46c07066cc7c5d3f1675e46.1479844244.git.tim.c.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, jolsa@redhat.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 22, 2016 at 12:23:53PM -0800, Tim Chen wrote:
> We generalize the scheduler's asym packing to provide an ordering
> of the cpu beyond just the cpu number.  This allows the use of the
> ASYM_PACKING scheduler machinery to move loads to preferred CPU in a
> sched domain. The preference is defined with the cpu priority
> given by arch_asym_cpu_priority(cpu).
> 
> We also record the most preferred cpu in a sched group when
> we build the cpu's capacity for fast lookup of preferred cpu
> during load balancing.
> 
> Co-developed-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>

With the two little edits below:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  include/linux/sched.h |  4 ++++
>  kernel/sched/core.c   | 15 ++++++++++++++
>  kernel/sched/fair.c   | 54 +++++++++++++++++++++++++++++++++++----------------
>  kernel/sched/sched.h  |  6 ++++++
>  4 files changed, 62 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 348f51b..ca02475 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1057,6 +1057,10 @@ static inline int cpu_numa_flags(void)
>  }
>  #endif
>  
> +int arch_asym_cpu_priority(int cpu);

extern

> +int arch_asym_max_cpu_and(const struct cpumask *mask1,
> +			  const struct cpumask *mask2);
> +

And that needs to go too; that function no longer exists.

>  struct sched_domain_attr {
>  	int relax_domain_level;
>  };
