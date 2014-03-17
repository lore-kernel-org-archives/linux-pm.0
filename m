From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCHv2 3/8] devfreq: exynos4: Add ppmu's clock control and code
 clean about regulator control
Date: Mon, 17 Mar 2014 11:51:22 +0900
Message-ID: <5326632A.8030801@samsung.com>
References: <1394698649-20996-1-git-send-email-cw00.choi@samsung.com>
 <1394698649-20996-4-git-send-email-cw00.choi@samsung.com>
 <53233F78.8020500@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:31217 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755818AbaCQCvp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 16 Mar 2014 22:51:45 -0400
In-reply-to: <53233F78.8020500@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomasz Figa <t.figa@samsung.com>
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rafael.j.wysocki@intel.com, nm@ti.com, b.zolnierkie@samsaung.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org

Hi Tomasz,

On 03/15/2014 02:42 AM, Tomasz Figa wrote:
> Hi Chanwoo,
> 
> On 13.03.2014 09:17, Chanwoo Choi wrote:
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
>>   drivers/devfreq/exynos/exynos4_bus.c | 114 ++++++++++++++++++++++++++++++-----
>>   1 file changed, 100 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/devfreq/exynos/exynos4_bus.c b/drivers/devfreq/exynos/exynos4_bus.c
>> index 1a0effa..a2a3a47 100644
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
>> @@ -722,8 +728,26 @@ static int exynos4_bus_get_dev_status(struct device *dev,
>>   static void exynos4_bus_exit(struct device *dev)
>>   {
>>       struct busfreq_data *data = dev_get_drvdata(dev);
>> +    int i;
>> +
>> +    /*
>> +     * Un-map memory map and disable regulator/clocks
>> +     * to prevent power leakage.
>> +     */
>> +    regulator_disable(data->vdd_int);
>> +    if (data->type == TYPE_BUSF_EXYNOS4x12)
>> +        regulator_disable(data->vdd_mif);
>> +
>> +    for (i = 0; i < PPMU_END; i++) {
>> +        if (data->clk_ppmu[i])
> 
> This check is invalid. Clock pointers must be checked for validity using the IS_ERR() macro, because NULL is a valid clock pointer value indicating a dummy clock.

OK, I'll check it by using the IS_ERR() macro as following:

	if (IS_ERR(data->clk_ppmu[i]) {


> 
>> +            clk_disable_unprepare(data->clk_ppmu[i]);
>> +    }
>>
>> -    devfreq_unregister_opp_notifier(dev, data->devfreq);
>> +    for (i = 0; i < PPMU_END; i++) {
>> +        if (data->ppmu[i].hw_base)
> 
> Can this even happen? Is there a PPMU without registers?
> 
>> +            iounmap(data->ppmu[i].hw_base);
>> +
>> +    }
>>   }
>>
>>   static struct devfreq_dev_profile exynos4_devfreq_profile = {
>> @@ -987,6 +1011,7 @@ static int exynos4_busfreq_parse_dt(struct busfreq_data *data)
>>   {
>>       struct device *dev = data->dev;
>>       struct device_node *np = dev->of_node;
>> +    const char **clk_name = exynos_ppmu_clk_name;
>>       int i, ret;
>>
>>       if (!np) {
>> @@ -1005,8 +1030,70 @@ static int exynos4_busfreq_parse_dt(struct busfreq_data *data)
>>           }
>>       }
>>
>> +    /*
>> +     * Get PPMU's clocks to control them. But, if PPMU's clocks
>> +     * is default 'pass' state, this driver don't need control
>> +     * PPMU's clock.
>> +     */
>> +    for (i = 0; i < PPMU_END; i++) {
>> +        data->clk_ppmu[i] = devm_clk_get(dev, clk_name[i]);
>> +        if (IS_ERR_OR_NULL(data->clk_ppmu[i])) {
> 
> Again, this check is invalid. Only IS_ERR() is the correct way to check whether returned clock pointer is valid.

ditto.
	if (IS_ERR(data->clk_ppmu[i]) {

> 
>> +            dev_warn(dev, "Cannot get %s clock\n", clk_name[i]);
>> +            data->clk_ppmu[i] = NULL;
> 
> This assignment is wrong. To allow further checking whether the clock was found the value returned from devm_clk_get() must be retained and then IS_ERR() used in further code.
> 
> However, I believe it should be an error if a clock is not provided. The driver must make sure that PPMU clocks are ungated before trying to access them, otherwise the system might hang.

OK, I'll use IS_ERR() macro when checking / handling clock instance of 'data->clk_ppmu[i]'.
And If this driver can't get the clock of ppmu, handel error exception.

> 
>> +        }
>> +
>> +        ret = clk_prepare_enable(data->clk_ppmu[i]);
> 
> The code above allows the clock to be skipped, but this line doesn't check whether it is valid. Still, I think the clock should be always required.

OK, I'll require clock of ppmu without exception.

> 
>> +        if (ret < 0) {
>> +            dev_warn(dev, "Cannot enable %s clock\n", clk_name[i]);
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
>> +        if (data->clk_ppmu[i])
> 
> Invalid check.

Modify it as following:

	if (!IS_ERR(data->clk_ppmu[i]) {


Best Regards,
Chanwoo Choi

