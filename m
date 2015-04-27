From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2] thermal: exynos: Add the support for Exynos5433 TMU
Date: Mon, 27 Apr 2015 11:20:22 +0900
Message-ID: <553D9CE6.5040505@samsung.com>
References: <1425954224-31035-1-git-send-email-cw00.choi@samsung.com>
 <5508C4A9.50705@samsung.com> <20150318083913.528119f4@amdc2363>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:30120 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769AbbD0CUZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 26 Apr 2015 22:20:25 -0400
In-reply-to: <20150318083913.528119f4@amdc2363>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>, edubezval@gmail.com
Cc: rui.zhang@intel.com, kgene@kernel.org, inki.dae@samsung.com, chanho61.park@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Eduardo and Lukasz,

I checked this patch merged on linux-next.git.
But, this patch is not merged on Linux 4.1-rc1.

Thanks,
Chanwoo Choi

On 03/18/2015 04:39 PM, Lukasz Majewski wrote:
> Hi Chanwoo,
> 
>> Hi Lukasz,
>>
>> Genlty Ping.
> 
> I've got your patches at the back of my head :-)
> 
> I will try to review them today or tomorrow.
> 
>>
>> Best Regards,
>> Chanwoo Choi
>>
>> On 03/10/2015 11:23 AM, Chanwoo Choi wrote:
>>> This patch adds the support for Exynos5433's TMU (Thermal
>>> Management Unit). Exynos5433 has a little different register bit
>>> fields as following description:
>>> - Support the eight trip points for rising/falling interrupt by
>>> using two registers
>>> - Read the calibration type (1-point or 2-point) and sensor id from
>>> TRIMINFO register
>>> - Use a little different register address
>>>
>>> Cc: Zhang Rui <rui.zhang@intel.com>
>>> Cc: Eduardo Valentin <edubezval@gmail.com>
>>> Cc: Lukasz Majewski <l.majewski@samsung.com>
>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>> ---
>>> Changes from v1:
>>> (https://lkml.org/lkml/2015/2/26/234)
>>> - Add exynos5433_tmu_control() instead of using
>>> exynos7_tmu_control() on both Exynos5433 and Exynos7.
>>> - Separate the patches related to devicetree and then send send
>>> Exnos5433's tmu patches[1] with other Exynos5433 devicetree patches.
>>>   [1] https://lkml.org/lkml/2015/3/9/1036
>>>
>>>  drivers/thermal/samsung/exynos_tmu.c | 187
>>> ++++++++++++++++++++++++++++++++++-
>>> drivers/thermal/samsung/exynos_tmu.h |   1 + 2 files changed, 186
>>> insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/thermal/samsung/exynos_tmu.c
>>> b/drivers/thermal/samsung/exynos_tmu.c index 1d30b09..531f4b17
>>> 100644 --- a/drivers/thermal/samsung/exynos_tmu.c
>>> +++ b/drivers/thermal/samsung/exynos_tmu.c
>>> @@ -97,6 +97,32 @@
>>>  #define EXYNOS4412_MUX_ADDR_VALUE          6
>>>  #define EXYNOS4412_MUX_ADDR_SHIFT          20
>>>  
>>> +/* Exynos5433 specific registers */
>>> +#define EXYNOS5433_TMU_REG_CONTROL1		0x024
>>> +#define EXYNOS5433_TMU_SAMPLING_INTERVAL	0x02c
>>> +#define EXYNOS5433_TMU_COUNTER_VALUE0		0x030
>>> +#define EXYNOS5433_TMU_COUNTER_VALUE1		0x034
>>> +#define EXYNOS5433_TMU_REG_CURRENT_TEMP1	0x044
>>> +#define EXYNOS5433_THD_TEMP_RISE3_0		0x050
>>> +#define EXYNOS5433_THD_TEMP_RISE7_4		0x054
>>> +#define EXYNOS5433_THD_TEMP_FALL3_0		0x060
>>> +#define EXYNOS5433_THD_TEMP_FALL7_4		0x064
>>> +#define EXYNOS5433_TMU_REG_INTEN		0x0c0
>>> +#define EXYNOS5433_TMU_REG_INTPEND		0x0c8
>>> +#define EXYNOS5433_TMU_EMUL_CON			0x110
>>> +#define EXYNOS5433_TMU_PD_DET_EN		0x130
>>> +
>>> +#define EXYNOS5433_TRIMINFO_SENSOR_ID_SHIFT	16
>>> +#define EXYNOS5433_TRIMINFO_CALIB_SEL_SHIFT	23
>>> +#define EXYNOS5433_TRIMINFO_SENSOR_ID_MASK	\
>>> +			(0xf <<
>>> EXYNOS5433_TRIMINFO_SENSOR_ID_SHIFT) +#define
>>> EXYNOS5433_TRIMINFO_CALIB_SEL_MASK	BIT(23) +
>>> +#define EXYNOS5433_TRIMINFO_ONE_POINT_TRIMMING	0
>>> +#define EXYNOS5433_TRIMINFO_TWO_POINT_TRIMMING	1
>>> +
>>> +#define EXYNOS5433_PD_DET_EN			1
>>> +
>>>  /*exynos5440 specific registers*/
>>>  #define EXYNOS5440_TMU_S0_7_TRIM		0x000
>>>  #define EXYNOS5440_TMU_S0_7_CTRL		0x020
>>> @@ -484,6 +510,101 @@ out:
>>>  	return ret;
>>>  }
>>>  
>>> +static int exynos5433_tmu_initialize(struct platform_device *pdev)
>>> +{
>>> +	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
>>> +	struct exynos_tmu_platform_data *pdata = data->pdata;
>>> +	struct thermal_zone_device *tz = data->tzd;
>>> +	unsigned int status, trim_info;
>>> +	unsigned int rising_threshold = 0, falling_threshold = 0;
>>> +	unsigned long temp, temp_hist;
>>> +	int ret = 0, threshold_code, i, sensor_id, cal_type;
>>> +
>>> +	status = readb(data->base + EXYNOS_TMU_REG_STATUS);
>>> +	if (!status) {
>>> +		ret = -EBUSY;
>>> +		goto out;
>>> +	}
>>> +
>>> +	trim_info = readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
>>> +	sanitize_temp_error(data, trim_info);
>>> +
>>> +	/* Read the temperature sensor id */
>>> +	sensor_id = (trim_info &
>>> EXYNOS5433_TRIMINFO_SENSOR_ID_MASK)
>>> +				>>
>>> EXYNOS5433_TRIMINFO_SENSOR_ID_SHIFT;
>>> +	dev_info(&pdev->dev, "Temperature sensor ID: 0x%x\n",
>>> sensor_id); +
>>> +	/* Read the calibration mode */
>>> +	writel(trim_info, data->base + EXYNOS_TMU_REG_TRIMINFO);
>>> +	cal_type = (trim_info & EXYNOS5433_TRIMINFO_CALIB_SEL_MASK)
>>> +				>>
>>> EXYNOS5433_TRIMINFO_CALIB_SEL_SHIFT; +
>>> +	switch (cal_type) {
>>> +	case EXYNOS5433_TRIMINFO_ONE_POINT_TRIMMING:
>>> +		pdata->cal_type = TYPE_ONE_POINT_TRIMMING;
>>> +		break;
>>> +	case EXYNOS5433_TRIMINFO_TWO_POINT_TRIMMING:
>>> +		pdata->cal_type = TYPE_TWO_POINT_TRIMMING;
>>> +		break;
>>> +	default:
>>> +		pdata->cal_type = TYPE_ONE_POINT_TRIMMING;
>>> +		break;
>>> +	};
>>> +
>>> +	dev_info(&pdev->dev, "Calibration type is %d-point
>>> calibration\n",
>>> +			cal_type ?  2 : 1);
>>> +
>>> +	/* Write temperature code for rising and falling threshold
>>> */
>>> +	for (i = 0; i < of_thermal_get_ntrips(tz); i++) {
>>> +		int rising_reg_offset, falling_reg_offset;
>>> +		int j = 0;
>>> +
>>> +		switch (i) {
>>> +		case 0:
>>> +		case 1:
>>> +		case 2:
>>> +		case 3:
>>> +			rising_reg_offset =
>>> EXYNOS5433_THD_TEMP_RISE3_0;
>>> +			falling_reg_offset =
>>> EXYNOS5433_THD_TEMP_FALL3_0;
>>> +			j = i;
>>> +			break;
>>> +		case 4:
>>> +		case 5:
>>> +		case 6:
>>> +		case 7:
>>> +			rising_reg_offset =
>>> EXYNOS5433_THD_TEMP_RISE7_4;
>>> +			falling_reg_offset =
>>> EXYNOS5433_THD_TEMP_FALL7_4;
>>> +			j = i - 4;
>>> +			break;
>>> +		default:
>>> +			continue;
>>> +		}
>>> +
>>> +		/* Write temperature code for rising threshold */
>>> +		tz->ops->get_trip_temp(tz, i, &temp);
>>> +		temp /= MCELSIUS;
>>> +		threshold_code = temp_to_code(data, temp);
>>> +
>>> +		rising_threshold = readl(data->base +
>>> rising_reg_offset);
>>> +		rising_threshold |= (threshold_code << j * 8);
>>> +		writel(rising_threshold, data->base +
>>> rising_reg_offset); +
>>> +		/* Write temperature code for falling threshold */
>>> +		tz->ops->get_trip_hyst(tz, i, &temp_hist);
>>> +		temp_hist = temp - (temp_hist / MCELSIUS);
>>> +		threshold_code = temp_to_code(data, temp_hist);
>>> +
>>> +		falling_threshold = readl(data->base +
>>> falling_reg_offset);
>>> +		falling_threshold &= ~(0xff << j * 8);
>>> +		falling_threshold |= (threshold_code << j * 8);
>>> +		writel(falling_threshold, data->base +
>>> falling_reg_offset);
>>> +	}
>>> +
>>> +	data->tmu_clear_irqs(data);
>>> +out:
>>> +	return ret;
>>> +}
>>> +
>>>  static int exynos5440_tmu_initialize(struct platform_device *pdev)
>>>  {
>>>  	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
>>> @@ -643,6 +764,48 @@ static void exynos4210_tmu_control(struct
>>> platform_device *pdev, bool on) writel(con, data->base +
>>> EXYNOS_TMU_REG_CONTROL); }
>>>  
>>> +static void exynos5433_tmu_control(struct platform_device *pdev,
>>> bool on) +{
>>> +	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
>>> +	struct thermal_zone_device *tz = data->tzd;
>>> +	unsigned int con, interrupt_en, pd_det_en;
>>> +
>>> +	con = get_con_reg(data, readl(data->base +
>>> EXYNOS_TMU_REG_CONTROL)); +
>>> +	if (on) {
>>> +		con |= (1 << EXYNOS_TMU_CORE_EN_SHIFT);
>>> +		interrupt_en =
>>> +			(of_thermal_is_trip_valid(tz, 7)
>>> +			<< EXYNOS7_TMU_INTEN_RISE7_SHIFT) |
>>> +			(of_thermal_is_trip_valid(tz, 6)
>>> +			<< EXYNOS7_TMU_INTEN_RISE6_SHIFT) |
>>> +			(of_thermal_is_trip_valid(tz, 5)
>>> +			<< EXYNOS7_TMU_INTEN_RISE5_SHIFT) |
>>> +			(of_thermal_is_trip_valid(tz, 4)
>>> +			<< EXYNOS7_TMU_INTEN_RISE4_SHIFT) |
>>> +			(of_thermal_is_trip_valid(tz, 3)
>>> +			<< EXYNOS7_TMU_INTEN_RISE3_SHIFT) |
>>> +			(of_thermal_is_trip_valid(tz, 2)
>>> +			<< EXYNOS7_TMU_INTEN_RISE2_SHIFT) |
>>> +			(of_thermal_is_trip_valid(tz, 1)
>>> +			<< EXYNOS7_TMU_INTEN_RISE1_SHIFT) |
>>> +			(of_thermal_is_trip_valid(tz, 0)
>>> +			<< EXYNOS7_TMU_INTEN_RISE0_SHIFT);
>>> +
>>> +		interrupt_en |=
>>> +			interrupt_en <<
>>> EXYNOS_TMU_INTEN_FALL0_SHIFT;
>>> +	} else {
>>> +		con &= ~(1 << EXYNOS_TMU_CORE_EN_SHIFT);
>>> +		interrupt_en = 0; /* Disable all interrupts */
>>> +	}
>>> +
>>> +	pd_det_en = on ? EXYNOS5433_PD_DET_EN : 0;
>>> +
>>> +	writel(pd_det_en, data->base + EXYNOS5433_TMU_PD_DET_EN);
>>> +	writel(interrupt_en, data->base +
>>> EXYNOS5433_TMU_REG_INTEN);
>>> +	writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
>>> +}
>>> +
>>>  static void exynos5440_tmu_control(struct platform_device *pdev,
>>> bool on) {
>>>  	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
>>> @@ -770,6 +933,8 @@ static void exynos4412_tmu_set_emulation(struct
>>> exynos_tmu_data *data, 
>>>  	if (data->soc == SOC_ARCH_EXYNOS5260)
>>>  		emul_con = EXYNOS5260_EMUL_CON;
>>> +	if (data->soc == SOC_ARCH_EXYNOS5433)
>>> +		emul_con = EXYNOS5433_TMU_EMUL_CON;
>>>  	else if (data->soc == SOC_ARCH_EXYNOS7)
>>>  		emul_con = EXYNOS7_TMU_REG_EMUL_CON;
>>>  	else
>>> @@ -882,6 +1047,9 @@ static void exynos4210_tmu_clear_irqs(struct
>>> exynos_tmu_data *data) } else if (data->soc == SOC_ARCH_EXYNOS7) {
>>>  		tmu_intstat = EXYNOS7_TMU_REG_INTPEND;
>>>  		tmu_intclear = EXYNOS7_TMU_REG_INTPEND;
>>> +	} else if (data->soc == SOC_ARCH_EXYNOS5433) {
>>> +		tmu_intstat = EXYNOS5433_TMU_REG_INTPEND;
>>> +		tmu_intclear = EXYNOS5433_TMU_REG_INTPEND;
>>>  	} else {
>>>  		tmu_intstat = EXYNOS_TMU_REG_INTSTAT;
>>>  		tmu_intclear = EXYNOS_TMU_REG_INTCLEAR;
>>> @@ -926,6 +1094,7 @@ static const struct of_device_id
>>> exynos_tmu_match[] = { { .compatible = "samsung,exynos5260-tmu", },
>>>  	{ .compatible = "samsung,exynos5420-tmu", },
>>>  	{ .compatible = "samsung,exynos5420-tmu-ext-triminfo", },
>>> +	{ .compatible = "samsung,exynos5433-tmu", },
>>>  	{ .compatible = "samsung,exynos5440-tmu", },
>>>  	{ .compatible = "samsung,exynos7-tmu", },
>>>  	{ /* sentinel */ },
>>> @@ -949,6 +1118,8 @@ static int exynos_of_get_soc_type(struct
>>> device_node *np) else if (of_device_is_compatible(np,
>>>  					 "samsung,exynos5420-tmu-ext-triminfo"))
>>>  		return SOC_ARCH_EXYNOS5420_TRIMINFO;
>>> +	else if (of_device_is_compatible(np,
>>> "samsung,exynos5433-tmu"))
>>> +		return SOC_ARCH_EXYNOS5433;
>>>  	else if (of_device_is_compatible(np,
>>> "samsung,exynos5440-tmu")) return SOC_ARCH_EXYNOS5440;
>>>  	else if (of_device_is_compatible(np,
>>> "samsung,exynos7-tmu")) @@ -1069,6 +1240,13 @@ static int
>>> exynos_map_dt_data(struct platform_device *pdev)
>>> data->tmu_set_emulation = exynos4412_tmu_set_emulation;
>>> data->tmu_clear_irqs = exynos4210_tmu_clear_irqs; break;
>>> +	case SOC_ARCH_EXYNOS5433:
>>> +		data->tmu_initialize = exynos5433_tmu_initialize;
>>> +		data->tmu_control = exynos5433_tmu_control;
>>> +		data->tmu_read = exynos4412_tmu_read;
>>> +		data->tmu_set_emulation =
>>> exynos4412_tmu_set_emulation;
>>> +		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
>>> +		break;
>>>  	case SOC_ARCH_EXYNOS5440:
>>>  		data->tmu_initialize = exynos5440_tmu_initialize;
>>>  		data->tmu_control = exynos5440_tmu_control;
>>> @@ -1172,7 +1350,9 @@ static int exynos_tmu_probe(struct
>>> platform_device *pdev) goto err_clk_sec;
>>>  	}
>>>  
>>> -	if (data->soc == SOC_ARCH_EXYNOS7) {
>>> +	switch (data->soc) {
>>> +	case SOC_ARCH_EXYNOS5433:
>>> +	case SOC_ARCH_EXYNOS7:
>>>  		data->sclk = devm_clk_get(&pdev->dev, "tmu_sclk");
>>>  		if (IS_ERR(data->sclk)) {
>>>  			dev_err(&pdev->dev, "Failed to get
>>> sclk\n"); @@ -1184,7 +1364,10 @@ static int exynos_tmu_probe(struct
>>> platform_device *pdev) goto err_clk;
>>>  			}
>>>  		}
>>> -	}
>>> +		break;
>>> +	default:
>>> +		break;
>>> +	};
>>>  
>>>  	ret = exynos_tmu_initialize(pdev);
>>>  	if (ret) {
>>> diff --git a/drivers/thermal/samsung/exynos_tmu.h
>>> b/drivers/thermal/samsung/exynos_tmu.h index 4d71ec6..440c714 100644
>>> --- a/drivers/thermal/samsung/exynos_tmu.h
>>> +++ b/drivers/thermal/samsung/exynos_tmu.h
>>> @@ -33,6 +33,7 @@ enum soc_type {
>>>  	SOC_ARCH_EXYNOS5260,
>>>  	SOC_ARCH_EXYNOS5420,
>>>  	SOC_ARCH_EXYNOS5420_TRIMINFO,
>>> +	SOC_ARCH_EXYNOS5433,
>>>  	SOC_ARCH_EXYNOS5440,
>>>  	SOC_ARCH_EXYNOS7,
>>>  };
>>>
>>
> 
> 
> 

