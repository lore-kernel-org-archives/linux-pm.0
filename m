From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 18:17:21 +0200
Message-ID: <20060615161721.GB23859@elf.ucw.cz>
References: <Pine.LNX.4.64.0606141042260.5498@g5.osdl.org>
	<20060614214048.GG4950@ucw.cz>
	<Pine.LNX.4.64.0606141501070.5498@g5.osdl.org>
	<20060614221235.GA7751@elf.ucw.cz>
	<1150324014.21941.23.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606141537570.5498@g5.osdl.org>
	<20060614224436.GF7751@elf.ucw.cz>
	<Pine.LNX.4.64.0606141557100.5498@g5.osdl.org>
	<20060614235713.GA24859@elf.ucw.cz>
	<Pine.LNX.4.64.0606141702300.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606141702300.5498@g5.osdl.org>
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
Cc: Power management list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > My point is that you really want the console enabled in writing phase
> > of suspend-to-disk. And old setup got that detail right, while new
> > setup does not.
> =

> I definitely agree that we can change things around a bit. I don't =

> personally use suspend-to-disk, and I'm a bit tired of having people tell =

> me STD works, when STR is what I have always cared about, so if the table=
s =

> are turned for once, I won't be _too_ sorry.
> =

> I have always argued that the suspend should be a two-phase thing: a =

> "prepare to suspend" (that saves the device state) and then a "real =

> suspend" (that actually turns off devices). =

> =

> _I_ think that's the only sane schenario, and I think that in that =

> schenario we could save the image to disk in between, and disable the =

> console after that, and just before the "actually turn off devices" phase.
> =

> But I've said that before, and nobody cared last time either. For some =

> reason, people continue to think that suspend should be a single phase, =

> with us sending down "suspend" to each device.

Actually we already have

	device_suspend()
	device_power_down()

calls (badly missnamed, some people believe), so it is two phase for
now for s2ram. s2disk is more complex...
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
