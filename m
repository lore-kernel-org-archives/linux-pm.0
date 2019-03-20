From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v2 3/5] devfreq: rk3399_dmc: Pass ODT and auto power down
 parameters to TF-A.
Date: Tue, 19 Mar 2019 17:33:52 -0700
Message-ID: <20190320003352.GN112750@google.com>
References: <20190319181323.22804-1-gael.portay@collabora.com>
 <20190319181323.22804-4-gael.portay@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190319181323.22804-4-gael.portay@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?R2HDq2w=?= PORTAY <gael.portay@collabora.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Lin Huang <hl@rock-chips.com>, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Klaus Goger <klaus.goger@theobroma-systems.com>, Derek Basehore <dbasehore@chromium.org>, Randy Li <ayaka@soulik.info>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, kernel@collabora.com
List-Id: linux-pm@vger.kernel.org

Hi Gaël,

On Tue, Mar 19, 2019 at 02:13:21PM -0400, Gaël PORTAY wrote:
> From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
> Trusted Firmware-A (TF-A) for rk3399 implements a SiP call to get the
> on-die termination (ODT) and auto power down parameters from kernel,
> this patch adds the functionality to do this. Also, if DDR clock
> frequency is lower than the on-die termination (ODT) disable frequency
> this driver should disable the DDR ODT.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
> 
> Changes in v2: None
> 
> Changes in v1:
> - [RFC 3/10] Add an explanation for platform SIP calls.
> - [RFC 3/10] Change if statement for a switch.
> - [RFC 3/10] Rename ddr_flag to odt_enable to be more clear.
> 
>  drivers/devfreq/rk3399_dmc.c        | 74 ++++++++++++++++++++++++++++-
>  include/soc/rockchip/rockchip_sip.h |  1 +
>  2 files changed, 74 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
> ...
>  static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
> @@ -80,6 +86,8 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
>  	struct dev_pm_opp *opp;
>  	unsigned long old_clk_rate = dmcfreq->rate;
>  	unsigned long target_volt, target_rate;
> +	struct arm_smccc_res res;
> +	bool odt_enable = false;
>  	int err;
>  
>  	opp = devfreq_recommended_opp(dev, freq, flags);
> @@ -95,6 +103,19 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
>  
>  	mutex_lock(&dmcfreq->lock);
>  
> +	if (target_rate >= dmcfreq->odt_dis_freq)
> +		odt_enable = true;
> +
> +	/*
> +	 * This makes a SMC call to the TF-A to set the DDR PD (power-down)
> +	 * timings and to enable or disable the ODT (on-die termination)
> +	 * resistors.
> +	 */
> +	arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, dmcfreq->odt_pd_arg0,
> +		      dmcfreq->odt_pd_arg1,
> +		      ROCKCHIP_SIP_CONFIG_DRAM_SET_ODT_PD,
> +		      odt_enable, 0, 0, 0, &res);

Is it necessary/desirable to make this call for every frequency
change? IIUC it should be only needed when odt_enable changes and the
driver could track the state. If the DDR frequency doesn't change too
often and the overhead of the call is small it shouldn't be really
important though.

> @@ -294,11 +315,13 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
>  {
>  	struct arm_smccc_res res;
>  	struct device *dev = &pdev->dev;
> -	struct device_node *np = pdev->dev.of_node;
> +	struct device_node *np = pdev->dev.of_node, *node;
>  	struct rk3399_dmcfreq *data;
>  	int ret, index, size;
>  	uint32_t *timing;
>  	struct dev_pm_opp *opp;
> +	u32 ddr_type;
> +	u32 val;
>  
>  	data = devm_kzalloc(dev, sizeof(struct rk3399_dmcfreq), GFP_KERNEL);
>  	if (!data)
> @@ -334,6 +357,34 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	/* Try to find the optional reference to the pmu syscon */
> +	node = of_parse_phandle(np, "rockchip,pmu", 0);
> +	if (node) {

The 'optional' part doesn't seem to be accurate: according to the
binding (https://lore.kernel.org/patchwork/patch/1052322/) the
property is required and the code below assumes that data->regmap_pmu
is set.

> +		data->regmap_pmu = syscon_node_to_regmap(node);
> +		if (IS_ERR(data->regmap_pmu))
> +			return PTR_ERR(data->regmap_pmu);
> +	}
> +
> +	/* Get DDR type */

nit: the comment doesn't add much value, thanks to good variable
naming this is evident from the code.

> +	regmap_read(data->regmap_pmu, RK3399_PMUGRF_OS_REG2, &val);
> +	ddr_type = (val >> RK3399_PMUGRF_DDRTYPE_SHIFT) &
> +		    RK3399_PMUGRF_DDRTYPE_MASK;
> +
> +	/* Get the odt_dis_freq parameter in function of the DDR type */

nit: ditto

(if you prefer to keep these comments I'm not opposed to keeping them,
but I don't think they are needed)

Cheers

Matthias
