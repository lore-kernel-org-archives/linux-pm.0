From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v6] power: new trace event to print device suspend and
 resume time
Date: Fri, 19 Jul 2013 14:36:43 -0400
Message-ID: <1374259003.3356.21.camel@gandalf.local.home>
References: <1374258440-7152-1-git-send-email-shuah.kh@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:5280 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752882Ab3GSSgr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jul 2013 14:36:47 -0400
In-Reply-To: <1374258440-7152-1-git-send-email-shuah.kh@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shuah Khan <shuah.kh@samsung.com>
Cc: len.brown@intel.com, pavel@ucw.cz, rjw@sisk.pl, gregkh@linuxfoundation.org, fweisbec@gmail.com, mingo@redhat.com, paul.gortmaker@windriver.com, joe@perches.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, shuahkhan@gmail.com

On Fri, 2013-07-19 at 12:27 -0600, Shuah Khan wrote:
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 5a9b656..9f098a8 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -28,6 +28,7 @@
>  #include <linux/sched.h>
>  #include <linux/async.h>
>  #include <linux/suspend.h>
> +#include <trace/events/power.h>
>  #include <linux/cpuidle.h>
>  #include "../base.h"
>  #include "power.h"
> @@ -56,6 +57,30 @@ static pm_message_t pm_transition;
>  
>  static int async_error;
>  
> +static char *pm_verb(int event)
> +{
> +	switch (event) {
> +	case PM_EVENT_SUSPEND:
> +		return "suspend";
> +	case PM_EVENT_RESUME:
> +		return "resume";
> +	case PM_EVENT_FREEZE:
> +		return "freeze";
> +	case PM_EVENT_QUIESCE:
> +		return "quiesce";
> +	case PM_EVENT_HIBERNATE:
> +		return "hibernate";
> +	case PM_EVENT_THAW:
> +		return "thaw";
> +	case PM_EVENT_RESTORE:
> +		return "restore";
> +	case PM_EVENT_RECOVER:
> +		return "recover";
> +	default:
> +		return "(unknown PM event)";
> +	}
> +}
> +
>  /**
>   * device_pm_sleep_init - Initialize system suspend-related device fields.
>   * @dev: Device object being initialized.
> @@ -172,16 +197,21 @@ static ktime_t initcall_debug_start(struct device *dev)
>  }
>  
>  static void initcall_debug_report(struct device *dev, ktime_t calltime,
> -				  int error)
> +				  int error, pm_message_t state, char *info)
>  {
> -	ktime_t delta, rettime;
> +	ktime_t rettime;
> +	s64 nsecs;
> +
> +	rettime = ktime_get();
> +	nsecs = (s64) ktime_to_ns(ktime_sub(rettime, calltime));
>  
>  	if (pm_print_times_enabled) {
> -		rettime = ktime_get();
> -		delta = ktime_sub(rettime, calltime);
>  		pr_info("call %s+ returned %d after %Ld usecs\n", dev_name(dev),
> -			error, (unsigned long long)ktime_to_ns(delta) >> 10);
> +			error, (unsigned long long)nsecs >> 10);
>  	}
> +
> +	trace_device_pm_report_time(dev, info, nsecs, pm_verb(state.event),
> +				    error);
>  }
>  



>  	}
> diff --git a/include/trace/events/power.h b/include/trace/events/power.h
> index 8e42410..5d6a208 100644
> --- a/include/trace/events/power.h
> +++ b/include/trace/events/power.h
> @@ -66,6 +66,43 @@ TRACE_EVENT(machine_suspend,
>  	TP_printk("state=%lu", (unsigned long)__entry->state)
>  );
>  
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
> +		char *tmp_p = dev->parent ? dev_name(dev->parent) : "none";
> +		char *tmp_i = pm_ops ? pm_ops : "none ";
> +
> +		__assign_str(device, dev_name(dev));
> +		__assign_str(driver, dev_driver_string(dev));
> +		__assign_str(parent, tmp_p);
> +		__assign_str(pm_ops, tmp_i);
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

For the tracepoint logic: Reviewed-by: Steven Rostedt
<rostedt@goodmis.org>

-- Steve


