From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 2/2] cpufreq: brcmstb-avs-cpufreq: prefer SCMI cpufreq if
 supported
Date: Thu, 19 Apr 2018 11:35:59 +0100
Message-ID: <0f011724-85fe-d411-b99d-dfd33e206052@arm.com>
References: <20180418155643.36464-1-code@mmayer.net>
 <20180418155643.36464-3-code@mmayer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180418155643.36464-3-code@mmayer.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Mayer <code@mmayer.net>, Florian Fainelli <f.fainelli@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jim Quinlan <jim2101024@gmail.com>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Markus Mayer <mmayer@broadcom.com>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org



On 18/04/18 16:56, Markus Mayer wrote:
> From: Jim Quinlan <jim2101024@gmail.com>
> 
> If the SCMI cpufreq driver is supported, we bail, so that the new
> approach can be used.
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---
>  drivers/cpufreq/brcmstb-avs-cpufreq.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> index b07559b9ed99..b4861a730162 100644
> --- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
> +++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> @@ -164,6 +164,8 @@
>  #define BRCM_AVS_CPU_INTR	"brcm,avs-cpu-l2-intr"
>  #define BRCM_AVS_HOST_INTR	"sw_intr"
>  
> +#define ARM_SCMI_COMPAT		"arm,scmi"
> +
>  struct pmap {
>  	unsigned int mode;
>  	unsigned int p1;
> @@ -511,6 +513,20 @@ static int brcm_avs_prepare_init(struct platform_device *pdev)
>  	struct device *dev;
>  	int host_irq, ret;
>  

Will this platform have both SCMI and BRCM_AVS_CPU_DATA nodes enabled ?
If so, is it not better to just keep only the preferred node enabled
instead ?

> +	/*
> +	 * If the SCMI cpufreq driver is supported, we bail, so that the more
> +	 * modern approach can be used.
> +	 */
> +	if (IS_ENABLED(CONFIG_ARM_SCMI_PROTOCOL)) {
> +		struct device_node *np;
> +
> +		np = of_find_compatible_node(NULL, NULL, ARM_SCMI_COMPAT);
> +		if (np) {
> +			of_node_put(np);
> +			return -ENXIO;
> +		}
> +	}
> +

Clearly not a good approach.

-- 
Regards,
Sudeep
