From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: brcmstb-avs-cpufreq: sort frequencies in
 ascending order
Date: Wed, 16 May 2018 10:02:18 +0530
Message-ID: <20180516043218.7ktq5vjq2rhcszz5@vireshk-i7>
References: <20180516034954.56475-1-code@mmayer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180516034954.56475-1-code@mmayer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Mayer <code@mmayer.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Markus Mayer <mmayer@broadcom.com>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Power Management List <linux-pm@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 15-05-18, 20:49, Markus Mayer wrote:
> From: Markus Mayer <mmayer@broadcom.com>
> 
> Most CPUfreq drivers (at least on ARM) seem to be sorting the available
> frequencies from lowest to highest. To match this behaviour, we reverse
> the sorting order in brcmstb-avs-cpufreq, so it is now also lowest to
> highest.

The reasoning isn't correct. Just because everyone else is doing it
doesn't make it right and so you shouldn't change just because of
that.

What you must written instead in the commit log is that the cpufreq
core performs better if the table is sorted (in any order), and so we
must sort it as well.

But I feel the table is already sorted for your platform, isn't it?
And I don't see a clear advantage of merging this patch.

> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---
>  drivers/cpufreq/brcmstb-avs-cpufreq.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> index b07559b9ed99..7dac3205d3eb 100644
> --- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
> +++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> @@ -403,7 +403,7 @@ brcm_avs_get_freq_table(struct device *dev, struct private_data *priv)
>  {
>  	struct cpufreq_frequency_table *table;
>  	unsigned int pstate;
> -	int i, ret;
> +	int p, i, ret;
>  
>  	/* Remember P-state for later */
>  	ret = brcm_avs_get_pstate(priv, &pstate);
> @@ -415,12 +415,13 @@ brcm_avs_get_freq_table(struct device *dev, struct private_data *priv)
>  	if (!table)
>  		return ERR_PTR(-ENOMEM);
>  
> -	for (i = AVS_PSTATE_P0; i <= AVS_PSTATE_MAX; i++) {
> -		ret = brcm_avs_set_pstate(priv, i);
> +	for (p = AVS_PSTATE_MAX, i = 0; p >= 0; p--, i++) {
> +		ret = brcm_avs_set_pstate(priv, p);
>  		if (ret)
>  			return ERR_PTR(ret);
>  		table[i].frequency = brcm_avs_get_frequency(priv->base);
> -		table[i].driver_data = i;
> +		/* Store the corresponding P-state with each frequency */
> +		table[i].driver_data = p;
>  	}
>  	table[i].frequency = CPUFREQ_TABLE_END;
>  
> -- 
> 2.7.4

-- 
viresh
