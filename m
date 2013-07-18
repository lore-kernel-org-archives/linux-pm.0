From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v5] power: new trace event to print device suspend and
 resume time
Date: Thu, 18 Jul 2013 18:53:33 -0400
Message-ID: <1374188013.3356.7.camel@gandalf.local.home>
References: <1374187352-3283-1-git-send-email-shuah.kh@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:7074 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754991Ab3GRWxf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2013 18:53:35 -0400
In-Reply-To: <1374187352-3283-1-git-send-email-shuah.kh@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shuah Khan <shuah.kh@samsung.com>
Cc: len.brown@intel.com, pavel@ucw.cz, rjw@sisk.pl, gregkh@linuxfoundation.org, fweisbec@gmail.com, mingo@redhat.com, paul.gortmaker@windriver.com, joe@perches.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, shuahkhan@gmail.com

On Thu, 2013-07-18 at 16:42 -0600, Shuah Khan wrote:

> +TRACE_EVENT(device_pm_report_time,
> +
> +	TP_PROTO(struct device *dev, const char *pm_ops, s64 ops_time,
> +		 char *pm_event_str, int error),
> +
> +	TP_ARGS(dev, pm_ops, ops_time, pm_event_str, error),
> +
> +	TP_STRUCT__entry(
> +		__string(device, dev_name(dev))
> +		__string(driver, dev_driver_string(dev))
> +		__string(parent, dev->parent ? dev_name(dev->parent) : "none")
> +		__string(pm_ops, pm_ops ? pm_ops : "none ")
> +		__string(pm_event_str, pm_event_str)
> +		__field(s64, ops_time)
> +		__field(int, error)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(device, dev_name(dev));
> +		__assign_str(driver, dev_driver_string(dev));
> +		__assign_str(parent,
> +				dev->parent ? dev_name(dev->parent) : "none");

Have you tried using the temp variables? These macros expand to be
called multiple times.

-- Steve

> +		__assign_str(pm_ops, pm_ops ? pm_ops : "none ");
> +		__assign_str(pm_event_str, pm_event_str);
> +		__entry->ops_time = ops_time;
> +		__entry->error = error;
> +	),
> +
> +	/* ops_str has an extra space at the end */
> +	TP_printk("%s %s parent=%s state=%s ops=%snsecs=%lld err=%d",
> +		__get_str(driver), __get_str(device), __get_str(parent),
> +		__get_str(pm_event_str), __get_str(pm_ops),
> +		__entry->ops_time, __entry->error)
> +);
> +
>  DECLARE_EVENT_CLASS(wakeup_source,
>  
>  	TP_PROTO(const char *name, unsigned int state),


