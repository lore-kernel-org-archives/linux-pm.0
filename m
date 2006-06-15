From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 23:10:31 +0200
Message-ID: <20060615211031.GA2255@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0606151625360.8641-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0606151345000.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606151345000.5498@g5.osdl.org>
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

> > If this happens you're already in trouble.  It doesn't matter that the =

> > unrelated devices aren't suspended; the fact that they have already sav=
ed =

> > their state and will no longer respond to outside stimuli means they ca=
n't =

> > be used.  Not to mention that their I/O queues won't be running.
> =

> THEIR IO QUEUES ARE RUNNING!
> =

> Why are people being dense and stupid? I told you in the very first =

> explanation that the IO state isn't suspended by "save_state()".
> =

> "save_state()" would not disable the device. It would not disable the =

> queues. The device would remain usable, and 100% functional.

Okay, so you are saving state, then changing it. Now.. you are right
that for most devices it is possible to separate state that does not
change from state that changes; that is okay but lot of work.

> > Suppose a driver needs to store its state info on a networked drive and =

> > the network interface has already saved _its_ state?  Or it needs to =

> > access a USB drive and the USB controller is no longer doing DMA?
> =

> So? The network device didn't save the state of the _software_. It doesn'=
t =

> need to. It doesn't need to save the state of the DMA areas - they should =

> be RE-DONE by the resume code. The only thing it needs to save is the =

> actual state of the hardware itself, and in fact, if it knows the hardwar=
e =

> intimately and there is no state that got set up "outside" of the driver, =

> it doesn't need to save even that.
> =

> It's perfectly ok to save zero state at all, if you know that you can =

> re-create the state from the "dev->resources[]" data, for example. =


Okay, so .. in your model you can simply save state *during driver
init*, right at boot.

(But they are not many devices where this is needed, besides X. Yes,
we need to deal with firmware, but having firmware in RAM is not that
bad, and you need to do that anyway.)

No, I do not claim suspend is the nicest code you can get. But it is
not terminally broken. You are right new phase
"save_state_while_userland_running" would make some sense (and it is
what we do with saving X), but then, it is not needed for common
drivers, and it may be better done during boot.
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
