From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] devfreq: rk3399_dmc: Fix duplicated opp table on
 reload.
Date: Tue, 19 Jun 2018 13:18:56 +0900
Message-ID: <5B288430.2040600@samsung.com>
References: <20180615151217.29872-1-enric.balletbo@collabora.com>
        <CAGTfZH16O6u_3QJ2u1eecUnGptSBf1ho47RPefOTmrw+Syxr0w@mail.gmail.com>
        <CGME20180618091029epcas3p498708535c8f8df019bf3785a199d58b4@epcas3p4.samsung.com>
        <CAFqH_51ptafw-Z_8-FqtxbTH9LU560cHoM5TFiF01ZwG_jW3VQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAFqH_51ptafw-Z_8-FqtxbTH9LU560cHoM5TFiF01ZwG_jW3VQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo Serra <eballetbo@gmail.com>, cwchoi00@gmail.com
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-kernel <linux-kernel@vger.kernel.org>, kernel@collabora.com, Kyungmin Park <kyungmin.park@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Enric,

On 2018년 06월 18일 18:10, Enric Balletbo Serra wrote:
> Hi Chanwoo,
> 
> Missatge de Chanwoo Choi <cwchoi00@gmail.com> del dia dg., 17 de juny
> 2018 a les 5:23:
>>
>> Hi Enric,
>>
>> 2018-06-16 0:12 GMT+09:00 Enric Balletbo i Serra <enric.balletbo@collabora.com>:
>>> The opp table is not removed when the driver is unloaded neither when
>>> there is an error within probe, so if the driver is reloaded the opp
>>> core shows the following warning:
>>>
>>>   rk3399-dmc-freq dmc: _opp_add: duplicate OPPs detected. Existing: freq:
>>>                200000000, volt: 900000, enabled: 1. New: freq: 200000000,
>>>                volt: 900000, enabled: 1
>>>   rk3399-dmc-freq dmc: _opp_add: duplicate OPPs detected. Existing: freq:
>>>                400000000, volt: 900000, enabled: 1. New: freq: 400000000,
>>>                volt: 900000, enabled: 1
>>>   rk3399-dmc-freq dmc: _opp_add: duplicate OPPs detected. Existing: freq:
>>>                666000000, volt: 900000, enabled: 1. New: freq: 666000000,
>>>                volt: 900000, enabled: 1
>>>   rk3399-dmc-freq dmc: _opp_add: duplicate OPPs detected. Existing: freq:
>>>                800000000, volt: 900000, enabled: 1. New: freq: 800000000,
>>>                volt: 900000, enabled: 1
>>>   rk3399-dmc-freq dmc: _opp_add: duplicate OPPs detected. Existing: freq:
>>>                928000000, volt: 900000, enabled: 1. New: freq: 928000000,
>>>                volt: 900000, enabled: 1
>>>
>>> This patch fixes the error path in the probe function and adds a .remove
>>> function to properly cleanup the opp table on unloading.
>>>
>>> Fixes: 5a893e31a636c (PM / devfreq: rockchip: add devfreq driver for rk3399 dmc)
>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>> ---
>>>
>>>  drivers/devfreq/rk3399_dmc.c | 31 +++++++++++++++++++++++++++----
>>>  1 file changed, 27 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
>>> index d5c03e5abe13..e795ad2b3f6b 100644
>>> --- a/drivers/devfreq/rk3399_dmc.c
>>> +++ b/drivers/devfreq/rk3399_dmc.c
>>> @@ -375,8 +375,10 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
>>>         data->rate = clk_get_rate(data->dmc_clk);
>>>
>>>         opp = devfreq_recommended_opp(dev, &data->rate, 0);
>>> -       if (IS_ERR(opp))
>>> -               return PTR_ERR(opp);
>>> +       if (IS_ERR(opp)) {
>>> +               ret = PTR_ERR(opp);
>>> +               goto err_free_opp;
>>> +       }
>>>
>>>         data->rate = dev_pm_opp_get_freq(opp);
>>>         data->volt = dev_pm_opp_get_voltage(opp);
>>> @@ -388,13 +390,33 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
>>>                                            &rk3399_devfreq_dmc_profile,
>>>                                            DEVFREQ_GOV_SIMPLE_ONDEMAND,
>>>                                            &data->ondemand_data);
>>> -       if (IS_ERR(data->devfreq))
>>> -               return PTR_ERR(data->devfreq);
>>> +       if (IS_ERR(data->devfreq)) {
>>> +               ret = PTR_ERR(data->devfreq);
>>> +               goto err_free_opp;
>>> +       }
>>> +
>>>         devm_devfreq_register_opp_notifier(dev, data->devfreq);
>>>
>>>         data->dev = dev;
>>>         platform_set_drvdata(pdev, data);
>>>
>>> +       return 0;
>>
>> It looks strange. Because rk3399_dmcfreq_probe() already include
>> 'return 0' when success.
>> What is the base commit of this patch?
>>
> 
> Sorry, I am not sure I understand your question, If I am not answering
> below could you rephrase?

When I check the rk3399_dmcfreq_probe()[1], as I commented,
rk3399_dmcfreq_probe() already 'return 0' after platform_set_drvdata().
You can check it on link[1].
[1] https://elixir.bootlin.com/linux/v4.18-rc1/source/drivers/devfreq/rk3399_dmc.c#L443

But, this patch add new '+       return 0;' line again in rk3399_dmcfreq_probe().
So, just I asked what is base commit of this patch.

> 
> So, once the opp table is added we need an error path to free it if an
> error occurs later. When the probe returns 0, we need to free the opp
> table when we remove the module.
> 
>> [snip]
>>
>> Anyway, if probe fail, device driver have to remove registered OPP table.
>> Looks good to me.
>>
>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>>
> 
> Thanks,
>  Enric
> 
>> --
>> Best Regards,
>> Chanwoo Choi
>> Samsung Electronics
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
