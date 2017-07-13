From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 2/5] tick: Add freeze timer events
Date: Thu, 13 Jul 2017 06:54:35 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1707130641520.2332@nanos>
References: <20170708000303.21863-1-dbasehore@chromium.org> <20170708000303.21863-2-dbasehore@chromium.org> <alpine.DEB.2.20.1707122248270.2510@nanos> <CAGAzgspJ1HoT_RsxCv-sGAWGeLw+cLCkN=kMUTika8fBeA2YxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <CAGAzgspJ1HoT_RsxCv-sGAWGeLw+cLCkN=kMUTika8fBeA2YxA@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: "dbasehore ." <dbasehore@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>, x86@kernel.org, Platform Driver <platform-driver-x86@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Linux-pm mailing list <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-pm@vger.kernel.org

Derek,

On Wed, 12 Jul 2017, dbasehore . wrote:
> On Wed, Jul 12, 2017 at 2:25 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Fri, 7 Jul 2017, Derek Basehore wrote:
> >> +/*
> >> + * Clockevent device may run during freeze
> >> + */
> >> +# define CLOCK_EVT_FEAT_FREEZE_NONSTOP       0x000100
> >
> > Is that really restricted to freezing?
> 
> I'm not going to make the call on what firmware may do when it enters
> suspend. Even if it's not supposed to do anything, it still might.

The feature is a description of the hardware capability not of the
way how it's used by software.

> >> +     if (!clockevent_state_shutdown(dev)) {
> >
> > What puts the device in shutdown mode when the machine is in freeze state?
> 
> tick_freeze does through timekeeping_suspend or tick_suspend_local
> depending on whether it's the last CPU to freeze or not.

Ok. I completely forgot about the inner workings of freeze. So this check
for shutdown actually wants to have a printk, because that's a state which
is wrong. The nonavailability of oneshot mode is just factual information
that this is not possible and does not justify dmesg spam.

> >> +     clockevents_tick_resume(dev);
> >
> > That looks wrong as well. What did call suspend on that device?
> >
> > I'm not aware that freeze will actually call suspend on anything down deep
> > in the core code. Can you please explain this magic here?
> 
> tick_freeze in tick-common.c calls the tick suspend code.

Fair enough.

> > All of this lacks an explanation how any of this is safe vs. the normal
> > operation of clock event devices and the tick device code.
> >
> > This lacks documentation of calling conventions and checks which make sure
> > they are obeyed.
> 
> If I get rid of passing in the cpu id, the only thing left to check
> seems to be making sure that tick_clear_freeze_event is called on the
> same CPU as tick_set_freeze_event.

Yes, you want to store that information somewhere.

> Am I missing something? I'll add Documentation.

Please make that whole thing depend on a Kconfig option. There is no point
having the code and the exports there for everyone while it has only a
single user.

Thanks,

	tglx
