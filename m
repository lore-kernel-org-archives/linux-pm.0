From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Sun, 25 Jun 2006 00:41:33 +0200
Message-ID: <20060624224133.GG2777@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0606241220100.19990-100000@netrider.rowland.org>
	<Pine.LNX.4.64.0606241518380.6483@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606241518380.6483@g5.osdl.org>
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

On Sat 2006-06-24 15:28:33, Linus Torvalds wrote:
> =

> =

> On Sat, 24 Jun 2006, Alan Stern wrote:
> > =

> > >  - "suspend_prepare()" is called for every device (with the semaphore =

> > >    held, you are _not_ allowed to try to unlink yourself in the prepa=
re =

> > >    function)
> > =

> > There should be a big fat warning about this somewhere, maybe added to =
the =

> > documentation.
> =

> Well, there is, right now, above the only place that does this (ie the =

> function itself).
> =

> Anyway, would people object to merging the infrastructure work early, eve=
n =

> if nothing else actually was done before 2.6.18?

I'm pretty sure someone, somewhere is using that -EAGAIN hack. Can we
go through regular -mm route?
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
