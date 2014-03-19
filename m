From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCHv2 3/8] devfreq: exynos4: Add ppmu's clock control and code
 clean about regulator control
Date: Wed, 19 Mar 2014 11:44:01 +0900
Message-ID: <53290471.105@samsung.com>
References: <1394698649-20996-1-git-send-email-cw00.choi@samsung.com>
 <1394698649-20996-4-git-send-email-cw00.choi@samsung.com>
 <53233F78.8020500@samsung.com> <5326632A.8030801@samsung.com>
 <53268F48.8060704@samsung.com> <53282A60.2010301@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-reply-to: <53282A60.2010301@samsung.com>
Sender: linux-doc-owner@vger.kernel.org
To: Tomasz Figa <t.figa@samsung.com>
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rafael.j.wysocki@intel.com, nm@ti.com, b.zolnierkie@samsaung.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Tomasz,

On 03/18/2014 08:13 PM, Tomasz Figa wrote:
> Hi Chanwoo,
> 
> On 17.03.2014 06:59, Chanwoo Choi wrote:
>> Hi Tomasz,
>>
>> On 03/17/2014 11:51 AM, Chanwoo Choi wrote:
>>> Hi Tomasz,
>>>
>>> On 03/15/2014 02:42 AM, Tomasz Figa wrote:
>>>> Hi Chanwoo,
>>>>
>>>> On 13.03.2014 09:17, Chanwoo Choi wrote:
>>>>> There are not the clock controller of ppmudmc0/1. This patch control the clock
>>>>> of ppmudmc0/1 which is used for monitoring memory bus utilization.
>>>>>
>>>>> Also, this patch code clean about regulator control and free resource
>>>>> when calling exit/remove function.
>>>>>
>>>>> For example,
>>>>> busfreq@106A0000 {
>>>>>      compatible = "samsung,exynos4x12-busfreq";
>>>>>
>>>>>      /* Clock for PPMUDMC0/1 */
>>>>>      clocks = <&clock CLK_PPMUDMC0>, <&clock CLK_PPMUDMC1>;
>>>>>      clock-names = "ppmudmc0", "ppmudmc1";
>>>>>
>>>>>      /* Regulator for MIF/INT block */
>>>>>      vdd_mif-supply = <&buck1_reg>;
>>>>>      vdd_int-supply = <&buck3_reg>;
>>>>> };
>>>>>
>>>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>
>> I modify this patch according your comment as following:
>>
>> Best Regards,
>> Chanwoo Choi
>>
>>> From c8f2fbc4c1166ec02fb2ad46164bc7ed9118721b Mon Sep 17 00:00:00 2001
>> From: Chanwoo Choi <cw00.choi@samsung.com>
>> Date: Fri, 14 Mar 2014 12:05:54 +0900
>> Subject: [PATCH] devfreq: exynos4: Add ppmu's clock control and code clean
>>   about regulator control
>>
>> There are not the clock controller of ppmudmc0/1. This patch control the clock
>> of ppmudmc0/1 which is used for monitoring memory bus utilization.
>>
>> Also, this patch code clean about regulator control and free resource
>> when calling exit/remove function.
>>
>> For example,
>> busfreq@106A0000 {
>>     compatible = "samsung,exynos4x12-busfreq";
>>
>>     /* Clock for PPMUDMC0/1 */
>>     clocks = <&clock CLK_PPMUDMC0>, <&clock CLK_PPMUDMC1>;
>>     clock-names = "ppmudmc0", "ppmudmc1";
>>
>>     /* Regulator for MIF/INT block */
>>     vdd_mif-supply = <&buck1_reg>;
>>     vdd_int-supply = <&buck3_reg>;
>> };
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>   drivers/devfreq/exynos/exynos4_bus.c | 97 +++++++++++++++++++++++++++++++-----
>>   1 file changed, 84 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/devfreq/exynos/exynos4_bus.c b/drivers/devfreq/exynos/exynos4_bus.c
>> index 4c630fb..3956bcc 100644
>> --- a/drivers/devfreq/exynos/exynos4_bus.c
>> +++ b/drivers/devfreq/exynos/exynos4_bus.c
>> @@ -62,6 +62,11 @@ enum exynos_ppmu_idx {
>>       PPMU_END,
>>   };
>>
>> +static const char *exynos_ppmu_clk_name[] = {
>> +    [PPMU_DMC0]    = "ppmudmc0",
>> +    [PPMU_DMC1]    = "ppmudmc1",
>> +};
>> +
>>   #define EX4210_LV_MAX    LV_2
>>   #define EX4x12_LV_MAX    LV_4
>>   #define EX4210_LV_NUM    (LV_2 + 1)
>> @@ -86,6 +91,7 @@ struct busfreq_data {
>>       struct regulator *vdd_mif; /* Exynos4412/4212 only */
>>       struct busfreq_opp_info curr_oppinfo;
>>       struct exynos_ppmu ppmu[PPMU_END];
>> +    struct clk *clk_ppmu[PPMU_END];
>>
>>       struct notifier_block pm_notifier;
>>       struct mutex lock;
>> @@ -724,6 +730,17 @@ static void exynos4_bus_exit(struct device *dev)
>>       struct busfreq_data *data = dev_get_drvdata(dev);
>>       int i;
>>
>> +    /*
>> +     * Un-map memory map and disable regulator/clocks
>> +     * to prevent power leakage.
>> +     */
>> +    regulator_disable(data->vdd_int);
>> +    if (data->type == TYPE_BUSF_EXYNOS4x12)
>> +        regulator_disable(data->vdd_mif);
>> +
>> +    for (i = 0; i < PPMU_END; i++)
>> +        clk_disable_unprepare(data->clk_ppmu[i]);
>> +
>>       for (i = 0; i < PPMU_END; i++)
>>           iounmap(data->ppmu[i].hw_base);
>>   }
>> @@ -989,6 +1006,7 @@ static int exynos4_busfreq_parse_dt(struct busfreq_data *data)
>>   {
>>       struct device *dev = data->dev;
>>       struct device_node *np = dev->of_node;
>> +    const char **clk_name = exynos_ppmu_clk_name;
>>       int i, ret = 0;
>>
>>       if (!np) {
>> @@ -1006,8 +1024,67 @@ static int exynos4_busfreq_parse_dt(struct busfreq_data *data)
>>           }
>>       }
>>
>> +    for (i = 0; i < PPMU_END; i++) {
>> +        data->clk_ppmu[i] = devm_clk_get(dev, clk_name[i]);
>> +        if (IS_ERR(data->clk_ppmu[i])) {
>> +            dev_warn(dev, "Failed to get %s clock\n", clk_name[i]);
> 
> dev_err() since this is an error.

OK, I'll fix it.

> 
>> +            goto err_clocks;
>> +        }
>> +
>> +        ret = clk_prepare_enable(data->clk_ppmu[i]);
>> +        if (ret < 0) {
>> +            dev_warn(dev, "Failed to enable %s clock\n", clk_name[i]);
> 
> Ditto.

OK, I'll fix it.

> 
>> +            data->clk_ppmu[i] = NULL;
>> +            goto err_clocks;
>> +        }
>> +    }
>> +
>> +    /* Get regulator to control voltage of int block */
>> +    data->vdd_int = devm_regulator_get(dev, "vdd_int");
>> +    if (IS_ERR(data->vdd_int)) {
>> +        dev_err(dev, "Failed to get the regulator of vdd_int\n");
>> +        ret = PTR_ERR(data->vdd_int);
>> +        goto err_clocks;
>> +    }
>> +    ret = regulator_enable(data->vdd_int);
>> +    if (ret < 0) {
>> +        dev_err(dev, "Failed to enable regulator of vdd_int\n");
>> +        goto err_clocks;
>> +    }
>> +
>> +    switch (data->type) {
>> +    case TYPE_BUSF_EXYNOS4210:
>> +        break;
> 
> Do you need to use switch here? Wouldn't a simple if (data->type == TYPE_BUSF_EXYNOS4x12) work as well, resulting with simpler code?

OK, I'll fix it.

> 
> However I would expect this code to be completely removed, after defining DT bindings in a way allowing you to completely drop such SoC type enums. Please see my other reply for explanation of Exynos power plane DT bindings concept.

OK, I agree your suggestion about Exynos power plane DT bindings concept.

I'll apply "Exynos power plane" to exynos4 busfreq driver on next step
after defining Exynos power plane DT bindings.

> 
>> +    case TYPE_BUSF_EXYNOS4x12:
>> +        /* Get regulator to control voltage of mif blk if Exynos4x12 */
>> +        data->vdd_mif = devm_regulator_get(dev, "vdd_mif");
>> +        if (IS_ERR(data->vdd_mif)) {
>> +            dev_err(dev, "Failed to get the regulator vdd_mif\n");
>> +            ret = PTR_ERR(data->vdd_mif);
>> +            goto err_regulator;
>> +        }
>> +        ret = regulator_enable(data->vdd_mif);
>> +        if (ret < 0) {
>> +            dev_err(dev, "Failed to enable regulator of vdd_mif\n");
>> +            goto err_regulator;
>> +        }
>> +        break;
>> +    default:
>> +        dev_err(dev, "Unknown device type : %d\n", data->type);
>> +        return -EINVAL;
>> +    };
>> +
>>       return 0;
>>
>> +err_regulator:
>> +    regulator_disable(data->vdd_int);
>> +err_clocks:
>> +    for (i = 0; i < PPMU_END; i++) {
>> +        if (IS_ERR(data->clk_ppmu[i]))
>> +            continue;
>> +        else
> 
> if (!IS_ERR(...))
> 
>> +            clk_disable_unprepare(data->clk_ppmu[i]);
>> +    }
> 
> Otherwise looks good.

Thanks for your review.

Best Regards,
Chanwoo Choi





