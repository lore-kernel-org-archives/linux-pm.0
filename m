From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] power: new trace event to print device suspend and
 resume time
Date: Wed, 17 Jul 2013 12:34:26 -0400
Message-ID: <1374078866.6458.150.camel@gandalf.local.home>
References: <1374076659-3444-1-git-send-email-shuah.kh@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:11521 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755537Ab3GQQec (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jul 2013 12:34:32 -0400
In-Reply-To: <1374076659-3444-1-git-send-email-shuah.kh@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shuah Khan <shuah.kh@samsung.com>
Cc: len.brown@intel.com, pavel@ucw.cz, rjw@sisk.pl, gregkh@linuxfoundation.org, fweisbec@gmail.com, mingo@redhat.com, paul.gortmaker@windriver.com, joe@perches.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, shuahkhan@gmail.com

On Wed, 2013-07-17 at 09:57 -0600, Shuah Khan wrote:

> +TRACE_EVENT(device_pm_report_time,
> +
> +	TP_PROTO(const char *device, const char *driver, const char *parent,
> +		 const char *pm_ops, ktime_t ops_time, char *pm_event_str,
> +		 int error),
> +
> +	TP_ARGS(device, driver, parent, pm_ops, ops_time, pm_event_str, error),
> +
> +	TP_STRUCT__entry(
> +		__string(device, device)
> +		__string(driver, driver)
> +		__string(parent, parent)
> +		__string(pm_ops, pm_ops)
> +		__string(pm_event_str, pm_event_str)
> +		__field(s64, ops_time)
> +		__field(int, error)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(device, device);
> +		__assign_str(driver, driver);
> +		__assign_str(parent, parent);
> +		__assign_str(pm_ops, pm_ops);
> +		__assign_str(pm_event_str, pm_event_str);
> +		__entry->ops_time = ktime_to_ns(ops_time) >> 10;

You may want to just record the ops_time, and do the conversion in the
TP_printk(). This is the fast path, and any calculations done here just
increases the overhead of the trace point.

-- Steve

> +		__entry->error = error;
> +	),
> +
> +	TP_printk("%s %s parent=%s state=%s ops=%s usecs=%lld err=%d\n",
> +		__get_str(driver), __get_str(device), __get_str(parent),
> +		__get_str(pm_event_str), __get_str(pm_ops),
> +		__entry->ops_time, __entry->error)
> +);
> +
>  DECLARE_EVENT_CLASS(wakeup_source,
>  
>  	TP_PROTO(const char *name, unsigned int state),


