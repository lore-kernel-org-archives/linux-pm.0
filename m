From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 4/5] cpufreq: governor: Quit work-handlers early if
 governor is stopped
Date: Wed, 28 Oct 2015 20:16:55 +0530
Message-ID: <20151028144655.GC3716@ubuntu>
References: <cover.1444723240.git.viresh.kumar@linaro.org>
 <11662041.x9fsKCWszL@vostro.rjw.lan>
 <20151028082559.GD30039@ubuntu>
 <1463739.8uKY7njy7x@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1463739.8uKY7njy7x@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 28-10-15, 16:12, Rafael J. Wysocki wrote:
> So this is a changelog matching your patch:
> 
> "gov_queue_work() acquires cpufreq_governor_lock to allow cpufreq_governor_stop()
> to drain delayed work items possibly scheduled on CPUs that share the policy with
> a CPU being taken offline.
> 
> However, the same goal may be achieved in a more straightforward way if the
> policy pointer in the struct cpu_dbs_info matching the policy CPU is reset
> upfront by cpufreq_governor_stop() under the timer_mutex belonging to it and
> checked against NULL, under the same lock, at the beginning of dbs_timer().
> 
> In that case every instance of dbs_timer() run for a struct cpu_dbs_info
> sharing the policy pointer in question after cpufreq_governor_stop() has started
> will notice that that pointer is NULL and bail out immediately without queuing up
> any new work items.  In turn, gov_cancel_work() called by cpufreq_governor_stop()
> before destroying timer_mutex will wait for all of the delayed work items
> currently running on the CPUs sharing the policy to drop the mutex, so it may
> be destroyed safely.
> 
> Make cpufreq_governor_stop() and dbs_timer() work as described and modify
> gov_queue_work() so it does not acquire cpufreq_governor_lock any more."

Looks far better, thanks :)

-- 
viresh
