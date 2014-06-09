From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] cpufreq: tegra: update comment for clarity
Date: Mon, 09 Jun 2014 12:38:21 -0600
Message-ID: <5395FF1D.1010606@wwwdotorg.org>
References: <594cf0e6982c471eb314fe4a00647bfaf59a3456.1402029512.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:44468 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbaFISiZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 Jun 2014 14:38:25 -0400
In-Reply-To: <594cf0e6982c471eb314fe4a00647bfaf59a3456.1402029512.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, rjw@rjwysocki.net
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, arvind.chauhan@arm.com, swarren@nvidia.com, dianders@chromium.org

On 06/05/2014 10:38 PM, Viresh Kumar wrote:
> Tegra's driver got updated a bit (00917dd cpufreq: Tegra: implement intermediate
> frequency callbacks) and implements new 'intermediate freq' infrastructure of
> core. Above commit updated comments about when to call
> clk_prepare_enable(pll_x_clk) and Doug wasn't satisfied with those comments and
> said this:
> 
>> The "Though when target-freq is intermediate freq, we don't need to
>> take this reference." makes me think that this function is actually
>> called when target-freq is intermediate freq.  I don't think it is,
>> right?
> 
> For better clarity just make that comment more explicit about when we call
> tegra_target_intermediate(). Wasn't sure if we actually need a commit for this,
> but anyway lets other decide if its worth enough :)

> diff --git a/drivers/cpufreq/tegra-cpufreq.c b/drivers/cpufreq/tegra-cpufreq.c
> index a5fbc0a..48bc89b 100644
> --- a/drivers/cpufreq/tegra-cpufreq.c
> +++ b/drivers/cpufreq/tegra-cpufreq.c
> @@ -73,7 +73,7 @@ static int tegra_target_intermediate(struct cpufreq_policy *policy,
>  	 * off when we move the cpu off of it as enabling it again while we
>  	 * switch to it from tegra_target() would take additional time. Though
>  	 * when target-freq is intermediate freq, we don't need to take this
> -	 * reference.
> +	 * reference and so this routine isn't called at all.
>  	 */
>  	clk_prepare_enable(pll_x_clk);

I would remove the word "so" in the added line; the function is not
called because we don't need to use an intermediate frequency, not
because we don't need to take a reference to pll_x. With that change,

Reviewed-by: Stephen Warren <swarren@nvidia.com>
