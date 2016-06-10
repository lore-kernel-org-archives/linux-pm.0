From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: Platform-specific suspend/resume code in drivers
Date: Fri, 10 Jun 2016 15:32:45 -0700
Message-ID: <m2k2hwwu7m.fsf@baylibre.com>
References: <Pine.LNX.4.44L0.1606091054140.1697-100000@iolanthe.rowland.org>
	<575A9E93.4090508@free.fr>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36654 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956AbcFJWcs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jun 2016 18:32:48 -0400
Received: by mail-pa0-f53.google.com with SMTP id b5so27373837pas.3
        for <linux-pm@vger.kernel.org>; Fri, 10 Jun 2016 15:32:47 -0700 (PDT)
In-Reply-To: <575A9E93.4090508@free.fr> (Mason's message of "Fri, 10 Jun 2016
	13:03:47 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-pm <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Pavel Machek <pavel@ucw.cz>, Arnd Bergmann <arnd@arndb.de>, Mans Rullgard <mans@mansr.com>, Sebastian Frias <sf84@laposte.net>, Mark Rutland <mark.rutland@arm.com>

Mason <slash.tmp@free.fr> writes:

[...]

> Consider two SoCs, SoCA and SocB.
>
> They both have the same device D, which exposes 16 registers to interact
> with the hardware.
>
> When SoCA is suspended, it stops D's clock, but keeps D powered on,
> preserving the 16 registers. Thus when SoCA resumes, it finds the
> 16 registers in the same state as before suspending.
>
> When SoCB is suspended, it powers D down. When SoCB resumes, the
> 16 registers contain garbage/random values. Therefore, in the case
> of SoCB, the suspend routine should save the values of the registers
> to RAM (which is preserved by "contract") and restore them on resume.
>
> However, this save/restore operation is unnecessary on SoCA.
>
> Should the save/restore operation be added unconditionally to the
> driver, even if some SoCs do not need it?

Yes.  For starters, this is the way to go.  If the added save/restore is
too expensive, a few things can be done...

> In other words, do we consider the performance penalty from saving
> and restoring device registers small enough that it should be done
> systematically, even if some SoCs do not require it?

The "save" part can be made to be almost no overhead by always keeping a
"shadow" copy of the registers in memory whenever they change (not just
at suspend time.)  This could be done "manually" by the driver for the
needed registers, or with the aid of something like the regmap cache
feature.  Doing that, there's no additional time for saving context
during suspend.

On resume time, on most hardware there are at least some registers that
will have some pre-determined power-on reset value.  You could optimize
the restore context by comparing one (or a few) of the registers from
your saved context against the power-on reset values to determine if
context was lost, and thus avoid doing a full restore if needed.

Honestly however, the save/restore context time for most devices is
going to be insignificant compared with the total system-wide
suspend/resume time, so the optimizations will not likely be noticed for
system-wide suspend/resume.

However, if you would like to also implement runtime PM (and you
should), then the save/restore context for individual devices will start
to matter since for latency reasons, you will likely care about runtime
suspend/resume times for individual devices.

In that case however, the solution is use PM QoS constraints when there
are specific latency requirements so that the power-off of the device is
avoided in cases where latency constraints could not be met.

> Some device tree nodes have a property called "always-on" which is
> documented as "If present, the block is powered through an always-on
> power domain, therefore it never loses context."
>
> In that case, I suppose the driver's suspend/resume routine should:
>
> suspend:
> if (always-on is not present) {
>     save device registers to RAM;
> }
>
> resume:
> if (always-on is not present) {
>     restore device registers from RAM;
> }
>
> Do you disagree?

Yes.  I'm not a fan of using always-on for this.

Kevin
