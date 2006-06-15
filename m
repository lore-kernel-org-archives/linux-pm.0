From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Fri, 16 Jun 2006 00:20:02 +0200
Message-ID: <20060615222002.GF2255@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0606151625360.8641-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0606151345000.5498@g5.osdl.org>
	<20060615211031.GA2255@elf.ucw.cz>
	<Pine.LNX.4.64.0606151446350.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606151446350.5498@g5.osdl.org>
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

> > Okay, so you are saving state, then changing it. Now.. you are right
> > that for most devices it is possible to separate state that does not
> > change from state that changes; that is okay but lot of work.
> =

> It's ok _by_definition_ for all work, since any changes we do are done by =

> ourselves, so it's "not important".
> =

> I think that a lot of problems that people look at aren't actually =

> "device" problems at all, but "memory management" problems. =

> =

> The fact is, suspend-to-disk is really nasty from a memory management =

> standpoint, since the image you save to disk is not the "final" image in =

> the same sense that the STR image is (or the APM suspend image is).

Right. Fortunately, it is only nasty brain-teaser when you try to
think about it, code is not that bad.

> That means, for example, that if you save-and-restore temporary pointers =

> in your device status, you need to do something about the =

> _memory_management_ problems, but that has really nothing to do with =

> saving and restoring the hardware device state.

? No, I do not think we have any problems with temporary
pointers. Memory snapshot is atomic (done on single CPU, with disabled
interrupts, no DMAs). Snapshot restore is also atomic (1 CPU, no
interrupts, no DMAs). And snapshot just take all the (allocated)
memory, so we need absolutely no support for saving state that is not
in hardware.

>  - some drivers might choose to not support suspend-to-disk as well as =

>    they support suspend-to-ram. They might, for example, decide that
>  if it =


? If driver support suspend-to-ram, it automatically supports
suspend-to-disk (albeit maybe slowly, like in disks case, which were
unneccessarily spun down).

> But notice how this is about _memory_, not about the actual hardware =

> device state?

? I do not see what problems are that with memory.

									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
