From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3] power: new trace event to print device suspend and
 resume time
Date: Wed, 17 Jul 2013 21:22:54 -0400
Message-ID: <1374110574.6458.201.camel@gandalf.local.home>
References: <1374102201-2937-1-git-send-email-shuah.kh@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1374102201-2937-1-git-send-email-shuah.kh@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shuah Khan <shuah.kh@samsung.com>
Cc: len.brown@intel.com, pavel@ucw.cz, rjw@sisk.pl, gregkh@linuxfoundation.org, fweisbec@gmail.com, mingo@redhat.com, paul.gortmaker@windriver.com, joe@perches.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, shuahkhan@gmail.com
List-Id: linux-pm@vger.kernel.org

On Wed, 2013-07-17 at 17:03 -0600, Shuah Khan wrote:

> diff --git a/include/trace/events/power.h b/include/trace/events/power.h
> index 8e42410..24afd22 100644
> --- a/include/trace/events/power.h
> +++ b/include/trace/events/power.h
> @@ -66,6 +66,41 @@ TRACE_EVENT(machine_suspend,
>  	TP_printk("state=%lu", (unsigned long)__entry->state)
>  );
>  
> +TRACE_EVENT(device_pm_report_time,
> +
> +	TP_PROTO(const char *device, const char *driver, const char *parent,
> +		 const char *pm_ops, s64 ops_time, char *pm_event_str,
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
> +		__entry->ops_time = ops_time;
> +		__entry->error = error;
> +	),
> +
> +	/* ops_str has an extra space at the end */
> +	TP_printk("%s %s parent=%s state=%s ops=%snsecs=%lld err=%d",
> +		__get_str(driver), __get_str(device), __get_str(parent),
> +		__get_str(pm_event_str), __get_str(pm_ops),
> +		__entry->ops_time, __entry->error)


Don't you want to convert the ops_time on display? You can have:

	TP_printk("%s %s parent=%s state=%s ops=%snsecs=%lld err=%d",
		__get_str(driver), __get_str(device), __get_str(parent),
		__get_str(pm_event_str), __get_str(pm_ops),
		ktime_to_ns(__entry->ops_time), __entry->error)


-- Steve

> +);
> +
>  DECLARE_EVENT_CLASS(wakeup_source,
>  
>  	TP_PROTO(const char *name, unsigned int state),
