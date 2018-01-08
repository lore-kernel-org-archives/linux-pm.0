From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFD] Devices that need full power for wakeup
Date: Mon, 8 Jan 2018 13:12:49 +0100
Message-ID: <CAMuHMdV+paxfDWYfTCY-k_ixKqQrahCSXBCC_er3OyOQnV=J3Q@mail.gmail.com>
References: <CAJZ5v0jf_CVsZOQj4ZzgU59Z9ketb_aNu0UdgMmgXyJwRc37Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:38758 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756426AbeAHMMu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jan 2018 07:12:50 -0500
Received: by mail-qt0-f170.google.com with SMTP id d4so13275020qtj.5
        for <linux-pm@vger.kernel.org>; Mon, 08 Jan 2018 04:12:50 -0800 (PST)
In-Reply-To: <CAJZ5v0jf_CVsZOQj4ZzgU59Z9ketb_aNu0UdgMmgXyJwRc37Yg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Alan Stern <stern@rowland.harvard.edu>

Hi Rafael,

On Mon, Jan 8, 2018 at 12:51 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
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

Why would they play games with the runtime PM usage counter?
And why does "that work with runtime PM"?
Wake-up signals don't matter when a device is runtime resumed, as the
system is not in a system-wide sleep state in the first place?

Or do you consider normal interrupt-passing (e.g. pressing a key with
gpio-keys when the system is not asleep) too?

> Assuming that the above description of the problem is accurate, here's
> how I see it.
>
> All depends on whether or not a device requiring full power for
> signaling wakeup is allowed to wake up the system from sleeps states.
> If it is not allowed to do that, it should be fully suspended during
> system transitions to sleep states regardless of its previous runtime
> PM status and (in the majority of cases) it may just be left in
> suspend if already suspended.

OK.

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

OK.

> In principle, that mechanism might be a new driver flag saying that
> power should not be removed from the device if device_may_wakeup()
> returns "true" for it.  However, there already is a similar thing in
> the kernel which already is taken into account by genpd_power_off()
> and which is the PM_QOS_FLAG_NO_POWER_OFF PM QoS flag.

Reading genpd_power_off(), that indeed works, probably.

> The existence of it means that drivers can use it for runtime PM in
> the first place instead of preventing devices from being suspended if
> they need to signal wakeup.  In principle, a driver may just set this

Again, "runtime PM" for system wakeup???

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

Sounds reasonable.
Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
