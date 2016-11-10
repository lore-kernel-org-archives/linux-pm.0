From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH] PM / wakeirq: report wakeup events in dedicated wake-IRQs
Date: Thu, 10 Nov 2016 13:39:17 -0800
Message-ID: <20161110213917.GB108490@google.com>
References: <1478801227-65527-1-git-send-email-briannorris@chromium.org>
 <20161110205720.GB31728@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161110205720.GB31728@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 10, 2016 at 09:57:20PM +0100, Pavel Machek wrote:
> On Thu 2016-11-10 10:07:07, Brian Norris wrote:
> > It's important that user space can figure out what device woke the
> > system from suspend -- e.g., for debugging, or for implementing
> > conditional wake behavior. Dedicated wakeup IRQs don't currently do
> > that.
> > 
> > Let's report the event (pm_wakeup_event()) and also allow drivers to
> > synchronize with these events in their resume path (hence, disable_irq()
> > instead of disable_irq_nosync()).
> > 
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> 
> How is this supposed to be presented to userspace?

/sys/kernel/debug/wakeup_sources or /sys/devices/.../power/wakeup*, for
some examples.

> There was big flamewar about that some time ago, and "what woke up the
> system" is pretty much meaningless, and certainly unavailable on most
> PC class hardware.

OK... I'm not privy to the flamewar, but I'm also not sure how it's
relevant here. These APIs specifically handle an IRQ that is solely used
for wakeup purposes, and so it should clearly be able to tell us
something about who/what woke the system.

> Good question to ask is "what wakeup events
> happened while the userspace was not available"....

That's what I'm patching here. handle_threaded_wake_irq() makes no note
of the wake event at the moment.

Brian
