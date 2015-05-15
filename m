From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: schedule_timeout sleeps too long after dividing CPU frequency
Date: Fri, 15 May 2015 14:15:21 +0100
Message-ID: <20150515131521.GK2067@n2100.arm.linux.org.uk>
References: <5554858A.9010207@free.fr>
 <20150514115456.GB23999@linux>
 <55549DEE.6010202@free.fr>
 <CAKohpon4AV-7nq=Qm7PpDbbW9ti98avY9zz82htzyHWi5_K7fA@mail.gmail.com>
 <20150514144239.GZ2067@n2100.arm.linux.org.uk>
 <5555BC7E.7010601@free.fr>
 <20150515095159.GF2067@n2100.arm.linux.org.uk>
 <5555CC1A.5040604@free.fr>
 <20150515115852.GJ2067@n2100.arm.linux.org.uk>
 <5555EA68.7030006@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5555EA68.7030006@free.fr>
Sender: cpufreq-owner@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mans Rullgard <mans@mansr.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux PM <linux-pm@vger.kernel.org>, cpufreq <cpufreq@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, May 15, 2015 at 02:45:28PM +0200, Mason wrote:
> The sad part is: I'm working on the "new" kernel.
> The current "official" kernel is 3.4 (and I'm afraid
> there's a 2.6.32 still kicking around somewhere).
> 
> I'm trying to convince management that one of the advantages
> of mainlining the port is that it is easier to switch to newer
> kernels. Do you agree with this assertion?

Yes and no.  If you can get stuff upstream, it should make things
easier.

The difficult bit - and time consuming bit - is getting code upstream.
Even in my position, I'd suggest allowing about five years for that
activity, and even then don't have expectations of getting everything
upstream.

Frankly now, my advice to people would be to just not bother, it's
*way* too much effort to get everything to an acceptable state,
especially if the SoC has no support what so ever.

For example, we're still banging on over the iMX6 SoCs - just getting
the display stuff sorted took more than a year.  Ethernet keeps becoming
unstable (people keep reporting problems with it) and it became far too
difficult for me to get my patch set for that upstream, so I dumped it.

> > I think you'll have to do the research for that yourself... what
> > I can say is that TWD is capable of one-shot mode,
> 
> Is one-shot mode preferred over periodic mode?
> (Seems counter-intuitive, as one-shot mode needs to be
> periodically reprogrammed, whereas periodic mode just
> keeps firing.)

Think about it in terms of high-resolution timers.  How can something
that's programmed to fire HZ times a second provide you with a high
resolution timer?  Something that you can program for an arbitary
period depending on your needs obviously allows higher resolution
intervals, up to the minimum timer count interval.  It can also provide
a longer interval, up to the maximum timer count interval.

> > and is capable of running as a high-res timer:
> > 
> > Per CPU device: 0
> > Clock Event Device: local_timer
> >  max_delta_ns:   21691754031
> >  min_delta_ns:   1000
> >  mult:           425201762
> >  shift:          31
> >  mode:           3			<== CLOCK_EVT_MODE_ONESHOT
> >  next_event:     595603944000000 nsecs
> >  set_next_event: twd_set_next_event
> >  set_mode:       twd_set_mode
> >  event_handler:  hrtimer_interrupt	<== indicates that it's switched
> > 					to high-res mode
> >  retries:        0
> 
> I'm confused.
> 
> In the "High-resolution timers not supported when using
> smp_twd on Cortex A9" thread, you seemed to agree that
> TWD could not be used as a hrtimer...

I guess I was wrong.  I'm no expert on the kernel's time code.  That's
why I've suggested to you several times that you do the research
yourself, rather than me having to do that research for you and then
write an email about it.  It's kind of wasting my time, and you're not
paying me for this kind of support service...

> > Yes - because the TWD stops in low power modes, which makes it
> > unsuitable as a high-resolution timer.  These kinds of issues
> > are annoying, but it's the way things are.
> 
> So it looks like TWD can be used as a hrtimer, but something
> on my platform is making it choose otherwise, and it is not
> the CLOCK_EVT_FEAT_C3STOP flag?

I've no idea.  I don't have the 3.14 code in front of me to research.
I _could_ wind my tree back to 3.14, and read that code, but I don't
see why I should go to all that effort... especially as I have other
things I need to be getting on with, and other problems to be taking
care of.

What I'm saying is that I have a platform here running a modern kernel
which _does_ use the TWD, and it _does_ appear to be running in high-res
mode.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
