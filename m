From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: tegra: don't error target() when suspended
Date: Thu, 21 Nov 2013 01:33:37 +0100
Message-ID: <1771874.b561cRyOuU@vostro.rjw.lan>
References: <1384981582-30697-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59447 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754168Ab3KUAU5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Nov 2013 19:20:57 -0500
In-Reply-To: <1384981582-30697-1-git-send-email-swarren@wwwdotorg.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, Stephen Warren <swarren@nvidia.com>

On Wednesday, November 20, 2013 02:06:22 PM Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> d4019f0a92ab "cpufreq: move freq change notifications to cpufreq core"
> added code to the cpufreq core to print an error if a cpufreq driver's
> .target() function returned an error. This exposed the fact that Tegra's
> cpufreq driver returns an error when it is ignoring requests due to the
> system being suspended.
> 
> Modify Tegra's .target() function not to return an error in this case;
> this prevents the error prints. The argument is that since the suspend
> hook can't and doesn't inform the cpufreq core when its requests will
> be ignored, there's no way for the cpufreq core to squelch them, so it's
> not an error for the requests to keep coming. This change make the Tegra
> driver consistent with how the Exynos handles the same situation. Note
> that s5pv210-cpufreq.c probably suffers from this same issue though.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Queued up for the next PM pull request, thanks!

> ---
> This is a fix for 3.13.
> 
> Commit d4019f0a92ab also failed to update the Tegra pm_notifier hook to
> emit cpufreq notifications. That hook calls the target() implementation
> directly, which used to emit the notifications. However, now that the
> notifications are made outside of target(), they no longer occur when
> target() is called directly. I'm not sure if this is an issue or not?
> ---
>  drivers/cpufreq/tegra-cpufreq.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/tegra-cpufreq.c b/drivers/cpufreq/tegra-cpufreq.c
> index f42df7ec03c5..b7309c37033d 100644
> --- a/drivers/cpufreq/tegra-cpufreq.c
> +++ b/drivers/cpufreq/tegra-cpufreq.c
> @@ -142,10 +142,8 @@ static int tegra_target(struct cpufreq_policy *policy, unsigned int index)
>  
>  	mutex_lock(&tegra_cpu_lock);
>  
> -	if (is_suspended) {
> -		ret = -EBUSY;
> +	if (is_suspended)
>  		goto out;
> -	}
>  
>  	freq = freq_table[index].frequency;
>  
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
