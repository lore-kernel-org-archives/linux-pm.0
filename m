From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Fri, 16 Jun 2006 14:49:19 +0200
Message-ID: <20060616124919.GA4821@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0606151720350.10244-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0606151502150.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606151502150.5498@g5.osdl.org>
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

> > Here's what you actually did say:
> > ---------
> >
> > > To have DMAs stopped, you need to "freeze" the devices.
> > =

> > No you don't. =

> > =

> > You need to stop the high-level _queues_, but that's something totally =

> > different from actually stopping the _devices_.
> =

> Right. =

> =

> What you _do_ need to do, is stop the user-level actions.

Well, user-level actions are stopped because of refrigerator.

> Before you suspend, you need to make the machine quiescent, in other =

> words. The devices are still working, but you really really don't want to =

> do this while things are still _happening_.
> =

> Now, with suspend-to-RAM, I suspect we could even avoid that until the =

> very last phase (ie the actual suspend code). But quite frankly, from a =

> pure debuggability standpoint, I do think we want to basically try to mak=
e =

> everything as quiet as humanly possible.

Suspend-to-RAM theoretically does not need any kind of stopping, and
on ppc (IIRC) no stopping is really done. For suspend-to-disk, both
user actions (so that they do not write to disk after atomic copy is
done) and DMA (so that atomic image is not corrupted) needs to be
stopped.

> So think about what we do now: We special-case X, and we special-case the =

> save-to-disk device, and we special-case the console printouts, and we =

> special-case a lot of other things, AND WE STILL GOT IT WRONG. Try
> using =


Actually no, we are not special-casing the disk device. There was
discussion about doing that, but it is not going to happen.

X are special, because they are user-level hardware driver. If/when we
meet more user-level hardware drivers, we'll have to invent something
extensible.
								Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
