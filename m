From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/2] Add some basic resume trace facilities
Date: Thu, 15 Jun 2006 20:08:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606151956580.5498@g5.osdl.org>
References: <5389061B65D50446B1783B97DFDB392D01623F6F@orsmsx411.amr.corp.intel.com>
	<Pine.LNX.4.64.0606131551210.5498@g5.osdl.org>
	<1150422553.7725.92.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1150422553.7725.92.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-pm@lists.osdl.org, Nigel Cunningham <ncunningham@linuxmail.org>
List-Id: linux-pm@vger.kernel.org



On Fri, 16 Jun 2006, Benjamin Herrenschmidt wrote:
>
> On Tue, 2006-06-13 at 15:59 -0700, Linus Torvalds wrote: =

> > The Apple Mac Mini I can't even get to _beep_, which is really annoying=
. =

> > It's a wonderful debug sequence ("oh, I head 15 beeps, it got to point =

> > X"). Or rather, it's "wonderful" compared to something that gives you j=
ust =

> > one single piece of data after the reboot ;)
> =

> No magic GPIO or ACPU command you can use to tweak the front led ?

There's a magic bit that can make it flash. I considered doing that, but =

decided that I'm better off with the "almost 24 bits of data" and a =

reboot, than trying to desperately look at how the led flashes.

That's especially true since resume on that machine is sometimes delayed =

by a SATA problem - so it actually _does_ come back, but it has a =

30-second timeout because the SATA controller didn't resume. It seems to =

be very timing-dependent: fixing the irq#9 issue on that box actually =

exposed it, because it no longer gets 10,000 spurious interrupts to slow =

it down ;)

An audible beep is actually _much_ better than a visual LED flash, because =

you hear it even if you're not looking at the box intently for half a =

minute.

Trust me, if I had to watch the LED all the time, I'd just go even crazier =

than I am already ;^p

> > The real-time clock was literally the only thing I could find that didn=
't =

> > get cleared, and that obviously has some serious limitations size-wise.
> =

> What about vram ? the entire of it gets cleared or only the displayed
> part ?

There's no VRAM. It's all system RAM. This is integrated video. =


So I bet that it's all cleared (before it's even marked for the integrated =

graphics chip - which is done by the firmware by writing a magic =

register for "top or RAM").

And perhaps more importantly, accessing that hidden memory is actually =

pretty hard. Since it's past the "top of RAM" register, you can't do it =

from the CPU directly, you have to do it through the AGP bridge.

So I didn't verify it all. I did verify that random memory locations were =

cleared (actually, not cleared - it looks like the firmware wrote a =

test-pattern to it), and I also verified that at least part of the "ACPI =

NVS" are was also cleared (it's called "Non Volatile Storage", which is =

why I tried it, but in ACPI terms that seems to mean that it's nonvolatile =

as far as the ACPI stuff is concerned: the OS isn't supposed to change it, =

not non-volatile in the OS kind of sense).

The RTC has the added advantage that it literally exists in every single =

PC out there, ie it's a piece of hardware that has absolutely _zero_ =

firmware or hardware dependencies. That particular code will most likely =

run on everything. =


The thing is, I don't actually enjoy debugging my own machines. I _much_ =

prefer having other people debug _their_ machines, and fixing my machine =

in the process. So I didn't want just something that worked on the Mac =

Mini, I wanted something that works _universally_, so that hopefully =

people who are even crazier than me will waste _their_ time trying to get =

these machines working.

I say that with a smile, but I'm serious. There's simply no _point_ for me =

to write code that just fixes one machine. If I don't believe it can help =

fix a bigger problem, it's not worth doing.

Sometimes fixing just one machine tends to mean that a lot of other =

machines also suddenly start working. That has historically clearly not =

been the case wrt suspend-to-RAM, which is why I wanted something =

different.

		Linus
