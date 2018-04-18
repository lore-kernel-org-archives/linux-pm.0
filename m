From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 2/2] cpufreq: brcmstb-avs-cpufreq: prefer SCMI cpufreq if
 supported
Date: Wed, 18 Apr 2018 09:37:17 -0700
Message-ID: <c20dc303-8753-5684-1fff-62f363a37a4c@gmail.com>
References: <20180418155643.36464-1-code@mmayer.net>
 <20180418155643.36464-3-code@mmayer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180418155643.36464-3-code@mmayer.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Mayer <code@mmayer.net>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>
Cc: Jim Quinlan <jim2101024@gmail.com>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Power Management List <linux-pm@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Markus Mayer <mmayer@broadcom.com>
List-Id: linux-pm@vger.kernel.org

On 04/18/2018 08:56 AM, Markus Mayer wrote:
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

We would probably want to make sure that the node is also enabled (that
is, does not have a status = "disabled" property) otherwise the check
can be defeated. Something like:

		if (np && of_device_is_available(np))

should be good for that.

Thanks!
-- 
Florian
