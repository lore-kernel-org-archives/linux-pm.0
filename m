From: Shuah Khan <shuah.kh@samsung.com>
Subject: Re: [PATCH v5] power: new trace event to print device suspend and
 resume time
Date: Fri, 19 Jul 2013 18:29:53 +0000
Message-ID: <B8EFE96D1287C24090BAD9D858E15E61743340@sisaex01sj>
References: <1374187352-3283-1-git-send-email-shuah.kh@samsung.com>
 <1374188013.3356.7.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w2.samsung.com ([211.189.100.14]:45241 "EHLO
	usmailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753576Ab3GSS34 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jul 2013 14:29:56 -0400
Content-language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "len.brown@intel.com" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "rjw@sisk.pl" <rjw@sisk.pl>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "fweisbec@gmail.com" <fweisbec@gmail.com>, "mingo@redhat.com" <mingo@redhat.com>, "paul.gortmaker@windriver.com" <paul.gortmaker@windriver.com>, "joe@perches.com" <joe@perches.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "shuahkhan@gmail.com" <shuahkhan@gmail.com>, Shuah Khan <shuah.kh@samsung.com>

On 07/18/2013 04:53 PM, Steven Rostedt wrote:
> On Thu, 2013-07-18 at 16:42 -0600, Shuah Khan wrote:
>
>> +TRACE_EVENT(device_pm_report_time,
>> +
>> +	TP_PROTO(struct device *dev, const char *pm_ops, s64 ops_time,
>> +		 char *pm_event_str, int error),
>> +
>> +	TP_ARGS(dev, pm_ops, ops_time, pm_event_str, error),
>> +
>> +	TP_STRUCT__entry(
>> +		__string(device, dev_name(dev))
>> +		__string(driver, dev_driver_string(dev))
>> +		__string(parent, dev->parent ? dev_name(dev->parent) : "none")
>> +		__string(pm_ops, pm_ops ? pm_ops : "none ")
>> +		__string(pm_event_str, pm_event_str)
>> +		__field(s64, ops_time)
>> +		__field(int, error)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__assign_str(device, dev_name(dev));
>> +		__assign_str(driver, dev_driver_string(dev));
>> +		__assign_str(parent,
>> +				dev->parent ? dev_name(dev->parent) : "none");
>
> Have you tried using the temp variables? These macros expand to be
> called multiple times.
>
> -- Steve

Steve,

Tried with temp variables. Patch is on its way with temp variables. I 
generated .s with and without temp variables and didn't see any 
difference. Should I be seeing a difference, if so what am I missing?

In any case, you have the patch v6 with temp variables.

-- Shuah

Shuah Khan, Linux Kernel Developer - Open Source Group Samsung Research 
America (Silicon Valley) shuah.kh@samsung.com | (970) 672-0658
