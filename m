From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Sun, 25 Jun 2006 10:57:31 +1000
Message-ID: <1151197051.4547.5.camel@localhost.localdomain>
References: <1150946286.947.50.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606221641180.6483@g5.osdl.org>
	<20060622235100.GA4940@elf.ucw.cz>
	<200606231115.21265.david-b@pacbell.net>
	<20060624213522.GE2777@elf.ucw.cz>
	<Pine.LNX.4.64.0606241454030.6483@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606241454030.6483@g5.osdl.org>
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
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


> I think requiring X to reinitialize the screen for us is perfectly fine.

When X can :) Wether we need X or some other userland based emulator,
the problem for the kernel is the same. We need to define something at
the fbdev level though to tell it to stay suspended until userland does
something to wake it up in that case. vgacon has less problems as it's
generally harmless to access the VGA memory hole even when the card
doesn't respond on the bus or isn't initialized. On machines using
fbdev, though, this is different, and depending on your platform can
cause machine checks or lockups (x86 tends to be fairly resilient to PCI
accesses into the wild turning into master or target aborts, though I've
heard some server-class x86 are not, ppc are generally not though).

> One of the reasons I wanted to get netconsole working is that on many =

> modern laptops, networking really does end up being the "simplest" device.

Yes, true.

> Graphics is complex as hell (and on the Mac Mini, even doing a video BIOS =

> init sequence doesn't even work - it has no video bios even with the =

> firmware updated to look more like a PC, it's normally initialized by =

> EFI).
> =

> KeithP tells me that it's not even Mac Mini specific, and that some norma=
l =

> laptops will resume similarly video-bios-less.

Yes. What happens with a lot of these things nowadays is that there is
no video BIOS proper at the PCI ROM base but whatever is needed to
initialize the video chip is buried in the system BIOS and the vendor
provides a mini-BIOS like kind of thing to answer a few standard VBE
calls.

> And serial is obviously gone, and its replacement (USB) is one of the =

> biggest problems to initialize fully, and nobody expects it to be up unti=
l =

> fairly late.
> =

> Which literally leaves networking as existing on just about everything =

> these days. It is also usually well-documented (network chip manufacturer=
s =

> definitely want Linux to work on those things), and the drivers know how =

> to initialize everything. So netconsole really _should_ be able to work =

> fairly early on.
> =

> I suspect most people prefer debugging over a network anyway (I know I =

> do).

Out of curiosity, do you get the video back at all on the mini ? Or will
we have at some point to get code to do a full re-initialization of the
intel video chip ?

Ben.
