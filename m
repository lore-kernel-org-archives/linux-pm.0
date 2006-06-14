From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Tue, 13 Jun 2006 17:29:28 -0700
Message-ID: <200606131729.29492.david-b@pacbell.net>
References: <Pine.LNX.4.64.0606131418580.5498@g5.osdl.org>
	<200606131620.45156.david-b@pacbell.net>
	<Pine.LNX.4.64.0606131635430.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606131635430.5498@g5.osdl.org>
Content-Disposition: inline
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
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 13 June 2006 4:46 pm, Linus Torvalds wrote:

> Maybe I'm more progressive than most, but I personally consider serial =

> lines pretty much dead.

If we had better debug options, I would never choose machines based =

on whether I can debug with them either!

Plus, serial consoles are very much alive in the embedded world.

Frankly you're far more likely to have a serial console than any
kind of graphical display during most development stages.  (And it
would just suck to develop during stages when serial download is the
best that's available.  Getting USB speeds is then a huge win!)



> > Although I must say I like Nigel's "BDI-2000 per developer" hack better.
> > Even though not all boxes can hook up to a JTAG module.  :(
> =

> Umm. Even more importantly, I don't think the JTAG interfaces for PC's ar=
e =

> necessarily even available. There is read-out logic for ARM's and embedde=
d =

> PPC, but have you ever seen anything for something non-embedded?

Beyond programmable logic analysers, no ... but then I don't really
hang around with that sort of hardware lately.  Once you stick such
an analyser on your PCI bus, there's quite a lot it can do ... just
like the firewire-as-pci-master case you mention below.

On the other hand, I'm not sure I'd notice four pads used for JTAG
testing/flashing on the factory floor as being all that different
from any other pads, so there might be more JTAG in PCs than is
readily apparent.

JTAG goes downmarket too.  There are even 8-bit microcontrollers that
support it.

 =

> A really useful trick the PPC people use was to put the firewire =

> controller into "anybody can read" mode, and use it as a kernel debugger =

> when it basically becomes a remote memory DMA engine. I used that to debu=
g =

> some kernel hangs, and it was very nice.

The net2280 PCI cards support the same kind of thing though USB 2.0, if
you set them up appropriately.  And presumably these x86 boxes with a
firewire controller can do that too.

 =

> However, that won't survive a power event, so it might be useful to debug =

> suspend problems, but generally not resume problems.

There seems to be a bit of art involved in manufacturing and deploying
field-debuggable systems nowadays.  One I'm not sure enough vendors
are following, or planning to follow.

- Dave
