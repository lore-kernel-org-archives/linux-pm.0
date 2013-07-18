From: Shuah Khan <shuah.kh@samsung.com>
Subject: Re: [PATCH v3] power: new trace event to print device suspend and
 resume time
Date: Thu, 18 Jul 2013 14:00:03 +0000
Message-ID: <B8EFE96D1287C24090BAD9D858E15E6173D4A9@sisaex02sj>
References: <1374102201-2937-1-git-send-email-shuah.kh@samsung.com>
 <1374110574.6458.201.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w2.samsung.com ([211.189.100.12]:63936 "EHLO
	usmailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754988Ab3GROAG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2013 10:00:06 -0400
Content-language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "len.brown@intel.com" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "rjw@sisk.pl" <rjw@sisk.pl>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "fweisbec@gmail.com" <fweisbec@gmail.com>, "mingo@redhat.com" <mingo@redhat.com>, "paul.gortmaker@windriver.com" <paul.gortmaker@windriver.com>, "joe@perches.com" <joe@perches.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "shuahkhan@gmail.com" <shuahkhan@gmail.com>, Shuah Khan <shuah.kh@samsung.com>

On 07/17/2013 07:23 PM, Steven Rostedt wrote:
> On Wed, 2013-07-17 at 17:03 -0600, Shuah Khan wrote:
>
>> diff --git a/include/trace/events/power.h b/include/trace/events/power.h
>> index 8e42410..24afd22 100644
>> --- a/include/trace/events/power.h
>> +++ b/include/trace/events/power.h
>> @@ -66,6 +66,41 @@ TRACE_EVENT(machine_suspend,
>>   	TP_printk("state=%lu", (unsigned long)__entry->state)
>>   );
>>
>> +TRACE_EVENT(device_pm_report_time,
>> +
>> +	TP_PROTO(const char *device, const char *driver, const char *parent,
>> +		 const char *pm_ops, s64 ops_time, char *pm_event_str,
>> +		 int error),
>> +
>> +	TP_ARGS(device, driver, parent, pm_ops, ops_time, pm_event_str, error),
>> +
>> +	TP_STRUCT__entry(
>> +		__string(device, device)
>> +		__string(driver, driver)
>> +		__string(parent, parent)
>> +		__string(pm_ops, pm_ops)
>> +		__string(pm_event_str, pm_event_str)
>> +		__field(s64, ops_time)
>> +		__field(int, error)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__assign_str(device, device);
>> +		__assign_str(driver, driver);
>> +		__assign_str(parent, parent);
>> +		__assign_str(pm_ops, pm_ops);
>> +		__assign_str(pm_event_str, pm_event_str);
>> +		__entry->ops_time = ops_time;
>> +		__entry->error = error;
>> +	),
>> +
>> +	/* ops_str has an extra space at the end */
>> +	TP_printk("%s %s parent=%s state=%s ops=%snsecs=%lld err=%d",
>> +		__get_str(driver), __get_str(device), __get_str(parent),
>> +		__get_str(pm_event_str), __get_str(pm_ops),
>> +		__entry->ops_time, __entry->error)
>
>
> Don't you want to convert the ops_time on display? You can have:
>
> 	TP_printk("%s %s parent=%s state=%s ops=%snsecs=%lld err=%d",
> 		__get_str(driver), __get_str(device), __get_str(parent),
> 		__get_str(pm_event_str), __get_str(pm_ops),
> 		ktime_to_ns(__entry->ops_time), __entry->error)
>
>
> -- Steve

I decided to pass in the converted value to the tracepoint. Please see 
the drivers/base/power/main.c call to trace_device_pm_report_time()

+
+	trace_device_pm_report_time(dev_name(dev), dev_driver_string(dev),
+				dev->parent ? dev_name(dev->parent) : "none",
+				info ? info : "none ",
+				(s64) ktime_to_ns(delta), pm_verb(state.event),
+				error);

-- Shuah

Shuah Khan, Linux Kernel Developer - Open Source Group Samsung Research 
America (Silicon Valley) shuah.kh@samsung.com | (970) 672-0658
