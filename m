From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 22:43:18 +0200
Message-ID: <20060615204317.GC1849@elf.ucw.cz>
References: <20060615083921.GB9423@elf.ucw.cz>
	<Pine.LNX.4.44L0.0606151047410.6879-100000@iolanthe.rowland.org>
	<20060615161446.GA23859@elf.ucw.cz>
	<Pine.LNX.4.64.0606150922200.5498@g5.osdl.org>
	<20060615182419.GA1711@elf.ucw.cz>
	<Pine.LNX.4.64.0606151219540.5498@g5.osdl.org>
	<20060615200333.GB1849@elf.ucw.cz>
	<Pine.LNX.4.64.0606151325520.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606151325520.5498@g5.osdl.org>
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
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Nigel Cunningham <ncunningham@linuxmail.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > Why? We are saving state to memory, we should not need any other
> > devices to do that.
> =

> Hell no, we're not.

?

> > Well, for devices that are so complex that userspace support is
> > needed... yes, you are right, separate pass would be
> > needed. Fortunately, such devices are not too common.
> =

> "Not too common"?
> =

> Having a graphical console is a hell of a lot more common than just about =

> any other device I can imagine, with the possible exception of USB these =

> days.

Okay, but graphical console means X these days, and -- being userspace
-- needs special casing, anyway.

For fbcon, etc, no, we do not any other devices, so it actually works
okay.

> In fact, done right, if you know the machine powers off, the final suspen=
d =

> should literally not be needed. "Remove power globally" is actually a ver=
y =

> good suspend/shutdown mechanism that doesn't even need any driver support=
 ;)

Actually, that's bad idea; some machines are unable to power down with
devices still running.
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
