From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RESEND 1/1] x86: tsc: avoid system instability in
 hibernation
Date: Mon, 30 Jul 2018 21:49:48 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1807302140390.1725@nanos.tec.linutronix.de>
References: <20180726155656.14873-1-eduval@amazon.com> <20180730085354.GA2494@hirez.programming.kicks-ass.net> <20180730164100.GD15414@u40b0340c692b58f6553c.ant.amazon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180730164100.GD15414@u40b0340c692b58f6553c.ant.amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <eduval@amazon.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Dou Liyang <douly.fnst@cn.fujitsu.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "mike.travis@hpe.com" <mike.travis@hpe.com>, Rajvi Jingar <rajvi.jingar@intel.com>, Pavel Tatashin <pasha.tatashin@oracle.com>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 30 Jul 2018, Eduardo Valentin wrote:
> On Mon, Jul 30, 2018 at 10:53:54AM +0200, Peter Zijlstra wrote:
> > On Thu, Jul 26, 2018 at 08:56:56AM -0700, Eduardo Valentin wrote:
> > > System instability are seen during resume from hibernation when system
> > > is under heavy CPU load. This is due to the lack of update of sched
> > > clock data
> > 
> > Which would suggest you're already running with unstable sched clock.
> > Otherwise nobody would care about the scd stuff.
> 
> Yes.

I doubt that...

> > 
> > What kind of machine are you running? What does:
> > 
> >   dmesg | grep -i tsc
> > 
> > say?
> 
> Here:
> [    0.000000] tsc: Fast TSC calibration using PIT
> [    0.004005] tsc: Detected 3000.000 MHz processor
> [    0.066796] TSC deadline timer enabled
> [    3.904269] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2b3e459bf4c, max_idle_ns: 440795289890 ns
>

... because if the sched clock would be unstable then you'd have something
like 'TSC unstable' in dmesg, which you obviously do not.

'sched_clock: Marking unstable' is the other message which would be
emitted.

> > > The fix for this situation is to mark the sched clock as unstable
> > > as early as possible in the resume path, leaving it unstable
> > > for the duration of the resume process. This will force the
> > > scheduler to attempt to align the sched clock across CPUs using
> > > the delta with time of day, updating sched clock data. In a post
> > > hibernation event, we can then mark the sched clock as stable
> > > again, avoiding unnecessary syncs with time of day on systems
> > > in which TSC is reliable.
> > 
> > None of this makes any sense. Either you were already unstable and it
> > should already have worked and them marking it stable is an outright
> > bug, or your sched clock was stable but then your initial diagnosis of
> > lack of scd updates is complete garbage.
> > 
> 
> I see, or it is just a workaround for the underling issue. I, for sure, see no
> lockups anymore after forcing the scd updates. The other thing which are not
> super clear is that this happens during the unfreezing of tasks. If I get a
> set of cpu hog tasks while unfreezing, I see the system throwing worqueue lockup
> detectors in hibernation restore.

Yes, it pretty much papers over something else. Can you please provide a
full dmesg from boot to failure case?

Another question: Does the system recover after issuing the lockup messages
or is it hosed completely?

Thanks,

	tglx
