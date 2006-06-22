From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Wed, 21 Jun 2006 22:52:31 -0700
Message-ID: <200606212252.31918.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0606211844590.5498@g5.osdl.org>
	<1150946286.947.50.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1150946286.947.50.camel@localhost.localdomain>
Content-Disposition: inline
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
Cc: linux-pm@lists.osdl.org, Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Wednesday 21 June 2006 8:18 pm, Benjamin Herrenschmidt wrote:
> =

> > Let me give you an example, just to clarify.
> > =

> > Let's say that you have a USB host controller. It's got two kinds of =

> > state: the "driver state", which is basically the in-memory image, and =

> > which gets snapshotted separately (or, in the case of STR, just remains=
), =

> > and the "hardware state" which is basically the rest, and which is =

> > snapshotted by save_state().
> =

> USB is funny because it has shared in-memory state between driver and
> controller, =


By which you mean I think the request queues?  Those do need clearly
defined sequence points for an atomic snapshot.  Resending a data buffer
would probably corrupt device state (either persistent or else maintained
through the device suspend state), if it even works (the protocol may
reject the resent request).


> and the controller itself doesn't really keep any state in =

> hardware, so it's in fact the easy example :)

Erm, controller most certainly maintains port state in hardware.

Especially for "real suspend" states like STR ... example, EHCI
is specified to retain that state (with Vaux power) even when
other registers get reset.

And that port state is critical breaks-if-corrupted state, which
can't be snapshotted by software (unless correctness doesn't matter
to you for some reason).


> Thing is, save_state happens at any time before the actual suspend with
> things still operating in between, thus there is absolutely no saying
> how long that state remains valid. In the case of PCI config space, it
> could have been saved at driver init time for what matters.

Nope ... setpci may have been used to tweak things at runtime, and
in ways that affect system correctness.  Admittedly that's not the
most common scenario, but I've had to use it on some systems.

So saving PCI config space "late" is a far better approach.  It's
hardware state that _can_ be snapshotted, with care.

- Dave
