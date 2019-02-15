From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH 2/2] drivers: devfreq: add tracing for scheduling work
Date: Fri, 15 Feb 2019 12:47:23 +0100
Message-ID: <07d46246-dfb2-2001-c1b6-b6a54df562df@partner.samsung.com>
References: <1550170676-14173-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190214185811eucas1p1e2f44d59495296fbfed42f28a2c897a0@eucas1p1.samsung.com>
        <1550170676-14173-3-git-send-email-l.luba@partner.samsung.com>
        <20190214140725.307d493c@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190214140725.307d493c@gandalf.local.home>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, b.zolnierkie@samsung.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, mka@chromium.org, mingo@redhat.com
List-Id: linux-pm@vger.kernel.org

Hi Steven,

On 2/14/19 8:07 PM, Steven Rostedt wrote:
> On Thu, 14 Feb 2019 19:57:56 +0100
> Lukasz Luba <l.luba@partner.samsung.com> wrote:
> 
>> This patch add basic tracing of the devfreq workqueue and delayed work.
>> It aims to capture changes of the polling intervals and device state.
>>
>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   drivers/devfreq/devfreq.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 0ae3de7..c9714fd 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -29,6 +29,9 @@
>>   #include <linux/of.h>
>>   #include "governor.h"
>>   
>> +#define CREATE_TRACE_POINTS
>> +#include <trace/events/devfreq.h>
>> +
>>   static struct class *devfreq_class;
>>   
>>   /*
>> @@ -394,6 +397,11 @@ static void devfreq_monitor(struct work_struct *work)
>>   	queue_delayed_work(devfreq_wq, &devfreq->work,
>>   				msecs_to_jiffies(devfreq->profile->polling_ms));
>>   	mutex_unlock(&devfreq->lock);
>> +
>> +	trace_devfreq_monitor(dev_name(&devfreq->dev), devfreq->previous_freq,
>> +			      devfreq->profile->polling_ms,
>> +			      devfreq->last_status.busy_time,
>> +			      devfreq->last_status.total_time);
> 
> I would pass just devfreq into the tracepoint (it will be less work by
> gcc in this code path), and do all this work in the TP__fast_assign()
> 
> The string can still handle this with:
> 
> 		__string(dev_name, dev_name(&devfreq->dev))
> 
> And assigned:
> 
> 		__assign_str(dev_name, dev_name(&devfreq->dev))
> 
> But the rest of fast assign should be:
> 
> 	TP_fast_assign(
> 		__entry->freq = devfreq->previous_freq;
> 		__entry->busy_time = devfreq->last_status.busy_time;
> 		__entry->total_time = devfreq->last_status.total_time;
> 		__entry->polling_ms = devfreq->profile->polling_ms;
> 		__assign_str(dev_name, dev_name(&deqfreq->dev));
> 	}
I agree, it makes sense. Let me test this approach and then send v3
patches. Thank you for the review.

Regards,
Lukasz
> 
> -- Steve
> 
>>   }
>>   
>>   /**
> 
> 
> 
