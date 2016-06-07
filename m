From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Platform-specific suspend/resume code in drivers
Date: Tue, 7 Jun 2016 11:06:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1606071055010.1604-100000@iolanthe.rowland.org>
References: <57568C48.709@free.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:34308 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932411AbcFGPGv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jun 2016 11:06:51 -0400
In-Reply-To: <57568C48.709@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: linux-pm <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Pavel Machek <pavel@ucw.cz>, Arnd Bergmann <arnd@arndb.de>, Mans Rullgard <mans@mansr.com>, Sebastian Frias <sf84@laposte.net>, Mark Rutland <mark.rutland@arm.com>

On Tue, 7 Jun 2016, Mason wrote:

> Hello everyone,
> 
> I want to implement system-wide suspend-to-RAM on my platform
> (an ARM Cortex A9 based SoC).
> 
> I'm hoping some of you can clear some of my confusion :-(
> 
> AFAIU, what happens to the hardware in the suspended state is
> very board/platform specific. The SoC may stop some clocks;
> it may even cut the power to some parts of the chip.
> 
> AFAIU, once power is cut, the value of internal and visible
> registers (called "state" or "context" IIUC) is lost.
> 
> Therefore, each driver is supposed to either
> 
> 1) save context on suspend & restore it on resume, or
> 2) re-initialize the device on resume (if context is unimportant)
> 
> Is that correct?

Yes.

> (Note: Kevin Hilman mentioned using a feature called "regmap" to
> help in saving/restoring context.)
> 
> Documentation/power/devices.txt mentions putting such save/restore
> code in suspend_late/resume_early callbacks. Is that the preferred
> solution today?

It depends on the device's requirements.  If you require interrupts to
be enabled while you do the save/restore then you can't use
suspend_late/resume_early; you have to use suspend/resume.

> Should these routines be guarded by #ifdef CONFIG_PM or #ifdef CONFIG_SUSPEND ?

CONFIG_SUSPEND.

> Another point of confusion for me is this: drivers are supposed to
> be shared among platforms, right? So my platform-specific suspend
> code should be enabled only if my platform is detected at run-time?

Is your device platform-specific?  If it is then the driver is also
platform-specific, and so no part of the driver will be called at
runtime unless your platform is detected.

If the device isn't platform-specific then the driver has to work on a 
bunch of different platforms.  It should be written to be 
platform-independent as much as possible.

> So this means I need to add in the probe function, for every driver
> my platform uses:
> 
>   if (platform == MY_PLATFORM) {
>     ops.suspend = my_suspend;
>     ops.resume  = my_resume;
>   }
> 
> Is that correct?

No.  For one thing, you only have to worry about the 
platform-independent drivers -- you know that the platform-specific 
ones won't get used unless your platform is present.

For another, the driver should be written in a way that doesn't require
this sort of code.  The ops pointer (not any of the structure's members
-- a pointer to the structure) should be set by the platform-dependent
part of the driver that handles initialization.

> While I'm listing the points I don't understand... It seems Linux
> handles suspend/resume "transparently". I mean the CPU calls all
> the functions leading to the suspend action, then when the system
> comes back online, it continues at the next instruction, as if
> nothing had happened. So the stack and registers need to be exactly
> in the same state.
> 
> But on my system, the firmware expects a return address for *where*
> to return on resume. Should I pass it the next instruction pointer?
> The address of the resume function?

You should pass it the address of a function you write, one that will 
clean things up and jump into the normal system resume code.

Alan Stern

