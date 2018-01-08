From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFD] Devices that need full power for wakeup
Date: Mon, 8 Jan 2018 17:33:43 +0100
Message-ID: <CAPDyKFqZ+ja5bu+G7ynTowq1CFQ2_k2zdA7qGbj3VagdB0yT4Q@mail.gmail.com>
References: <CAJZ5v0jf_CVsZOQj4ZzgU59Z9ketb_aNu0UdgMmgXyJwRc37Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:42147 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933007AbeAHQdo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jan 2018 11:33:44 -0500
Received: by mail-io0-f170.google.com with SMTP id x67so14861650ioi.9
        for <linux-pm@vger.kernel.org>; Mon, 08 Jan 2018 08:33:44 -0800 (PST)
In-Reply-To: <CAJZ5v0jf_CVsZOQj4ZzgU59Z9ketb_aNu0UdgMmgXyJwRc37Yg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Alan Stern <stern@rowland.harvard.edu>

On 8 January 2018 at 12:51, Rafael J. Wysocki <rafael@kernel.org> wrote:
> Hi,
>
> First, let me characterize the problem the way I understand it and if
> my understanding of it is not correct, let me know why.
>
> There are devices that can only signal wakeup if they are provided
> with full "in-band" power (in contrast with devices that can signal
> wakeup with the help of a special "wakeup" power source, possibly of
> smaller capacity).  Suspending them via runtime PM is problematic
> because of the general assumption that wakeup should always be enabled
> for all runtime-suspended wakeup-capable devices which leads to sort
> of a Catch 22 situation in this particular case.
>
> Some drivers work around that by only allowing the device to be
> suspended if they know that it is not expected by user space to signal
> wakeup and they use the runtime PM usage counter to prevent the device
> from being suspended otherwise.  That works for runtime PM, but if the
> system goes to a sleep state, the runtime PM usage counter is not
> taken into account and the handling of the device may not be adequate
> and there is a question how to address that.

As far as I understand, I would describe the problem a bit
differently. Let me elaborate on that.

Genpd treats a device with the ->dev.power.wakeup_path flag set, as it
need to stay powered on during system suspend, thus also its PM
domain. There is nothing new around this, which make me think that we
should continue to treat that as being the default behavior. This is
also what Geert convinced to be the best, from earlier discussions.

However, there are a few related issues around system wakeups in
genpd, during system suspend.

1)
If the driver for the device, configures system wakeup as an
"out-band-wakeup", the device and its PM domain, don't need to stay
powered on during system suspend from the driver perspective. A very
common scenario when this is the case, is when a wakeup signal is
routed via GPIO IRQ.

In these cases, genpd still leaves the device powered on, as well as
its PM domain, thus wasting power during system suspend.

2)
The are cases when device_may_wakeup() returns true for a device, but
because there are no consumers registered for the system wakeup IRQ,
it doesn't make sense for the driver to configure system wakeup for
the device during system suspend. An example of this, exists in the
mmc subsystem, when an SDIO controller driver, during system suspend,
realizes that there are no SDIO functional driver (a WiFi driver for
example) that wants system wakeup signals (SDIO IRQs) to be delivered.

Again, the problem boils done to that the middle-layer/PM domain, only
can check the ->dev.power.wakeup_path flag to know if the device needs
to stay power on during system suspend, while in fact in both case 1)
and case 2), the device could have been powered off.

I think, to cope with these scenarios, we need a way for drivers to
inform the middle-layer/PM domain, that the driver is fine with
powering off the device and its PM domain during system suspend. Of
course, then its up to the middle-layer/PM domain to act on this.

>
> Assuming that the above description of the problem is accurate, here's
> how I see it.
>
> All depends on whether or not a device requiring full power for
> signaling wakeup is allowed to wake up the system from sleeps states.
> If it is not allowed to do that, it should be fully suspended during
> system transitions to sleep states regardless of its previous runtime
> PM status and (in the majority of cases) it may just be left in
> suspend if already suspended.
>
> The problematic case is when the device is allowed to wake up the
> system from sleep states, because it has to be provided with full
> power while the system is in a sleep state for the wakeup to work.
> Clearly, checking the runtime PM usage counter alone is not sufficient
> for that, because the wakeup counter may be nonzero for reasons other
> than wakeup and the driver may not be able to arrange things properly
> by itself during system-wide transitions, for example in the cases
> when the device belongs to a power domain managed by a separate code
> layer (like genpd).  This leads to the conclusion that it is necessary
> to provide an additional mechanism allowing all of the layers of code
> involved in the handling of the device to check what to do with it (or
> with the power domain it belongs to etc) during system-wide
> transitions to sleep state.
>
> In principle, that mechanism might be a new driver flag saying that
> power should not be removed from the device if device_may_wakeup()
> returns "true" for it.  However, there already is a similar thing in
> the kernel which already is taken into account by genpd_power_off()
> and which is the PM_QOS_FLAG_NO_POWER_OFF PM QoS flag.
>
> The existence of it means that drivers can use it for runtime PM in
> the first place instead of preventing devices from being suspended if
> they need to signal wakeup.  In principle, a driver may just set this
> flag and then suspend the device normally whenever that makes sense
> (of course, taking the flag into account if set) which may lead to
> reduced power draw if (say) device cloks may be gated without
> disturbing its wakeup capability.  Moreover, PM QoS requests may be
> added and removed at any time, so the driver may just set the flag or
> clear it whenever the device's wakeup settings change.
>
> And if this flag is taken into account by genpd_sync_power_off() too,
> using it may just be sufficient to address the concern at hand.
>
> Thoughts?

As I tried to describe above, I think we rather need an "opt-out
method", rather than opt-in. In other words, a flag telling that the
device can be powered off, from the driver's perspective.

I also think such flag needs to be propagated to parent devices,
similar to what we do for the wakeup_path flag.

If this makes some sense, I can share some patches which I already in my pipe!?

Kind regards
Uffe
