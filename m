From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 10:56:01 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0606151047410.6879-100000@iolanthe.rowland.org>
References: <20060615083921.GB9423@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060615083921.GB9423@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@suse.cz>
Cc: David Brownell <david-b@pacbell.net>, Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org, Nigel Cunningham <ncunningham@linuxmail.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 15 Jun 2006, Pavel Machek wrote:

> > Actually it would be interesting to hear counter-arguments to this
> > position:
> > =

> > 	We already HAVE that two-phase thing going on, at
> > 	least for swsusp.  In phase I a PM_EVENT_FREEZE
> > 	gets sent.  Then in phase II a PM_EVENT_SUSPEND gets
> > 	tries to really suspend things.
> > =

> > One counter-argument might be that "phase I.5 resumes those devices"
> > is a problem.  Another might be that "FREEZE should not be sent to
> > the console(s), the swap device, or their parents".  I suspect there
> > are a few more issues mixed up in there too.
> =

> This is FAQ:
> =

> Q: I do not understand why you have such strong objections to idea of
> selective suspend.
> =

> A: Do selective suspend during runtime power managment, that's
> okay. But
> its useless for suspend-to-disk. (And I do not see how you could use
> it for suspend-to-ram, I hope you do not want that).
> =

> Lets see, so you suggest to
> =

> * SUSPEND all but swap device and parents
> * Snapshot
> * Write image to disk
> * SUSPEND swap device and parents
> * Powerdown
> =

> Oh no, that does not work, if swap device or its parents uses DMA,
> you've corrupted data. You'd have to do
> =

> * SUSPEND all but swap device and parents
> * FREEZE swap device and parents
> * Snapshot
> * UNFREEZE swap device and parents
> * Write
> * SUSPEND swap device and parents
> =

> Which means that you still need that FREEZE state, and you get more
> complicated code. (And I have not yet introduce details like system
> devices).

Complications aside, you're setting up a straw man.  You don't need to
have the console or other devices enabled while the snapshot is being
made, only while it is being written out to disk.  Which the current
approach already does (although perhaps not in the best possible way).

One way to allow for a two-phase suspend would be like this:

* FREEZE all devices
* Snapshot
* UNFREEZE all devices (perhaps skip some devices, although I don't
	know how you could determine which ones)
* Write image to disk
* Send PRESUSPEND message to all devices (they can treat it like SUSPEND
	or like FREEZE, or they can ignore it if they want)
* SUSPEND all devices

The two-phase part being the last two steps.

Alan Stern
