From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 5/5] devfreq: exynos5: Use devm_devfreq_* function using
 device resource management
Date: Wed, 30 Apr 2014 09:58:40 +0900
Message-ID: <53604AC0.6020306@samsung.com>
References: <1398416894-6782-1-git-send-email-cw00.choi@samsung.com>
 <1398416894-6782-6-git-send-email-cw00.choi@samsung.com>
 <CAK9yfHyP63QaaBwc4vkkqU4g3+B2DpqeC_11E5+LevWXED0Qxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CAK9yfHyP63QaaBwc4vkkqU4g3+B2DpqeC_11E5+LevWXED0Qxg@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, rafael.j.wysocki@intel.com, Nishanth Menon <nm@ti.com>, Jiri Kosina <jkosina@suse.cz>, labbe.montjoie@gmail.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Manish Badarkhe <badarkhe.manish@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Sachin,

On 04/30/2014 01:54 AM, Sachin Kamat wrote:
> Hi Chanwoo,
> 
> On 25 April 2014 14:38, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>> This patch uses devm_devfreq_add_device()/devm_devfreq_register_opp_notifier()
>> to control automatically the resource of devfreq.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Cc: Kukjin Kim <kgene.kim@samsung.com>
>> Cc: Sachin Kamat <sachin.kamat@linaro.org>
>> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> Cc: Manish Badarkhe <badarkhe.manish@gmail.com>
>> Cc: Abhilash Kesavan <a.kesavan@samsung.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-samsung-soc@vger.kernel.org
>> ---
>>  drivers/devfreq/exynos/exynos5_bus.c | 23 ++++++++---------------
>>  1 file changed, 8 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/devfreq/exynos/exynos5_bus.c b/drivers/devfreq/exynos/exynos5_bus.c
>> index ab54a69..1f622f8 100644
>> --- a/drivers/devfreq/exynos/exynos5_bus.c
>> +++ b/drivers/devfreq/exynos/exynos5_bus.c
>> @@ -165,11 +165,6 @@ static int exynos5_int_get_dev_status(struct device *dev,
>>  }
>>  static void exynos5_int_exit(struct device *dev)
>>  {
>> -       struct platform_device *pdev = container_of(dev, struct platform_device,
>> -                                                   dev);
>> -       struct busfreq_data_int *data = platform_get_drvdata(pdev);
>> -
>> -       devfreq_unregister_opp_notifier(dev, data->devfreq);
>>  }
> 
> Do you need an empty function?

exynos5_init_exit() function would be removed because this function is not necessary.

> 
>>
>>  static struct devfreq_dev_profile exynos5_devfreq_int_profile = {
>> @@ -343,30 +338,29 @@ static int exynos5_busfreq_int_probe(struct platform_device *pdev)
>>
>>         busfreq_mon_reset(ppmu_data);
>>
>> -       data->devfreq = devfreq_add_device(dev, &exynos5_devfreq_int_profile,
>> +       data->devfreq = devm_devfreq_add_device(dev, &exynos5_devfreq_int_profile,
>>                                            "simple_ondemand", NULL);
>> -
>>         if (IS_ERR(data->devfreq)) {
>>                 err = PTR_ERR(data->devfreq);
> 
> No need of err.   return PTR_ERR(data->devfreq);

OK, I'll fix it.

> 
>> -               goto err_devfreq_add;
>> +               return err;
>>         }
>>
>> -       devfreq_register_opp_notifier(dev, data->devfreq);
>> +       err = devm_devfreq_register_opp_notifier(dev, data->devfreq);
>> +       if (err < 0) {
>> +               dev_err(dev, "Failed to register opp notifier\n");
>> +               return err;
>> +       }
>>
>>         err = register_pm_notifier(&data->pm_notifier);
>>         if (err) {
>>                 dev_err(dev, "Failed to setup pm notifier\n");
>> -               goto err_devfreq_add;
>> +               return err;
>>         }
>>
>>         /* TODO: Add a new QOS class for int/mif bus */
>>         pm_qos_add_request(&data->int_req, PM_QOS_NETWORK_THROUGHPUT, -1);
>>
>>         return 0;
>> -
>> -err_devfreq_add:
>> -       devfreq_remove_device(data->devfreq);
>> -       return err;
>>  }
>>
>>  static int exynos5_busfreq_int_remove(struct platform_device *pdev)
>> @@ -375,7 +369,6 @@ static int exynos5_busfreq_int_remove(struct platform_device *pdev)
>>
>>         pm_qos_remove_request(&data->int_req);
>>         unregister_pm_notifier(&data->pm_notifier);
>> -       devfreq_remove_device(data->devfreq);
>>
>>         return 0;
>>  }
>> --
>> 1.8.0
>>
> 
> 
> 
