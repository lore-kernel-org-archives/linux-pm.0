From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Fri, 16 Jun 2006 15:29:39 +0200
Message-ID: <20060616132939.GC1666@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0606151625360.8641-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0606151345000.5498@g5.osdl.org>
	<20060615211031.GA2255@elf.ucw.cz>
	<Pine.LNX.4.64.0606151446350.5498@g5.osdl.org>
	<20060615222002.GF2255@elf.ucw.cz>
	<Pine.LNX.4.64.0606151532230.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606151532230.5498@g5.osdl.org>
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

> > ? No, I do not think we have any problems with temporary
> > pointers. Memory snapshot is atomic (done on single CPU, with disabled
> > interrupts, no DMAs).
> =

> The problem I'm trying to point out is that it's _not_ atomic wrt "save =

> the device state".
> =

> You've actually worked very hard to make "save device state" and "snapsho=
t =

> memory" to be as atomic as possible - by having the device state save als=
o =

> basically try to freeze the state.

Agreed.

> And I'm trying to change that.

Okay, but I do not see why? You'd force me to do...

> And that means that the resume must not restore any "temporary pointers". =

> =

> Now, a lot of hardware doesn't _have_ temporary pointers, but if it has =

> things like a DMA ring with pointers to buffers (network drivers do this, =

> for example), then you need to realize that if the that ring is _not_ =

> atomic wrt the memory snapshotting if packets were still coming in =

> (packets that you didn't even care about).

...some magic, involving driver knowing which pointers are temporary
and which are not, possible leaking memory.

> It's an inconvenience that needs a strategy, and the strategy can range =

> from "refuse to do networking during suspend if we're suspendign to disk" =

> to "various MM things to make it easier to handle" to "if you use =

> networking during the suspend, you migth possibly leak some memory".

It's a pretty big inconvenience, and I do not see a point.
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
