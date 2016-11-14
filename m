From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/3] cpufreq: schedutil: move slow path from workqueue to
 SCHED_FIFO task
Date: Mon, 14 Nov 2016 12:06:09 +0530
Message-ID: <20161114063609.GB4178@vireshk-i7>
References: <cover.1478858983.git.viresh.kumar@linaro.org>
 <85bf45982709e06f7f42e1b8f8315945e9d9b6d0.1478858983.git.viresh.kumar@linaro.org>
 <CAJZ5v0jODn1gJtTtpTigA=7QwK04wzdFopr-R6GeoSchqgpgiQ@mail.gmail.com>
 <582670FD.7080203@codeaurora.org>
 <CAJZ5v0gdZZ-h5JvRYacv2OH+gzG-wwHWevRmp04GNPNzUWwYeA@mail.gmail.com>
 <20161113194722.GC29583@graphite.smuckle.net>
 <CAJZ5v0hGVq7SQE-m7Pi-WTv7f+OP=sFwAuzp08sFKAMBS2Mzyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hGVq7SQE-m7Pi-WTv7f+OP=sFwAuzp08sFKAMBS2Mzyg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Steve Muckle <smuckle.linux@gmail.com>, Saravana Kannan <skannan@codeaurora.org>, Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, Robin Randhawa <robin.randhawa@arm.com>
List-Id: linux-pm@vger.kernel.org

On 13-11-16, 23:44, Rafael J. Wysocki wrote:
> To a minimum, there should be a comment regarding that in the patches.

Wanted to get the comment written properly before sending that in the patch. Can
you please rectify this based on what you are looking for ?

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index c6bc60078e21..e43f4fd42fb4 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -313,6 +313,20 @@ static void sugov_irq_work(struct irq_work *irq_work)
        struct sugov_policy *sg_policy;
 
        sg_policy = container_of(irq_work, struct sugov_policy, irq_work);
+
+       /*
+        * For Real Time and Deadline tasks, schedutil governor shoots the
+        * frequency to maximum. And special care must be taken to ensure that
+        * this kthread doesn't result in that.
+        *
+        * This is (mostly) guaranteed by the work_in_progress flag. The flag is
+        * updated only at the end of the sugov_work() and before that schedutil
+        * rejects all other frequency scaling requests.
+        *
+        * Though there is a very rare case where the RT thread yields right
+        * after the work_in_progress flag is cleared. The effects of that are
+        * neglected for now.
+        */
        kthread_queue_work(&sg_policy->worker, &sg_policy->work);
 }
 
> In any case, the clearing of work_in_progress might still be deferred
> by queuing a regular (non-RT) work item to do that from the kthread
> work (that will guarantee "hiding" the kthread work from the
> governor), but admittedly that would be a sledgehammer of sorts (and
> it might defeat the purpose of the whole exercise) ...

I agree.

-- 
viresh
