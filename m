From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/3] cpufreq: schedutil: enable fast switch earlier
Date: Fri, 11 Nov 2016 15:19:52 +0100
Message-ID: <20161111141952.GJ3117@twins.programming.kicks-ass.net>
References: <cover.1478858983.git.viresh.kumar@linaro.org>
 <1acfffe798c0371e69ec1171f485499e7b49ed6d.1478858983.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:50463 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751821AbcKKOTx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Nov 2016 09:19:53 -0500
Content-Disposition: inline
In-Reply-To: <1acfffe798c0371e69ec1171f485499e7b49ed6d.1478858983.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, Robin Randhawa <robin.randhawa@arm.com>

On Fri, Nov 11, 2016 at 03:52:21PM +0530, Viresh Kumar wrote:
> @@ -456,8 +460,6 @@ static int sugov_init(struct cpufreq_policy *policy)
>  
>   out:
>  	mutex_unlock(&global_tunables_lock);
> -
> -	cpufreq_enable_fast_switch(policy);
>  	return 0;
>  
>   fail:
> @@ -468,6 +470,10 @@ static int sugov_init(struct cpufreq_policy *policy)
>  	mutex_unlock(&global_tunables_lock);
>  
>  	sugov_policy_free(sg_policy);
> +
> + disable_fast_switch:
> +	cpufreq_disable_fast_switch(policy);
> +
>  	pr_err("initialization failed (error %d)\n", ret);
>  	return ret;
>  }

Argh, no indented labels please. Please fix the 3 that snuck in while
you're there.
