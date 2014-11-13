From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v10 1/5] PM / Runtime: Allow accessing irq_safe if no PM_RUNTIME
Date: Thu, 13 Nov 2014 11:22:51 +0100
Message-ID: <CAPDyKFrATXiiTCeK8A5NBB6K5TPgb9xG5CCKHTHCqdEW_i7qKA@mail.gmail.com>
References: <CAPDyKFqzWvcr7qrnBed=atbtGoUTJ5-8URvn7ZMYJZoZk2+dYw@mail.gmail.com>
	<Pine.LNX.4.44L0.1411121124420.1676-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:41392 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932241AbaKMKWw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Nov 2014 05:22:52 -0500
Received: by mail-qc0-f178.google.com with SMTP id b13so12310966qcw.9
        for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2014 02:22:52 -0800 (PST)
In-Reply-To: <Pine.LNX.4.44L0.1411121124420.1676-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 12 November 2014 17:34, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Wed, 12 Nov 2014, Ulf Hansson wrote:
>
>> Since AMBA bus/drivers are handling runtime PM resources like
>> clocks/pinctrl/etc from their runtime PM callbacks, using
>> pm_runtime_force_suspen|resume() from their system PM callbacks makes
>> perfect sense to me.
>
> This sounds like a case of misdesign.  If clocks/pinctrl/etc are all
> purely _runtime_ PM resources then the _system_ PM callbacks should
> have nothing to do with them.  On the other hand, if they are general
> PM resources then they should be handled from a general-purpose routine
> that can be invoked by both the runtime-PM and system-PM callbacks.
>
> It makes very little sense to have a special-purpose routine manage a
> general-purpose resource.

I don't agree and thought you also were of the opposite opinion. :-)

If I remember correctly, it was you who came up with the really
brilliant idea to reuse the runtime PM callbacks for this matter!?

>From that, we ended up in adding the SET_PM_RUNTIME_PM_OPS macro.

>
>> > As I understand the problem, you've got a bus type where some of the
>> > drivers have IRQ-safe runtime PM (and therefore carry out their
>> > suspend/resume operations in interrupt context) and others don't.  The
>> > subsystem core wants to maximize the power saving by deconfiguring some
>> > clocks whenever a device is suspended, but this requires a process
>> > context and so it can't be done directly when IRQ-safe runtime PM is
>> > used.
>> >
>> > Is that a good summary?  If it is, there are ways of dealing with this
>>
>> Yes.
>>
>> > that don't involve messing around with the runtime PM internals, or
>> > using pm_runtime_force_suspend().
>>
>> The logic to handle that would in principle mean to keep track of the
>> device's runtime PM status. That doesn't make sense, it's the job of
>> the runtime PM core to do that!?
>
> Why do think we have pm_runtime_suspended() and related routines?  They
> are there so that your code can make decisions based on the runtime PM
> status without having to keep track of it.

Those runtime PM routines your refer to, are exactly what the
pm_runtime_force_suspend|resume() helpers make use of. It seems like a
bad idea to duplicate similar code into each an every bus/driver to
handle the same issue.

If we shouldn't use pm_runtime_force_suspend|resume() helpers for
these cases, when do you think it would be appropriate to use them?

>
>> Additionally, you would also need to protect the runtime PM resume
>> callback from doing clock enable during system PM, unless you also
>> disable runtime PM.
>>
>> To me, pm_runtime_force_suspend|resume() will do exactly what we need
>> for the AMBA case.
>
> Your description leaves out large parts of the design.  Please list the
> relevant resources, together with an explanation of exactly how each
> one is handled by the system- and runtime-PM callback routines, in your
> scheme.

The runtime PM resources depends on what AMBA device/driver is being
used, typically clocks and pinctrls.

Simplified described, these bus/drivers PM support are designed in a
runtime PM centric manner. It means at system PM suspend, the
bus/driver wants to make sure the runtime PM resources are in a
runtime PM suspend state.

Does that answer your question?

Kind regards
Uffe
