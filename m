From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/5] ARM: dove: create a proper PMU driver for power
 domains, PMU IRQs and resets
Date: Fri, 13 Feb 2015 13:29:25 +0000
Message-ID: <20150213132924.GA27774@n2100.arm.linux.org.uk>
References: <20140427132312.GC26756@n2100.arm.linux.org.uk>
 <E1WeP8f-0000Uo-1q@rmk-PC.arm.linux.org.uk>
 <CAPDyKFoboE4iKyom86+EwHHTQAGpgKxGq969yrjQVpqizk-SLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:38955 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520AbbBMN3g (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Feb 2015 08:29:36 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFoboE4iKyom86+EwHHTQAGpgKxGq969yrjQVpqizk-SLA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>

On Mon, Apr 28, 2014 at 01:55:40PM +0200, Ulf Hansson wrote:
> On 27 April 2014 15:29, Russell King <rmk+kernel@arm.linux.org.uk> wr=
ote:
> > The PMU device contains an interrupt controller, power control and
> > resets.  The interrupt controller is a little sub-standard in that
> > there is no race free way to clear down pending interrupts, so we t=
ry
> > to avoid problems by reducing the window as much as possible, and
> > clearing as infrequently as possible.
> >
> > The interrupt support is implemented using an IRQ domain, and the
> > parent interrupt referenced in the standard DT way.
> >
> > The power domains and reset support is closely related - there is a
> > defined sequence for powering down a domain which is tightly couple=
d
> > with asserting the reset.  Hence, it makes sense to group these two
> > together.
> >
> > This patch adds the core PMU driver: power domains must be defined =
in
> > the DT file in order to make use of them.  The reset controller can
> > be referenced in the standard way for reset controllers.
>=20
> Hi Russell,
>=20
> This patch would be simplified if this was based upon the not yet
> merged patchset from Tomasz Figa, "[PATCH v3 0/3] Generic Device Tree
> based power domain look-up".
>=20
> For example you would likely not need to add some of the marvel
> specific DT bindings, and you wouldn=E2=80=99t need the bus_notifiers=
 to add
> devices to the power domain. I guess I just though it could be useful
> input to consider while going forward, unless you already knew.

In 3.19, I notice something of an odd behaviour.

My vMeta driver has runtime PM support enabled.  When I explicitly regi=
ster
the PM domain in the pmu driver via a bus notifier, I see:

root@cubox:~# cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
    domain                      status         slaves
           /device                                      runtime status
----------------------------------------------------------------------
gpu-domain                      on
    /devices/platform/vivante/etnaviv-gpu,2d            active
vpu-domain                      off
    /devices/platform/mbus/mbus:internal-regs/f1c00000.video-decoder  s=
uspended

But when I disable that, and let the generic code do the registration,
I instead get:

root@cubox:~# cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
    domain                      status         slaves
           /device                                      runtime status
----------------------------------------------------------------------
gpu-domain                      on
    /devices/platform/vivante/etnaviv-gpu,2d            active
vpu-domain                      on
    /devices/platform/mbus/mbus:internal-regs/f1c00000.video-decoder  s=
uspended

The difference being that the vpu domain remains powered.

The only difference code-wise seems to be when genpd_dev_pm_attach() is
called.  In the working case, it's before the device is considered for
probing.  In the non-working case, it's just before the device is probe=
d.

With debugging enabled in the PM domain code, with the former case I ge=
t:

Added domain provider from /mbus/internal-regs/power-management@d0000/v=
pu-domain
platform f1c00000.video-decoder: adding to PM domain vpu-domain
platform f1c00000.video-decoder: __pm_genpd_add_device()

With the latter non-working case:

Added domain provider from /mbus/internal-regs/power-management@d0000/v=
pu-domain
=2E..
ap510-vmeta f1c00000.video-decoder: adding to PM domain vpu-domain
ap510-vmeta f1c00000.video-decoder: __pm_genpd_add_device()
vpu-domain: Power-on latency exceeded, new value 1578 ns

Neither of these debug messages provide much hint as to what the
difference is, or the cause of the PM domain code being de-sync'd
with its devices.

Maybe the PM code needs more debugging in it, and maybe the debugfs
file should always be present if debugfs support is enabled?

--=20
=46TTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps u=
p
according to speedtest.net.
