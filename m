From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v2] PM / sleep: prohibit devices probing during
 suspend/hibernation
Date: Fri, 6 Nov 2015 11:58:40 +0200
Message-ID: <563C79D0.7020602@ti.com>
References: <1445288064-25299-1-git-send-email-grygorii.strashko@ti.com>
 <20151105221903.GA4919@amd> <3237315.NCBdGinISd@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3237315.NCBdGinISd@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>
Cc: stern@rowland.harvard.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 11/06/2015 02:13 AM, Rafael J. Wysocki wrote:
> On Thursday, November 05, 2015 11:19:03 PM Pavel Machek wrote:
>> On Mon 2015-10-19 23:54:24, Grygorii Strashko wrote:
>>> It is unsafe [1] if probing of devices will happen during suspend or
>>> hibernation and system behavior will be unpredictable in this case
>>> (for example: after successful probe the device potentially has a different
>>>   set of PM callbacks than before [2]).
>>> So, let's prohibit device's probing in dpm_prepare() and defer their
>>> probes instead. The normal behavior will be restored in dpm_complete().
>>>
>>> This patch introduces new DD core APIs:
>>>   device_defer_all_probes_enable()
>>>     It will disable probing of devices and defer their probes.
>>>   device_defer_all_probes_disable()
>>>     It will restore normal behavior and trigger re-probing of deferred
>>>     devices.
>>>
>>> [1] https://lkml.org/lkml/2015/9/11/554
>>> [2] https://lkml.org/lkml/2015/9/15/1039
>>> Cc: Alan Stern <stern@rowland.harvard.edu>
>>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>>> Cc: Thierry Reding <thierry.reding@gmail.com>
>>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>>> ---
>>> Changes in v2:
>>> - DD core API device_defer_all_probes(bool enable) split on two
>>>    void device_defer_all_probes_enable(void);
>>>    void device_defer_all_probes_disable(void);
>>> - more comments added
>>>
>>> Link on v1:
>>> - https://lkml.org/lkml/2015/10/8/681
>>>
>>>   drivers/base/base.h       |  2 ++
>>>   drivers/base/dd.c         | 48 ++++++++++++++++++++++++++++++++++++++++++++++-
>>>   drivers/base/power/main.c | 17 +++++++++++++++++
>>>   3 files changed, 66 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/base/base.h b/drivers/base/base.h
>>> index 1782f3a..c332b68 100644
>>> --- a/drivers/base/base.h
>>> +++ b/drivers/base/base.h
>>> @@ -131,6 +131,8 @@ extern void device_remove_groups(struct device *dev,
>>>   extern char *make_class_name(const char *name, struct kobject *kobj);
>>>
>>>   extern int devres_release_all(struct device *dev);
>>> +extern void device_defer_all_probes_enable(void);
>>> +extern void device_defer_all_probes_disable(void);
>>>
>>>   /* /sys/devices directory */
>>>   extern struct kset *devices_kset;
>>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>>> index be0eb46..b8d9e70 100644
>>> --- a/drivers/base/dd.c
>>> +++ b/drivers/base/dd.c
>>> @@ -55,6 +55,13 @@ static struct workqueue_struct *deferred_wq;
>>>   static atomic_t deferred_trigger_count = ATOMIC_INIT(0);
>>>
>>>   /*
>>> + * In some cases, like suspend to RAM or hibernation, It might be reasonable
>>> + * to prohibit probing of devices as it could be unsafe.
>>> + * Once defer_all_probes is true all drivers probes will be forcibly deferred.
>>> + */
>>> +static bool defer_all_probes;
>>> +
>>> +/*
>>>    * deferred_probe_work_func() - Retry probing devices in the active list.
>>>    */
>>>   static void deferred_probe_work_func(struct work_struct *work)
>>> @@ -172,6 +179,30 @@ static void driver_deferred_probe_trigger(void)
>>>   }
>>>
>>>   /**
>>> + * device_defer_all_probes_enable() - Enable deferring of device's probes
>>> + *
>>> + *	It will disable probing of devices and defer their probes.
>>> + */
>>> +void device_defer_all_probes_enable(void)
>>> +{
>>> +	defer_all_probes = true;
>>> +	/* sync with probes to avoid races. */
>>> +	wait_for_device_probe();
>>> +}
>>
>> device_pause_probing()?

device_stop_probing(). Right?

>>
>>> +/**
>>> + * device_defer_all_probes_disable() - Disable deferring of device's probes
>>> + *
>>> + *	It will restore normal behavior and trigger re-probing of deferred
>>> + * devices.
>>> + */

device_start_probing(). Right?

>>
>> Hmm. This is not quite a double negative... but it sounds like one.
>>
>> device_restart_probing()?
>
> I _start/_stop would be fine by me too.

Ok. So do I need rename/resend it again?
Probably, I'll need to wait for -rc1 before resending.

-- 
regards,
-grygorii
