From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCHv4 2/4] thermal: exynos: Add support for many TRIMINFO_CTRL
 registers
Date: Mon, 25 Aug 2014 20:49:16 +0900
Message-ID: <53FB22BC.2000609@samsung.com>
References: <1408951825-2639-1-git-send-email-cw00.choi@samsung.com>
 <5071235.4ralWIzmJe@amdc1032> <53FB11E5.2070503@samsung.com>
 <13170930.3cdcLOtxou@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <13170930.3cdcLOtxou@amdc1032>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, eduardo.valentin@ti.com, amit.daniel@samsung.com, rui.zhang@intel.com, mark.rutland@arm.com, devicetree@vger.kernel.org, kgene.kim@samsung.com, pawel.moll@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, linux-samsung-soc@vger.kernel.org, kyungmin.park@samsung.com, robh+dt@kernel.org, galak@codeaurora.org, ch.naveen@samsung.com
List-Id: linux-pm@vger.kernel.org

On 08/25/2014 08:19 PM, Bartlomiej Zolnierkiewicz wrote:
> On Monday, August 25, 2014 07:37:25 PM Chanwoo Choi wrote:
>> Hi Bartlomiej,
>>
>> On 08/25/2014 07:15 PM, Bartlomiej Zolnierkiewicz wrote:
>>>
>>> Hi,
>>>
>>> On Monday, August 25, 2014 04:30:23 PM Chanwoo Choi wrote:
>>>> This patch support many TRIMINFO_CTRL registers if specific Exynos SoC
>>>> has one more TRIMINFO_CTRL registers. Also this patch uses proper 'RELOAD'
>>>> shift/mask bit operation to set RELOAD feature instead of static value.
>>>>
>>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
>>>> Cc: Zhang Rui <rui.zhang@intel.com>
>>>> Cc: Eduardo Valentin <edubezval@gmail.com>
>>>> Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
>>>> Reviewed-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
>>>> ---
>>>>  drivers/thermal/samsung/exynos_thermal_common.h |  1 +
>>>>  drivers/thermal/samsung/exynos_tmu.c            | 23 ++++++++++++++++++++---
>>>>  drivers/thermal/samsung/exynos_tmu.h            |  9 +++++++--
>>>>  drivers/thermal/samsung/exynos_tmu_data.c       |  5 ++++-
>>>>  drivers/thermal/samsung/exynos_tmu_data.h       |  3 +++
>>>>  5 files changed, 35 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/thermal/samsung/exynos_thermal_common.h b/drivers/thermal/samsung/exynos_thermal_common.h
>>>> index 3eb2ed9..b211976 100644
>>>> --- a/drivers/thermal/samsung/exynos_thermal_common.h
>>>> +++ b/drivers/thermal/samsung/exynos_thermal_common.h
>>>> @@ -28,6 +28,7 @@
>>>>  #define MAX_TRIP_COUNT	8
>>>>  #define MAX_COOLING_DEVICE 4
>>>>  #define MAX_THRESHOLD_LEVS 5
>>>> +#define MAX_TRIMINFO_CTRL_REG	2
>>>>  
>>>>  #define ACTIVE_INTERVAL 500
>>>>  #define IDLE_INTERVAL 10000
>>>> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
>>>> index acbff14..7234f38 100644
>>>> --- a/drivers/thermal/samsung/exynos_tmu.c
>>>> +++ b/drivers/thermal/samsung/exynos_tmu.c
>>>> @@ -147,7 +147,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
>>>>  	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
>>>>  	struct exynos_tmu_platform_data *pdata = data->pdata;
>>>>  	const struct exynos_tmu_registers *reg = pdata->registers;
>>>> -	unsigned int status, trim_info = 0, con;
>>>> +	unsigned int status, trim_info = 0, con, ctrl;
>>>>  	unsigned int rising_threshold = 0, falling_threshold = 0;
>>>>  	int ret = 0, threshold_code, i, trigger_levs = 0;
>>>>  
>>>> @@ -164,8 +164,25 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
>>>>  		}
>>>>  	}
>>>>  
>>>> -	if (TMU_SUPPORTS(pdata, TRIM_RELOAD))
>>>> -		__raw_writel(1, data->base + reg->triminfo_ctrl);
>>>> +	if (TMU_SUPPORTS(pdata, TRIM_RELOAD)) {
>>>> +		if (reg->triminfo_ctrl_count > MAX_TRIMINFO_CTRL_REG) {
>>>
>>> Please remove this check and MAX_TRIMINFO_CTRL_REG define.
>>>
>>> We do not want such runtime checks for development time errors.
>>
>> OK, I'll remove it.
>>
>>>
>>>> +			ret = -EINVAL;
>>>> +			goto out;
>>>> +		}
>>>> +
>>>> +		for (i = 0; i < reg->triminfo_ctrl_count; i++) {
>>>> +			if (pdata->triminfo_reload[i]) {
>>>> +				ctrl = readl(data->base +
>>>> +						reg->triminfo_ctrl[i]);
>>>> +				ctrl &= ~(reg->triminfo_reload_mask <<
>>>> +						reg->triminfo_reload_shift);
>>>> +				ctrl |= pdata->triminfo_reload[i] <<
>>>> +						reg->triminfo_reload_shift;
>>>
>>> triminfo_reload_shift and triminfo_reload_mask variables have always
>>> the same values when this code is run so there is no need for them.
>>
>> I don't understand. Do you mean that timinfo_reload_{shift/mask} variable is un-needed?
> 
> Yes.
> 
>> If you possible, I need more detailed comment.
> 
> Currently triminfo_reload_shift is always "0" and triminfo_reload_mask
> is "1" so there is no need to add an abstraction for different SoCs
> (it should be added only when there is a real need for it).
> 
> Please just rewrite this code as:
> 
> 			if (pdata->triminfo_reload[i]) {
> 				ctrl = readl(data->base +
> 						reg->triminfo_ctrl[i]);
> 				ctrl |= pdata->triminfo_reload[i];
> 				__raw_writel(ctrl, data->base +
> 						reg->triminfo_ctrl[i]);
> 			}
> 
> Then you can remove unused triminfo_reload_shift and
> EXYNOS_TRIMINFO_RELOAD_SHIFT.
> 
> Please also include my patch (https://lkml.org/lkml/2014/8/20/481) in
> your patch series (or at least mark it in the cover letter that my
> patch should be merged before your patch #2/4).

OK. thanks for your comment.

Best Regards,
Chanwoo Choi
