From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] power: new trace event to print device suspend and
 resume time
Date: Tue, 16 Jul 2013 14:39:01 -0700
Message-ID: <1374010741.1949.46.camel@joe-AO722>
References: <1374009806-11823-1-git-send-email-shuah.kh@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1374009806-11823-1-git-send-email-shuah.kh@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shuah Khan <shuah.kh@samsung.com>
Cc: len.brown@intel.com, pavel@ucw.cz, rjw@sisk.pl, gregkh@linuxfoundation.org, rostedt@goodmis.org, fweisbec@gmail.com, mingo@redhat.com, paul.gortmaker@windriver.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, shuahkhan@gmail.com
List-Id: linux-pm@vger.kernel.org

On Tue, 2013-07-16 at 15:23 -0600, Shuah Khan wrote:
> A new trace event is added to pm events to print time it takes to suspend and
> resume a device. It generates trace message that includes device, driver,
> parent information in addition to the type of pm ops invoked as well as the
> pm event and error status from the pm ops. Example trace below:

> diff --git a/include/trace/events/power.h b/include/trace/events/power.h
[]
> @@ -66,6 +66,41 @@ TRACE_EVENT(machine_suspend,
>  	TP_printk("state=%lu", (unsigned long)__entry->state)
>  );
>  
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
> +		__field(unsigned long long, ops_time)

s64

> +		__field(int, error)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(device, device);
> +		__assign_str(driver, driver);
> +		__assign_str(parent, parent);
> +		__assign_str(pm_ops, pm_ops);
> +		__assign_str(pm_event_str, pm_event_str);
> +		__entry->ops_time = (unsigned long long)
> +					ktime_to_ns(ops_time) >> 10;

so no need for cast.

> +		__entry->error = error;
> +	),
> +
> +	TP_printk("%s driver(%s) parent(%s) %s %s (%llu usecs) err(%d)\n",

%lld and no newline

> +		__get_str(device), __get_str(driver), __get_str(parent),
> +		__get_str(pm_event_str), __get_str(pm_ops),
> +		__entry->ops_time, __entry->error)
> +);
> +
>  DECLARE_EVENT_CLASS(wakeup_source,
>  
>  	TP_PROTO(const char *name, unsigned int state),
