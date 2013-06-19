From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 05/13] cpufreq: e_powersave: call CPUFREQ_POSTCHANGE
 notfier in error cases
Date: Wed, 19 Jun 2013 21:22:02 +0900
Message-ID: <20130619122202.GB32292@verge.net.au>
References: <cover.1371630975.git.viresh.kumar@linaro.org>
 <859db6d3cfc0efbd5b96783967c10cfcb8b5a51a.1371630975.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <859db6d3cfc0efbd5b96783967c10cfcb8b5a51a.1371630975.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com, dave.martin@arm.com
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 19, 2013 at 02:22:59PM +0530, Viresh Kumar wrote:
> PRECHANGE and POSTCHANGE notifiers must be called in groups, i.e either both
> should be called or both shouldn't be.
> 
> In case we have started PRECHANGE notifier and found an error, we must call
> POSTCHANGE notifier with freqs.new = freqs.old to guarantee that sequence of
> calling notifiers is complete.
> 
> This driver was taking care of it but frequency isn't restored to freqs.old.
> 
> This patch fixes it.
> 
> Cc: Simon Horman <horms@verge.net.au>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

I have no objections to this change but at the same time I don't
feel that I know the code well enough to review it.

> ---
>  drivers/cpufreq/e_powersaver.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cpufreq/e_powersaver.c b/drivers/cpufreq/e_powersaver.c
> index 37380fb..3d03626 100644
> --- a/drivers/cpufreq/e_powersaver.c
> +++ b/drivers/cpufreq/e_powersaver.c
> @@ -161,6 +161,9 @@ postchange:
>  		current_multiplier);
>  	}
>  #endif
> +	if (err)
> +		freqs.new = freqs.old;
> +
>  	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
>  	return err;
>  }
> -- 
> 1.7.12.rc2.18.g61b472e
> 
