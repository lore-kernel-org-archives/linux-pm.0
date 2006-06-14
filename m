From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 01:57:13 +0200
Message-ID: <20060614235713.GA24859@elf.ucw.cz>
References: <20060614103404.GC28536@elf.ucw.cz>
	<Pine.LNX.4.64.0606140820420.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606141042260.5498@g5.osdl.org>
	<20060614214048.GG4950@ucw.cz>
	<Pine.LNX.4.64.0606141501070.5498@g5.osdl.org>
	<20060614221235.GA7751@elf.ucw.cz>
	<1150324014.21941.23.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606141537570.5498@g5.osdl.org>
	<20060614224436.GF7751@elf.ucw.cz>
	<Pine.LNX.4.64.0606141557100.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606141557100.5498@g5.osdl.org>
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
Cc: Power management list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On St 14-06-06 15:59:00, Linus Torvalds wrote:
> =

> =

> On Thu, 15 Jun 2006, Pavel Machek wrote:
> >
> > Console subsystem should be stopped when console device is stopped,
> > and restarted when console device is restarted.
> =

> There is no "console device".
> =

> There are potentially _many_ console devices.

With printks going to all of them?

> And you don't even know which ones they are.
> =

> The old setup is BROKEN. The new setup is less so. It really is that =

> simple.

I agree that old setup is broken.

> That's not to say that the new setup cannot be improved upon, though. I'm =

> just telling you that the old one was not fixable, not the way it thought =

> it could do things.

...and yes, queueing the messages is nicer solution then the old one.

My point is that you really want the console enabled in writing phase
of suspend-to-disk. And old setup got that detail right, while new
setup does not.

It should be possible to register console device (whatever it means,
make it /sys/devices/system/printk_console ), and reuse its
suspend/resume routines. That will get "console enabled during write"
for s2disk right, too.
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
