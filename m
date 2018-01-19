From: "dbasehore ." <dbasehore@chromium.org>
Subject: Re: [PATCH 4/8] irqchip/gic-v3: add ability to save/restore GIC/ITS state
Date: Fri, 19 Jan 2018 14:58:14 -0800
Message-ID: <CAGAzgsrx+5NDZEZ9haSjfbnAHV71ugsF_HimhwoZdhH8K+brLg@mail.gmail.com>
References: <20180112212422.148625-1-dbasehore@chromium.org>
 <20180112212422.148625-5-dbasehore@chromium.org> <86fu79fx3n.wl-marc.zyngier@arm.com>
 <20180118233243.GA209323@google.com> <d84d49ef-cd8a-ec75-498e-22826809ab67@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33100 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752938AbeASW6R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jan 2018 17:58:17 -0500
Received: by mail-wm0-f67.google.com with SMTP id x4so9204869wmc.0
        for <linux-pm@vger.kernel.org>; Fri, 19 Jan 2018 14:58:16 -0800 (PST)
In-Reply-To: <d84d49ef-cd8a-ec75-498e-22826809ab67@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Brian Norris <briannorris@chromium.org>, linux-kernel <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Sudeep Holla <sudeep.holla@arm.com>

On Fri, Jan 19, 2018 at 1:22 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 18/01/18 23:33, Brian Norris wrote:
>> Hi,
>>
>> On Sat, Jan 13, 2018 at 06:10:52PM +0000, Marc Zyngier wrote:
>>> On Fri, 12 Jan 2018 21:24:18 +0000,
>>> Derek Basehore wrote:
>>>>
>>>> Some platforms power off GIC logic in S3, so we need to save/restore
>>>
>>> S3 is a not a GIC concept, and is only vaguely mentioned in terms of
>>> the rk3399 silicon, if grep serves me right. Please expand on what
>>> state this is exactly.
>>>
>>>> state. This adds a DT-binding to save/restore the GICD/GICR/GITS
>>>> states using the new CPU_PM_SYSTEM_ENTER/EXIT CPU PM states.
>>>
>>> DT binding? I can't see any in this patch.
>>>
>>>>
>>>> Change-Id: I1fb2117296373fa67397fdd4a8960077b241462e
>>>
>>> It's been mentioned somewhere else in the thread: these tags have no
>>> purpose in the kernel. Please sanitise your patches before posting them.
>>>
>>>> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
>>>> Signed-off-by: Brian Norris <briannorris@chromium.org>
>>>
>>> Who is the author of this patch? If that's a joined authorship, please
>>> use the Co-Developed-by: tag.
>>
>> I only did some minimal code shuffling when rebasing and working with
>> this code in our downstream tree. I probably didn't actually need to
>> apply my Signed-off-by at the time, but Derek carried it along anyway.
>>
>> Derek is the author, and I'd be perfectly fine dropping my S-o-b from
>> these patches.
>>
>>>> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>>>> index 9a7a15049903..95d37fb6f458 100644
>>>> --- a/drivers/irqchip/irq-gic-v3.c
>>>> +++ b/drivers/irqchip/irq-gic-v3.c
>
> [...]
>
>>>> +           if (IS_ERR(gicr_ctx)) {
>>>> +                   err = PTR_ERR(gicr_ctx);
>>>> +                   goto out_free_gicd_ctx;
>>>> +           }
>>>> +   }
>>>
>>> You really want to kill the box because something went wrong in your
>>> save area allocation? It doesn't feel quite right.
>>
>> Isn't that what all drivers (including irqchip drivers) do on failed
>> allocations? What else would we do? Pretend that we can limp along and
>> just b0rk the system when it suspends?
> It would certainly give the user a chance to diagnostic the problem
> (which is otherwise pretty hard if the system doesn't boot). We kill the
> system if we cannot continue. In this case, we can. So why not try it?

I'm in the middle of a lot of refactoring that will make this
irrelevant, so I guess we can leave it at that. I'll disable the
feature and print an error in the case of allocation failures (in the
parts that remain) in the next version.

Still debugging the broken ATF code which is now going to be used, so
no ETA on that.

>
> Thanks,
>
>         M.
> --
> Jazz is not dead. It just smells funny...
