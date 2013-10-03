From: Jesper Nilsson <jesper.nilsson@axis.com>
Subject: Re: [PATCH V2 Resend 43/92] cpufreq: cris: don't initialize part
 of policy that is set by core too
Date: Thu, 3 Oct 2013 17:27:16 +0200
Message-ID: <20131003152716.GS11028@axis.com>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
 <e9c26250ea876738d25da101ca92e0a8731f869e.1380783079.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e9c26250ea876738d25da101ca92e0a8731f869e.1380783079.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "rjw@sisk.pl" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Jesper Nilsson <jespern@axis.com>, Mikael Starvik <starvik@axis.com>, linux-cris-kernel <linux-cris-kernel@axis.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 03, 2013 at 04:58:37PM +0200, Viresh Kumar wrote:
> Many common initializations of struct policy are moved to core now and hence
> this driver doesn't need to do it. This patch removes such code.
> 
> Most recent of those changes is to call ->get() in the core after calling
> ->init().

You should already have gotten my Acked-by: for this series, but here it is again:

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

> Cc: Mikael Starvik <starvik@axis.com>
> Cc: linux-cris-kernel@axis.com
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cris-artpec3-cpufreq.c | 1 -
>  drivers/cpufreq/cris-etraxfs-cpufreq.c | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cris-artpec3-cpufreq.c b/drivers/cpufreq/cris-artpec3-cpufreq.c
> index d26f4e4..4d88e4f 100644
> --- a/drivers/cpufreq/cris-artpec3-cpufreq.c
> +++ b/drivers/cpufreq/cris-artpec3-cpufreq.c
> @@ -73,7 +73,6 @@ static int cris_freq_cpu_init(struct cpufreq_policy *policy)
>  {
>  	/* cpuinfo and default policy values */
>  	policy->cpuinfo.transition_latency = 1000000; /* 1ms */
> -	policy->cur = cris_freq_get_cpu_frequency(0);
>  
>  	return cpufreq_table_validate_and_show(policy, cris_freq_table);
>  }
> diff --git a/drivers/cpufreq/cris-etraxfs-cpufreq.c b/drivers/cpufreq/cris-etraxfs-cpufreq.c
> index d384e63..f7d2d49 100644
> --- a/drivers/cpufreq/cris-etraxfs-cpufreq.c
> +++ b/drivers/cpufreq/cris-etraxfs-cpufreq.c
> @@ -72,7 +72,6 @@ static int cris_freq_cpu_init(struct cpufreq_policy *policy)
>  {
>  	/* cpuinfo and default policy values */
>  	policy->cpuinfo.transition_latency = 1000000;	/* 1ms */
> -	policy->cur = cris_freq_get_cpu_frequency(0);
>  
>  	return cpufreq_table_validate_and_show(policy, cris_freq_table);
>  }
> -- 
> 1.7.12.rc2.18.g61b472e

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
