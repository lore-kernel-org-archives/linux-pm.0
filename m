From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [RFC PATCH 3/6] sched: Add over-utilization/tipping point
 indicator
Date: Mon, 9 Apr 2018 11:53:00 +0200
Message-ID: <093ba425-4f81-9f86-78a6-1cd1fd4651f9@arm.com>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-4-dietmar.eggemann@arm.com>
 <20180409094001.GZ4043@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180409094001.GZ4043@hirez.programming.kicks-ass.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Quentin Perret <quentin.perret@arm.com>, Thara Gopinath <thara.gopinath@linaro.org>, linux-pm@vger.kernel.org, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

On 04/09/2018 11:40 AM, Peter Zijlstra wrote:
> 
> (I know there is a new version out; but I was reading through this to
> catch up with the discussion)
> 
> On Tue, Mar 20, 2018 at 09:43:09AM +0000, Dietmar Eggemann wrote:
>> +static inline int sd_overutilized(struct sched_domain *sd)
>> +{
>> +	return READ_ONCE(sd->shared->overutilized);
>> +}
>> +
>> +static inline void update_overutilized_status(struct rq *rq)
>> +{
>> +	struct sched_domain *sd;
>> +
>> +	rcu_read_lock();
>> +	sd = rcu_dereference(rq->sd);
>> +	if (sd && !sd_overutilized(sd) && cpu_overutilized(rq->cpu))
>> +		WRITE_ONCE(sd->shared->overutilized, 1);
>> +	rcu_read_unlock();
>> +}
>> +#else
> 
> I think you ought to go have a look at the end of
> kernel/sched/topology.c:sd_init(), where it says:
> 
> 	/*
> 	 * For all levels sharing cache; connect a sched_domain_shared
> 	 * instance.
> 	 */
> 	if (sd->flags & SD_SHARE_PKG_RESOURCES) {
> 		sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
> 		atomic_inc(&sd->shared->ref);
> 		atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
> 	}
> 
> Because if I read all this correctly, your code assumes sd->shared
> exists unconditionally, while the quoted bit only ensures it does so <=
> LLC.
> 

But the patch changes this part further down.

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 64cc564f5255..c8b7c7665ab2 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1184,15 +1184,11 @@ sd_init(struct sched_domain_topology_level *tl,
  		sd->idle_idx = 1;
  	}

-	/*
-	 * For all levels sharing cache; connect a sched_domain_shared
-	 * instance.
-	 */
-	if (sd->flags & SD_SHARE_PKG_RESOURCES) {
-		sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
-		atomic_inc(&sd->shared->ref);
+	sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
+	atomic_inc(&sd->shared->ref);
+
+	if (sd->flags & SD_SHARE_PKG_RESOURCES)
  		atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
-	}
