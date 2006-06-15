From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 15:31:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606151518380.5498@g5.osdl.org>
References: <20060615083921.GB9423@elf.ucw.cz>
	<Pine.LNX.4.44L0.0606151047410.6879-100000@iolanthe.rowland.org>
	<20060615161446.GA23859@elf.ucw.cz>
	<Pine.LNX.4.64.0606150922200.5498@g5.osdl.org>
	<20060615182419.GA1711@elf.ucw.cz>
	<Pine.LNX.4.64.0606151219540.5498@g5.osdl.org>
	<20060615200333.GB1849@elf.ucw.cz>
	<Pine.LNX.4.64.0606151325520.5498@g5.osdl.org>
	<20060615204317.GC1849@elf.ucw.cz>
	<Pine.LNX.4.64.0606151356480.5498@g5.osdl.org>
	<20060615212724.GB2255@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060615212724.GB2255@elf.ucw.cz>
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
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Nigel Cunningham <ncunningham@linuxmail.org>
List-Id: linux-pm@vger.kernel.org



On Thu, 15 Jun 2006, Pavel Machek wrote:
> =

> That's okay, kernel tells X to switch consoles. When X gives console
> control back to kernel, kernel owns the graphics hardware, and we are
> okay.

Right. If you special case things so that the "save state" for X is a =

separate phase entirely, before we actually suspend anything.

> I admit we have problems with various virtual devices...

Would you also admit that they really need the same kind of thing?

That my solution is perhaps the _general_ solution, exactly because it =

doesn't special-case X.

X and video really isn't anything special. They are just the _obvious_ =

problem. They are the problem that you can't avoid on _any_ machine: the =

others you can just add special cases for on a one-by-one basis, and you =

can get most setups working.

> > So we're _not_ just saving data to memory. We're allocating memory (whi=
ch =

> > means that we want to access every single device that may do write-back=
), =

> > and we're calling out to user space (which means that we _really_ don't =

> > know what a device may need).
> =

> That memory should be either allocated statically, or allocated during
> boot up or something. Usually, device just adds few bytes to
> per-device structures.. this problem is real but not too bad.

I agree. When it's statically allocated, there are no problems (because =

the suspend won't actually do anything wrt the memory management).

HOWEVER. It's not actually true that the memory that a driver knows about =

is all small and all statically allocated. I wish it was, but networking =

tends to often allocate things dynamically.

Not always, mind you. Several network drivers seem to allocate a "pool" of =

maximum-sized skb's, and re-use those. That memory management is actually =

optimal for the suspend/resume case, again because there is no question =

about what might have been saved/restored. Although I suspect networking =

may or may not be playing tricks with it, so I think in practice there are =

still sone nasty issues with networking happening after the =

suspend-to-disk phase.

Of course, it's probably perfectly fine to say "we simply don't support =

suspend-to-disk over NBD" ;)

(I'm kidding, of course. I don't think anybody actually wants =

suspend-to-disk-over-NBD, but many of the same issues are actually likely =

true with USB and firewire disks, which do end up needing to do "complex" =

memory management for packet allocation for the data that goes to disk, so =

I think the problem case in general exists).

> Except that powerdown is done with ACPI, and that means

Actually, power down and reboot by accessing the hardware directly ;)

This following macro, for example, is very useful when you're debugging =

STR, and you want certain problems like oopses to just reboot immediately, =

so that you can see what the last trace event before the problem was:

	#define reboot_now()					\
		({ unsigned long long bogus =3D 0;		\
		asm volatile("lgdt %0": :"m" (bogus)); })

I'm basically one of the people who believe that when Intel says that you =

have to do things through ACPI, they're simply _lying_. There's a lot of =

things that are better done by just looking at the hardware itself.

In many cases, their chipset documentation is actually a lot better than =

their ACPI documentation (and a lot simpler to use, too ;).

Also, on several other architectures, ACPI isn't even an issue, so their =

"pm->suspend()" might just do direct device accesses unconditionally. So =

don't get _too_ hung up on PC issues, although PC's are obviously in many =

ways the most important (and complex) case.

		Linus
