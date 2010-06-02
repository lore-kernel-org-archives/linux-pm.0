From: Florian Mickler <florian@mickler.org>
Subject: Re: [PATCH] - race-free suspend. Was: Re: [PATCH 0/8]
 Suspend block api (version 8)
Date: Wed, 2 Jun 2010 21:05:21 +0200
Message-ID: <20100602210521.54b9cd9b__19808.0854760066$1275505669$gmane$org@schatten.dmk.lab>
References: <Pine.LNX.4.44L0.1005271303190.3239-100000@iolanthe.rowland.org>
	<201006010005.19554.rjw@sisk.pl>
	<20100601090023.788cabf4@notabene.brown>
	<201006010232.20263.rjw@sisk.pl>
	<20100601113309.609349fd@notabene.brown>
	<alpine.LFD.2.00.1006010340160.2933@localhost.localdomain>
	<20100601122012.1edeaf48@notabene.brown>
	<alpine.LFD.2.00.1006011243350.2933@localhost.localdomain>
	<20100602153235.340a7852@notabene.brown>
	<AANLkTikVjAf5nHdMx2bcHRAUSkq99s-b5YZCECXIJJLy@mail.gmail.com>
	<20100602180614.729246ea@notabene.brown>
	<AANLkTimISbs4X2YR_Pal9A80mpkNyCy8laWBcOgR2Cl7@mail.gmail.com>
	<20100602210224.6ae2333f@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100602210224.6ae2333f@notabene.brown>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Neil Brown <neilb@suse.de>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Zijlstra <peterz@infradead.org>, "Paul@smtp1.linux-foundation.org" <Paul@smtp1.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, James Bottomley <James.Bottomley@suse.de>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter@smtp1.linux-foundation.org, Felipe Balbi <felipe.balbi@nokia.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Wed, 2 Jun 2010 21:02:24 +1000
Neil Brown <neilb@suse.de> wrote:
> 
> And this decision (to block suspend) really needs to be made in the driver,
> not in userspace?

Well, it fits. The requirement is a direct consequence of the intimate
knowledge the driver has about the driven devices. 
Or if you get in an upper layer, the knowledge that the subsystem has
about it's requirements to function properly. Why would you separate it out?

If all your drivers specify their needed requirements, the pm-core (or
idle) has the maximum flexibility to implement any strategy and is
guaranteed a stable system as long as it honours the given requirements.
(That's the theory, of course.)

> 
> You could get those drivers to return EBUSY from PM_SUSPEND_PREPARE (which
> would need to be a configurable option), but then I guess you have no way to
> wait for the device to become non-busy.
> 
> If user-space really cannot tell if the driver is busy or not, then I would
> suggest that the driver is fairly poorly designed.

In general, userspace has no business knowing if the driver is busy or
not. It would need intimate knowledge about the driver to determine if
it is busy or not. That is what the kernel is all about, to hide that
knowledge from userspace and masking it with a one-fits-all-API.


> 
> It would seem then that a user-space requested suspend is not sufficient for
> your needs even if we remove the race window, as you have drivers that want
> to avoid suspend indefinitely, and that "need to avoid suspend" status is not
> visible from user-space.

Well, but the kernel-solution and the userspace solution should be
pretty independent. The tricky part here seems to be to have a
kernel-userspace-boundary that doesn't require a specific kernel
implementation and works. 

Could someone perhaps make a recap on what are the problems with the
API? I have no clear eye (experience?) for that (or so it seems).

> It is a pity that this extra requirement was not clear from your introduction
> to the "Opportunistic suspend support" patch.

I think that the main problem was that _all_ the requirements were
not communicated well.  That caused everybody to think that their
solution would be a better fit. You are not alone.
 
> If that be the case, I'll stop bothering you with suggestions that can never
> work.
> Thanks for your time,
> NeilBrown

Don't be frustrated. What should Arve be?  :)

Cheers,
Flo
