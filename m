From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Eas-dev] [PATCH V5 2/2] cpufreq: Process remote callbacks from
 any CPU if the platform permits
Date: Wed, 2 Aug 2017 09:14:08 +0530
Message-ID: <20170802034408.GB26689@vireshk-i7>
References: <cover.1501223897.git.viresh.kumar@linaro.org>
 <c121a20eff05565155852c070e83504bf117da3e.1501223897.git.viresh.kumar@linaro.org>
 <CAEU1=Pm5sdV3imHpx7J2dNqYs5Y_mHiNnQt_HccHsgG2P9NyHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAEU1=Pm5sdV3imHpx7J2dNqYs5Y_mHiNnQt_HccHsgG2P9NyHQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavan Kondeti <pkondeti@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, joelaf@google.com, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, skannan@codeaurora.org, smuckle.linux@gmail.com, eas-dev@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

On 01-08-17, 16:30, Pavan Kondeti wrote:
> Currently sugov threads in the schedutil governor are pinned to the
> policy CPUs. schedutil can now make use of this new
> dvfs_possible_from_any_cpu flag and avoid the pinning, right?

Actually yes and it would be something as simple as below. Will send a patch for
this if no one reports any problems with this.

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 9deedd5f16a5..6ea12a8c8863 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -471,7 +471,10 @@ static int sugov_kthread_create(struct sugov_policy *sg_policy)
        }
 
        sg_policy->thread = thread;
-       kthread_bind_mask(thread, policy->related_cpus);
+
+       if (!policy->dvfs_possible_from_any_cpu)
+               kthread_bind_mask(thread, policy->related_cpus);
+
        init_irq_work(&sg_policy->irq_work, sugov_irq_work);
        mutex_init(&sg_policy->work_lock);
 

-- 
viresh
