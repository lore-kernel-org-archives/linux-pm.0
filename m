From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Wed, 14 Jun 2006 15:03:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606141501070.5498@g5.osdl.org>
References: <Pine.LNX.4.64.0606131418580.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606131435400.5498@g5.osdl.org>
	<20060614103404.GC28536@elf.ucw.cz>
	<Pine.LNX.4.64.0606140820420.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606141042260.5498@g5.osdl.org>
	<20060614214048.GG4950@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060614214048.GG4950@ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Power management list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org



On Wed, 14 Jun 2006, Pavel Machek wrote:
> =

> > The debugging patch helped me figure out a number of the problems (and =

> > even more problems that then didn't actually make any difference once I =

> > started getting things working ;)
> > =

> > And the console fixes is apparently what got things working in SMP mode=
. =

> =

> It works for some people _without_ that console fix.

Yes. It worked for me in UP and with several drivers removed without the =

console fix. It didn't work for me when I did fancier stuff, netconsole in =

particular ;/

> Then, you have irq9 problem that breaks second suspend, right? I've
> seen that before, forced the poor soul to report it into kernel
> bugzilla, and IIRC ACPI people were already proposing solutions.

Yes, I've got the same irq9 problem, and the broken second resume.

The irq9 one is really irritating (hey, ACPI almost always is). I thought =

it would be something as simple as the wrong polarity or something, but =

nope..

			Linus
