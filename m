From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq:cpufreq - Fix typo in comment.
Date: Fri, 22 May 2015 03:32:19 +0200
Message-ID: <7136415.q1D1SjnnfZ@vostro.rjw.lan>
References: <1432232271-3753-1-git-send-email-shailendra.capricorn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58071 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755688AbbEVBG5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 May 2015 21:06:57 -0400
In-Reply-To: <1432232271-3753-1-git-send-email-shailendra.capricorn@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shailendra Verma <shailendra.capricorn@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday, May 21, 2015 11:47:51 PM Shailendra Verma wrote:
> 
> Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>

Two typos in two comments really.  Care to fix the subject?

> ---
>  drivers/cpufreq/cpufreq.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 8ae655c..b4c7e0f 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -178,7 +178,7 @@ int cpufreq_generic_init(struct cpufreq_policy *policy,
>  	policy->cpuinfo.transition_latency = transition_latency;
>  
>  	/*
> -	 * The driver only supports the SMP configuartion where all processors
> +	 * The driver only supports the SMP configuration where all processors
>  	 * share the clock and voltage and clock.
>  	 */
>  	cpumask_setall(policy->cpus);
> @@ -1891,7 +1891,7 @@ static int __target_index(struct cpufreq_policy *policy,
>  		 * Failed after setting to intermediate freq? Driver should have
>  		 * reverted back to initial frequency and so should we. Check
>  		 * here for intermediate_freq instead of get_intermediate, in
> -		 * case we have't switched to intermediate freq at all.
> +		 * case we haven't switched to intermediate freq at all.
>  		 */
>  		if (unlikely(retval && intermediate_freq)) {
>  			freqs.old = intermediate_freq;
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
