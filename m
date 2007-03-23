From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Fri, 23 Mar 2007 11:25:23 -0700
Message-ID: <200703231125.25180.david-b@pacbell.net>
References: <200703221344.l2MDi2Q9007989@olwen.urbana.css.mot.com>
	<200703221416.27103.david-b@pacbell.net>
	<20070323131515.GA12226@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070323131515.GA12226@atomide.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: tony@atomide.com
Cc: alexey.y.starikovskiy@intel.com, ben@simtec.co.uk, linux-arm@lists.arm.linux.org.uk, dirk.behme@de.bosch.com, pavel@ucw.cz, johannes@sipsolutions.net, nico@cam.org, linux-pm@lists.linux-foundation.org, g.liakhovetski@gmx.de
List-Id: linux-pm@vger.kernel.org

On Friday 23 March 2007 6:15 am, tony@atomide.com wrote:
> * David Brownell <david-b@pacbell.net> [070322 17:29]:
> > On Thursday 22 March 2007 12:26 pm, Tony Lindgren wrote:

> > > Retention is where clocks are off for a device, but power is on.
> > > In this case the device registers are maintained in hardware.
> > =

> > Analagous to PCI D1 or D2.
> =

> Hmmm, I think with PCI it's just numbering where the power
> consumption decreases as the nuber increases except for D3hot
> and D3cold.

There are additional constraints ... as the number increases,
more device state can be discarded (significant!), and there
are longer latencies to return to D0 (almost noise).


> > > Suspend is where clocks and power are off. In this state the
> > > device registers are maintained in software.
> > =

> > Analagous to PCI D3, especially D3cold ... although PCI D3
> > certainly allows the Vaux "power well" to power some parts
> > of the device, so that not all register values get reset.
> =

> Maybe actually D3hot =3D retention and D3cold =3D suspend? =

> =

> PCI       SOCs        CLOCKS	POWER
> D3hot     retention   off	on
> D3cold    suspend     off	off

That's why I said "especially", but there's other funkiness
beyond the fact that the PCI spec leaves out "clocks" and
other such implementation details.

In particular, ISTR transition D3hot->D0 can optionally add
some level of device reset, so it's not quite as direct a
mapping as D3cold.  Plus there's Vaux letting PCI devices
live in two overlapping power domains.

- Dave


> > > Laptops mostly have suspend, while socs allow both retention
> > > and suspend in many cases.
> > =

> > Not quite true, as noted above.  There are differences in how
> > things are factored, but those mechanisms exist in both x86
> > and SOC worlds.  One key difference from a Linux perspective
> > is probably that without ACPI in the way, a SOC design can
> > make much better use of the hardware PM capabilities.
> > =

> > Very few non-USB drivers address "retention" modes on laptops;
> > USB host controller drivers need it to handle "remote wakeup",
> > which one expects to work from "standby" and suspend-to-RAM.
> > (Plus potentialy suspend-to-disk, but that's uncommon.)
> =

> Yeah, OK.
> =

> Tony
> =
