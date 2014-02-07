From: Naveen Krishna Ch <naveenkrishna.ch-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] thermal: exynos: handle gate clock for misplaced TRIMINFO register
Date: Fri, 7 Feb 2014 15:03:18 +0530
Message-ID: <CAHfPSqCftzo8ud=K9Lv4Y_q9+wW+23ZPnbTxXpwsBWOXHXLucg@mail.gmail.com>
References: <1383828154-428-1-git-send-email-ch.naveen@samsung.com> <1388642820.3739.80.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1388642820.3739.80.camel@rzhang1-mobl4>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eduardo.valentin-l0cyMroinI0@public.gmane.org, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amit.daniel-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, cpgs-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hello All,

On 2 January 2014 11:37, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> On Thu, 2013-11-07 at 18:12 +0530, Naveen Krishna Chatradhi wrote:
>> On Exynos5420 the TMU(4) for GPU has a seperate clock enable bit from
>> the other TMU channels(0 ~ 3). Hence, accessing TRIMINFO for base_second
>> should be acompanied by enabling the respective clock.
>>
>> This patch which allow for a "clk_sec" clock to be specified in the
>> device-tree which will be ungated when accessing the TRIMINFO register.
>>
>> Signed-off-by: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>
> Eduardo,
>
> what do you think of this patch?
>
> thanks,
> rui
>> ---
>>  drivers/thermal/samsung/exynos_tmu.c |   24 +++++++++++++++++++++++-
>>  1 file changed, 23 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
>> index b54825a..33edd1a 100644
>> --- a/drivers/thermal/samsung/exynos_tmu.c
>> +++ b/drivers/thermal/samsung/exynos_tmu.c
>> @@ -47,6 +47,7 @@
>>   * @irq_work: pointer to the irq work structure.
>>   * @lock: lock to implement synchronization.
>>   * @clk: pointer to the clock structure.
>> + * @clk_sec: pointer to the clock structure for accessing the base_second.
>>   * @temp_error1: fused value of the first point trim.
>>   * @temp_error2: fused value of the second point trim.
>>   * @regulator: pointer to the TMU regulator structure.
>> @@ -61,7 +62,7 @@ struct exynos_tmu_data {
>>       enum soc_type soc;
>>       struct work_struct irq_work;
>>       struct mutex lock;
>> -     struct clk *clk;
>> +     struct clk *clk, *clk_sec;
>>       u8 temp_error1, temp_error2;
>>       struct regulator *regulator;
>>       struct thermal_sensor_conf *reg_conf;
>> @@ -152,6 +153,8 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
>>
>>       mutex_lock(&data->lock);
>>       clk_enable(data->clk);
>> +     if (!IS_ERR(data->clk_sec))
>> +             clk_enable(data->clk_sec);
>>
>>       if (TMU_SUPPORTS(pdata, READY_STATUS)) {
>>               status = readb(data->base + reg->tmu_status);
>> @@ -306,6 +309,8 @@ skip_calib_data:
>>  out:
>>       clk_disable(data->clk);
>>       mutex_unlock(&data->lock);
>> +     if (!IS_ERR(data->clk_sec))
>> +             clk_disable(data->clk_sec);
>>
>>       return ret;
>>  }
>> @@ -457,12 +462,16 @@ static void exynos_tmu_work(struct work_struct *work)
>>       const struct exynos_tmu_registers *reg = pdata->registers;
>>       unsigned int val_irq, val_type;
>>
>> +     if (!IS_ERR(data->clk_sec))
>> +             clk_enable(data->clk_sec);
>>       /* Find which sensor generated this interrupt */
>>       if (reg->tmu_irqstatus) {
>>               val_type = readl(data->base_second + reg->tmu_irqstatus);
>>               if (!((val_type >> data->id) & 0x1))
>>                       goto out;
>>       }
>> +     if (!IS_ERR(data->clk_sec))
>> +             clk_disable(data->clk_sec);
>>
>>       exynos_report_trigger(data->reg_conf);
>>       mutex_lock(&data->lock);
>> @@ -641,6 +650,15 @@ static int exynos_tmu_probe(struct platform_device *pdev)
>>       if (ret)
>>               return ret;
>>
>> +     data->clk_sec = devm_clk_get(&pdev->dev, "tmu_apbif_sec");
>> +     if (!IS_ERR(data->clk_sec)) {
>> +             ret = clk_prepare(data->clk_sec);
>> +             if (ret) {
>> +                     dev_err(&pdev->dev, "Failed to get clock\n");
>> +                     return  PTR_ERR(data->clk_sec);
>> +             }
>> +     }
>> +
>>       if (pdata->type == SOC_ARCH_EXYNOS4210 ||
>>           pdata->type == SOC_ARCH_EXYNOS4412 ||
>>           pdata->type == SOC_ARCH_EXYNOS5250 ||
>> @@ -713,6 +731,8 @@ static int exynos_tmu_probe(struct platform_device *pdev)
>>       return 0;
>>  err_clk:
>>       clk_unprepare(data->clk);
>> +     if (!IS_ERR(data->clk_sec))
>> +             clk_unprepare(data->clk_sec);
>>       return ret;
>>  }
>>
>> @@ -725,6 +745,8 @@ static int exynos_tmu_remove(struct platform_device *pdev)
>>       exynos_unregister_thermal(data->reg_conf);
>>
>>       clk_unprepare(data->clk);
>> +     if (!IS_ERR(data->clk_sec))
>> +             clk_unprepare(data->clk_sec);
>>
>>       if (!IS_ERR(data->regulator))
>>               regulator_disable(data->regulator);
>
>
Ping.



-- 
Shine bright,
(: Nav :)
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
