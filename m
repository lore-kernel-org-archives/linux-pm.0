From: Wei Ni <wni@nvidia.com>
Subject: Re: [PATCH v2 12/12] thermal: tegra: enable OC hw throttle
Date: Wed, 24 Apr 2019 16:36:54 +0800
Message-ID: <a9a241aa-1d0b-b1d3-8599-969fe86569eb@nvidia.com>
References: <1550744327-4677-1-git-send-email-wni@nvidia.com>
 <1550744327-4677-13-git-send-email-wni@nvidia.com>
 <20190423154602.GB16014@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423154602.GB16014@localhost.localdomain>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: daniel.lezcano@linaro.org, robh@kernel.org, thierry.reding@gmail.com, linux-tegra@vger.kernel.org, rui.zhang@intel.com, srikars@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 23/4/2019 11:46 PM, Eduardo Valentin wrote:
> On Thu, Feb 21, 2019 at 06:18:47PM +0800, Wei Ni wrote:
>> Parse Over Current settings from DT and program them to
>> generate interrupts. Also enable hw throttling whenever
>> there are OC events. Log the OC events as debug messages.
>>
>> Signed-off-by: Wei Ni <wni@nvidia.com>
> 
> I applied this series except for this specific patch which:
> a. does not apply clean
> b. does not compile.
> 
> Please rebase on top of my -linus branch and resend this. remember to 
> checkpatch and compile and boot test before sending.

Thanks for your comment, will rebase and test it.

