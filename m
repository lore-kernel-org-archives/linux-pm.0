From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH v2 1/2] trace: events: add devfreq trace event file
Date: Mon, 18 Feb 2019 18:57:37 +0100
Message-ID: <bd9bfc80-0589-ea1e-1115-ca7fc9225990@partner.samsung.com>
References: <1550235913-5189-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190215130555eucas1p219217e3f1d0901f61be78870df0ecf6d@eucas1p2.samsung.com>
        <1550235913-5189-2-git-send-email-l.luba@partner.samsung.com>
        <bfe5eced-712e-774a-a5d9-3649e276e848@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bfe5eced-712e-774a-a5d9-3649e276e848@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: b.zolnierkie@samsung.com, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, mka@chromium.org, rostedt@goodmis.org, mingo@redhat.com
List-Id: linux-pm@vger.kernel.org

Hi Chanwoo,

On 2/18/19 6:40 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> On 19. 2. 15. 오후 10:05, Lukasz Luba wrote:
>> The patch adds a new file for with trace events for devfreq
>> framework. They are used for performance analysis of the framework.
>> It also contains updates in MAINTAINERS file adding new entry for
>> devfreq maintainers.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   MAINTAINERS                    |  1 +
>>   include/trace/events/devfreq.h | 40 ++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 41 insertions(+)
>>   create mode 100644 include/trace/events/devfreq.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 41ce5f4..9c44076 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -4447,6 +4447,7 @@ S:	Maintained
>>   F:	drivers/devfreq/
>>   F:	include/linux/devfreq.h
>>   F:	Documentation/devicetree/bindings/devfreq/
>> +F:	include/trace/events/devfreq.h
>>   
>>   DEVICE FREQUENCY EVENT (DEVFREQ-EVENT)
>>   M:	Chanwoo Choi <cw00.choi@samsung.com>
>> diff --git a/include/trace/events/devfreq.h b/include/trace/events/devfreq.h
>> new file mode 100644
>> index 0000000..ce83dba
>> --- /dev/null
>> +++ b/include/trace/events/devfreq.h
>> @@ -0,0 +1,40 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#undef TRACE_SYSTEM
>> +#define TRACE_SYSTEM devfreq
>> +
>> +#if !defined(_TRACE_DEVFREQ_H) || defined(TRACE_HEADER_MULTI_READ)
>> +#define _TRACE_DEVFREQ_H
>> +
>> +#include <linux/devfreq.h>
>> +#include <linux/tracepoint.h>
>> +
>> +TRACE_EVENT(devfreq_monitor,
>> +	TP_PROTO(struct devfreq *devfreq),
>> +
>> +	TP_ARGS(devfreq),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(unsigned long, freq)
>> +		__field(unsigned long, busy_time)
>> +		__field(unsigned long, total_time)
>> +		__field(unsigned int, polling_ms)
>> +		__string(dev_name, dev_name(&devfreq->dev))
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->freq = devfreq->previous_freq;
>> +		__entry->busy_time = devfreq->last_status.busy_time;
>> +		__entry->total_time = devfreq->last_status.total_time;
>> +		__entry->polling_ms = devfreq->profile->polling_ms;
>> +		__assign_str(dev_name, dev_name(&devfreq->dev));
>> +	),
>> +
>> +	TP_printk("dev_name=%s freq=%lu polling_ms=%u load=%lu",
>> +		__get_str(dev_name), __entry->freq, __entry->polling_ms,
>> +		__entry->total_time == 0 ? 100 :
> 
> I case of __entry->total_time is zero,
> why do you show '100' instead of '0'(zero)?
> I think that it might make the some confusion for user.
> 
> If it show the '100' in case of "__entry->total_time is zero",
> it cannot distinguish between the real 100% utilization
> and "total_time is zero".
Good point, I will change it.

Regards,
Lukasz
> 
>> +			(100 * __entry->busy_time) / __entry->total_time)
>> +);
>> +#endif /* _TRACE_DEVFREQ_H */
>> +
>> +/* This part must be outside protection */
>> +#include <trace/define_trace.h>
>>
> 
> 
