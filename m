From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCHv4 2/4] thermal: exynos: Add support for many TRIMINFO_CTRL
 registers
Date: Mon, 25 Aug 2014 19:37:25 +0900
Message-ID: <53FB11E5.2070503@samsung.com>
References: <1408951825-2639-1-git-send-email-cw00.choi@samsung.com>
 <1408951825-2639-3-git-send-email-cw00.choi@samsung.com>
 <5071235.4ralWIzmJe@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:57567 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753445AbaHYKh2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Aug 2014 06:37:28 -0400
In-reply-to: <5071235.4ralWIzmJe@amdc1032>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, eduardo.valentin@ti.com, amit.daniel@samsung.com, rui.zhang@intel.com, mark.rutland@arm.com, devicetree@vger.kernel.org, kgene.kim@samsung.com, pawel.moll@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, linux-samsung-soc@vger.kernel.org, kyungmin.park@samsung.com, robh+dt@kernel.org, galak@codeaurora.org, ch.naveen@samsung.com

Hi Bartlomiej,

On 08/25/2014 07:15 PM, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On Monday, August 25, 2014 04:30:23 PM Chanwoo Choi wrote:
>> This patch support many TRIMINFO_CTRL registers if specific Exynos SoC
>> has one more TRIMINFO_CTRL registers. Also this patch uses proper 'RELOAD'
>> shift/mask bit operation to set RELOAD feature instead of static value.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
>> Cc: Zhang Rui <rui.zhang@intel.com>
>> Cc: Eduardo Valentin <edubezval@gmail.com>
>> Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
>> Reviewed-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
>> ---
>>  drivers/thermal/samsung/exynos_thermal_common.h |  1 +
>>  drivers/thermal/samsung/exynos_tmu.c            | 23 ++++++++++++++++++++---
>>  drivers/thermal/samsung/exynos_tmu.h            |  9 +++++++--
>>  drivers/thermal/samsung/exynos_tmu_data.c       |  5 ++++-
>>  drivers/thermal/samsung/exynos_tmu_data.h       |  3 +++
>>  5 files changed, 35 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/thermal/samsung/exynos_thermal_common.h b/drivers/thermal/samsung/exynos_thermal_common.h
>> index 3eb2ed9..b211976 100644
>> --- a/drivers/thermal/samsung/exynos_thermal_common.h
>> +++ b/drivers/thermal/samsung/exynos_thermal_common.h
>> @@ -28,6 +28,7 @@
>>  #define MAX_TRIP_COUNT	8
>>  #define MAX_COOLING_DEVICE 4
>>  #define MAX_THRESHOLD_LEVS 5
>> +#define MAX_TRIMINFO_CTRL_REG	2
>>  
>>  #define ACTIVE_INTERVAL 500
>>  #define IDLE_INTERVAL 10000
>> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
>> index acbff14..7234f38 100644
>> --- a/drivers/thermal/samsung/exynos_tmu.c
>> +++ b/drivers/thermal/samsung/exynos_tmu.c
>> @@ -147,7 +147,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
>>  	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
>>  	struct exynos_tmu_platform_data *pdata = data->pdata;
>>  	const struct exynos_tmu_registers *reg = pdata->registers;
>> -	unsigned int status, trim_info = 0, con;
>> +	unsigned int status, trim_info = 0, con, ctrl;
>>  	unsigned int rising_threshold = 0, falling_threshold = 0;
>>  	int ret = 0, threshold_code, i, trigger_levs = 0;
>>  
>> @@ -164,8 +164,25 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
>>  		}
>>  	}
>>  
>> -	if (TMU_SUPPORTS(pdata, TRIM_RELOAD))
>> -		__raw_writel(1, data->base + reg->triminfo_ctrl);
>> +	if (TMU_SUPPORTS(pdata, TRIM_RELOAD)) {
>> +		if (reg->triminfo_ctrl_count > MAX_TRIMINFO_CTRL_REG) {
> 
> Please remove this check and MAX_TRIMINFO_CTRL_REG define.
> 
> We do not want such runtime checks for development time errors.

OK, I'll remove it.

> 
>> +			ret = -EINVAL;
>> +			goto out;
>> +		}
>> +
>> +		for (i = 0; i < reg->triminfo_ctrl_count; i++) {
>> +			if (pdata->triminfo_reload[i]) {
>> +				ctrl = readl(data->base +
>> +						reg->triminfo_ctrl[i]);
>> +				ctrl &= ~(reg->triminfo_reload_mask <<
>> +						reg->triminfo_reload_shift);
>> +				ctrl |= pdata->triminfo_reload[i] <<
>> +						reg->triminfo_reload_shift;
> 
> triminfo_reload_shift and triminfo_reload_mask variables have always
> the same values when this code is run so there is no need for them.

I don't understand. Do you mean that timinfo_reload_{shift/mask} variable is un-needed?
If you possible, I need more detailed comment.

> 
> They should be added only when needed instead of doing it now.
> 
>> +				__raw_writel(ctrl, data->base +
>> +						reg->triminfo_ctrl[i]);
>> +			}
>> +		}
>> +	}
>>  
>>  	if (pdata->cal_mode == HW_MODE)
>>  		goto skip_calib_data;
>> diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
>> index 1b4a644..d7674ad 100644
>> --- a/drivers/thermal/samsung/exynos_tmu.h
>> +++ b/drivers/thermal/samsung/exynos_tmu.h
>> @@ -85,8 +85,11 @@ enum soc_type {
>>   * @triminfo_25_shift: shift bit of the 25 C trim value in triminfo_data reg.
>>   * @triminfo_85_shift: shift bit of the 85 C trim value in triminfo_data reg.
>>   * @triminfo_ctrl: trim info controller register.
>> + * @triminfo_ctrl_count: the number of trim info controller register.
>>   * @triminfo_reload_shift: shift of triminfo reload enable bit in triminfo_ctrl
>>  	reg.
>> + * @triminfo_reload_mask: mask of triminfo reload enable bit in triminfo_ctrl
>> +	reg.
>>   * @tmu_ctrl: TMU main controller register.
>>   * @test_mux_addr_shift: shift bits of test mux address.
>>   * @buf_vref_sel_shift: shift bits of reference voltage in tmu_ctrl register.
>> @@ -151,9 +154,10 @@ struct exynos_tmu_registers {
>>  	u32	triminfo_25_shift;
>>  	u32	triminfo_85_shift;
>>  
>> -	u32	triminfo_ctrl;
>> -	u32	triminfo_ctrl1;
>> +	u32	triminfo_ctrl[MAX_TRIMINFO_CTRL_REG];
>> +	u32	triminfo_ctrl_count;
>>  	u32	triminfo_reload_shift;
>> +	u32	triminfo_reload_mask;
>>  
>>  	u32	tmu_ctrl;
>>  	u32     test_mux_addr_shift;
>> @@ -295,6 +299,7 @@ struct exynos_tmu_platform_data {
>>  	u8 second_point_trim;
>>  	u8 default_temp_offset;
>>  	u8 test_mux;
>> +	u8 triminfo_reload[MAX_TRIMINFO_CTRL_REG];
>>  
>>  	enum calibration_type cal_type;
>>  	enum calibration_mode cal_mode;
>> diff --git a/drivers/thermal/samsung/exynos_tmu_data.c b/drivers/thermal/samsung/exynos_tmu_data.c
>> index aa8e0de..754c638 100644
>> --- a/drivers/thermal/samsung/exynos_tmu_data.c
>> +++ b/drivers/thermal/samsung/exynos_tmu_data.c
>> @@ -184,8 +184,10 @@ static const struct exynos_tmu_registers exynos4412_tmu_registers = {
>>  	.triminfo_data = EXYNOS_TMU_REG_TRIMINFO,
>>  	.triminfo_25_shift = EXYNOS_TRIMINFO_25_SHIFT,
>>  	.triminfo_85_shift = EXYNOS_TRIMINFO_85_SHIFT,
>> -	.triminfo_ctrl = EXYNOS_TMU_TRIMINFO_CON,
>> +	.triminfo_ctrl[0] = EXYNOS_TMU_TRIMINFO_CON,
>> +	.triminfo_ctrl_count = 1,
>>  	.triminfo_reload_shift = EXYNOS_TRIMINFO_RELOAD_SHIFT,
>> +	.triminfo_reload_mask = EXYNOS_TRIMINFO_RELOAD_MASK,
>>  	.tmu_ctrl = EXYNOS_TMU_REG_CONTROL,
>>  	.test_mux_addr_shift = EXYNOS4412_MUX_ADDR_SHIFT,
>>  	.buf_vref_sel_shift = EXYNOS_TMU_REF_VOLTAGE_SHIFT,
>> @@ -252,6 +254,7 @@ static const struct exynos_tmu_registers exynos4412_tmu_registers = {
>>  		.temp_level = 95, \
>>  	}, \
>>  	.freq_tab_count = 2, \
>> +	.triminfo_reload[0] = EXYNOS_TRIMINFO_RELOAD_ENABLE, \
>>  	.registers = &exynos4412_tmu_registers, \
>>  	.features = (TMU_SUPPORT_EMULATION | TMU_SUPPORT_TRIM_RELOAD | \
>>  			TMU_SUPPORT_FALLING_TRIP | TMU_SUPPORT_READY_STATUS | \
>> diff --git a/drivers/thermal/samsung/exynos_tmu_data.h b/drivers/thermal/samsung/exynos_tmu_data.h
>> index 401bab7..87454f63 100644
>> --- a/drivers/thermal/samsung/exynos_tmu_data.h
>> +++ b/drivers/thermal/samsung/exynos_tmu_data.h
>> @@ -64,6 +64,9 @@
>>  #define EXYNOS_EMUL_CON		0x80
>>  
>>  #define EXYNOS_TRIMINFO_RELOAD_SHIFT	0
>> +#define EXYNOS_TRIMINFO_RELOAD_MASK	0x1
>> +#define EXYNOS_TRIMINFO_RELOAD_ENABLE	1
>> +#define EXYNOS_TRIMINFO_RELOAD_DISABLE	0
> 
> This define is never used please remove it.

OK, I'll remove it. Thanks.

Beset Regards,
Chanwoo CHoi
