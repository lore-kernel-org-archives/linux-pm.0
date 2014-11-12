From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v10 1/5] PM / Runtime: Allow accessing irq_safe if no PM_RUNTIME
Date: Wed, 12 Nov 2014 11:39:13 +0100
Message-ID: <CAPDyKFqzWvcr7qrnBed=atbtGoUTJ5-8URvn7ZMYJZoZk2+dYw@mail.gmail.com>
References: <CAPDyKFp+cZa6PrAwQHbQE4xEzmRKBwN5J_uRByOdM0h8yoV2vg@mail.gmail.com>
	<Pine.LNX.4.44L0.1411101346430.13641-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:41746 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752568AbaKLKjO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Nov 2014 05:39:14 -0500
Received: by mail-qa0-f47.google.com with SMTP id dc16so8276295qab.6
        for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2014 02:39:13 -0800 (PST)
In-Reply-To: <Pine.LNX.4.44L0.1411101346430.13641-100000@netrider.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 10 November 2014 19:59, Alan Stern <stern@rowland.harvard.edu> wrote:
> [CC: list severely trimmed]
>
> On Mon, 10 Nov 2014, Ulf Hansson wrote:
>
>> >> There are an important advantage of using the pm_runtime_force_suspend() here.
>> >>
>> >> For the driver to handle clock gating at system PM suspend, it first
>> >> needs to bring the device into full power, through
>> >> pm_runtime_get_sync(). Otherwise it's not safe to gate the clock,
>> >> since it may already be gated.
>> >
>> > That's fine, but it has nothing to do with pm_runtime_force_suspend().
>> >
>> > Besides, if the real question is whether or not to gate the clock (or
>> > in other words, has the clock already been gated), why not just store a
>> > "clock_is_gated" flag somewhere?
>>
>> You could do that, but it's easier to not.
>
> I'm not convinced.  And you haven't said how this is related to
> pm_runtime_force_suspend().
>
>> You will need to update the runtime PM status and disable runtime PM
>> anyway, done by the API.
>
> So what?  And what API are you referring to: the runtime PM API or
> something else?

Sorry if I was unclear, I was referring to pm_runtime_force_suspend().

>
> I get the feeling that I'm missing a lot of important points here.
> What have you left out?

First, this patch which we are discussing is about how the amba
bus/drivers should cope with irq_safe devices. I think we have already
solved that through Rafael's latest suggestion.

In principle what you want me to elaborate upon, is why the
pm_runtime_force_suspend|resume() helpers is a good choice for AMBA
bus/drivers to use, right?

Indeed the pm_runtime_force_suspend|resume() helpers was discussed
thoroughly before Rafael, decided to merge them. I do now realize that
I forgot to add some information about them into the runtime PM
documentation, my bad. Will fix it soon.

Anyway, this is copied from the function header, which gives you an
overall idea why they are good for AMBA.

/**
 * pm_runtime_force_suspend - Force a device into suspend state if needed.
 * @dev: Device to suspend.
 *
 * Disable runtime PM so we safely can check the device's runtime PM status and
 * if it is active, invoke it's .runtime_suspend callback to bring it into
 * suspend state. Keep runtime PM disabled to preserve the state unless we
 * encounter errors.
 *
 * Typically this function may be invoked from a system suspend callback to make
 * sure the device is put into low power state.
 */

Since AMBA bus/drivers are handling runtime PM resources like
clocks/pinctrl/etc from their runtime PM callbacks, using
pm_runtime_force_suspen|resume() from their system PM callbacks makes
perfect sense to me.

>
> As I understand the problem, you've got a bus type where some of the
> drivers have IRQ-safe runtime PM (and therefore carry out their
> suspend/resume operations in interrupt context) and others don't.  The
> subsystem core wants to maximize the power saving by deconfiguring some
> clocks whenever a device is suspended, but this requires a process
> context and so it can't be done directly when IRQ-safe runtime PM is
> used.
>
> Is that a good summary?  If it is, there are ways of dealing with this

Yes.

> that don't involve messing around with the runtime PM internals, or
> using pm_runtime_force_suspend().

The logic to handle that would in principle mean to keep track of the
device's runtime PM status. That doesn't make sense, it's the job of
the runtime PM core to do that!?

Additionally, you would also need to protect the runtime PM resume
callback from doing clock enable during system PM, unless you also
disable runtime PM.

To me, pm_runtime_force_suspend|resume() will do exactly what we need
for the AMBA case.

Kind regards
Uffe
