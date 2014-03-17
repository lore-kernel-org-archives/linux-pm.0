From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCHv2 4/8] devfreq: exynos4: Fix bug of resource leak and code
 clean on probe()
Date: Mon, 17 Mar 2014 14:05:44 +0900
Message-ID: <532682A8.2030300@samsung.com>
References: <1394698649-20996-1-git-send-email-cw00.choi@samsung.com>
 <1394698649-20996-5-git-send-email-cw00.choi@samsung.com>
 <53234132.8080202@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-reply-to: <53234132.8080202@samsung.com>
Sender: linux-doc-owner@vger.kernel.org
To: Tomasz Figa <t.figa@samsung.com>
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rafael.j.wysocki@intel.com, nm@ti.com, b.zolnierkie@samsaung.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Tomasz,

On 03/15/2014 02:49 AM, Tomasz Figa wrote:
> Hi Chanwoo,
> 
> On 13.03.2014 09:17, Chanwoo Choi wrote:
>> This patch fix bug about resource leak when happening probe fail and code clean
>> to add debug message.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>   drivers/devfreq/exynos/exynos4_bus.c | 32 ++++++++++++++++++++++++++------
>>   1 file changed, 26 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/devfreq/exynos/exynos4_bus.c b/drivers/devfreq/exynos/exynos4_bus.c
>> index a2a3a47..152a3e9 100644
>> --- a/drivers/devfreq/exynos/exynos4_bus.c
>> +++ b/drivers/devfreq/exynos/exynos4_bus.c
>> @@ -1152,8 +1152,11 @@ static int exynos4_busfreq_probe(struct platform_device *pdev)
>>           dev_err(dev, "Cannot determine the device id %d\n", data->type);
>>           err = -EINVAL;
>>       }
>> -    if (err)
>> +    if (err) {
>> +        dev_err(dev, "Cannot initialize busfreq table %d\n",
>> +                 data->type);
>>           return err;
>> +    }
>>
>>       rcu_read_lock();
>>       opp = dev_pm_opp_find_freq_floor(dev,
>> @@ -1176,7 +1179,7 @@ static int exynos4_busfreq_probe(struct platform_device *pdev)
>>       if (IS_ERR(data->devfreq)) {
>>           dev_err(dev, "Failed to add devfreq device\n");
>>           err = PTR_ERR(data->devfreq);
>> -        goto err_opp;
>> +        goto err_devfreq;
>>       }
>>
>>       /*
>> @@ -1185,18 +1188,35 @@ static int exynos4_busfreq_probe(struct platform_device *pdev)
>>        */
>>       busfreq_mon_reset(data);
>>
>> -    devfreq_register_opp_notifier(dev, data->devfreq);
>> +    /* Register opp_notifier for Exynos4 busfreq */
>> +    err = devfreq_register_opp_notifier(dev, data->devfreq);
>> +    if (err < 0) {
>> +        dev_err(dev, "Failed to register opp notifier\n");
>> +        goto err_notifier_opp;
>> +    }
>>
>> +    /* Register pm_notifier for Exynos4 busfreq */
>>       err = register_pm_notifier(&data->pm_notifier);
>>       if (err) {
>>           dev_err(dev, "Failed to setup pm notifier\n");
>> -        devfreq_remove_device(data->devfreq);
>> -        return err;
>> +        goto err_notifier_pm;
>>       }
>>
>>       return 0;
>>
>> -err_opp:
>> +err_notifier_pm:
>> +    devfreq_unregister_opp_notifier(dev, data->devfreq);
>> +err_notifier_opp:
>> +    /*
>> +     * The devfreq_remove_device() would execute finally devfreq->profile
>> +     * ->exit(). To avoid duplicate resource free operation, return directly
>> +     * before executing resource free below 'err_devfreq' goto statement.
>> +     */
> 
> I'm not quite sure about this. I believe that in this case devfreq->profile->exit() would be exynos4_bus_exit() and all it does is devfreq_unregister_opp_notifier(dev, data->devfreq), so all remaining resources (regulators, clocks, etc.) would get leaked.

This patch execute following sequence to probe exynos4_busfreq.c:

1. Parse dt node to get resource(regulator/clock/memory address).
2. Enable regulator/clock and map memory.
3. Add devfreq device using devfreq_add_device().
   The devfreq_add_device() return devfreq instance(data->devfreq).
4. Register opp_notifier using devfreq instance(data->devfreq) which is created in sequence #3.

Case 1,
If an error happens in sequence #3 for registering devfreq_add_device(),

this case can't execute devfreq->profile->exit() to free resource
because this case has failed to register devfreq->profile to devfreq_list.

So, must goto 'err_devfreq' statement to free resource(regulator/clock/memory).


Case 2,
If an error happens in sequence #4 for registering opp_notifier,

In contrast
this case can execute devfreq->profile->exit() to free resource.
But, After executed devfreq->profile->exit(),
should not execute 'err_devfreq' statement to free resource.
In case, will operate twice of resource.

If my explanation is wrong, please reply your comment.

> 
> I believe the correct thing to do would be to remove the .exit() callback from exynos4_devfreq_profile struct and handle all the clean-up here in error path.
> 

Best Regards,
Chanwoo Choi





