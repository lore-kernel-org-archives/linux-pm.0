From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 2/2] PM / sleep: prohibit devices probing during
 suspend/hibernation
Date: Thu, 8 Oct 2015 14:48:15 -0500
Message-ID: <5616C87F.5070200@ti.com>
References: <Pine.LNX.4.44L0.1510081512130.1284-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40956 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755392AbbJHTs0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 8 Oct 2015 15:48:26 -0400
In-Reply-To: <Pine.LNX.4.44L0.1510081512130.1284-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>

On 10/08/2015 02:20 PM, Alan Stern wrote:
> On Thu, 8 Oct 2015, Grygorii Strashko wrote:
> 
>>>>    /**
>>>> + * device_defer_all_probes() - Enable/disable probing of devices
>>>> + * @enable:  Enable/disable probing of devices
>>>> + *
>>>> + * if @enable = true
>>>> + *	It will disable probing of devices and defer their probes.
>>>> + * otherwise
>>>> + *	It will restore normal behavior and trigger re-probing of deferred
>>>> + *	devices.
>>>> + */
>>>> +void device_defer_all_probes(bool enable)
>>>> +{
>>>> +	defer_all_probes = enable;
>>>> +	if (enable)
>>>> +		/* sync with probes to avoid any races. */
>>>> +		wait_for_device_probe();
>>
>> ^ pls, pay attention on above code line
>>
>>>> +	else
>>>> +		driver_deferred_probe_trigger();
>>>> +}
>>>
>>> Some people might prefer to see two separate functions, an enable
>>> routine and a disable routine.  I don't much care.
>>
>> May be. Should I change it?
> 
> It would then be more in line with functions like
> pm_runtime_set_{active|suspended} or pm_runtime_[dont_]use_autosuspend.

ok

> 
>>>> @@ -277,9 +304,15 @@ static DECLARE_WAIT_QUEUE_HEAD(probe_waitqueue);
>>>>    
>>>>    static int really_probe(struct device *dev, struct device_driver *drv)
>>>>    {
>>>> -	int ret = 0;
>>>> +	int ret = -EPROBE_DEFER;
>>>>    	int local_trigger_count = atomic_read(&deferred_trigger_count);
>>>>    
>>>> +	if (defer_all_probes) {

Will it be ok If I add below comment here?
		/*
		 * Value of defer_all_probes can be set only by
		 * device_defer_all_probes_enable() which, in turn, will call
		 * wait_for_device_probe() right after that to avoid any races.
		 */


>>>> +		dev_dbg(dev, "Driver %s force probe deferral\n", drv->name);
>>>> +		driver_deferred_probe_add(dev);
>>>> +		return ret;
>>>> +	}
>>>
>>> In theory there's a race here.  If one CPU sets defer_all_probes, the
>>> new value might not be perceived by another CPU until a little while
>>> later.  Is there an easy way to insure that this race won't cause any
>>> problems?
>>
>> Yes. this question was raised by Rafael also [1].
> 
> I see.  Can you add a comment explaining all of this?



-- 
regards,
-grygorii
