From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH v3 6/7] trace: events: add devfreq trace event file
Date: Wed, 13 Feb 2019 15:37:14 +0100
Message-ID: <b55633bc-827a-6420-d641-b34bc1a785be@partner.samsung.com>
References: <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190212222437eucas1p198db6fca1f1ba3056d93c57327dd48ed@eucas1p1.samsung.com>
        <1550010238-24002-7-git-send-email-l.luba@partner.samsung.com>
        <20190213085623.660e19da@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190213085623.660e19da@gandalf.local.home>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, b.zolnierkie@samsung.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, tkjos@google.com, joel@joelfernandes.org, chris.diamand@arm.com, mka@chromium.org, mingo@redhat.com
List-Id: linux-pm@vger.kernel.org

Hi Steven,

On 2/13/19 2:56 PM, Steven Rostedt wrote:
> On Tue, 12 Feb 2019 23:23:57 +0100
> Lukasz Luba <l.luba@partner.samsung.com> wrote:
> 
>> The patch adds a new file for with trace events for devfreq
>> framework. They are used for performance analysis of the framework.
>> It also contains updates in MAINTAINERS file adding new entry for
>> devfreq maintainers.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   MAINTAINERS                    |  1 +
>>   include/trace/events/devfreq.h | 39 +++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 40 insertions(+)
>>   create mode 100644 include/trace/events/devfreq.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 9919840..c042fda 100644
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
>> index 0000000..fec9304
>> --- /dev/null
>> +++ b/include/trace/events/devfreq.h
>> @@ -0,0 +1,39 @@
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
>> +	TP_PROTO(const char *dev_name, unsigned long freq,
>> +		 unsigned int polling_ms, unsigned long busy_time,
>> +		 unsigned long total_time),
>> +
>> +	TP_ARGS(dev_name, freq, polling_ms, busy_time, total_time),
>> +
>> +	TP_STRUCT__entry(
>> +		__string(dev_name, dev_name)
> 
> I would also put the string at the end. Strings are stored as a dynamic
> array in the event, where the position of __string() holds a 32 bit
> number. The 16 MSBs is the length of the string and the 16 LSBs is the
> offset into the trace event (after the TP_STRUCT__entry).
That's a nice engineering. Thank you for sharing this knowledge.
> 
> That means on a 64 bit machine, there's a chance that this struct will
> have a 4 byte "hole" between the __string() meta data and the freq
> field.
I will put the string at the end.

Regards,
Lukasz
> 
> -- Steve
> 
>> +		__field(unsigned long, freq)
>> +		__field(unsigned int, polling_ms)
>> +		__field(unsigned int, load)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__assign_str(dev_name, dev_name);
>> +		__entry->freq = freq;
>> +		__entry->polling_ms = polling_ms;
>> +		__entry->load = (100 * busy_time) / total_time;
>> +	),
>> +
>> +	TP_printk("dev_name=%s freq=%lu polling_ms=%u load=%u",
>> +		__get_str(dev_name), __entry->freq, __entry->polling_ms,
>> +		__entry->load)
>> +);
>> +#endif /* _TRACE_DEVFREQ_H */
>> +
>> +/* This part must be outside protection */
>> +#include <trace/define_trace.h>
> 
> 
> 
