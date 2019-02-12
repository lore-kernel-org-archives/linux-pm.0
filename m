From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH v2 1/2] drivers: devfreq: change devfreq workqueue
 mechanism
Date: Tue, 12 Feb 2019 12:20:42 +0100
Message-ID: <01644c1c-a419-9864-3b34-0837a114b799@partner.samsung.com>
References: <1549899005-7760-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190211153035eucas1p12ecdd3289a20ce9fb28588ba20869c60@eucas1p1.samsung.com>
        <1549899005-7760-2-git-send-email-l.luba@partner.samsung.com>
        <20190211214252.GR117604@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190211214252.GR117604@google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, b.zolnierkie@samsung.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, tkjos@google.com, joel@joelfernandes.org, chris.diamand@arm.com
List-Id: linux-pm@vger.kernel.org

Hi Matthias,

On 2/11/19 10:42 PM, Matthias Kaehlcke wrote:
> Hi Lukasz,
> 
> On Mon, Feb 11, 2019 at 04:30:04PM +0100, Lukasz Luba wrote:
>> There is no need for creating another workqueue in the system,
>> the existing one should meet the requirements.
>> This patch removes devfreq's custom workqueue and uses system one.
>> It switches from queue_delayed_work() to schedule_delayed_work().
>> It also does not wake up the system when it enters suspend (this
>> functionality stays the same).
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   drivers/devfreq/devfreq.c | 25 ++++++-------------------
>>   1 file changed, 6 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 0ae3de7..882e717 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -31,13 +31,6 @@
>>   
>>   static struct class *devfreq_class;
>>   
>> -/*
>> - * devfreq core provides delayed work based load monitoring helper
>> - * functions. Governors can use these or can implement their own
>> - * monitoring mechanism.
>> - */
>> -static struct workqueue_struct *devfreq_wq;
>> -
>>   /* The list of all device-devfreq governors */
>>   static LIST_HEAD(devfreq_governor_list);
>>   /* The list of all device-devfreq */
>> @@ -391,8 +384,8 @@ static void devfreq_monitor(struct work_struct *work)
>>   	if (err)
>>   		dev_err(&devfreq->dev, "dvfs failed with (%d) error\n", err);
>>   
>> -	queue_delayed_work(devfreq_wq, &devfreq->work,
>> -				msecs_to_jiffies(devfreq->profile->polling_ms));
>> +	schedule_delayed_work(&devfreq->work,
>> +			      msecs_to_jiffies(devfreq->profile->polling_ms));
>>   	mutex_unlock(&devfreq->lock);
>>   }
>>   
>> @@ -409,7 +402,7 @@ void devfreq_monitor_start(struct devfreq *devfreq)
>>   {
>>   	INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
>>   	if (devfreq->profile->polling_ms)
>> -		queue_delayed_work(devfreq_wq, &devfreq->work,
>> +		schedule_delayed_work(&devfreq->work,
>>   			msecs_to_jiffies(devfreq->profile->polling_ms));
>>   }
>>   EXPORT_SYMBOL(devfreq_monitor_start);
>> @@ -473,7 +466,7 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
>>   
>>   	if (!delayed_work_pending(&devfreq->work) &&
>>   			devfreq->profile->polling_ms)
>> -		queue_delayed_work(devfreq_wq, &devfreq->work,
>> +		schedule_delayed_work(&devfreq->work,
>>   			msecs_to_jiffies(devfreq->profile->polling_ms));
>>   
>>   	devfreq->last_stat_updated = jiffies;
>> @@ -516,7 +509,7 @@ void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
>>   
>>   	/* if current delay is zero, start polling with new delay */
>>   	if (!cur_delay) {
>> -		queue_delayed_work(devfreq_wq, &devfreq->work,
>> +		schedule_delayed_work(&devfreq->work,
>>   			msecs_to_jiffies(devfreq->profile->polling_ms));
>>   		goto out;
>>   	}
>> @@ -527,7 +520,7 @@ void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
>>   		cancel_delayed_work_sync(&devfreq->work);
>>   		mutex_lock(&devfreq->lock);
>>   		if (!devfreq->stop_polling)
>> -			queue_delayed_work(devfreq_wq, &devfreq->work,
>> +			schedule_delayed_work(&devfreq->work,
>>   			      msecs_to_jiffies(devfreq->profile->polling_ms));
>>   	}
>>   out:
>> @@ -1430,12 +1423,6 @@ static int __init devfreq_init(void)
>>   		return PTR_ERR(devfreq_class);
>>   	}
>>   
>> -	devfreq_wq = create_freezable_workqueue("devfreq_wq");
>> -	if (!devfreq_wq) {
>> -		class_destroy(devfreq_class);
>> -		pr_err("%s: couldn't create workqueue\n", __FILE__);
>> -		return -ENOMEM;
>> -	}
>>   	devfreq_class->dev_groups = devfreq_groups;
>>   
>>   	return 0;
> 
> As commented on v1, the change from a custom to a system workqueue
> seems reasonable to me. However this patch also changes from a
> freezable workqueue to a non-freezable one. C&P of my comments on v1:
> 
> ``WQ_FREEZABLE``
>      A freezable wq participates in the freeze phase of the system
>      suspend operations.  Work items on the wq are drained and no
>      new work item starts execution until thawed.
> 
> I'm not entirely sure what the impact of this is.
> 
> I imagine suspend is potentially quicker because the wq isn't drained,
> but could works that execute during the suspend phase be a problem?
The devfreq supports suspend from v4.20-rc6, which picks OPP for a
device based on its DT 'opp-suspend'. For the devices which do not
choose the suspend OPP it is possible to enter that state with any
frequency. Queuing work for calling governor during suspend which
calculates the device's frequency for the next period is IMO not needed,
The 'next period' is actually suspend and is not related to
'predicted' load by the governor.

You are right, the suspend will be faster.

Regards,
Lukasz
> 
> Cheers
> 
> Matthias
> 
> 
