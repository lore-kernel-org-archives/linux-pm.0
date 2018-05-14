From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [RFC PATCH 03/10] devfreq: rk3399_dmc: Pass ODT and auto power
 down parameters to TF-A.
Date: Tue, 15 May 2018 07:20:04 +0900
Message-ID: <5AFA0B94.4000100@samsung.com>
References: <20180514211610.26618-1-enric.balletbo@collabora.com>
        <CGME20180514211840epcas3p41708e430bc22d7e61e8b894b12a083f9@epcas3p4.samsung.com>
        <20180514211610.26618-4-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180514211610.26618-4-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Rob Herring <robh+dt@kernel.org>, Will Deacon <will.deacon@arm.com>, Heiko Stuebner <heiko@sntech.de>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Sandy Huang <hjc@rock-chips.com>, David Airlie <airlied@linux.ie>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Derek Basehore <dbasehore@chromium.org>, linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org, Lin Huang <hl@rock-chips.com>, kernel@collabora.com, Sean Paul <seanpaul@chromium.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 2018년 05월 15일 06:16, Enric Balletbo i Serra wrote:
> Trusted Firmware-A (TF-A) for rk3399 implements a SiP call to get the
> on-die termination (ODT) and auto power down parameters from kernel,
> this patch adds the functionality to do this. Also, if DDR clock
> frequency is lower than the on-die termination (ODT) disable frequency
> this driver should disable the DDR ODT.

I have a question.
'disable frequency' is the same meaning of 'disable the DDR ODT'?

> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>  drivers/devfreq/rk3399_dmc.c        | 50 ++++++++++++++++++++++++++++-
>  include/soc/rockchip/rockchip_sip.h |  1 +
>  2 files changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
> index d5c03e5abe13..cc1bbca3fb15 100644
> --- a/drivers/devfreq/rk3399_dmc.c
> +++ b/drivers/devfreq/rk3399_dmc.c
> @@ -18,14 +18,17 @@
>  #include <linux/devfreq.h>
>  #include <linux/devfreq-event.h>
>  #include <linux/interrupt.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_opp.h>
> +#include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/rwsem.h>
>  #include <linux/suspend.h>
>  
> +#include <soc/rockchip/rk3399_grf.h>
>  #include <soc/rockchip/rockchip_sip.h>
>  
>  struct dram_timing {
> @@ -69,8 +72,11 @@ struct rk3399_dmcfreq {
>  	struct mutex lock;
>  	struct dram_timing timing;
>  	struct regulator *vdd_center;
> +	struct regmap *regmap_pmu;
>  	unsigned long rate, target_rate;
>  	unsigned long volt, target_volt;
> +	unsigned int odt_dis_freq;
> +	int odt_pd_arg0, odt_pd_arg1;
>  };
>  
>  static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
> @@ -80,6 +86,8 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
>  	struct dev_pm_opp *opp;
>  	unsigned long old_clk_rate = dmcfreq->rate;
>  	unsigned long target_volt, target_rate;
> +	struct arm_smccc_res res;
> +	int dram_flag;
>  	int err;
>  
>  	opp = devfreq_recommended_opp(dev, freq, flags);
> @@ -95,6 +103,15 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
>  
>  	mutex_lock(&dmcfreq->lock);
>  
> +	dram_flag = 0;

Also, if dram_flag is 0, it mean that disable ODT frequency?
If it's right, you better to define the precise variables as following
instead of just integer(0 or 1).
For example,
- ROCKCHIP_SIP_DRAM_FREQ_ENABLE
- ROCKCHIP_SIP_DRAM_FREQ_DISABLE

> +	if (target_rate >= dmcfreq->odt_dis_freq)
> +		dram_flag = 1;
> +
> +	arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, dmcfreq->odt_pd_arg0,
> +		      dmcfreq->odt_pd_arg1,
> +		      ROCKCHIP_SIP_CONFIG_DRAM_SET_ODT_PD,
> +		      dram_flag, 0, 0, 0, &res);
> +

This operation is special for only rk3399_dmc. It is difficult
to understand what to do. I recommend you better to add the detailed comment
with code.

>  	/*
>  	 * If frequency scaling from low to high, adjust voltage first.
>  	 * If frequency scaling from high to low, adjust frequency first.
> @@ -294,11 +311,13 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
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
> @@ -334,6 +353,29 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	/* Try to find the optional reference to the pmu syscon */
> +	node = of_parse_phandle(np, "rockchip,pmu", 0);
> +	if (node) {
> +		data->regmap_pmu = syscon_node_to_regmap(node);
> +		if (IS_ERR(data->regmap_pmu))
> +			return PTR_ERR(data->regmap_pmu);
> +	}
> +
> +	/* Get DDR type */
> +	regmap_read(data->regmap_pmu, RK3399_PMUGRF_OS_REG2, &val);
> +	ddr_type = (val >> RK3399_PMUGRF_DDRTYPE_SHIFT) &
> +		    RK3399_PMUGRF_DDRTYPE_MASK;
> +
> +	/* Get the odt_dis_freq parameter in function of the DDR type */
> +	if (ddr_type == RK3399_PMUGRF_DDRTYPE_DDR3)
> +		data->odt_dis_freq = data->timing.ddr3_odt_dis_freq;
> +	else if (ddr_type == RK3399_PMUGRF_DDRTYPE_LPDDR3)
> +		data->odt_dis_freq = data->timing.lpddr3_odt_dis_freq;
> +	else if (ddr_type == RK3399_PMUGRF_DDRTYPE_LPDDR4)
> +		data->odt_dis_freq = data->timing.lpddr4_odt_dis_freq;
> +	else
> +		return -EINVAL;
> +

how about using 'switch' statement?

>  	/*
>  	 * Get dram timing and pass it to arm trust firmware,
>  	 * the dram drvier in arm trust firmware will get these
> @@ -358,6 +400,12 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
>  		      ROCKCHIP_SIP_CONFIG_DRAM_INIT,
>  		      0, 0, 0, 0, &res);
>  
> +	data->odt_pd_arg0 = (data->timing.sr_idle & 0xff) |
> +			    ((data->timing.sr_mc_gate_idle & 0xff) << 8) |
> +			    ((data->timing.standby_idle & 0xffff) << 16);
> +	data->odt_pd_arg1 = (data->timing.pd_idle & 0xfff) |
> +			    ((data->timing.srpd_lite_idle & 0xfff) << 16);
> +

odt_pd_arg0 and odt_pd_arg1 might be used for disabling/enabling the ODT frequency.
As I commented, it depend on only rk3399_dmc. You better to add detailed comment.

And I prefer to define the XXX_SHIFT/XXX_MASK definition instead of
using 8/16/0xff/0xffff for the readability.

>  	/*
>  	 * We add a devfreq driver to our parent since it has a device tree node
>  	 * with operating points.
> diff --git a/include/soc/rockchip/rockchip_sip.h b/include/soc/rockchip/rockchip_sip.h
> index 7e28092c4d3d..ad9482c56797 100644
> --- a/include/soc/rockchip/rockchip_sip.h
> +++ b/include/soc/rockchip/rockchip_sip.h
> @@ -23,5 +23,6 @@
>  #define ROCKCHIP_SIP_CONFIG_DRAM_GET_RATE	0x05
>  #define ROCKCHIP_SIP_CONFIG_DRAM_CLR_IRQ	0x06
>  #define ROCKCHIP_SIP_CONFIG_DRAM_SET_PARAM	0x07
> +#define ROCKCHIP_SIP_CONFIG_DRAM_SET_ODT_PD	0x08
>  
>  #endif
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
