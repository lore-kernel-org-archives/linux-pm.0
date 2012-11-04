From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH] PM / Qos: Ensure device not in PRM_SUSPENDED when pm
 qos flags request functions are invoked in the pm core.
Date: Sun, 04 Nov 2012 23:09:32 +0800
Message-ID: <5096852C.3000707@intel.com>
References: <1351843430-8023-1-git-send-email-tianyu.lan@intel.com> <1888394.d23n1PsP9K@vostro.rjw.lan> <5093F1F3.5020004@intel.com> <3462113.4oKq44aJDs@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <3462113.4oKq44aJDs@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: stern@rowland.harvard.edu, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 2012/11/3 4:11, Rafael J. Wysocki wrote:
>>>>    }
>>>> > >>   EXPORT_SYMBOL_GPL(dev_pm_qos_expose_flags);
>>>> > >>@@ -645,7 +649,9 @@ void dev_pm_qos_hide_flags(struct device *dev)
>>>> > >>   {
>>>> > >>   	if (dev->power.qos && dev->power.qos->flags_req) {
>>>> > >>   		pm_qos_sysfs_remove_flags(dev);
>>>> > >>+		pm_runtime_get_sync(dev);
>>>> > >>   		__dev_pm_qos_drop_user_request(dev, DEV_PM_QOS_FLAGS);
>>>> > >>+		pm_runtime_put(dev);
>>> > >
>>> > >I'm not sure if these two are necessary.  If we remove a request,
>>> > >then what happens worst case is that some flags will be cleared
>>> > >effectively which means fewer restrictions on the next sleep state.
>>> > >Then, it shouldn't hurt that the current sleep state is more
>>> > >restricted.
>> >
>> >But this mean the device can be put into lower power state(power off).
>> >So why not do that? that can save more power, right?
> Correct.  On the other hand, though, if the device already is in the
> deepest low-power state available, we will resume it unnecessarily this
> way.  Which may not be a big deal, however, and since we do that in other
> cases, we may as well do it here.
Yeah. This seems not very reasonable. But we can optimize this 
later.From my previous opinion, add notifier for flags and let device 
driver or bus driver to determine when the device should be resumed. 
Since you said at another email you would remove all notifiers in the pm 
qos to make some functions able to be invoked in interrupt context. I 
have a thought that check the context before call notifiers chain. If it 
was in interrupt, not call notifier chain and trigger a work queue or 
other choices to do that. If not, call the chain. Does this make sense? :)

>
> Thanks,
> Rafael


-- 
Best Regards
Tianyu Lan
linux kernel enabling team
