From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 2/5] tick: Add freeze timer events
Date: Wed, 19 Jul 2017 00:22:23 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1707190019500.2425@nanos>
References: <20170708000303.21863-1-dbasehore@chromium.org> <CAJZ5v0horA+vgR3bAbEu+AiqEFJ7JyZ49nTv6FBPHRvmXOUFpQ@mail.gmail.com> <CAGAzgsoFugSw=UQsJmep0woGg70J3nie0-EtvtQ4Ec1NG1usOg@mail.gmail.com> <7467728.lI8lN4PjS8@aspire.rjw.lan>
 <CAGAzgsq1c3HdMJ9801uqB+7USK9mqt9xtZTbH=EYv0KDLe+8=A@mail.gmail.com> <CAJZ5v0jaHAExRdwwhJU9p+tDB1ESEXqgfU_DLXev0su3qZaNBA@mail.gmail.com> <CAGAzgsqhV=e8ZuwA7NtOX_tg+HfQfYGg6oTTTRa2bp-LBOZ54w@mail.gmail.com> <alpine.DEB.2.20.1707180838570.1945@nanos>
 <CAGAzgsqwOhTYz9D=XYkMYHBZsmajUH8HJoMOJOe3DfG8WVusRA@mail.gmail.com> <alpine.DEB.2.20.1707182352340.2425@nanos> <CAGAzgsoqjwK1HPK7jPKhC+YhH7EbVLjbYm+p-UARGmK_hvB=+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:41039 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751962AbdGRWWp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jul 2017 18:22:45 -0400
In-Reply-To: <CAGAzgsoqjwK1HPK7jPKhC+YhH7EbVLjbYm+p-UARGmK_hvB=+A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "dbasehore ." <dbasehore@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>, the arch/x86 maintainers <x86@kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Len Brown <len.brown@intel.com>, Linux PM <linux-pm@vger.kernel.org>

On Tue, 18 Jul 2017, dbasehore . wrote:
> On Tue, Jul 18, 2017 at 2:53 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Tue, 18 Jul 2017, dbasehore . wrote:
> >> On Mon, Jul 17, 2017 at 11:40 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> >> > On Mon, 17 Jul 2017, dbasehore . wrote:
> >> >> On Mon, Jul 17, 2017 at 6:33 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >> >> I could make a patch to try it out. I would probably add a flag to rtc
> >> >> timers to indicate whether it wakes the system (default true). We
> >> >> would have to add a sync with the rtc irq and the rtc irqwork. I would
> >> >> probably add a rtc_timer_sync function that would flush the rtc irq
> >> >> and flush the irqwork. I would call this after the freeze_ops sync
> >> >> function since the sci irq needs to finish before syncing with the rtc
> >> >> irq. Also, pm_wakeup_irq seems racy with the current implementation of
> >> >> s2idle_loop since the RTC irq could be mistakenly set as pm_wakeup_irq
> >> >> when something else actually triggered the full wakeup. Fortunately, I
> >> >> don't think pm_wakeup_irq is used for anything except debugging, but
> >> >> we might change that.
> >> >
> >> > There is another option which you might consider. We can reserve one of the
> >> > HPET comparators for that purpose and have a special interrupt handler for
> >> > it. Checking the HPET for expiry from the low level code should be trivial.
> >> >
> >> Does that handle setting up new timers properly or does the timer sync
> >> code still need to be written?
> >
> > Sorry, I don't understand the question. What is timer sync code?
> >
> 
> Does the comparator allow you to have a completely separate alarm set
> in the hardware? If there's another timer setup (say some user
> specified wake alarm), we need to program that alarm after the current
> one goes off if we aren't able to program multiple alarms at the same
> time.

The HPET consists of several independent comparator units. The kernel uses
only a limited set of them. We can reserve one or more for that purpose, so
it does not require any multiplexing or whatever. How many of them do you
need?

Thanks,

	tglx