> 
>> ---
>>  drivers/thermal/tegra/soctherm.c | 130 ++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 120 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
>> index b8c66368e54e..6e3f329d1ac4 100644
>> --- a/drivers/thermal/tegra/soctherm.c
>> +++ b/drivers/thermal/tegra/soctherm.c
>> @@ -106,9 +106,26 @@
>>  #define STATS_CTL_CLR_UP			0x2
>>  #define STATS_CTL_EN_UP				0x1
>>  
>> +#define OC1_CFG					0x310
>> +#define OC1_CFG_LONG_LATENCY_MASK		BIT(6)
>> +#define OC1_CFG_HW_RESTORE_MASK			BIT(5)
>> +#define OC1_CFG_PWR_GOOD_MASK_MASK		BIT(4)
>> +#define OC1_CFG_THROTTLE_MODE_MASK		(0x3 << 2)
>> +#define OC1_CFG_ALARM_POLARITY_MASK		BIT(1)
>> +#define OC1_CFG_EN_THROTTLE_MASK		BIT(0)
>> +
>> +#define OC1_CNT_THRESHOLD			0x314
>> +#define OC1_THROTTLE_PERIOD			0x318
>> +#define OC1_ALARM_COUNT				0x31c
>> +#define OC1_FILTER				0x320
>> +#define OC1_STATS				0x3a8
>> +
>>  #define OC_INTR_STATUS				0x39c
>>  #define OC_INTR_ENABLE				0x3a0
>>  #define OC_INTR_DISABLE				0x3a4
>> +#define OC_STATS_CTL				0x3c4
>> +#define OC_STATS_CTL_CLR_ALL			0x2
>> +#define OC_STATS_CTL_EN_ALL			0x1
>>  
>>  #define OC_INTR_OC1_MASK			BIT(0)
>>  #define OC_INTR_OC2_MASK			BIT(1)
>> @@ -207,6 +224,25 @@
>>  #define THROT_DELAY_CTRL(throt)		(THROT_DELAY_LITE + \
>>  					(THROT_OFFSET * throt))
>>  
>> +#define ALARM_OFFSET			0x14
>> +#define ALARM_CFG(throt)		(OC1_CFG + \
>> +					(ALARM_OFFSET * (throt - THROTTLE_OC1)))
>> +
>> +#define ALARM_CNT_THRESHOLD(throt)	(OC1_CNT_THRESHOLD + \
>> +					(ALARM_OFFSET * (throt - THROTTLE_OC1)))
>> +
>> +#define ALARM_THROTTLE_PERIOD(throt)	(OC1_THROTTLE_PERIOD + \
>> +					(ALARM_OFFSET * (throt - THROTTLE_OC1)))
>> +
>> +#define ALARM_ALARM_COUNT(throt)	(OC1_ALARM_COUNT + \
>> +					(ALARM_OFFSET * (throt - THROTTLE_OC1)))
>> +
>> +#define ALARM_FILTER(throt)		(OC1_FILTER + \
>> +					(ALARM_OFFSET * (throt - THROTTLE_OC1)))
>> +
>> +#define ALARM_STATS(throt)		(OC1_STATS + \
>> +					(4 * (throt - THROTTLE_OC1)))
>> +
>>  /* get CCROC_THROT_PSKIP_xxx offset per HIGH/MED/LOW vect*/
>>  #define CCROC_THROT_OFFSET			0x0c
>>  #define CCROC_THROT_PSKIP_CTRL_CPU_REG(vect)    (CCROC_THROT_PSKIP_CTRL_CPU + \
>> @@ -218,6 +254,9 @@
>>  #define THERMCTL_LVL_REGS_SIZE		0x20
>>  #define THERMCTL_LVL_REG(rg, lv)	((rg) + ((lv) * THERMCTL_LVL_REGS_SIZE))
>>  
>> +#define OC_THROTTLE_MODE_DISABLED	0
>> +#define OC_THROTTLE_MODE_BRIEF		2
>> +
>>  static const int min_low_temp = -127000;
>>  static const int max_high_temp = 127000;
>>  
>> @@ -266,6 +305,15 @@ struct tegra_thermctl_zone {
>>  	const struct tegra_tsensor_group *sg;
>>  };
>>  
>> +struct soctherm_oc_cfg {
>> +	u32 active_low;
>> +	u32 throt_period;
>> +	u32 alarm_cnt_thresh;
>> +	u32 alarm_filter;
>> +	u32 mode;
>> +	bool intr_en;
>> +};
>> +
>>  struct soctherm_throt_cfg {
>>  	const char *name;
>>  	unsigned int id;
>> @@ -273,6 +321,7 @@ struct soctherm_throt_cfg {
>>  	u8 cpu_throt_level;
>>  	u32 cpu_throt_depth;
>>  	u32 gpu_throt_level;
>> +	struct soctherm_oc_cfg oc_cfg;
>>  	struct thermal_cooling_device *cdev;
>>  	bool init;
>>  };
>> @@ -715,7 +764,7 @@ static int tegra_soctherm_set_hwtrips(struct device *dev,
>>  		return 0;
>>  	}
>>  
>> -	for (i = 0; i < THROTTLE_SIZE; i++) {
>> +	for (i = 0; i < THROTTLE_OC1; i++) {
>>  		struct thermal_cooling_device *cdev;
>>  
>>  		if (!ts->throt_cfgs[i].init)
>> @@ -1537,6 +1586,32 @@ static int soctherm_thermtrips_parse(struct platform_device *pdev)
>>  	return 0;
>>  }
>>  
>> +static void soctherm_oc_cfg_parse(struct device *dev,
>> +				struct device_node *np_oc,
>> +				struct soctherm_throt_cfg *stc)
>> +{
>> +	u32 val;
>> +
>> +	if (of_property_read_bool(np_oc, "nvidia,polarity-active-low"))
>> +		stc->oc_cfg.active_low = 1;
>> +	else
>> +		stc->oc_cfg.active_low = 0;
>> +
>> +	if (!of_property_read_u32(np_oc, "nvidia,count-threshold", &val)) {
>> +		stc->oc_cfg.intr_en = 1;
>> +		stc->oc_cfg.alarm_cnt_thresh = val;
>> +	}
>> +
>> +	if (!of_property_read_u32(np_oc, "nvidia,throttle-period-us", &val))
>> +		stc->oc_cfg.throt_period = val;
>> +
>> +	if (!of_property_read_u32(np_oc, "nvidia,alarm-filter", &val))
>> +		stc->oc_cfg.alarm_filter = val;
>> +
>> +	/* BRIEF throttling by default, do not support STICKY */
>> +	stc->oc_cfg.mode = OC_THROTTLE_MODE_BRIEF;
>> +}
>> +
>>  static int soctherm_throt_cfg_parse(struct device *dev,
>>  				    struct device_node *np,
>>  				    struct soctherm_throt_cfg *stc)
>> @@ -1619,24 +1694,34 @@ static void soctherm_init_hw_throt_cdev(struct platform_device *pdev)
>>  			continue;
>>  		}
>>  
>> +		if (stc->init) {
>> +			dev_err(dev, "throttle-cfg: %s: redefined!\n", name);
>> +			of_node_put(np_stcc);
>> +			break;
>> +		}
>>  
>>  		err = soctherm_throt_cfg_parse(dev, np_stcc, stc);
>>  		if (err)
>>  			continue;
>>  
>> -		tcd = thermal_of_cooling_device_register(np_stcc,
>> +		if (stc->id >= THROTTLE_OC1) {
>> +			soctherm_oc_cfg_parse(dev, np_stcc, stc);
>> +			stc->init = true;
>> +		} else {
>> +
>> +			tcd = thermal_of_cooling_device_register(np_stcc,
>>  							 (char *)name, ts,
>>  							 &throt_cooling_ops);
>> -		of_node_put(np_stcc);
>> -		if (IS_ERR_OR_NULL(tcd)) {
>> -			dev_err(dev,
>> -				"throttle-cfg: %s: failed to register cooling device\n",
>> -				name);
>> -			continue;
>> +			if (IS_ERR_OR_NULL(tcd)) {
>> +				dev_err(dev,
>> +					"throttle-cfg: %s: failed to register cooling device\n",
>> +					name);
>> +				continue;
>> +			}
>> +			stc->cdev = tcd;
>> +			stc->init = true;
>>  		}
>>  
>> -		stc->cdev = tcd;
>> -		stc->init = true;
>>  	}
>>  
>>  	of_node_put(np_stc);
>> @@ -1787,6 +1872,28 @@ static void throttlectl_gpu_level_select(struct tegra_soctherm *ts,
>>  	writel(r, ts->regs + THROT_PSKIP_CTRL(throt, THROTTLE_DEV_GPU));
>>  }
>>  
>> +static int soctherm_oc_cfg_program(struct tegra_soctherm *ts,
>> +				      enum soctherm_throttle_id throt)
>> +{
>> +	u32 r;
>> +	struct soctherm_oc_cfg *oc = &ts->throt_cfgs[throt].oc_cfg;
>> +
>> +	if (oc->mode == OC_THROTTLE_MODE_DISABLED)
>> +		return -EINVAL;
>> +
>> +	r = REG_SET_MASK(0, OC1_CFG_HW_RESTORE_MASK, 1);
>> +	r = REG_SET_MASK(r, OC1_CFG_THROTTLE_MODE_MASK, oc->mode);
>> +	r = REG_SET_MASK(r, OC1_CFG_ALARM_POLARITY_MASK, oc->active_low);
>> +	r = REG_SET_MASK(r, OC1_CFG_EN_THROTTLE_MASK, 1);
>> +	writel(r, ts->regs + ALARM_CFG(throt));
>> +	writel(oc->throt_period, ts->regs + ALARM_THROTTLE_PERIOD(throt));
>> +	writel(oc->alarm_cnt_thresh, ts->regs + ALARM_CNT_THRESHOLD(throt));
>> +	writel(oc->alarm_filter, ts->regs + ALARM_FILTER(throt));
>> +	soctherm_oc_intr_enable(ts, throt, oc->intr_en);
>> +
>> +	return 0;
>> +}
>> +
>>  /**
>>   * soctherm_throttle_program() - programs pulse skippers' configuration
>>   * @throt: the LIGHT/HEAVY of the throttle event id.
>> @@ -1803,6 +1910,9 @@ static void soctherm_throttle_program(struct tegra_soctherm *ts,
>>  	if (!stc.init)
>>  		return;
>>  
>> +	if ((throt >= THROTTLE_OC1) && (soctherm_oc_cfg_program(ts, throt)))
>> +		return;
>> +
>>  	/* Setup PSKIP parameters */
>>  	if (ts->soc->use_ccroc)
>>  		throttlectl_cpu_level_select(ts, throt);
>> -- 
>> 2.7.4
>>
