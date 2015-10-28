From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V3 2/5] cpufreq: ondemand: update sampling rate immediately
Date: Wed, 28 Oct 2015 07:28:36 +0100
Message-ID: <2498053.EX0k8RstLZ@vostro.rjw.lan>
References: <cover.1444723240.git.viresh.kumar@linaro.org> <1746c301a8f0a94578f550026cf41e532e6e0f41.1444723240.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:44238 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751704AbbJ1F7o (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2015 01:59:44 -0400
In-Reply-To: <1746c301a8f0a94578f550026cf41e532e6e0f41.1444723240.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

On Tuesday, October 13, 2015 01:39:02 PM Viresh Kumar wrote:
> We are immediately updating sampling rate for already queued-works, only
> if the new expiry is lesser than the old one.
> 
> But what about the case, where the user doesn't want frequent events and
> want to increase sampling time immediately? Shouldn't we cancel the
> works (and so their interrupts) on all policy->cpus (which might occur
> very shortly).
> 
> This patch removes this special case and simplifies code by immediately
> updating the expiry.

The changelog is a complete disaster. :-/

Your argument seems to be that it should be OK to do the
cancel_delayed_work_sync()/gov_queue_work() combo in all cases, because
even if the new rate is greater than the old one, the user may actually
want it to take effect immediately and it shouldn't hurt to skip the next
sample anyway in that case.

Is this really the case, though?  What about the old rate is 1s, the new one
is 2s and the timer is just about to expire?  Won't the canceling effectively
move the next sample 3s away from the previous one which may not be desirable?

The current code just allows the timer to expire, unless that would prevent
the new rate from taking effect for too long, which seems perfectly reasonable
to me.

All that seems to be racy with respect to the delayed work execution, but that's
a different problem.

> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq_ondemand.c | 25 ++++---------------------
>  1 file changed, 4 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
> index 03ac6ce54042..bf0511a9735c 100644
> --- a/drivers/cpufreq/cpufreq_ondemand.c
> +++ b/drivers/cpufreq/cpufreq_ondemand.c
> @@ -231,17 +231,8 @@ static unsigned int od_dbs_timer(struct cpu_dbs_info *cdbs,
>  static struct common_dbs_data od_dbs_cdata;
>  
>  /**
> - * update_sampling_rate - update sampling rate effective immediately if needed.
> + * update_sampling_rate - update sampling rate immediately.
>   * @new_rate: new sampling rate
> - *
> - * If new rate is smaller than the old, simply updating
> - * dbs_tuners_int.sampling_rate might not be appropriate. For example, if the
> - * original sampling_rate was 1 second and the requested new sampling rate is 10
> - * ms because the user needs immediate reaction from ondemand governor, but not
> - * sure if higher frequency will be required or not, then, the governor may
> - * change the sampling rate too late; up to 1 second later. Thus, if we are
> - * reducing the sampling rate, we need to make the new value effective
> - * immediately.
>   */
>  static void update_sampling_rate(struct dbs_data *dbs_data,
>  		unsigned int new_rate)
> @@ -255,7 +246,6 @@ static void update_sampling_rate(struct dbs_data *dbs_data,
>  	for_each_online_cpu(cpu) {
>  		struct cpufreq_policy *policy;
>  		struct od_cpu_dbs_info_s *dbs_info;
> -		unsigned long next_sampling, appointed_at;
>  
>  		policy = cpufreq_cpu_get(cpu);
>  		if (!policy)
> @@ -270,16 +260,9 @@ static void update_sampling_rate(struct dbs_data *dbs_data,
>  		if (!delayed_work_pending(&dbs_info->cdbs.dwork))
>  			continue;
>  
> -		next_sampling = jiffies + usecs_to_jiffies(new_rate);
> -		appointed_at = dbs_info->cdbs.dwork.timer.expires;
> -
> -		if (time_before(next_sampling, appointed_at)) {
> -			cancel_delayed_work_sync(&dbs_info->cdbs.dwork);
> -
> -			gov_queue_work(dbs_data, policy,
> -				       usecs_to_jiffies(new_rate), true);
> -
> -		}
> +		cancel_delayed_work_sync(&dbs_info->cdbs.dwork);
> +		gov_queue_work(dbs_data, policy, usecs_to_jiffies(new_rate),
> +			       true);
>  	}
>  }

Thanks,
Rafael

