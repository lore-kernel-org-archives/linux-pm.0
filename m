From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Fri, 16 Jun 2006 15:26:00 +0200
Message-ID: <20060616132559.GB1666@elf.ucw.cz>
References: <20060615161446.GA23859@elf.ucw.cz>
	<Pine.LNX.4.64.0606150922200.5498@g5.osdl.org>
	<20060615182419.GA1711@elf.ucw.cz>
	<Pine.LNX.4.64.0606151219540.5498@g5.osdl.org>
	<20060615200333.GB1849@elf.ucw.cz>
	<Pine.LNX.4.64.0606151325520.5498@g5.osdl.org>
	<20060615204317.GC1849@elf.ucw.cz>
	<Pine.LNX.4.64.0606151356480.5498@g5.osdl.org>
	<20060615212724.GB2255@elf.ucw.cz>
	<Pine.LNX.4.64.0606151518380.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606151518380.5498@g5.osdl.org>
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

> > > So we're _not_ just saving data to memory. We're allocating memory (w=
hich =

> > > means that we want to access every single device that may do write-ba=
ck), =

> > > and we're calling out to user space (which means that we _really_ don=
't =

> > > know what a device may need).
> > =

> > That memory should be either allocated statically, or allocated during
> > boot up or something. Usually, device just adds few bytes to
> > per-device structures.. this problem is real but not too bad.
> =

> I agree. When it's statically allocated, there are no problems (because =

> the suspend won't actually do anything wrt the memory management).
> =

> HOWEVER. It's not actually true that the memory that a driver knows about =

> is all small and all statically allocated. I wish it was, but networking =

> tends to often allocate things dynamically.
> =

> Not always, mind you. Several network drivers seem to allocate a "pool" o=
f =

> maximum-sized skb's, and re-use those. That memory management is actually =

> optimal for the suspend/resume case, again because there is no question =

> about what might have been saved/restored. Although I suspect networking =

> may or may not be playing tricks with it, so I think in practice there ar=
e =

> still sone nasty issues with networking happening after the =

> suspend-to-disk phase.
> =

> Of course, it's probably perfectly fine to say "we simply don't support =

> suspend-to-disk over NBD" ;)

Actually, we probably can support suspend-to-disk over
NBD. Suspend-to-USB-ZIP-drive worked at one point. We do unfreeze on
all devices before starting writeout (remember?), so we have no nasty
dependencies.

> > Except that powerdown is done with ACPI, and that means
> =

> Actually, power down and reboot by accessing the hardware directly ;)
> =

> This following macro, for example, is very useful when you're debugging =

> STR, and you want certain problems like oopses to just reboot immediately=
, =

> so that you can see what the last trace event before the problem was:
> =

> 	#define reboot_now()					\
> 		({ unsigned long long bogus =3D 0;		\
> 		asm volatile("lgdt %0": :"m" (bogus)); })
> =

> I'm basically one of the people who believe that when Intel says that you =

> have to do things through ACPI, they're simply _lying_. There's a lot of =

> things that are better done by just looking at the hardware itself.
> =

> In many cases, their chipset documentation is actually a lot better than =

> their ACPI documentation (and a lot simpler to use, too ;).

Yes, you are right. OTOH going through ACPI means it should work on
future machines, too. I do not _like_ ACPI, either.
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
