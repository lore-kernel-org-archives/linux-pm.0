From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/4] PM / core: Direct handling of DPM_FLAG_SMART_SUSPEND
 and DPM_FLAG_LEAVE_SUSPENDED
Date: Tue, 2 Jan 2018 13:26:56 +0100
Message-ID: <CAJZ5v0h4T19=_wVRoEUGzKTm6k4KY_+rezBEfhS-bMMxT=uKFQ@mail.gmail.com>
References: <7742130.AaJQIxeI1n@aspire.rjw.lan> <2174279.mj3UjPCxfO@aspire.rjw.lan>
 <CAPDyKFqi0TgSwPzjfJj=6SEtk4uKUJhgM9ubyax4u-4aC5=Jfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:46663 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751765AbeABM05 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jan 2018 07:26:57 -0500
In-Reply-To: <CAPDyKFqi0TgSwPzjfJj=6SEtk4uKUJhgM9ubyax4u-4aC5=Jfw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Kevin Hilman <khilman@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>

On Tue, Jan 2, 2018 at 1:17 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 2 January 2018 at 12:32, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Sunday, December 10, 2017 12:55:23 AM CET Rafael J. Wysocki wrote:
>>> Hi All,
>>>
>>> This series is a follow-up for
>>>
>>> https://marc.info/?l=linux-doc&m=151101644105835&w=2
>>>
>>> Patches[1-3/6] from the above have been reviewed and agreed on, so
>>> they are in linux-next now and here's a next version of the rest.
>>>
>>> Patches [1-2/4] are preparatory.  The first one is just really small
>>> code duplication avoidance on top of this recent fix:
>>>
>>> https://patchwork.kernel.org/patch/10097563/
>>>
>>> and the second one simply moves some code to separate functions.
>>>
>>> Patch [3/4] causes the PM core to carry out some optimizations for
>>> drivers of devices with DPM_FLAG_SMART_SUSPEND set whose "late"
>>> and "noirq" suspend (or equivalent) driver callbacks are invoked
>>> directly by the core.
>>>
>>> The underlying observation is that if the device is suspended (via
>>> runtime PM) during the "late suspend" phase of a system transition,
>>> invoking the "late" and "noirq" callbacks from the driver for it is not
>>> going to make it more suspended, so to speak, so it doesn't make sense to
>>> invoke them at all.
>>>
>>> [That optimization is only done for devices with DPM_FLAG_SMART_SUSPEND
>>> set, because drivers setting that flag are expected to be prepared for
>>> skipping their "late" and "noirq" callbacks if the device is already
>>> suspended.]
>>>
>>> Patch [4/4] makes the core do an analogous thing for devices with
>>> DPM_FLAG_LEAVE_SUSPENDED set whose "noirq" and "early" resume (or
>>> equivalent) driver callbacks are directly invoked by the core.
>>>
>>> In that case the observation is that if such devices can be left in
>>> suspend after the system transition to the working state, running
>>> resume callbacks from their drivers is simply not necessary.
>>>
>>> Pathes [3-4/4] have been reoredered and reworked a bit since the last
>>> iteration, so they are regarded as new.
>>>
>>> The series is on top of the linux-next branch of the linux-pm.git tree
>>> that should be merged into linux-next on Monday.
>>>
>>> [I have developed debug bus type and driver modules to test that code,
>>> but they are not ready to be made available at this point.]
>>
>> While I acknowledge that Ulf doesn't appear to be convinced by my
>> arguments, I also see no technical reason why this cannot go in.
>
> Correct, I am not convinced this is the right path as a general
> optimization, at least in it's current form. The main argument is
> about skipping invoking callbacks, as I have stated.
>
> Moreover, I think we are lacking important input from some more
> experienced PM core code contributors, like Alan, Kevin etc. If any of
> those guys would give an ack, that would also make me more comfortable
> with this.
>
> On the other hand, I realize that we can't wait forever for that to happen.
>
>>
>> As I said during the discussion, I have tested it and it works for me
>> as expected.  I also need it to make progress on the drivers front.
>>
>> Moreover, it should not matter for any drivers that don't set the flags
>> in question, so the optimizations introduced here are super-easy to avoid
>> by leaving those flags unset.
>
> What prevents you from folding in some changes to a few drivers as
> apart of the $subject series?
>
> I have asked for that, as to get a better picture of how this is going
> to work in the end.

I can repost this along with the driver changes, but I don't think
that will make much of a difference honestly and I really don't want
to defer this series any more, so I will do as follows.

Consider this series as queued up unless Greg speaks up and I will
post patches [2-4/4] (the first one is in linux-next already) again
with the drivers stuff later today.

Thanks,
Rafael
