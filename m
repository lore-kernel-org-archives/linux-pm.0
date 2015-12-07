From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 5/6] cpufreq: governor: replace per-cpu delayed work
 with timers
Date: Mon, 7 Dec 2015 13:20:27 +0530
Message-ID: <20151207075027.GC3294@ubuntu>
References: <cover.1449115453.git.viresh.kumar@linaro.org>
 <2132445.kEr4nQIvso@vostro.rjw.lan>
 <20151205041042.GU3430@ubuntu>
 <1517154.7rUJCu3tN2@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1517154.7rUJCu3tN2@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ashwin.chaugule@linaro.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 07-12-15, 02:28, Rafael J. Wysocki wrote:
> What about if that happens in parallel with the decrementation in
> dbs_work_handler()?
> 
> Is there anything preventing that from happening?

Hmmm, you are right. Following is required for that.

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index c9e420bd0eec..d8a89e653933 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -230,6 +230,7 @@ static void dbs_work_handler(struct work_struct *work)
        struct dbs_data *dbs_data;
        unsigned int sampling_rate, delay;
        bool eval_load;
+       unsigned long flags;
 
        policy = shared->policy;
        dbs_data = policy->governor_data;
@@ -257,7 +258,10 @@ static void dbs_work_handler(struct work_struct *work)
        delay = dbs_data->cdata->gov_dbs_timer(policy, eval_load);
        mutex_unlock(&shared->timer_mutex);
 
+       spin_lock_irqsave(&shared->timer_lock, flags);
        shared->skip_work--;
+       spin_unlock_irqrestore(&shared->timer_lock, flags);
+
        gov_add_timers(policy, delay);
 }

> That aside, I think you could avoid using the spinlock altogether if the
> counter was atomic (and which would make the above irrelevant too).
> 
> Say, skip_work is atomic the the relevant code in dbs_timer_handler() is
> written as
> 
> 	atomic_inc(&shared->skip_work);
> 	smp_mb__after_atomic();
> 	if (atomic_read(&shared->skip_work) > 1)
> 		atomic_dec(&shared->skip_work);
> 	else

At this point we might end up decrementing skip_work from
gov_cancel_work() and then cancel the work which we haven't queued
yet. And the end result will be that the work is still queued while
gov_cancel_work() has finished.

And we have to keep the atomic operation, as well as queue_work()
within the lock.

> 		queue_work(system_wq, &shared->work);
> 
> and the remaining incrementation and decrementation of skip_work are replaced
> with the corresponding atomic operations, it still should work, no?

-- 
viresh
