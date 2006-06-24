From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Sat, 24 Jun 2006 15:00:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606241454030.6483@g5.osdl.org>
References: <1150946286.947.50.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606221641180.6483@g5.osdl.org>
	<20060622235100.GA4940@elf.ucw.cz>
	<200606231115.21265.david-b@pacbell.net>
	<20060624213522.GE2777@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060624213522.GE2777@elf.ucw.cz>
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
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org



On Sat, 24 Jun 2006, Pavel Machek wrote:
> > =

> > Doesn't it seem wrong to _everyone_ else that making a basic
> > kernel mechanism like "echo ... >/sys/power/state" work, some
> > out of tree code appears to be needed?
> =

> Bringing up video hardware needs x86 emulator (yes, s2ram is ugly on
> PC)... I'd prefer to keep that out of tree.

I think requiring X to reinitialize the screen for us is perfectly fine.

One of the reasons I wanted to get netconsole working is that on many =

modern laptops, networking really does end up being the "simplest" device.

Graphics is complex as hell (and on the Mac Mini, even doing a video BIOS =

init sequence doesn't even work - it has no video bios even with the =

firmware updated to look more like a PC, it's normally initialized by =

EFI).

KeithP tells me that it's not even Mac Mini specific, and that some normal =

laptops will resume similarly video-bios-less.

And serial is obviously gone, and its replacement (USB) is one of the =

biggest problems to initialize fully, and nobody expects it to be up until =

fairly late.

Which literally leaves networking as existing on just about everything =

these days. It is also usually well-documented (network chip manufacturers =

definitely want Linux to work on those things), and the drivers know how =

to initialize everything. So netconsole really _should_ be able to work =

fairly early on.

I suspect most people prefer debugging over a network anyway (I know I =

do).

			Linus
