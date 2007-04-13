From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFD] swsusp problem: Drivers allocate much memory
	during	suspend (was: Re: 2.6.21-rc5: swsusp: Not enough free memory)
Date: Sat, 14 Apr 2007 00:38:41 +0200
Message-ID: <20070413223841.GD28269@elf.ucw.cz>
References: <460B6E4B.3060004@gmail.com> <200704131400.12021.rjw@sisk.pl>
	<1176466896.7112.159.camel@nigel.suspend2.net>
	<200704132241.52725.rjw@sisk.pl>
	<20070413221016.GQ28264@elf.ucw.cz>
	<1176503692.7112.189.camel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1176503692.7112.189.camel@nigel.suspend2.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <nigel@nigel.suspend2.net>
Cc: linux-pm@lists.osdl.org, Jiri Slaby <jirislaby@gmail.com>, Linux kernel mailing list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > > > Well, it looks like someone allocated about 6000 pages after we h=
ad freed
> > > > > enough memory for suspending.
> > > > =

> > > > We have a tunable allowance in Suspend2 for this, because fglrx
> > > > allocates a lot of pages in its suspend routine if DRI is enabled. I
> > > > think some other drivers do too, but fglrx is the main one I know.
> > > =

> > > I wasn't aware of that, thanks for the information.
> > > =

> > > I think this means we'll probably need to add a tunable, similar to i=
mage_size,
> > > that will allow the users to specify how much spare memory they want =
to reserve
> > > for suspending (instead of the constant PAGES_FOR_IO).  IMO we can ca=
ll it
> > > 'spare_memory'.
> > =

> > Just increase PAGES_FOR_IO. This should not be tunable.
> =

> If we don't have a means for drivers to pre-allocate or say how much
> memory they need, it should be tunable. Frankly, I'm startled that you
> guys haven't heard of this issue before now. I can't believe everyone
> who has ever wanted to hibernate with DRM enabled has been using
> Suspend2. Maybe this is one of the sources of complaints that swsusp
> isn't reliable?

We do not support closed-source drivers, and open-source drivers are
well behaved.

> > > IMO to really fix the problem, we should let the drivers that need mu=
ch memory
> > > for suspending allocate it _before_ the memory shrinker is called.  F=
or this
> > > purpose we can use notifiers that will be called before we start the =
shrinking
> > > of memory.  Namely, if a driver needs to allocate substantial amount
> > > of memory
> > =

> > Yes please. Using that notifier without leaking the memory will be
> > "interesting" but if someone needs so much memory during suspend, let
> > them eat their own complexity.
> =

> It doesn't need to be that complex. Add another (optional) function to
> the driver model to let drivers say how much they want and it becomes
> trivial. Maybe this idea should be preferred over the notifier chain.

Actually, it is trivial to prealocate during boot ;-). As the notifier
chain can be useful for other stuff, too, I'd go that way.

									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
