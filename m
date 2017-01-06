From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: brcmstb-avs-cpufreq: extend sysfs entry
 brcm_avs_pmap
Date: Fri, 6 Jan 2017 09:34:49 +0530
Message-ID: <20170106040449.GB21926@vireshk-i7>
References: <20161219201028.18885-1-code@mmayer.net>
 <20161219201028.18885-2-code@mmayer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161219201028.18885-2-code@mmayer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Mayer <code@mmayer.net>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Power Management List <linux-pm@vger.kernel.org>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Markus Mayer <mmayer@broadcom.com>
List-Id: linux-pm@vger.kernel.org

On 19-12-16, 12:10, Markus Mayer wrote:
> From: Markus Mayer <mmayer@broadcom.com>
> 
> We extend the brcm_avs_pmap sysfs entry (which issues the GET_PMAP
> command to AVS) to include all fields from struct pmap. This means
> adding mode (AVS, DVS, DVFS) and state (the P-state) to the output.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---
>  drivers/cpufreq/brcmstb-avs-cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> index 4fda623..2c6e325 100644
> --- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
> +++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> @@ -954,9 +954,9 @@ static ssize_t show_brcm_avs_pmap(struct cpufreq_policy *policy, char *buf)
>  	brcm_avs_parse_p1(pmap.p1, &mdiv_p0, &pdiv, &ndiv);
>  	brcm_avs_parse_p2(pmap.p2, &mdiv_p1, &mdiv_p2, &mdiv_p3, &mdiv_p4);
>  
> -	return sprintf(buf, "0x%08x 0x%08x %u %u %u %u %u %u %u\n",
> +	return sprintf(buf, "0x%08x 0x%08x %u %u %u %u %u %u %u %u %u\n",
>  		pmap.p1, pmap.p2, ndiv, pdiv, mdiv_p0, mdiv_p1, mdiv_p2,
> -		mdiv_p3, mdiv_p4);
> +		mdiv_p3, mdiv_p4, pmap.mode, pmap.state);
>  }
>  
>  static ssize_t show_brcm_avs_voltage(struct cpufreq_policy *policy, char *buf)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
