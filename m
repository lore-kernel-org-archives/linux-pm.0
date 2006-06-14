From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH 2/2] Fix console handling during
 suspend/resume
Date: Tue, 13 Jun 2006 17:06:09 -0700
Message-ID: <20060613170609.3291ce36.rdunlap@xenotime.net>
References: <Pine.LNX.4.64.0606131418580.5498@g5.osdl.org>
	<200606131620.45156.david-b@pacbell.net>
	<Pine.LNX.4.64.0606131635430.5498@g5.osdl.org>
	<200606141000.12260.ncunningham@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200606141000.12260.ncunningham@linuxmail.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: david-b@pacbell.net, torvalds@osdl.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Wed, 14 Jun 2006 10:00:08 +1000 Nigel Cunningham wrote:

> Hi.
> =

> On Wednesday 14 June 2006 09:46, Linus Torvalds wrote:
> > On Tue, 13 Jun 2006, David Brownell wrote:
> > > Here's a related patch (well, "hack") I found helpful ... specificall=
y to
> > > help let _serial_ consoles be more useful.
> >
> > I just checked.
> >
> > I think exactly _two_ of the six machines I have around my desk have
> > serial ports, and of those two, one is permanently turned off because i=
t's
> > old, noisy, and just not interesting.
> >
> > Maybe I'm more progressive than most, but I personally consider serial
> > lines pretty much dead.
> =

> Usb to serial converters are not completely unheard of, though. My old =

> omnibook even came with one. It's the one bit I still use :)

and usb serial-console works, although not during early init (it has
to wait for the usb subsystem to be ready).

> > > Although I must say I like Nigel's "BDI-2000 per developer" hack bett=
er.
> > > Even though not all boxes can hook up to a JTAG module.  :(
> >
> > Umm. Even more importantly, I don't think the JTAG interfaces for PC's =
are
> > necessarily even available. There is read-out logic for ARM's and embed=
ded
> > PPC, but have you ever seen anything for something non-embedded?
> =

> Yeah. Sort of kills that idea, doesn't it?
> =

> > A really useful trick the PPC people use was to put the firewire
> > controller into "anybody can read" mode, and use it as a kernel debugger
> > when it basically becomes a remote memory DMA engine. I used that to de=
bug
> > some kernel hangs, and it was very nice.
> >
> > However, that won't survive a power event, so it might be useful to deb=
ug
> > suspend problems, but generally not resume problems.
> =

> Since just about every problem occurs at resume time, it really does seem=
 to =

> me to be the case that we have to use the rtc. Great idea, by the way.


---
~Randy
