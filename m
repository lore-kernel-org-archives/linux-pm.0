From: "dbasehore ." <dbasehore@chromium.org>
Subject: Re: [PATCH v4 2/5] clockevents: Add timed freeze
Date: Mon, 20 Jun 2016 17:12:58 -0700
Message-ID: <CAGAzgsq0DvWepF=prqXHOv8msCxVOeAcLUCNgGRPkSrV_-nRtg@mail.gmail.com>
References: <1465506139-25981-1-git-send-email-dbasehore@chromium.org>
 <1465506139-25981-3-git-send-email-dbasehore@chromium.org> <alpine.DEB.2.11.1606100001180.28031@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:33465 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932736AbcFUAOq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jun 2016 20:14:46 -0400
Received: by mail-vk0-f46.google.com with SMTP id d185so531280vkg.0
        for <linux-pm@vger.kernel.org>; Mon, 20 Jun 2016 17:13:00 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1606100001180.28031@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter Zijlstra <peterz@infradead.org>

On Thu, Jun 9, 2016 at 3:43 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Thu, 9 Jun 2016, dbasehore@chromium.org wrote:
>>
>> +/*
>> + * Clockevent device may run during freeze
>> + */
>> +# define CLOCK_EVT_FEAT_FREEZE               0x000100
>
> This is a bad name and a horrible comment. The device does not freeze. It is
> able to run during suspend.
>
> Hint: We have CLOCK_SOURCE_SUSPEND_NONSTOP which is self explanatory.
>
>>  /**
>>   * struct clock_event_device - clock event device descriptor
>>   * @event_handler:   Assigned by the framework to be called by the low
>>   *                   level handler of the event source
>>   * @set_next_event:  set next event function using a clocksource delta
>>   * @set_next_ktime:  set next event function using a direct ktime value
>> + * @event_pending:   check if the programmed event is still pending. Used
>> + *                   for freeze events when timekeeping is suspended and
>> + *                   irqs are disabled.
>>   * @next_event:              local storage for the next event in oneshot mode
>>   * @max_delta_ns:    maximum delta value in ns
>>   * @min_delta_ns:    minimum delta value in ns
>> @@ -100,7 +108,9 @@ struct clock_event_device {
>>       void                    (*event_handler)(struct clock_event_device *);
>>       int                     (*set_next_event)(unsigned long evt, struct clock_event_device *);
>>       int                     (*set_next_ktime)(ktime_t expires, struct clock_event_device *);
>> +     bool                    (*event_expired)(struct clock_event_device *);
>>       ktime_t                 next_event;
>> +     bool                    freeze_event_programmed;
>
> I really don't like that flag. Why do you need it at all?

Probably left over from when I tried doing this a different way. I'll remove it.

>
>>       u64                     max_delta_ns;
>>       u64                     min_delta_ns;
>
>> +static int clockevents_program_freeze_event(struct clock_event_device *dev,
>> +                                         ktime_t delta)
>> +{
>> +     int64_t delta_ns = ktime_to_ns(delta);
>
> Why int? Please use u64 and spare all the silly type casts you have in your
> code.
>
>> +     unsigned long long clc;
>
> What's wrong with u64?

Will change.

>
>> +     int ret;
>> +
>> +     if (delta_ns > (int64_t) dev->max_delta_ns) {
>> +             printk_deferred(KERN_WARNING
>> +                             "Freeze event time longer than max delta\n");
>> +             delta_ns = (int64_t) dev->max_delta_ns;
>
> What's the point of this? Tell the caller that it does not work and be done
> with it. -ERANGE or something like that.
>

Okay.

>> +     }
>
>> +     clockevents_tick_resume(dev);
>> +     clockevents_switch_state(dev, CLOCK_EVT_STATE_ONESHOT);
>> +     delta_ns = max_t(int64_t, delta_ns, dev->min_delta_ns);
>
> You're comparing signed and insigned. Use u64 and max()... Also you really
> should tell the caller, that providing a timeout that small is silly.
>
>> +     clc = ((unsigned long long) delta_ns * dev->mult) >> dev->shift;
>
> Sigh.
>
>> +     ret = dev->set_next_event((unsigned long) clc, dev);
>> +     if (ret < 0) {
>> +             printk_deferred(KERN_WARNING
>> +                             "Failed to program freeze event\n");
>> +             clockevents_shutdown(dev);
>> +     } else {
>> +             dev->freeze_event_programmed = true;
>
> I'm still not seing why you need that flag.
>
>> +     }
>> +
>> +     return ret;
>> +}
>> +
>> +static bool clockevents_freeze_event_expired(struct clock_event_device *dev)
>> +{
>> +     if (dev->freeze_event_programmed)
>> +             return dev->event_expired(dev);
>
> So this will oops from deep inside suspend when the clock event does not have
> the callback ....
>
>> +     return false;
>> +}
>> +
>> +static void clockevents_cleanup_freeze_event(struct clock_event_device *dev)
>> +{
>> +     if (!(dev->features & CLOCK_EVT_FEAT_FREEZE))
>> +             return;
>
> What's that check for? This is only called from the code below in a section
> which cannot be reached when the flag is not set.
>
>> +     clockevents_shutdown(dev);
>
> You can open code this line at the call site because that's all you need.
>
>> +     dev->freeze_event_programmed = false;
>> +}
>
>> +/**
>> + * timed_freeze - Enter freeze on a CPU for a timed duration
>> + * @ops:     Pointers for enter freeze and callback functions.
>> + * @data:    Pointer to pass arguments to the function pointers.
>> + * @delta:   Time to freeze for. If this amount of time passes in freeze, the
>> + *           callback in ops will be called.
>> + *
>> + * Returns the value from ops->enter_freeze or ops->callback on success, -EERROR
>> + * otherwise. If an error is encountered while setting up the clock event,
>> + * freeze with still be entered, but it will not be timed nor will the callback
>> + * function be run.
>
> That logic makes no sense at all.
>
>> +int timed_freeze(struct timed_freeze_ops *ops, void *data, ktime_t delta)
>> +{
>> +     int cpu = smp_processor_id();
>> +     struct tick_device *td = tick_get_device(cpu);
>> +     struct clock_event_device *dev;
>> +     int ret;
>> +
>> +     if (!ops || !ops->enter_freeze) {
>> +             printk_deferred(KERN_ERR
>> +                             "[%s] called with invalid ops\n", __func__);
>> +             return -EINVAL;
>> +     }
>> +
>> +     if (!td || !td->evtdev ||
>
> td is always valid, because it's a pointer to a per cpu variable.
>
>> +         !(td->evtdev->features & CLOCK_EVT_FEAT_FREEZE)) {
>> +             printk_deferred(KERN_WARNING
>> +                             "[%s] called with invalid clock event device\n",
>
> The function is not called with an invalid clock event device. There is either
> no clock event device or the device does not support this.
>
>> +                             __func__);
>> +             ret = -ENOSYS;
>> +             goto freeze_no_check;
>> +     }
>> +
>> +     dev = td->evtdev;
>> +     if (!clockevent_state_shutdown(dev)) {
>> +             printk_deferred(KERN_WARNING
>> +                             "[%s] called while clock event device in use\n",
>> +                             __func__);
>> +             ret = -EBUSY;
>> +             goto freeze_no_check;
>> +     }
>> +
>> +     ret = clockevents_program_freeze_event(dev, delta);
>> +     if (ret < 0)
>> +             goto freeze_no_check;
>> +
>> +     ret = ops->enter_freeze(data);
>> +     if (ret < 0)
>> +             goto out;
>> +
>> +     if (ops->callback && clockevents_freeze_event_expired(dev))
>> +             ret = ops->callback(data);
>
> This callback thing is just wrong here. If that fails then how is the call
> site supposed to figure out where the error came from? From your printks?
>
> The correct way to do this is:
>
> int tick_set_frozen_event(ktime_t delta)
> {
>         if (....)
>                 return -EINVAL;
>         if (....)
>                 return -ENOSYS;
>
>         return program_event(dev, delta);
> }
>
> and:
>
> int tick_clear_frozen_event()
> {
>         ret = event_expired(dev);
>         clockevents_shutdown(dev);
>         return ret;
> }
>
> So no ops, nothing nada.
>
> And at the call site you do:
>
>     ret = tick_set_frozen_event(delta);
>     if (ret)
>                 goto deal_with_ret;
>
>     ret = freeze();
>     if (ret) {
>              tick_clear_frozen_event();
>              goto deal_with_freeze_abort;
>     }
>
>     ret = tick_clear_frozen_event();
>
>     do_something_sensible(ret);
>
> That's actually understandable and debugable code.
>
> Thanks,
>
>         tglx
>
>

I'll address these in another patch to be sent out soon.
