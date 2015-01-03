From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 02/14] cpufreq: stats: return -EEXIST when stats are already allocated
Date: Sat, 03 Jan 2015 22:58:52 +0100
Message-ID: <1494840.aVYkdgdxZS@vostro.rjw.lan>
References: <cover.1420177186.git.viresh.kumar@linaro.org> <85e5b1e6e871fdd8e7a80bba310a7b2948b52917.1420177186.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55036 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751311AbbACVgj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 3 Jan 2015 16:36:39 -0500
In-Reply-To: <85e5b1e6e871fdd8e7a80bba310a7b2948b52917.1420177186.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org

On Friday, January 02, 2015 11:16:39 AM Viresh Kumar wrote:
> __cpufreq_stats_create_table() is called from:
> - policy create notifier: stats will always be NULL here
> - cpufreq_stats_init() calls it for all CPUs as cpufreq-stats can be initialized
>   after cpufreq driver. Because CPUs share clock lines, 'stats' will be NULL
>   here for the first cpu only and will return back for others.
> 
> While we return for other CPUs, we don't return the right error value. We must
> return -EEXIST, as that is the case here.

What exactly is wrong with -EBUSY, then?

> Reviewed-by: Prarit Bhargava <prarit@redhat.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq_stats.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> index 81be4d637ab4..403671b1a5ee 100644
> --- a/drivers/cpufreq/cpufreq_stats.c
> +++ b/drivers/cpufreq/cpufreq_stats.c
> @@ -192,8 +192,10 @@ static int __cpufreq_stats_create_table(struct cpufreq_policy *policy)
>  	if (unlikely(!table))
>  		return 0;
>  
> +	/* stats already initialized */
>  	if (per_cpu(cpufreq_stats_table, cpu))
> -		return -EBUSY;
> +		return -EEXIST;
> +
>  	stat = kzalloc(sizeof(*stat), GFP_KERNEL);
>  	if ((stat) == NULL)
>  		return -ENOMEM;
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
