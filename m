From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH] PM / wakeirq: report wakeup events in dedicated wake-IRQs
Date: Fri, 11 Nov 2016 11:40:42 -0800
Message-ID: <20161111194041.GA111624@google.com>
References: <1478801227-65527-1-git-send-email-briannorris@chromium.org>
 <CAKdAkRRWUWmGUFaD=95Zd=wZfqXcs47YXL335Y4A+VmhtdJFTA@mail.gmail.com>
 <20161110184910.GA135921@google.com>
 <20161110204911.GK27724@atomide.com>
 <20161110213038.GA108490@google.com>
 <20161111164753.GD7138@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161111164753.GD7138@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, lkml <linux-kernel@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Nov 11, 2016 at 08:47:54AM -0800, Tony Lindgren wrote:
> But sounds like the threaded IRQ is not your concern and you mostly

Right, threaded is OK for this; it's not performance critical. It just
highlighted the fact that its completion is not synchronized with
anything.

> care about getting the right time for the wake up interrupt.

Not "time", per se, but blame. But that blame is timing related: if it
comes after the system finished resuming, then it's useless, since
user-space won't know to come back and check later.

> The wakeup interrupt controller knows something happened earlier,
> so maybe it could report that time if queried somehow?

Sort of. We have /sys/power/pm_wakeup_irq already. But it's really less
useful to get IRQ-level stats for this, than to get device info. AFAICT,
there's no machine-readable association between IRQs and devices; the
best you can get is by parsing the names in /proc/interrupts.

Or, if we really want to say that's sufficient, then maybe we should
kill all the device-level wakeup stats in sysfs... (Is that what the
flamewar was all about? I hope I'm not poking the hornet's nest.)

BTW, for context, I'm working on using dev_pm_set_dedicated_wake_irq()
for a Wifi driver which supports out-of-band (e.g., GPIO-based) wakeup.
I see it's used in the I2C core, but the I2C code never actually calls
dev_pm_enable_wake_irq(). So while I think I can use this API OK for
my Wifi driver (calling dev_pm_{en,dis}able_wake_irq() at system
suspend/resume), I'm not sure this will help the I2C case.

The more I look at this API, the more I'm confused, especially about its
seeming dependence on runtime PM.

Brian
