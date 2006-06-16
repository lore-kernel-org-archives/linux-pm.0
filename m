From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Fri, 16 Jun 2006 15:22:51 +0200
Message-ID: <20060616132250.GA1666@elf.ucw.cz>
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

> And yes, I admit (and I started off talking about this) that I care a lot =

> more about suspend-to-ram than I do about suspend-to-disk. I seriously =

> claim that STR _should_ be a lot simpler than suspend-to-disk, because it =

> avoids all the memory management problems. The reason that we support =

> suspend-to-disk but not STR is totally perverse - it's simply that it has =

> been easier to debug, because unlike STR, we can do a "real boot" into a =

> working system, and thus we don't have the debugging problems that the =

> "easy" suspend/resume case has.

This is one reason, there are two more.

> Which is obviously also why patch 1/2 (and in many way the more =

> fundamental one) was about trying to make debugging much simpler. Or at =

> least possible.

Yes, 1/2 is pretty clever hack that can't hurt. Debugging s2ram will
still be bad, but probably no longer a nightmare.
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
