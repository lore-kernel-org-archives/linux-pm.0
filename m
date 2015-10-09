From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 1/5] thermal: exynos: Fix unbalanced regulator disable on
 probe failure
Date: Fri, 9 Oct 2015 19:58:08 +0900
Message-ID: <56179DC0.1040003@samsung.com>
References: <1444282446-6419-1-git-send-email-k.kozlowski@samsung.com>
 <CAGOxZ52DE42YA3b5z-16H7fxs58f6Mv+AjMcaaaJEM6bftEmnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33194 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932355AbbJIK6O (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 9 Oct 2015 06:58:14 -0400
In-Reply-To: <CAGOxZ52DE42YA3b5z-16H7fxs58f6Mv+AjMcaaaJEM6bftEmnA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alim Akhtar <alim.akhtar@gmail.com>
Cc: k.kozlowski.k@gmail.com, Lukasz Majewski <l.majewski@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, stable@vger.kernel.org

W dniu 09.10.2015 o 01:45, Alim Akhtar pisze:
> Hello,
> 
> On Thu, Oct 8, 2015 at 11:04 AM, Krzysztof Kozlowski
> <k.kozlowski@samsung.com> wrote:
>> During probe if the regulator could not be enabled, the error exit path
>> would still disable it. This could lead to unbalanced counter of
>> regulator enable/disable.
>>
> Do you see a regulator unbalanced reported here during boot? You may
> want to add that to commit message.

I did not see the warning/error message about unbalanced disable. It
would happen in certain condition only - no other enables of regulator
and count going below 0.

I would have to simulate this error to get the warning message. I don't
think it is worth the effort.

Best regards,
Krzysztof

> 
>> The patch moves code for getting and enabling the regulator from
>> exynos_map_dt_data() to probe function because it is really not a part
>> of getting Device Tree properties.
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> Fixes: 5f09a5cbd14a ("thermal: exynos: Disable the regulator on probe failure")
>> Cc: <stable@vger.kernel.org>
>> ---
>>  drivers/thermal/samsung/exynos_tmu.c | 34 +++++++++++++++++-----------------
>>  1 file changed, 17 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
>> index 0bae8cc6c23a..23f4320f8ef7 100644
>> --- a/drivers/thermal/samsung/exynos_tmu.c
>> +++ b/drivers/thermal/samsung/exynos_tmu.c
>> @@ -1168,27 +1168,10 @@ static int exynos_map_dt_data(struct platform_device *pdev)
>>         struct exynos_tmu_data *data = platform_get_drvdata(pdev);
>>         struct exynos_tmu_platform_data *pdata;
>>         struct resource res;
>> -       int ret;
>>
>>         if (!data || !pdev->dev.of_node)
>>                 return -ENODEV;
>>
>> -       /*
>> -        * Try enabling the regulator if found
>> -        * TODO: Add regulator as an SOC feature, so that regulator enable
>> -        * is a compulsory call.
>> -        */
>> -       data->regulator = devm_regulator_get(&pdev->dev, "vtmu");
>> -       if (!IS_ERR(data->regulator)) {
>> -               ret = regulator_enable(data->regulator);
>> -               if (ret) {
>> -                       dev_err(&pdev->dev, "failed to enable vtmu\n");
>> -                       return ret;
>> -               }
>> -       } else {
>> -               dev_info(&pdev->dev, "Regulator node (vtmu) not found\n");
>> -       }
>> -
>>         data->id = of_alias_get_id(pdev->dev.of_node, "tmuctrl");
>>         if (data->id < 0)
>>                 data->id = 0;
>> @@ -1312,6 +1295,23 @@ static int exynos_tmu_probe(struct platform_device *pdev)
>>                 pr_err("thermal: tz: %p ERROR\n", data->tzd);
>>                 return PTR_ERR(data->tzd);
>>         }
>> +
>> +       /*
>> +        * Try enabling the regulator if found
>> +        * TODO: Add regulator as an SOC feature, so that regulator enable
>> +        * is a compulsory call.
>> +        */
>> +       data->regulator = devm_regulator_get(&pdev->dev, "vtmu");
>> +       if (!IS_ERR(data->regulator)) {
>> +               ret = regulator_enable(data->regulator);
>> +               if (ret) {
>> +                       dev_err(&pdev->dev, "failed to enable vtmu\n");
>> +                       return ret;
>> +               }
>> +       } else {
>> +               dev_info(&pdev->dev, "Regulator node (vtmu) not found\n");
>> +       }
>> +
>>         ret = exynos_map_dt_data(pdev);
>>         if (ret)
>>                 goto err_sensor;
>> --
>> 1.9.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 
> 

