From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/3] PM / core: Assign the wakeup_path status flag in __device_prepare()
Date: Tue, 26 Dec 2017 01:36:19 +0100
Message-ID: <3322626.o28ExYgzAs@aspire.rjw.lan>
References: <1513353391-30806-1-git-send-email-ulf.hansson@linaro.org> <CAJZ5v0iu-5Y9j+Qc-no_BUAamYZ7tq=24qSUu4H=vU98YBXCxw@mail.gmail.com> <CAPDyKFqKoOuLK2NG+kXthCUSRJnNUf57wCq_eYrkh+-2KTPWhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:55611 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750805AbdLZAhQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Dec 2017 19:37:16 -0500
In-Reply-To: <CAPDyKFqKoOuLK2NG+kXthCUSRJnNUf57wCq_eYrkh+-2KTPWhQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Vincent Guittot <vincent.guittot@linaro.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On Saturday, December 23, 2017 4:17:58 PM CET Ulf Hansson wrote:
> [...]
> 
> >>>> How many drivers actually do call device_set_wakeup_enable() during suspend?
> >>>
> >>> There are some ethernet/wifi drivers, although it hard to say how many
> >>> without a more thorough investigation.
> >>>
> >>> Besides those I found these more obvious ones:
> >>> drivers/ssb/pcihost_wrapper.c
> >>> drivers/staging/rtlwifi/core.c
> >>> drivers/tty/serial/atmel_serial.c
> >>> drivers/usb/core/hcd-pci.c
> >>
> >> Ugh.  I need to look at the last one at least ...
> >
> > The drivers/usb/core/hcd-pci.c instance is actually valid, because it
> > calls device_set_wakeup_enable() to remove the wakeup source object in
> > case the device is dead.  Moreover, it does that in the "noirq" phase
> > which is not covered by your patch anyway.
> 
> Right, but this puzzles me a bit.
> 
> Could you explain what you mean by valid here? Is it okay to call
> device_set_wakeup_enable() in the suspend phase after all? No?

This is an exception and it would be better to call
device_wakeup_disable() directly here.

In general, calling device_set_wakeup_enable() during system suspend (to
"enable" device wakeup) and then during system resume (to "disable" it) may
be problematic.

First, if device_wakeup_enable() is run during system suspend, it will
create a wakeup source object, which then, quite obviously, can only cover
the time after its creation, so there is a window (between the start of the
system suspend transition and the creation of the wakeup source) during
which wakeup events may be missed.

That is not only relevant for devices supporting runtime PM, because input
device drivers, say, may choose to report system wakeup events every time
they see input (eg. from their interrupt handlers or similar) and wakeup
sources used for that should be present before system suspend begins.

Also, if the wakeup source is not present already, this effectively overrides
the choice made by user space which didn't set the device's "wakeup" attribute
in sysfs to "enabled", so it should not wake up the system.

Second, if device_wakeup_disable() is run during system resume, it effectively
destroys information that can be used to figure out why the system woke up
and, again, it may cause the choice made by user space to be effectively
overridden.

However, if the device is dead, calling device_wakeup_disable() on it is fine
at any time (as dead devices do not wake up the system as a rule).

> My very vague idea at this point is, if we find cases where
> device_set_wakeup_enable() makes sense to call during system suspend,
> probably those could/should be replaces by using the "wakeup_path"
> flag instead, somehow.

Not really in this particular case.  Clearing the wakeup enable bit for the
device plays the role of "don't bother any more" here.

Thanks,
Rafael
