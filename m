From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 2/2] cpufreq: schedutil: Always process remote callback with slow switching
Date: Tue, 22 Aug 2017 15:27:10 +0200
Message-ID: <2514808.4A5PPQc5Ab@aspire.rjw.lan>
References: <2a395ea76235dce00828172a1129c46bf87a79c8.1502338812.git.viresh.kumar@linaro.org> <c31960d7db67bdf4fc578fa967d4699291879f43.1502701992.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:51425 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932825AbdHVNfm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Aug 2017 09:35:42 -0400
In-Reply-To: <c31960d7db67bdf4fc578fa967d4699291879f43.1502701992.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Juri.Lelli@arm.com, joelaf@google.com, linux-kernel@vger.kernel.org

On Monday, August 14, 2017 11:20:16 AM CEST Viresh Kumar wrote:
> The frequency update from the utilization update handlers can be divided
> into two parts:
> 
> (A) Finding the next frequency
> (B) Updating the frequency
> 
> While any CPU can do (A), (B) can be restricted to a group of CPUs only,
> depending on the current platform.
> 
> For platforms where fast cpufreq switching is possible, both (A) and (B)
> are always done from the same CPU and that CPU should be capable of
> changing the frequency of the target CPU.
> 
> But for platforms where fast cpufreq switching isn't possible, after
> doing (A) we wake up a kthread which will eventually do (B). This
> kthread is already bound to the right set of CPUs, i.e. only those which
> can change the frequency of CPUs of a cpufreq policy. And so any CPU
> can actually do (A) in this case, as the frequency is updated from the
> right set of CPUs only.
> 
> Check cpufreq_can_do_remote_dvfs() only for the fast switching case.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V2: s/policy/sg_policy->policy/, missed updating the commit with local
> updates earlier, noticed that just now.
> 
>  kernel/sched/cpufreq_schedutil.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 504d0752f8f2..9209d83ecdcf 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -84,13 +84,18 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
>  	 *
>  	 * However, drivers cannot in general deal with cross-cpu
>  	 * requests, so while get_next_freq() will work, our
> -	 * sugov_update_commit() call may not.
> +	 * sugov_update_commit() call may not for the fast switching platforms.
>  	 *
>  	 * Hence stop here for remote requests if they aren't supported
>  	 * by the hardware, as calculating the frequency is pointless if
>  	 * we cannot in fact act on it.
> +	 *
> +	 * For the slow switching platforms, the kthread is always scheduled on
> +	 * the right set of CPUs and any CPU can find the next frequency and
> +	 * schedule the kthread.
>  	 */
> -	if (!cpufreq_can_do_remote_dvfs(sg_policy->policy))
> +	if (sg_policy->policy->fast_switch_enabled &&
> +	    !cpufreq_can_do_remote_dvfs(sg_policy->policy))
>  		return false;
>  
>  	if (sg_policy->work_in_progress)
> 

Applied, thanks!
