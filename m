From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Wed, 14 Jun 2006 21:40:48 +0000
Message-ID: <20060614214048.GG4950@ucw.cz>
References: <Pine.LNX.4.64.0606131418580.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606131435400.5498@g5.osdl.org>
	<20060614103404.GC28536@elf.ucw.cz>
	<Pine.LNX.4.64.0606140820420.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606141042260.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606141042260.5498@g5.osdl.org>
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

> > > And we definitely want to go back to SYSTEM_RUNNING or how is it
> > > called here.
> > =

> > Right. A bit too much cut-and-paste ;)
> =

> Btw, maybe I didn't quite make this clear enough, but the two patches =

> actually make a huge difference for me.

Well, I'm sure they will make huge difference to me, too ;-)))))))))).

The first one is probably harmless/good idea, but I think the second
one will break suspend-to-disk, or at least make it undebuggable.

> My Mac Mini (Intel dual-core CPU) now resumes and suspends in SMP mode =

> too, which was not true just a couple of days ago. It even seems to do it =

> fairly reliable.

Yep, you are not alone trying to get that working.

> The debugging patch helped me figure out a number of the problems (and =

> even more problems that then didn't actually make any difference once I =

> started getting things working ;)
> =

> And the console fixes is apparently what got things working in SMP mode. =


It works for some people _without_ that console fix.

Then, you have irq9 problem that breaks second suspend, right? I've
seen that before, forced the poor soul to report it into kernel
bugzilla, and IIRC ACPI people were already proposing solutions.

						Pavel

-- =

Thanks for all the (sleeping) penguins.
