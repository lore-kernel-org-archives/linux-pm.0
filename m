From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Fri, 16 Jun 2006 23:28:11 +0200
Message-ID: <20060616212811.GA2213@elf.ucw.cz>
References: <20060614103404.GC28536@elf.ucw.cz>
	<200606150957.42449.david-b@pacbell.net>
	<20060615180350.GG23859@elf.ucw.cz>
	<200606160704.34093.david-b@pacbell.net>
	<Pine.LNX.4.64.0606161114110.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606161114110.5498@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > It's not so different from what Linus has been sketching, except
> > for the actual turn-off-DMA step.  (Needed because you want to get
> > an atomic snapshot.)  In terms of $SUBJECT the gain is that you
> > actually get a debuggable suspend sequence.
> =

> Actually, if the _only_ thing STD wants to do, why not just have a
> =

> 	->freeze(dev)
> 	->unfreeze(dev)
> =

> call-in?

Unfortunately, it is not the _only_ thing STD needs to do. unfreeze()
must be able to reinitialize/resume the device during resume.

> In other words, if you really just want to stop the devices in order to d=
o =

> a memory snapshot, doing a "suspend" + "resume" is _way_way_way_ overkill=
, =

> and really really fragile because it is so much more complicated. A
> simple

Well, but we need that to work for s2ram anyway.
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
