From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Platform-specific suspend/resume code in drivers
Date: Fri, 10 Jun 2016 10:19:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1606101008500.1615-100000@iolanthe.rowland.org>
References: <575A9E93.4090508@free.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:38650 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932099AbcFJOTj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jun 2016 10:19:39 -0400
In-Reply-To: <575A9E93.4090508@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mason <slash.tmp@free.fr>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-pm <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Pavel Machek <pavel@ucw.cz>, Arnd Bergmann <arnd@arndb.de>, Mans Rullgard <mans@mansr.com>, Sebastian Frias <sf84@laposte.net>, Mark Rutland <mark.rutland@arm.com>

On Fri, 10 Jun 2016, Mason wrote:

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

It certainly should be added, because otherwise SoCB won't work.  
Whether it is unconditional is up to the programmer.  If the driver has
some way to know that power won't be lost, it can skip saving the
registers.

> In other words, do we consider the performance penalty from saving
> and restoring device registers small enough that it should be done
> systematically, even if some SoCs do not require it?

Time is not the most important consideration -- proper operation is.

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

Apart from nit-picking, no.  In the resume routine, it might be better 
to check a flag that the suspend routine would set to indicate whether 
or not the registers were saved, instead of retrieving the always-on 
attribute again.


On Fri, 10 Jun 2016, Geert Uytterhoeven wrote:

> Hi Alan,

Hello.
 
> > Of course, if a driver needs suspend support but doesn't include it,
> > then it's quite likely the driver will not work properly after the  
> > system has been resumed.  But that's not a platform-specific issue. 
> 
> It may be. The same device may be present on different SoCs. On some
> SoCs, the device may be part of a power area, on others not.
> When running on the former SoC, the driver needs to save/restore registers,
> while this is not needed (but harmless, except for a small time impact)
> on the latter SoC.

Splitting hairs.  As a general principle, you have to agree that:

	If a driver needs suspend support but doesn't include it, then
	it's quite likely the driver will not work properly after the
	system has been resumed.

is true on all platforms.  On the other hand, the question of whether 
or not the driver needs suspend support may well be platform-specific.

Alan Stern

