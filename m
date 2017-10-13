From: Rajat Jain <rajatja@google.com>
Subject: Getting precise wake reason (Was "Understanding the use cases for
 calling pm_wakeup_event()")
Date: Thu, 12 Oct 2017 17:59:10 -0700
Message-ID: <CACK8Z6H3S2+Jj2T59zTtg5dj_3g==SkYWxHVvUK-fQ2dz9f8kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f172.google.com ([209.85.216.172]:47919 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753301AbdJMA7v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Oct 2017 20:59:51 -0400
Received: by mail-qt0-f172.google.com with SMTP id z50so16903386qtj.4
        for <linux-pm@vger.kernel.org>; Thu, 12 Oct 2017 17:59:51 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Dmitry Torokhov <dtor@google.com>, Ruchi Kandoi <kandoiruchi@google.com>

[Changed the subject to more apt one]

On Thu, Oct 12, 2017 at 5:28 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Fri, Oct 13, 2017 at 2:13 AM, Rajat Jain <rajatja@google.com> wrote:
>> Hi,
>>
>> I'm trying to understand when a driver is supposed to call the
>> pm_wakeup_event(). It appears that the purpose of this call is to
>>
>> (1) In the suspend path, halt the suspend if the driver believes it
>> just got an appropriate wake event from the device while the system is
>> trying to suspend.
>>
>> (2) If driver detects the event in the resume path, identify the
>> device as (one of the) wake sources that fired.
>>
>> I understand good use cases of this call will be when a driver knows
>> that its device has woken up the system, e.g:
>>
>> * When a driver handles dedicated "wakeup irq", and sees the interrupt fired.
>> * If a driver detect operator events such as lid opened, power button
>> pressed, switched to tablet mode etc etc.
>
> The above is correct.
>
>> But what should a driver do, when it handles an event (in the resume
>> path) that potentially was a wake up source but the driver is not
>> sure?
>
> Examples?

I'd like to determine precisely what woke my system up. One of the
missing pieces - the USB keyboard. I'm not sure if the usbhid driver
can tell whether its key presses were the reason for the system wake
up.

>
>> Is it appropriate to call
>>
>>        if (device_may_wakeup(dev))
>>                 pm_wakeup_event(dev, 0);
>>
>> in that case, because I do see some drivers seem to call it when they
>> think that their device *may* have been the reason the system woke up,
>> but not necessarily *is* the reason for wake up. E.g.:
>>
>> drivers/input/mouse/cyapa.c:
>> drivers/input/serio/hyperv-keyboard.c
>> drivers/input/serio/olpc_apsp.c
>
> Anyway, if that happens in the resume path there are no consequences
> of that for the kernel.
>
> However, if user space looks at wakeup sources in order to figure out
> what event woke the system up from sleep, it may be confused by that.
> Are you aware of any user space stacks doing this?

Sorry, I think I should give more context. A new Chromeos platform
wants to use Intel S0ix (suspend-to-idle) for suspend. Since the
suspend and resume paths are entirely in kernel, need to find a good
way of determining the wakeup source in the kernel. Ideally, we'd want
to get (and log):

* the first wakeup event that fired i.e. the real culprit event that
actually lead to *this* system wakeup.
* any other wakeup events that may have fired in the patch (after the
first wakeup event).

Looking around, I see that the struct wakeup_source(s) are available -
however AFAICT the responsibility lies on each and driver to use
pm_wakeup_event() to inform the kernel that it saw a wake up event.
Now, I see only a limited number of drivers doing it - so I'm trying
to understand if this can be somehow be be used for my purposes.

I do see that some efforts were made in the past
(https://patchwork.kernel.org/patch/3827341/) but were suggested to
use the wake_sources framework.

Thanks,

Rajat

>
> Thanks,
> Rafael
