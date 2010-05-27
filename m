From: Florian Mickler <florian@mickler.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 19:42:41 +0200
Message-ID: <20100527194241.52caaf37__19912.2694357813$1274982335$gmane$org@schatten.dmk.lab>
References: <20100526120242.5c9b73ad@schatten.dmk.lab>
	<AANLkTim4021cTnhVZrQpefq1MG-eEPOFLDRO-XDepHb4@mail.gmail.com>
	<20100526133721.602633b2@schatten.dmk.lab>
	<AANLkTikzgaOFdQKess4E-D86OLPOzxP3dWiDkU_UR0ri@mail.gmail.com>
	<20100526142430.327ccbc4@schatten.dmk.lab>
	<20100526141612.3e2e0443@lxorguk.ukuu.org.uk>
	<AANLkTin97MMu-XO_Lk-snefBWz2ymhS0Qi1y1RxLwdVA@mail.gmail.com>
	<20100527003943.07c17f85@lxorguk.ukuu.org.uk>
	<20100527140655.GA28048@srcf.ucam.org>
	<alpine.LFD.2.00.1005271642440.3032@localhost.localdomain>
	<20100527155201.GA31937@srcf.ucam.org>
	<alpine.LFD.2.00.1005271808340.3032@localhost.localdomain>
	<20100527192135.6c6543b3@schatten.dmk.lab>
	<1274981127.27810.5597.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1274981127.27810.5597.camel@twins>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Linux@smtp1.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, felipe.balbi@nokia.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Thu, 27 May 2010 19:25:27 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, 2010-05-27 at 19:21 +0200, Florian Mickler wrote:
> > On Thu, 27 May 2010 18:45:25 +0200 (CEST)
> > Thomas Gleixner <tglx@linutronix.de> wrote:
> > 
> > > The whole notion of treating suspend to RAM any different than a plain
> > > idle C-State is wrong. It's not different at all. You just use a
> > > different mechanism which has longer takedown and wakeup latencies and
> > > requires to shut down stuff and setup extra wakeup sources.
> > > 
> > > And there is the whole problem. Switching from normal event delivery
> > > to those special wakeup sources. That needs to be engineered in any
> > > case carefuly and it does not matter whether you add suspend blockers
> > > or not.
> > 
> > Ok, I just don't know the answer: How is it just another idle state if
> > the userspace gets frozen? Doesn't that bork the whole transition and
> > you need a userspace<->kernel synchronisation point to not loose events?
> 
> There is no userspace to freeze when the runqueues are empty.

If in the imaginery situation where userspace can aquire certain
wakeup-constraints and loose certain wakeup-constraints, then it could
be that the system enters suspend without empty runqueues. 

> And as explained, you won't loose events if all the devices do a proper
> state transition. To quote:

I believe the problem beeing userspace frozen at an unopportune time.
So the wakeup event is processed (kernel-side) but userspace didn't
have time to reacquire the correct wakeup-constraint to process the
event.

I.e. the wakeup will be effectivly ignored.


Cheers,
Flo
