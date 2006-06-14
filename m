From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 00:12:35 +0200
Message-ID: <20060614221235.GA7751@elf.ucw.cz>
References: <Pine.LNX.4.64.0606131418580.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606131435400.5498@g5.osdl.org>
	<20060614103404.GC28536@elf.ucw.cz>
	<Pine.LNX.4.64.0606140820420.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606141042260.5498@g5.osdl.org>
	<20060614214048.GG4950@ucw.cz>
	<Pine.LNX.4.64.0606141501070.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606141501070.5498@g5.osdl.org>
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

Hi!

> > > The debugging patch helped me figure out a number of the problems (an=
d =

> > > even more problems that then didn't actually make any difference once=
 I =

> > > started getting things working ;)
> > > =

> > > And the console fixes is apparently what got things working in SMP mo=
de. =

> > =

> > It works for some people _without_ that console fix.
> =

> Yes. It worked for me in UP and with several drivers removed without the =

> console fix. It didn't work for me when I did fancier stuff, netconsole i=
n =

> particular ;/

I guess I'd much rather see

if (network_driver_suspended)
	drop_message_on_the_floor() =


or something like that... This really stops messages too early.

> > Then, you have irq9 problem that breaks second suspend, right? I've
> > seen that before, forced the poor soul to report it into kernel
> > bugzilla, and IIRC ACPI people were already proposing solutions.
> =

> Yes, I've got the same irq9 problem, and the broken second resume.

According to

http://bugzilla.kernel.org/show_bug.cgi?id=3D6670

this should help:

http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D115005083610700&w=3D2

> The irq9 one is really irritating (hey, ACPI almost always is). I thought =

> it would be something as simple as the wrong polarity or something, but =

> nope..

BTW what is wrong with mac mini? I asked original reporter to boot
noacpi and nosmp, and he told me it will not boot in any of those
cases. At that point I basically called that machine terminally
broken. Is it supposed to be PC-compatible?
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
