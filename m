From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH v2 2/2] drivers: devfreq: change deferred work into
 delayed
Date: Tue, 12 Feb 2019 12:03:42 +0100
Message-ID: <f87887b9-13cd-43a5-8d1f-740a90118152@partner.samsung.com>
References: <1549899005-7760-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190211153037eucas1p20b80e44795e3599dabd9c2fc0291c063@eucas1p2.samsung.com>
        <1549899005-7760-3-git-send-email-l.luba@partner.samsung.com>
        <20190211213602.GQ117604@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190211213602.GQ117604@google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, b.zolnierkie@samsung.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, tkjos@google.com, joel@joelfernandes.org, chris.diamand@arm.com
List-Id: linux-pm@vger.kernel.org

Hi Matthias,

On 2/11/19 10:36 PM, Matthias Kaehlcke wrote:
> Hi Lukasz,
> 
> On Mon, Feb 11, 2019 at 04:30:05PM +0100, Lukasz Luba wrote:
>> This patch changes deferred work to delayed work, which is now not missed
>> when timer is put on CPU that entered idle state.
>> The devfreq framework governor was not called, thus changing the device's
>> frequency did not happen.
>> Benchmarks for stressing Dynamic Memory Controller show x2 (in edge cases
>> even x5) performance boost with this patch when 'simpleondemand_governor'
>> is responsible for monitoring the device load and frequency changes.
>>
>> With this patch, the delayed work is done no mater CPUs' idle.
>> All of the drivers in devfreq which rely on periodic, guaranteed wakeup
>> intervals should benefit from it.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   drivers/devfreq/devfreq.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 882e717..c200b3c 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -400,7 +400,7 @@ static void devfreq_monitor(struct work_struct *work)
>>    */
>>   void devfreq_monitor_start(struct devfreq *devfreq)
>>   {
>> -	INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
>> +	INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);
>>   	if (devfreq->profile->polling_ms)
>>   		schedule_delayed_work(&devfreq->work,
>>   			msecs_to_jiffies(devfreq->profile->polling_ms));
> 
> I'd suggest to swap the order of the patches in this series.
> 
> Why, you may ask, if the end product is the same? This patch ([2/2])
> fixes an actual problem, while IIUC [1/2] is just an improvement, the
> fix doesn't really depend on it. If -stable wants to integrate the
> fix, they also need to pick the improvement (or resolve a conflict),
> which might not be desired.
Good point, I will reorder them.
> 
> Otherwise this looks sane to me:
> 
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> 
>
Thank you for the review.

Regards,
Lukasz
