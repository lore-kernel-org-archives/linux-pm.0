From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 20:53:11 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1005272027560.3032__10966.3561721847$1274986788$gmane$org@localhost.localdomain>
References: <AANLkTin97MMu-XO_Lk-snefBWz2ymhS0Qi1y1RxLwdVA@mail.gmail.com>
	<20100527003943.07c17f85@lxorguk.ukuu.org.uk>
	<20100527140655.GA28048@srcf.ucam.org>
	<alpine.LFD.2.00.1005271642440.3032@localhost.localdomain>
	<20100527155201.GA31937@srcf.ucam.org>
	<alpine.LFD.2.00.1005271808340.3032@localhost.localdomain>
	<20100527165931.GB1062@srcf.ucam.org>
	<alpine.LFD.2.00.1005271905000.3032@localhost.localdomain>
	<20100527172343.GB2468@srcf.ucam.org>
	<alpine.LFD.2.00.1005271930350.3032@localhost.localdomain>
	<20100527182633.GN3543@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100527182633.GN3543@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Thu, 27 May 2010, Matthew Garrett wrote:

> On Thu, May 27, 2010 at 07:59:02PM +0200, Thomas Gleixner wrote:
> > On Thu, 27 May 2010, Matthew Garrett wrote:
> > > ACPI provides no guarantees about what level of hardware functionality 
> > > remains during S3. You don't have any useful ability to determine which 
> > > events will generate wakeups. And from a purely practical point of view, 
> > > since the latency is in the range of seconds, you'll never have a low 
> > > enough wakeup rate to hit it.
> > 
> > Right, it does not as of today. So we cannot use that on x86
> > hardware. Fine. That does not prevent us to implement it for
> > architectures which can do it. And if x86 comes to the point where it
> > can handle it as well we're going to use it. Where is the problem ? If
> > x86 cannot guarantee the wakeup sources it's not going to be used for
> > such devices. The kernel just does not provide the service for it, so
> > what ?
> 
> We were talking about PCs. Suspend-as-c-state is already implemented for 
> OMAP.
 
Ah, now we talk about PCs. And all of a sudden the problem of the
unability of determining wakeup sources is not longer relevant ? So
how do you guarantee that we don't miss one if we cant figure out
which ones are kept alive in S3 ?

> > So the only thing you are imposing to app writers is to use an
> > interface which solves nothing and does not save you any power at
> > all. 
> 
> It's already been demonstrated that the Android approach saves power.

Demonstrated ? Care to explain me how it makes a difference:

while (1) {
  block();
  read();
  process_event();
  unblock();
		---> suspend
		<--- resume
  do_crap();	1000000 cycles
}

vs.

while (1) {
  read();
		---> suspend
		<--- resume
  process_event();
  do_crap();	1000000 cycles
}

You spend the damned 10000000 cycles in any case just at a different
point in time. So if you are so convinced and have fully understood
all the implications, please enlighten me why do_crap() costs less
power with the blockers approach.

An you are also stubbornly refusing to answer my analysis about the
effect on apps which do not use the blocker or are not allowed to.

1) The kernel blocker does not guarantee that the lousy app has
   processed the event. It just guarantees that the lousy app has
   emptied the input queue. So what's the point of the kernel blocker
   in that case ?

2) What's the difference on setting that app to QoS(NONE) and let the
   kernel happily ignore it.

Come up with real explanations and numbers and not just the "it has
been demonstrated" chant which is not holding water if you look at the
above.
 
> > Runnable tasks and QoS guarantees are the indicators whether you can
> > go to opportunistic suspend or not. Everything else is just window
> > dressing.
> 
> As I keep saying, this is all much less interesting if you don't care 
> about handling suboptimal applications. If you do care about them then 
> the Android approach works. Nobody has demonstrated a scheduler-based 
> one that does.

That does not make the android approach any better. They should have
talked to us upfront and not after the fact. Just because they decided
to do that in their google basement w/o talking to people who care is
not proving that it's a good solution and even less a reason to merge
it as is.

The kernel history is full of examples where crappy solutions got
rejected and kept out of the kernel for a long time even if there was
a need for them in the application field and they got shipped in
quantities with out of tree patches (NOHZ, high resolution timers,
...). At some point people stopped arguing for crappy solutions and
sat down and got it right. The problem of power management and
opportunistic suspend is not different in any way.

Thanks,

	tglx
