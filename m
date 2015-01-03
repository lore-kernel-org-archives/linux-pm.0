From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 11/14] cpufreq: stats: don't update stats on false notifiers
Date: Sat, 03 Jan 2015 23:36:40 +0100
Message-ID: <1568546.J3P5QRyvCt@vostro.rjw.lan>
References: <cover.1420177186.git.viresh.kumar@linaro.org> <bc9a1be9bacfe155f89989404b6eba916286b4c5.1420177186.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53329 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750735AbbACWO1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 3 Jan 2015 17:14:27 -0500
In-Reply-To: <bc9a1be9bacfe155f89989404b6eba916286b4c5.1420177186.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org

On Friday, January 02, 2015 11:16:48 AM Viresh Kumar wrote:
> No idea when 'old_index == new_index' in transition notifier (probably never?),

This piece of information is completely irrelevant here.

> but if this happens, we aren't supposed to update time_in_state by calling
> cpufreq_stats_update().

"..., because ...".

> Its only relevant when we are changing frequencies.
> 
> So, move the call after matching indexes.
> 
> Reviewed-by: Prarit Bhargava <prarit@redhat.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq_stats.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> index c0c2ddece8fe..7701532b32c8 100644
> --- a/drivers/cpufreq/cpufreq_stats.c
> +++ b/drivers/cpufreq/cpufreq_stats.c
> @@ -293,11 +293,11 @@ static int cpufreq_stat_notifier_trans(struct notifier_block *nb,
>  	if (old_index == -1 || new_index == -1)
>  		return 0;
>  
> -	cpufreq_stats_update(stat);
> -
>  	if (old_index == new_index)
>  		return 0;
>  
> +	cpufreq_stats_update(stat);
> +
>  	spin_lock(&cpufreq_stats_lock);
>  	stat->last_index = new_index;
>  #ifdef CONFIG_CPU_FREQ_STAT_DETAILS
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
