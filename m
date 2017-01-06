From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: brcmstb-avs-cpufreq: properly retrieve
 P-state upon suspend
Date: Fri, 6 Jan 2017 09:41:12 +0530
Message-ID: <20170106041112.GC21926@vireshk-i7>
References: <20161219201028.18885-1-code@mmayer.net>
 <20161219201028.18885-3-code@mmayer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161219201028.18885-3-code@mmayer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Mayer <code@mmayer.net>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Power Management List <linux-pm@vger.kernel.org>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Markus Mayer <mmayer@broadcom.com>
List-Id: linux-pm@vger.kernel.org

On 19-12-16, 12:10, Markus Mayer wrote:
> From: Markus Mayer <mmayer@broadcom.com>
> 
> The AVS GET_PMAP command does return a P-state along with the P-map
> information. However, that P-state is the initial P-state when the
> P-map was first downloaded to AVS. It is *not* the current P-state.
> 
> Therefore, we explicitly retrieve the P-state using the GET_PSTATE
> command.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---
>  drivers/cpufreq/brcmstb-avs-cpufreq.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> index 2c6e325..c943606 100644
> --- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
> +++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> @@ -784,8 +784,19 @@ static int brcm_avs_target_index(struct cpufreq_policy *policy,
>  static int brcm_avs_suspend(struct cpufreq_policy *policy)
>  {
>  	struct private_data *priv = policy->driver_data;
> +	int ret;
> +
> +	ret = brcm_avs_get_pmap(priv, &priv->pmap);
> +	if (ret)
> +		return ret;
>  
> -	return brcm_avs_get_pmap(priv, &priv->pmap);
> +	/*
> +	 * We can't use the P-state returned by brcm_avs_get_pmap(), since
> +	 * that's the initial P-state from when the P-map was downloaded to the
> +	 * AVS co-processor, not necessarily the P-state we are running at now.
> +	 * So, we get the current P-state explicitly.
> +	 */
> +	return brcm_avs_get_pstate(priv, &priv->pmap.state);
>  }
>  
>  static int brcm_avs_resume(struct cpufreq_policy *policy)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
