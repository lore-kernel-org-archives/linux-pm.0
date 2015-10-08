From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 2/2] PM / sleep: prohibit devices probing during
 suspend/hibernation
Date: Thu, 8 Oct 2015 13:54:39 -0500
Message-ID: <5616BBEF.90303@ti.com>
References: <Pine.LNX.4.44L0.1510081314400.1502-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33313 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755115AbbJHSyt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 8 Oct 2015 14:54:49 -0400
In-Reply-To: <Pine.LNX.4.44L0.1510081314400.1502-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>

On 10/08/2015 12:24 PM, Alan Stern wrote:
> On Thu, 8 Oct 2015, Grygorii Strashko wrote:
> 
>> It is unsafe [1] if probing of devices will happen during suspend or
>> hibernation and system behavior will be unpredictable in this case.
>> So, lets prohibit device's probing in dpm_prepare() and defer their
> 
> s/lets/let's/, and same for the comment in the code.
> 
>> probing instead. The normal behavior will be restored in
>> dpm_complete().
> 
> 
>> @@ -172,6 +179,26 @@ static void driver_deferred_probe_trigger(void)
>>   }
>>   
>>   /**
>> + * device_defer_all_probes() - Enable/disable probing of devices
>> + * @enable:  Enable/disable probing of devices
>> + *
>> + * if @enable = true
>> + *	It will disable probing of devices and defer their probes.
>> + * otherwise
>> + *	It will restore normal behavior and trigger re-probing of deferred
>> + *	devices.
>> + */
>> +void device_defer_all_probes(bool enable)
>> +{
>> +	defer_all_probes = enable;
>> +	if (enable)
>> +		/* sync with probes to avoid any races. */
>> +		wait_for_device_probe();

^ pls, pay attention on above code line

>> +	else
>> +		driver_deferred_probe_trigger();
>> +}
> 
> Some people might prefer to see two separate functions, an enable
> routine and a disable routine.  I don't much care.

May be. Should I change it?

> 
>> @@ -277,9 +304,15 @@ static DECLARE_WAIT_QUEUE_HEAD(probe_waitqueue);
>>   
>>   static int really_probe(struct device *dev, struct device_driver *drv)
>>   {
>> -	int ret = 0;
>> +	int ret = -EPROBE_DEFER;
>>   	int local_trigger_count = atomic_read(&deferred_trigger_count);
>>   
>> +	if (defer_all_probes) {
>> +		dev_dbg(dev, "Driver %s force probe deferral\n", drv->name);
>> +		driver_deferred_probe_add(dev);
>> +		return ret;
>> +	}
> 
> In theory there's a race here.  If one CPU sets defer_all_probes, the
> new value might not be perceived by another CPU until a little while
> later.  Is there an easy way to insure that this race won't cause any
> problems?

Yes. this question was raised by Rafael also [1].

> 
> Or do we already know that when this mechanism gets used, the system is
> already running on a single CPU?  I forget when that happens.

No. nonboot cpus are still  on.

> 
>> @@ -1624,6 +1627,16 @@ int dpm_prepare(pm_message_t state)
>>   	trace_suspend_resume(TPS("dpm_prepare"), state.event, true);
>>   	might_sleep();
>>   
>> +	/* Give a chance for the known devices to complete their probing. */
>> +	wait_for_device_probe();

^ this sync point is important at least at boot time + hibernation restore

>> +	/*
>> +	 * It is unsafe if probing of devices will happen during suspend or
>> +	 * hibernation and system behavior will be unpredictable in this case.
>> +	 * So, lets prohibit device's probing here and defer their probes
>> +	 * instead. The normal behavior will be restored in dpm_complete().
>> +	 */
>> +	device_defer_all_probes(true);
> 
> Don't you want to call these two functions in the opposite order?
> First prevent new probes from occurring, then wait for any probes that
> are already in progress?  The way you have it here, a new probe could
> start between these two lines.

No. Initially I did it as below:
     wait_for_device_probe(); <- wait for active probes
     device_defer_all_probes(true); <- prohibit probing
     wait_for_device_probe(); <- sync again to avoid races

then I decided to move second wait_for_device_probe() call inside
device_defer_all_probes() because it's always required.

[1] https://lkml.org/lkml/2015/9/17/857

-- 
regards,
-grygorii
