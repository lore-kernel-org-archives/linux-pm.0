From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v7 1/8] sched: Extend scheduler's asym packing
Date: Tue, 22 Nov 2016 11:09:59 +0100
Message-ID: <20161122100959.GC3124@twins.programming.kicks-ass.net>
References: <cover.1478805832.git.tim.c.chen@linux.intel.com>
 <0c494b134a93e89ebf48e45719a6b864d4ac96b7.1478805832.git.tim.c.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0c494b134a93e89ebf48e45719a6b864d4ac96b7.1478805832.git.tim.c.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, jolsa@redhat.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 10, 2016 at 02:36:33PM -0800, Tim Chen wrote:
> +/*
> + * Return the lowest numbered (or highest priority) cpu
> + * in the intersection of two cpu masks.  If no cpu is
> + * is in both masks, nr_cpu_ids will be returned.
> + */
> +int __weak arch_asym_max_cpu_and(const struct cpumask *mask1,
> +				 const struct cpumask *mask2)
> +{
> +	return cpumask_first_and(mask1, mask2);
> +}
> +#endif

> @@ -8516,10 +8541,14 @@ static inline bool nohz_kick_needed(struct rq *rq)
>  	}
>  
>  	sd = rcu_dereference(per_cpu(sd_asym, cpu));
> -	if (sd && (cpumask_first_and(nohz.idle_cpus_mask,
> -				  sched_domain_span(sd)) < cpu)) {
> -		kick = true;
> -		goto unlock;
> +	if (sd) {
> +		asym_idle_cpu = arch_asym_max_cpu_and(nohz.idle_cpus_mask,
> +						sched_domain_span(sd));
> +		if (asym_idle_cpu < nr_cpu_ids &&
> +		        sched_asym_prefer(asym_idle_cpu, cpu)) {
> +			kick = true;
> +			goto unlock;
> +		}
>  	}


Not a big fan of that part.. would not something like the below cure
that?

It would be slightly less optimal for Power7 but would actually be
faster (on average) for the ITMT case, but most importantly, it does
away with that extra weak function.

---
 arch/x86/kernel/itmt.c |   16 ----------------
 kernel/sched/fair.c    |   29 ++++++++++-------------------
 2 files changed, 10 insertions(+), 35 deletions(-)

--- a/arch/x86/kernel/itmt.c
+++ b/arch/x86/kernel/itmt.c
@@ -76,22 +76,6 @@ int arch_asym_cpu_priority(int cpu)
 	return per_cpu(sched_core_priority, cpu);
 }
 
-int arch_asym_max_cpu_and(const struct cpumask *mask1,
-			  const struct cpumask *mask2)
-{
-	int cpu;
-	int max_priority, max_cpu = nr_cpu_ids;
-
-	for_each_cpu_and(cpu, mask1, mask2) {
-		if (max_cpu == nr_cpu_ids ||
-		    arch_asym_cpu_priority(cpu) > max_priority) {
-			max_cpu = cpu;
-			max_priority = arch_asym_cpu_priority(cpu);
-		}
-	}
-	return max_cpu;
-}
-
 /**
  * sched_set_itmt_core_prio() - Set CPU priority based on ITMT
  * @prio:	Priority of cpu core
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -102,16 +102,6 @@ int __weak arch_asym_cpu_priority(int cp
 	return -cpu;
 }
 
-/*
- * Return the lowest numbered (or highest priority) cpu
- * in the intersection of two cpu masks.  If no cpu is
- * is in both masks, nr_cpu_ids will be returned.
- */
-int __weak arch_asym_max_cpu_and(const struct cpumask *mask1,
-				 const struct cpumask *mask2)
-{
-	return cpumask_first_and(mask1, mask2);
-}
 #endif
 
 #ifdef CONFIG_CFS_BANDWIDTH
@@ -8758,9 +8748,8 @@ static inline bool nohz_kick_needed(stru
 	unsigned long now = jiffies;
 	struct sched_domain_shared *sds;
 	struct sched_domain *sd;
-	int nr_busy, cpu = rq->cpu;
+	int nr_busy, i, cpu = rq->cpu;
 	bool kick = false;
-	int asym_idle_cpu;
 
 	if (unlikely(rq->idle_balance))
 		return false;
@@ -8811,15 +8800,17 @@ static inline bool nohz_kick_needed(stru
 
 	sd = rcu_dereference(per_cpu(sd_asym, cpu));
 	if (sd) {
-		asym_idle_cpu = arch_asym_max_cpu_and(nohz.idle_cpus_mask,
-						sched_domain_span(sd));
-		if (asym_idle_cpu < nr_cpu_ids &&
-		    sched_asym_prefer(asym_idle_cpu, cpu)) {
-			kick = true;
-			goto unlock;
+		for_each_cpu(i, sched_domain_span(sd)) {
+			if (i == cpu ||
+			    !cpumask_test_cpu(i, nohz.idle_cpus_mask))
+				continue;
+
+			if (sched_asym_prefer(i, cpu)) {
+				kick = true;
+				goto unlock;
+			}
 		}
 	}
-
 unlock:
 	rcu_read_unlock();
 	return kick;
