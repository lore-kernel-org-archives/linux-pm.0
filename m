From: Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH RFC] schedutil: Address the r/w ordering race in kthread
Date: Wed, 23 May 2018 08:47:45 +0200
Message-ID: <20180523064745.GA30909@localhost.localdomain>
References: <20180522235028.80564-1-joel@joelfernandes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180522235028.80564-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Joel Fernandes (Google)" <joelaf@google.com>
Cc: linux-kernel@vger.kernel.org, "Joel Fernandes (Google)" <joel@joelfernandes.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Luca Abeni <luca.abeni@santannapisa.it>, Todd Kjos <tkjos@google.com>, claudio@evidence.eu.com, kernel-team@android.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Joel,

On 22/05/18 16:50, Joel Fernandes (Google) wrote:
> Currently there is a race in schedutil code for slow-switch single-CPU
> systems. Fix it by enforcing ordering the write to work_in_progress to
> happen before the read of next_freq.
> 
> Kthread                                       Sched update
> 
> sugov_work()				      sugov_update_single()
> 
>       lock();
>       // The CPU is free to rearrange below
>       // two in any order, so it may clear
>       // the flag first and then read next
>       // freq. Lets assume it does.
>       work_in_progress = false
> 
>                                                if (work_in_progress)
>                                                      return;
> 
>                                                sg_policy->next_freq = 0;
>       freq = sg_policy->next_freq;
>                                                sg_policy->next_freq = real-freq;
>       unlock();
> 
> Reported-by: Viresh Kumar <viresh.kumar@linaro.org>
> CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Patrick Bellasi <patrick.bellasi@arm.com>
> CC: Juri Lelli <juri.lelli@redhat.com>
> Cc: Luca Abeni <luca.abeni@santannapisa.it>
> CC: Todd Kjos <tkjos@google.com>
> CC: claudio@evidence.eu.com
> CC: kernel-team@android.com
> CC: linux-pm@vger.kernel.org
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
> I split this into separate patch, because this race can also happen in
> mainline.
> 
>  kernel/sched/cpufreq_schedutil.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 5c482ec38610..ce7749da7a44 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -401,6 +401,13 @@ static void sugov_work(struct kthread_work *work)
>  	 */
>  	raw_spin_lock_irqsave(&sg_policy->update_lock, flags);
>  	freq = sg_policy->next_freq;
> +
> +	/*
> +	 * sugov_update_single can access work_in_progress without update_lock,
> +	 * make sure next_freq is read before work_in_progress is set.

s/set/reset/

> +	 */
> +	smp_mb();
> +

Also, doesn't this need a corresponding barrier (I guess in
sugov_should_update_freq)? That being a wmb and this a rmb?

Best,

- Juri
