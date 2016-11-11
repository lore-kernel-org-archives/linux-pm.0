From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM / wakeirq: report wakeup events in dedicated wake-IRQs
Date: Fri, 11 Nov 2016 16:09:25 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1611111604120.18268-100000@netrider.rowland.org>
References: <20161111194041.GA111624@google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:50463 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S934727AbcKKVJ0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Nov 2016 16:09:26 -0500
In-Reply-To: <20161111194041.GA111624@google.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, lkml <linux-kernel@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Fri, 11 Nov 2016, Brian Norris wrote:

> > The wakeup interrupt controller knows something happened earlier,
> > so maybe it could report that time if queried somehow?
> 
> Sort of. We have /sys/power/pm_wakeup_irq already. But it's really less
> useful to get IRQ-level stats for this, than to get device info. AFAICT,
> there's no machine-readable association between IRQs and devices; the
> best you can get is by parsing the names in /proc/interrupts.
> 
> Or, if we really want to say that's sufficient, then maybe we should
> kill all the device-level wakeup stats in sysfs... (Is that what the
> flamewar was all about? I hope I'm not poking the hornet's nest.)

If I recall correctly, that flamewar was about the whole idea of what
caused the system to wake up.  In general, the system does not know
what caused it to wake up.  All it knows, once it is awake again, is
what IRQs (or other similar events, such as ACPI GPEs) are pending.  It
doesn't know which of those events caused it to wake up.  And if 
multiple devices share the same IRQ line, the PM core won't know which 
of them raised the IRQ.

Of course, for some purposes this distinction doesn't matter.

Alan Stern

