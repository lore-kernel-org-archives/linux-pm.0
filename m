From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Mon, 3 Jul 2006 23:32:11 +0200
Message-ID: <20060703213211.GB1674@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<200606221130.30614.david-b@pacbell.net>
	<Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<200606231106.46863.david-b@pacbell.net>
	<Pine.LNX.4.64.0606231216290.6483@g5.osdl.org>
	<1151150259.15365.316.camel@localhost.localdomain>
	<20060625230335.GA2519@elf.ucw.cz>
	<1151277515.753.122.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <1151277515.753.122.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Jim Gettys <jg@laptop.org>
Cc: David Brownell <david-b@pacbell.net>, Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > > We're building the OLPC machine in which the wireless hardware is ali=
ve
> > > (and able to forward packets in the mesh) even with the machine STR.
> > > Even our ATest hardware supports this for wireless.
> > =

> > > Similarly for the screen; it can be "alive" while the machine is STR.
> > > The power savings are dramatic. the screen takes an ASIC we don't have
> > > back yet, so that we won't have until the next batch of boards.  And
> > > with the Geode's UMA, all we should have to do on the console is save
> > > and restore the graphics registers, which should be very fast.
> > =

> > Actually, what you are doing is _not_ suspend-to-RAM. You are doing
> > (trying to do?) very advanced kind of runtime power management on PC
> > platform (that happens to use S3).
> =

> I suppose it is a matter of definitions...  However, the main CPU is in
> fact going to be suspended to RAM; it's just that our wireless and
> screen are able to run autonomously.

Well, and keyboard ... so that machine "pretends" to be powered on,
no? That is actually more similar to very deep CPU sleep...

> > I hope we'll be able to do the same on regular notebooks some day...
> > =

> =

> So do we.
> =

> It is fun for Linux to be going first for once.
> =

> If you want a board to play with, let me know, Pavel (and others)...
> This is not mythological hardware, but stuff I can ship out immediately.
> (though the video has to wait until the next revision of the board:
> we're doing an asic for that, and won't have that chip for several more
> months).

I'm afraid I'd not force myself to use machine without display. I
still need to get that dual-core home-server running...
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
