From: Mason <slash.tmp@free.fr>
Subject: Platform-specific suspend/resume code in drivers
Date: Tue, 7 Jun 2016 10:56:40 +0200
Message-ID: <57568C48.709@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:45358 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753806AbcFGI5I (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 7 Jun 2016 04:57:08 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Pavel Machek <pavel@ucw.cz>, Arnd Bergmann <arnd@arndb.de>, Mans Rullgard <mans@mansr.com>, Sebastian Frias <sf84@laposte.net>, Mark Rutland <mark.rutland@arm.com>

Hello everyone,

I want to implement system-wide suspend-to-RAM on my platform
(an ARM Cortex A9 based SoC).

I'm hoping some of you can clear some of my confusion :-(

AFAIU, what happens to the hardware in the suspended state is
very board/platform specific. The SoC may stop some clocks;
it may even cut the power to some parts of the chip.

AFAIU, once power is cut, the value of internal and visible
registers (called "state" or "context" IIUC) is lost.

Therefore, each driver is supposed to either

1) save context on suspend & restore it on resume, or
2) re-initialize the device on resume (if context is unimportant)

Is that correct?

(Note: Kevin Hilman mentioned using a feature called "regmap" to
help in saving/restoring context.)

Documentation/power/devices.txt mentions putting such save/restore
code in suspend_late/resume_early callbacks. Is that the preferred
solution today?

Should these routines be guarded by #ifdef CONFIG_PM or #ifdef CONFIG_SUSPEND ?

Another point of confusion for me is this: drivers are supposed to
be shared among platforms, right? So my platform-specific suspend
code should be enabled only if my platform is detected at run-time?

So this means I need to add in the probe function, for every driver
my platform uses:

  if (platform == MY_PLATFORM) {
    ops.suspend = my_suspend;
    ops.resume  = my_resume;
  }

Is that correct?


While I'm listing the points I don't understand... It seems Linux
handles suspend/resume "transparently". I mean the CPU calls all
the functions leading to the suspend action, then when the system
comes back online, it continues at the next instruction, as if
nothing had happened. So the stack and registers need to be exactly
in the same state.

But on my system, the firmware expects a return address for *where*
to return on resume. Should I pass it the next instruction pointer?
The address of the resume function?

I see arch/arm/kernel/psci_smp.c seems to have the same notion.
=> drivers/firmware/psci.c

References:
arch/arm/kernel/suspend.c
kernel/power/suspend.c

Regards.
