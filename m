From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 3/4] PM / core: Direct DPM_FLAG_SMART_SUSPEND optimization
Date: Tue, 19 Dec 2017 17:54:15 +0100
Message-ID: <CAJZ5v0haf3fkwfbfA0rOTTqOLjzyeB8ewKfz5WdYSL09ffkJLw@mail.gmail.com>
References: <7742130.AaJQIxeI1n@aspire.rjw.lan> <252167445.OQUXi2Ca9Y@aspire.rjw.lan>
 <CAPDyKFpC0xLfGLqyWUZwnSVdeY9Ojs-JUtPzEkRr=KAuSXDfmQ@mail.gmail.com>
 <CAJZ5v0hFP4zP+Q1znQ9ZnUTLunNaStmSR4-h-AqKn6UaF-d9Vw@mail.gmail.com>
 <CAPDyKFpG5UbTqyVSg+5oTpq2ipVxQqydd39oUOG+5TNVEXG-YA@mail.gmail.com> <CAJZ5v0hSHEb+TeSqmparHAwvWM1tLN+6TNsEQL96mOMtLjWLjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:38068 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbdLSQyQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Dec 2017 11:54:16 -0500
In-Reply-To: <CAJZ5v0hSHEb+TeSqmparHAwvWM1tLN+6TNsEQL96mOMtLjWLjA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Kevin Hilman <khilman@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>

On Tue, Dec 19, 2017 at 5:29 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Tue, Dec 19, 2017 at 2:10 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 19 December 2017 at 12:13, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>> On Tue, Dec 19, 2017 at 8:38 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>> On 10 December 2017 at 01:00, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>
>>>>> Make the PM core avoid invoking the "late" and "noirq" system-wide
>>>>> suspend (or analogous) callbacks provided by device drivers directly
>>>>> for devices with DPM_FLAG_SMART_SUSPEND set that are in runtime
>>>>> suspend during the "late" and "noirq" phases of system-wide suspend
>>>>> (or analogous) transitions.  That is only done for devices without
>>>>> any middle-layer "late" and "noirq" suspend callbacks (to avoid
>>>>> confusing the middle layer if there is one).
>>>>>
>>>>> The underlying observation is that runtime PM is disabled for devices
>>>>> during the "late" and "noirq" system-wide suspend phases, so if they
>>>>> remain in runtime suspend from the "late" phase forward, it doesn't
>>>>> make sense to invoke the "late" and "noirq" callbacks provided by
>>>>> the drivers for them (arguably, the device is already suspended and
>>>>> in the right state).  Thus, if the remaining driver suspend callbacks
>>>>> are to be invoked directly by the core, they can be skipped.
>>>>>
>>>
>>> It looks like I'm consistently failing to explain my point clearly enough. :-)
>>>
>>>> As I have stated earlier, this isn't going to solve the general case,
>>>> as the above change log seems to state.
>
> No, it doesn't, as long as drivers follow the documentation.
>
> So your concern seems to be "What if I don't follow the
> documentation?" which, honestly, is not something I can address. :-)

I'm not sure why this ended up in this particular place ...

I must have messed up something.

>>> Well, it doesn't say that or anything similar, at least to my eyes.
>>>
>>> The observation is that if you have set DPM_FLAG_SMART_SUSPEND, then
>>> you need to be prepared for your ->suspend_late and ->suspend_noirq to
>>> be skipped (because the ACPI PM domain does that and you may happen to
>>> work with it, for example) if the device is already suspended at the
>>> beginning of the "late suspend" phase.  That's already documented.
>>>
>>> Given the above, and the fact that there is not much to be done for a
>>> suspended device in ->suspend_late and ->suspend_noirq, why can't the
>>> core skip these callbacks too if there's no middle layer?
>>>
>>> But the reason why I really need this is because
>>> i2c-designware-platdrv can work both with the ACPI PM domain and
>>> standalone and I need it to be handled consistently in both cases.
>>
>> Yeah, I understand that.
>>
>>>
>>>> I think we really need to do that, before adding yet another system suspend/resume optimization
>>>> path in the PM core.
>>>
>>> So what exactly is the technical argument in the above?
>>
>> As stated, when the driver needs additional operations to be done, it
>> all falls a part.

So I wanted to say the above thing here:

+ No, it doesn't, as long as drivers follow the documentation.
+
+ So your concern seems to be "What if I don't follow the
+ documentation?" which, honestly, is not something I can address. :-)

> If the driver *needs* such operations to be done, then it *should*
> *not* set DPM_FLAG_SMART_SUSPEND as per the existing documentation.

Thanks,
Rafael
