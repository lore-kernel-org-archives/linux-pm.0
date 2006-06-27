From: Adam Belay <ambx1@neo.rr.com>
Subject: Re: [PATCH 2/2] Fix console
	handling	during	suspend/resume
Date: Tue, 27 Jun 2006 02:08:11 -0400
Message-ID: <20060627060810.GD4264@neo.rr.com>
References: <Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<200606231106.46863.david-b@pacbell.net>
	<Pine.LNX.4.64.0606231216290.6483@g5.osdl.org>
	<20060623233244.GB4264@neo.rr.com>
	<Pine.LNX.4.64.0606231622580.6483@g5.osdl.org>
	<20060624024230.GB3438@neo.rr.com>
	<Pine.LNX.4.64.0606231953560.6483@g5.osdl.org>
	<1151124740.10141.49.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606232155160.6483@g5.osdl.org>
	<1151130644.10141.70.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <1151130644.10141.70.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Brownell <david-b@pacbell.net>, Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Sat, Jun 24, 2006 at 04:30:43PM +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2006-06-23 at 22:18 -0700, Linus Torvalds wrote:
> > And the "suspend_late()" thing really is fundamentally different from =

> > "suspend()". As mentioned several times, splitting suspend() up is what =

> > allows us to, very specifically, avoid having to shut down the console =

> > early. I want to be able to do printk() until as late in the game as =

> > possible, and preferably as early in the game as possible. =

> >
> > And splitting suspend was the way to do that. And when I actually start=
ed =

> > doing that, splitting resume (which is even _better_) actually fell out=
 of =

> > it automatically - I needed to do that just to handle the nested error =

> > cases correctly (which I had earlier thought I'd just punt entirely, an=
d =

> > require that we do errors in the "prepare/save_state" phase only).
> > =

> > In other words, I think that this patch will allow us to resume, say VG=
A =

> > early, and reliably, and get a working console by the time we resume US=
B.
> =

> So your resume_early is equivalent to my pmac specific hack to resume
> the fbdev early (except that my hack is really very very very early :)
> Before I even bring the L2 cache back, but that's almost a detail. After
> all, nothing says the L2 cache couldn't be just another driver with a
> suspend and a resume method :)
> =

> However, I do still think that this late/early business is problematic
> with "runtime/dynamic" suspend of individual devices or sub-trees
> because of the "irq off" requirement of the late round of calls and I'm
> not necessarily fan of having drivers split themselves between the 2
> phases. If there is a case where we would be tempted to do that, then I
> tend to prefer splitting into 2 drivers instead. The PHY example is a
> good one: move the PHY suspend/resume to the new PHY layer and have
> proper PHY drivers with their suspend/resume etc... (reminds me I sitll
> need to port sungem to that new stuff... )
> =

> > Now, it does require that PCI buses (and preferably other devices) go t=
o =

> > D3 only in suspend_late(), and come back in resume_early(), so that VGA=
 is =

> > reachable. So that _will_ require driver modifications.
> =

> Yes, though doing the PCI busses that way is fair enough provided we
> don't get into semaphore/msleep/etc... vs. interrupt off kind of issues.
> I really don't think we need irq off for that late phase :) Let's just
> quickly look at the reason why you want IRQs off. I think that it's a
> way to avoid being hit by requests etc... right ?

Yes, and pci_set_power_state() can require msleep().  A suspend_late()
and resume_early() pass with interrupts off does cleanup the ugly
legacy device problem and gives some new debugging opportunities.  However,
I agree, it may not be very useful for most modern devices, especially when
considering a possible runtime suspend requirement.

Thanks,
Adam
