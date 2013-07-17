From: Shuah Khan <shuah.kh@samsung.com>
Subject: Re: [PATCH v2] power: new trace event to print device suspend and
 resume time
Date: Wed, 17 Jul 2013 17:06:33 +0000
Message-ID: <B8EFE96D1287C24090BAD9D858E15E6173CB98@sisaex02sj>
References: <1374076659-3444-1-git-send-email-shuah.kh@samsung.com>
 <1374078866.6458.150.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w2.samsung.com ([211.189.100.14]:26344 "EHLO
	usmailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755796Ab3GQRGf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jul 2013 13:06:35 -0400
Content-language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "len.brown@intel.com" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "rjw@sisk.pl" <rjw@sisk.pl>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "fweisbec@gmail.com" <fweisbec@gmail.com>, "mingo@redhat.com" <mingo@redhat.com>, "paul.gortmaker@windriver.com" <paul.gortmaker@windriver.com>, "joe@perches.com" <joe@perches.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "shuahkhan@gmail.com" <shuahkhan@gmail.com>, Shuah Khan <shuah.kh@samsung.com>

On 07/17/2013 10:35 AM, Steven Rostedt wrote:
> On Wed, 2013-07-17 at 09:57 -0600, Shuah Khan wrote:
>
>> +TRACE_EVENT(device_pm_report_time,
>> +
>> +	TP_PROTO(const char *device, const char *driver, const char *parent,
>> +		 const char *pm_ops, ktime_t ops_time, char *pm_event_str,
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
>> +		__entry->ops_time = ktime_to_ns(ops_time) >> 10;
>
> You may want to just record the ops_time, and do the conversion in the
> TP_printk(). This is the fast path, and any calculations done here just
> increases the overhead of the trace point.
>
> -- Steve

Thanks for the review and pointing the overhead out. Will fix that.

-- Shuah

-- 
Shuah Khan, Linux Kernel Developer - Open Source Group Samsung Research 
America (Silicon Valley) shuah.kh@samsung.com | (970) 672-0658
