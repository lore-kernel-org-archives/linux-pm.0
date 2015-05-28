From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: Re: [PATCH] PM / sleep: cancel the synchronous restriction of pm-trace
Date: Thu, 28 May 2015 22:43:53 +0800
Message-ID: <556729A9.7010105@linux.intel.com>
References: <554A297C.2040305@linux.intel.com> <3154303.fma7bByNVc@vostro.rjw.lan> <555C4AC5.4080901@linux.intel.com> <7277571.Mlj5enddWV@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:1878 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752285AbbE1On5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 28 May 2015 10:43:57 -0400
In-Reply-To: <7277571.Mlj5enddWV@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: len.brown@intel.com, pavel@ucw.cz, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>



On 2015/5/21 9:16, Rafael J. Wysocki wrote:
> On Wednesday, May 20, 2015 04:50:13 PM Fu, Zhonghui wrote:
>> On 2015/5/16 8:45, Rafael J. Wysocki wrote:
>>> On Wednesday, May 06, 2015 10:47:24 PM Fu, Zhonghui wrote:
>>>> Some system-hang occur only when multiple device PM methods
>>>> are running asynchronously. So should cancel the synchronization
>>>> of pm-trace, and make it suitable for asynchronous PM environment.
>>>>
>>>> Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
>>>> ---
>>>>  drivers/base/power/main.c |   53 +++++++++++++++++++++-----------------------
>>>>  include/linux/pm-trace.h  |   24 ++++++++++++--------
>>>>  kernel/power/main.c       |    2 +
>>>>  3 files changed, 41 insertions(+), 38 deletions(-)
>>>>
>>>> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
>>>> index 3d874ec..40daf48 100644
>>>> --- a/drivers/base/power/main.c
>>>> +++ b/drivers/base/power/main.c
>>>> @@ -476,9 +476,6 @@ static int device_resume_noirq(struct device *dev, pm_message_t state, bool asyn
>>>>  	char *info = NULL;
>>>>  	int error = 0;
>>>>  
>>>> -	TRACE_DEVICE(dev);
>>>> -	TRACE_RESUME(0);
>>>> -
>>>>  	if (dev->power.syscore || dev->power.direct_complete)
>>>>  		goto Out;
>>>>  
>>>> @@ -506,19 +503,21 @@ static int device_resume_noirq(struct device *dev, pm_message_t state, bool asyn
>>>>  		callback = pm_noirq_op(dev->driver->pm, state);
>>>>  	}
>>>>  
>>>> +	TRACE_DEVICE_START(dev);
>>>> +	TRACE_RESUME(0);
>>>> +
>>>>  	error = dpm_run_callback(callback, dev, state, info);
>>>>  	dev->power.is_noirq_suspended = false;
>>>>  
>>>> +	TRACE_DEVICE_END();
>>>>   Out:
>>>>  	complete_all(&dev->power.completion);
>>>> -	TRACE_RESUME(error);
>>>>  	return error;
>>>>  }
>>>>  
>>>>  static bool is_async(struct device *dev)
>>>>  {
>>>> -	return dev->power.async_suspend && pm_async_enabled
>>>> -		&& !pm_trace_is_enabled();
>>>> +	return dev->power.async_suspend && pm_async_enabled;
>>>>  }
>>>>  
>>>>  static void async_resume_noirq(void *data, async_cookie_t cookie)
>>>> @@ -605,9 +604,6 @@ static int device_resume_early(struct device *dev, pm_message_t state, bool asyn
>>>>  	char *info = NULL;
>>>>  	int error = 0;
>>>>  
>>>> -	TRACE_DEVICE(dev);
>>>> -	TRACE_RESUME(0);
>>>> -
>>>>  	if (dev->power.syscore || dev->power.direct_complete)
>>>>  		goto Out;
>>>>  
>>>> @@ -635,12 +631,14 @@ static int device_resume_early(struct device *dev, pm_message_t state, bool asyn
>>>>  		callback = pm_late_early_op(dev->driver->pm, state);
>>>>  	}
>>>>  
>>>> +	TRACE_DEVICE_START(dev);
>>>> +	TRACE_RESUME(0);
>>>> +
>>>>  	error = dpm_run_callback(callback, dev, state, info);
>>>>  	dev->power.is_late_suspended = false;
>>>>  
>>>> +	TRACE_DEVICE_END();
>>>>   Out:
>>>> -	TRACE_RESUME(error);
>>>> -
>>>>  	pm_runtime_enable(dev);
>>>>  	complete_all(&dev->power.completion);
>>>>  	return error;
>>>> @@ -734,9 +732,6 @@ static int device_resume(struct device *dev, pm_message_t state, bool async)
>>>>  	int error = 0;
>>>>  	DECLARE_DPM_WATCHDOG_ON_STACK(wd);
>>>>  
>>>> -	TRACE_DEVICE(dev);
>>>> -	TRACE_RESUME(0);
>>>> -
>>>>  	if (dev->power.syscore)
>>>>  		goto Complete;
>>>>  
>>>> @@ -801,9 +796,13 @@ static int device_resume(struct device *dev, pm_message_t state, bool async)
>>>>  	}
>>>>  
>>>>   End:
>>>> +	TRACE_DEVICE_START(dev);
>>>> +	TRACE_RESUME(0);
>>>> +
>>>>  	error = dpm_run_callback(callback, dev, state, info);
>>>>  	dev->power.is_suspended = false;
>>>>  
>>>> +	TRACE_DEVICE_END();
>>>>   Unlock:
>>>>  	device_unlock(dev);
>>>>  	dpm_watchdog_clear(&wd);
>>>> @@ -811,8 +810,6 @@ static int device_resume(struct device *dev, pm_message_t state, bool async)
>>>>   Complete:
>>>>  	complete_all(&dev->power.completion);
>>>>  
>>>> -	TRACE_RESUME(error);
>>>> -
>>>>  	return error;
>>>>  }
>>>>  
>>>> @@ -1017,9 +1014,6 @@ static int __device_suspend_noirq(struct device *dev, pm_message_t state, bool a
>>>>  	char *info = NULL;
>>>>  	int error = 0;
>>>>  
>>>> -	TRACE_DEVICE(dev);
>>>> -	TRACE_SUSPEND(0);
>>>> -
>>>>  	if (async_error)
>>>>  		goto Complete;
>>>>  
>>>> @@ -1052,15 +1046,18 @@ static int __device_suspend_noirq(struct device *dev, pm_message_t state, bool a
>>>>  		callback = pm_noirq_op(dev->driver->pm, state);
>>>>  	}
>>>>  
>>>> +	TRACE_DEVICE_START(dev);
>>>> +	TRACE_SUSPEND(0);
>>>> +
>>>>  	error = dpm_run_callback(callback, dev, state, info);
>>>>  	if (!error)
>>>>  		dev->power.is_noirq_suspended = true;
>>>>  	else
>>>>  		async_error = error;
>>>>  
>>>> +	TRACE_DEVICE_END();
>>>>  Complete:
>>>>  	complete_all(&dev->power.completion);
>>>> -	TRACE_SUSPEND(error);
>>>>  	return error;
>>>>  }
>>>>  
>>>> @@ -1161,9 +1158,6 @@ static int __device_suspend_late(struct device *dev, pm_message_t state, bool as
>>>>  	char *info = NULL;
>>>>  	int error = 0;
>>>>  
>>>> -	TRACE_DEVICE(dev);
>>>> -	TRACE_SUSPEND(0);
>>>> -
>>>>  	__pm_runtime_disable(dev, false);
>>>>  
>>>>  	if (async_error)
>>>> @@ -1198,14 +1192,17 @@ static int __device_suspend_late(struct device *dev, pm_message_t state, bool as
>>>>  		callback = pm_late_early_op(dev->driver->pm, state);
>>>>  	}
>>>>  
>>>> +	TRACE_DEVICE_START(dev);
>>>> +	TRACE_SUSPEND(0);
>>>> +
>>>>  	error = dpm_run_callback(callback, dev, state, info);
>>>>  	if (!error)
>>>>  		dev->power.is_late_suspended = true;
>>>>  	else
>>>>  		async_error = error;
>>>>  
>>>> +	TRACE_DEVICE_END();
>>>>  Complete:
>>>> -	TRACE_SUSPEND(error);
>>>>  	complete_all(&dev->power.completion);
>>>>  	return error;
>>>>  }
>>>> @@ -1346,9 +1343,6 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
>>>>  	int error = 0;
>>>>  	DECLARE_DPM_WATCHDOG_ON_STACK(wd);
>>>>  
>>>> -	TRACE_DEVICE(dev);
>>>> -	TRACE_SUSPEND(0);
>>>> -
>>>>  	dpm_wait_for_children(dev, async);
>>>>  
>>>>  	if (async_error)
>>>> @@ -1428,8 +1422,12 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
>>>>  		callback = pm_op(dev->driver->pm, state);
>>>>  	}
>>>>  
>>>> +	TRACE_DEVICE_START(dev);
>>>> +	TRACE_SUSPEND(0);
>>>> +
>>>>  	error = dpm_run_callback(callback, dev, state, info);
>>>>  
>>>> +	TRACE_DEVICE_END();
>>>>   End:
>>>>  	if (!error) {
>>>>  		struct device *parent = dev->parent;
>>>> @@ -1455,7 +1453,6 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
>>>>  	if (error)
>>>>  		async_error = error;
>>>>  
>>>> -	TRACE_SUSPEND(error);
>>>>  	return error;
>>>>  }
>>>>  
>>>> diff --git a/include/linux/pm-trace.h b/include/linux/pm-trace.h
>>>> index ecbde7a..aa480b1 100644
>>>> --- a/include/linux/pm-trace.h
>>>> +++ b/include/linux/pm-trace.h
>>>> @@ -6,29 +6,33 @@
>>>>  #include <linux/types.h>
>>>>  
>>>>  extern int pm_trace_enabled;
>>>> -
>>>> -static inline int pm_trace_is_enabled(void)
>>>> -{
>>>> -       return pm_trace_enabled;
>>>> -}
>>>> +extern struct mutex pt_mutex;
>>>>  
>>>>  struct device;
>>>>  extern void set_trace_device(struct device *);
>>>>  extern void generate_pm_trace(const void *tracedata, unsigned int user);
>>>>  extern int show_trace_dev_match(char *buf, size_t size);
>>>>  
>>>> -#define TRACE_DEVICE(dev) do { \
>>>> +#define TRACE_DEVICE_START(dev) do { \
>>>>  	if (pm_trace_enabled) \
>>>> +		mutex_lock(&pt_mutex); \
>>>>  		set_trace_device(dev); \
>>>>  	} while(0)
>>>>  
>>>> +#define TRACE_DEVICE_END() \
>>>> +do { \
>>>> +	if (pm_trace_enabled) { \
>>>> +		mutex_unlock(&pt_mutex); \
>>>> +	} \
>>>> +} while (0)
>>>> +
>>> Won't this serialize the whole thing again?
>> Yes, this mutex lock will ultimately serialize all PM operations. But, all device's PM operations are asynchronous each other at first. So, the PM operation order of all devices will vary in multiple suspend/resume. This can be similar to real to an extreme, and helpful to debugging.
> I see.  You're saying that callbacks will be serialized, but if they originally
> would be asynchronous with respect to each other (they may run in parallel IOW),
> their respective ordering may vary between suspend-resume cycles.
>
> The class of bugs you can catch this way is quite limited and the change is
> rather intrusive, so I'm with Pavel on that.
Sorry for late reply.

Although the improvement to PM-trace is limited, I still think it is helpful for debugging some special suspend/resume bugs.


Thanks,
Zhonghui
>
>

