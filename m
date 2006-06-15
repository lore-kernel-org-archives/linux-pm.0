From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 18:14:46 +0200
Message-ID: <20060615161446.GA23859@elf.ucw.cz>
References: <20060615083921.GB9423@elf.ucw.cz>
	<Pine.LNX.4.44L0.0606151047410.6879-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0606151047410.6879-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Brownell <david-b@pacbell.net>, Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org, Nigel Cunningham <ncunningham@linuxmail.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > This is FAQ:
> > =

> > Q: I do not understand why you have such strong objections to idea of
> > selective suspend.
> > =

> > A: Do selective suspend during runtime power managment, that's
> > okay. But
> > its useless for suspend-to-disk. (And I do not see how you could use
> > it for suspend-to-ram, I hope you do not want that).
> > =

> > Lets see, so you suggest to
> > =

> > * SUSPEND all but swap device and parents
> > * Snapshot
> > * Write image to disk
> > * SUSPEND swap device and parents
> > * Powerdown
> > =

> > Oh no, that does not work, if swap device or its parents uses DMA,
> > you've corrupted data. You'd have to do
> > =

> > * SUSPEND all but swap device and parents
> > * FREEZE swap device and parents
> > * Snapshot
> > * UNFREEZE swap device and parents
> > * Write
> > * SUSPEND swap device and parents
> > =

> > Which means that you still need that FREEZE state, and you get more
> > complicated code. (And I have not yet introduce details like system
> > devices).
> =

> Complications aside, you're setting up a straw man.  You don't need to
> have the console or other devices enabled while the snapshot is being
> made, only while it is being written out to disk.  Which the current
> approach already does (although perhaps not in the best possible
> way).

No, I do not, but patch, as is, currently does not reenable console
for writing to disk.

That said... Linus, can I get latest version of that patch? I'll fix
it up to work with s2disk...
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
