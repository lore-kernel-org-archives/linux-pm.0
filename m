From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Wed, 14 Jun 2006 15:37:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606141529270.5498@g5.osdl.org>
References: <Pine.LNX.4.64.0606131418580.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606131435400.5498@g5.osdl.org>
	<20060614103404.GC28536@elf.ucw.cz>
	<Pine.LNX.4.64.0606140820420.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606141042260.5498@g5.osdl.org>
	<20060614214048.GG4950@ucw.cz>
	<Pine.LNX.4.64.0606141501070.5498@g5.osdl.org>
	<20060614221235.GA7751@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060614221235.GA7751@elf.ucw.cz>
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



On Thu, 15 Jun 2006, Pavel Machek wrote:
> =

> I guess I'd much rather see
> =

> if (network_driver_suspended)
> 	drop_message_on_the_floor() =

> =

> or something like that... This really stops messages too early.

You didn't look at the big picture.

Your approach DROPS THE DATA. Mine doesn't.

There's no data that can be usefully printed except for debugging, quite =

frankly. =


Which is why I propose something totally different: don't drop the data, =

don't bother printing it, make the code simpler and more robust, and if =

you really think it will help debugging, add a flag to keep printing.

Best of both world. The _right_ behaviour, with an opt-out for when you =

want to debug.

> this should help:
> =

> http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D115005083610700&w=3D2

That looks likely.

> > The irq9 one is really irritating (hey, ACPI almost always is). I thoug=
ht =

> > it would be something as simple as the wrong polarity or something, but =

> > nope..
> =

> BTW what is wrong with mac mini? I asked original reporter to boot
> noacpi and nosmp, and he told me it will not boot in any of those
> cases. At that point I basically called that machine terminally
> broken. Is it supposed to be PC-compatible?

It's _not_ supposed to be PC-compatible. It just happens to be close =

enough that we can ignore the differences.

And btw, the reason it didn't resume originally was because _we_ did =

things wrong. The PCI command word mustn't be writen before the rest of =

the config space has been restored (one of the things I used my debugging =

patches for, until I noticed that -mm had the same fix independently, so =

that's the one that is merged right now ;)

So don't go blaming the Mac Mini. So far, the above irq9 problem seems to =

be the first one that is literally due to the Mac Mini, and it's entirely =

possible that the Mac Mini isn't even the only machine that does it. =


The fact is, Linux suspend/resume to RAM has been broken for as long as I =

can remember. I finally got fed up, and started debugging it. Unlike =

laptops (which I only use when travelling), I hope to make a MacMini like =

system my main one (well, I'm going to wait for Conroe/Merom, and the =

current one goes to Patricia or Tove, but the point is that small is =

beautiful, and that machine is one of the few desktops I know is supposed =

to do STR fine, and where it makes sense to do so).

		Linus
