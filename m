From: tony@atomide.com
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Fri, 23 Mar 2007 09:15:17 -0400
Message-ID: <20070323131515.GA12226@atomide.com>
References: <200703221344.l2MDi2Q9007989@olwen.urbana.css.mot.com>
	<200703221129.28722.david-b@pacbell.net>
	<20070322192647.GB20605@atomide.com>
	<200703221416.27103.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200703221416.27103.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: alexey.y.starikovskiy@intel.com, ben@simtec.co.uk, linux-arm@lists.arm.linux.org.uk, dirk.behme@de.bosch.com, pavel@ucw.cz, johannes@sipsolutions.net, nico@cam.org, linux-pm@lists.linux-foundation.org, g.liakhovetski@gmx.de
List-Id: linux-pm@vger.kernel.org

* David Brownell <david-b@pacbell.net> [070322 17:29]:
> On Thursday 22 March 2007 12:26 pm, Tony Lindgren wrote:
> > =

> > In addition to offering wakeup events for individual devices,
> > the device suspend states should be something like retention
> > and suspend, where:
> =

> Maybe ... worth discussing.  Most PCI drivers don't make
> that distinction, although they could (see below).
> =

> What they do instead is assume the lowest device power state
> ("suspend"), and re-initialize in resume().  If Linux starts to
> support standby and STR modes properly ... then it'd make sense
> to teach more PCI drivers to try using "retention" states.  But
> those drivers would still need to be prepared to re-init.

I agree, in general we should start taking advantage of the
device power states. =

 =

> > Retention is where clocks are off for a device, but power is on.
> > In this case the device registers are maintained in hardware.
> =

> Analagous to PCI D1 or D2.

Hmmm, I think with PCI it's just numbering where the power
consumption decreases as the nuber increases except for D3hot
and D3cold.
 =

> > Suspend is where clocks and power are off. In this state the
> > device registers are maintained in software.
> =

> Analagous to PCI D3, especially D3cold ... although PCI D3
> certainly allows the Vaux "power well" to power some parts
> of the device, so that not all register values get reset.

Maybe actually D3hot =3D retention and D3cold =3D suspend? =


PCI	SOCs		CLOCKS	POWER
D3hot	retention	off	on
D3cold	suspend		off	off
 =

> > Laptops mostly have suspend, while socs allow both retention
> > and suspend in many cases.
> =

> Not quite true, as noted above.  There are differences in how
> things are factored, but those mechanisms exist in both x86
> and SOC worlds.  One key difference from a Linux perspective
> is probably that without ACPI in the way, a SOC design can
> make much better use of the hardware PM capabilities.
> =

> Very few non-USB drivers address "retention" modes on laptops;
> USB host controller drivers need it to handle "remote wakeup",
> which one expects to work from "standby" and suspend-to-RAM.
> (Plus potentialy suspend-to-disk, but that's uncommon.)

Yeah, OK.

Tony
