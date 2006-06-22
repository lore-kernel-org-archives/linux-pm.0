From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 22 Jun 2006 11:19:44 -0700
Message-ID: <200606221119.45346.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<200606212252.31918.david-b@pacbell.net>
	<Pine.LNX.4.64.0606220922570.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606220922570.5498@g5.osdl.org>
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
To: Linus Torvalds <torvalds@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Thursday 22 June 2006 9:43 am, Linus Torvalds wrote:
> =

> On Wed, 21 Jun 2006, David Brownell wrote:
> > =

> > By which you mean I think the request queues?  Those do need clearly
> > defined sequence points for an atomic snapshot.
> =

> If you mean the actual USB command queues, you do realize that that is =

> physically impossible for suspend-to-disk on a USB device, don't you?

Not so, when the snapshot is created with an _empty_ queue (which is
how it works today).  "Empty" is a nice clearly defined sequence point.
(And we don't support STD-over-USB either, as previously discussed;
it seems unlikely until the block and/or filesystem layers change.)

The data toggle for bulk and interrupt endpoints might be a bit of a
problem spot (as you noted) if one tried to reuse it after snapshot
resume.  For now, we don't use such snapshots unless the hardware has
been reset (STD cases, not "real suspend") ... which means that such
endpoint state is always discarded.

In the unlikely event that we ever hit "no controller reset" on STD
paths **AND** support STD-over-USB, the fix would be just resetting
the active endpoints before resume completes (probably simplest to
do that before taking the snapshot).

 =

> > Nope ... setpci may have been used to tweak things at runtime, and
> > in ways that affect system correctness.  Admittedly that's not the
> > most common scenario, but I've had to use it on some systems.
> > =

> > So saving PCI config space "late" is a far better approach.  It's
> > hardware state that _can_ be snapshotted, with care.
> =

> Yes. We _could_ save it basically at driver initialization time, but sinc=
e =

> the time you have to save it is basically your choice, it's just _better_ =

> to save it later rather than earlier. Exactly if some config stuff is don=
e =

> that changes things - you should still get a working setup even if you =

> drop it, but it's obviously better and has no real downsides to make that =

> "drop config stuff" window smaller.
> =

> At worst, people can re-do their setpci or whatever, but at best, they =

> simply wouldn't have to.

Agreed.

- Dave
