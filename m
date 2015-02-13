From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/5] ARM: dove: create a proper PMU driver for power
 domains, PMU IRQs and resets
Date: Fri, 13 Feb 2015 14:11:52 +0000
Message-ID: <20150213141151.GA8656@n2100.arm.linux.org.uk>
References: <20140427132312.GC26756@n2100.arm.linux.org.uk>
 <E1WeP8f-0000Uo-1q@rmk-PC.arm.linux.org.uk>
 <CAPDyKFoboE4iKyom86+EwHHTQAGpgKxGq969yrjQVpqizk-SLA@mail.gmail.com>
 <20150213132924.GA27774@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:39020 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533AbbBMOMA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Feb 2015 09:12:00 -0500
Content-Disposition: inline
In-Reply-To: <20150213132924.GA27774@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Pawel Moll <pawel.moll@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tomasz Figa <tomasz.figa@gmail.com>, Rob Herring <robh+dt@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

On Fri, Feb 13, 2015 at 01:29:25PM +0000, Russell King - ARM Linux wrot=
e:
> On Mon, Apr 28, 2014 at 01:55:40PM +0200, Ulf Hansson wrote:
> > On 27 April 2014 15:29, Russell King <rmk+kernel@arm.linux.org.uk> =
wrote:
> > > The PMU device contains an interrupt controller, power control an=
d
> > > resets.  The interrupt controller is a little sub-standard in tha=
t
> > > there is no race free way to clear down pending interrupts, so we=
 try
> > > to avoid problems by reducing the window as much as possible, and
> > > clearing as infrequently as possible.
> > >
> > > The interrupt support is implemented using an IRQ domain, and the
> > > parent interrupt referenced in the standard DT way.
> > >
> > > The power domains and reset support is closely related - there is=
 a
> > > defined sequence for powering down a domain which is tightly coup=
led
> > > with asserting the reset.  Hence, it makes sense to group these t=
wo
> > > together.
> > >
> > > This patch adds the core PMU driver: power domains must be define=
d in
> > > the DT file in order to make use of them.  The reset controller c=
an
> > > be referenced in the standard way for reset controllers.
> >=20
> > Hi Russell,
> >=20
> > This patch would be simplified if this was based upon the not yet
> > merged patchset from Tomasz Figa, "[PATCH v3 0/3] Generic Device Tr=
ee
> > based power domain look-up".
> >=20
> > For example you would likely not need to add some of the marvel
> > specific DT bindings, and you wouldn=E2=80=99t need the bus_notifie=
rs to add
> > devices to the power domain. I guess I just though it could be usef=
ul
> > input to consider while going forward, unless you already knew.
>=20
> In 3.19, I notice something of an odd behaviour.
>=20
> My vMeta driver has runtime PM support enabled.  When I explicitly re=
gister
> the PM domain in the pmu driver via a bus notifier, I see:
>=20
> root@cubox:~# cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
>     domain                      status         slaves
>            /device                                      runtime statu=
s
> ---------------------------------------------------------------------=
-
> gpu-domain                      on
>     /devices/platform/vivante/etnaviv-gpu,2d            active
> vpu-domain                      off
>     /devices/platform/mbus/mbus:internal-regs/f1c00000.video-decoder =
 suspended
>=20
> But when I disable that, and let the generic code do the registration=
,
> I instead get:
>=20
> root@cubox:~# cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
>     domain                      status         slaves
>            /device                                      runtime statu=
s
> ---------------------------------------------------------------------=
-
> gpu-domain                      on
>     /devices/platform/vivante/etnaviv-gpu,2d            active
> vpu-domain                      on
>     /devices/platform/mbus/mbus:internal-regs/f1c00000.video-decoder =
 suspended
>=20
> The difference being that the vpu domain remains powered.
>=20
> The only difference code-wise seems to be when genpd_dev_pm_attach() =
is
> called.  In the working case, it's before the device is considered fo=
r
> probing.  In the non-working case, it's just before the device is pro=
bed.
>=20
> With debugging enabled in the PM domain code, with the former case I =
get:
>=20
> Added domain provider from /mbus/internal-regs/power-management@d0000=
/vpu-domain
> platform f1c00000.video-decoder: adding to PM domain vpu-domain
> platform f1c00000.video-decoder: __pm_genpd_add_device()
>=20
> With the latter non-working case:
>=20
> Added domain provider from /mbus/internal-regs/power-management@d0000=
/vpu-domain
> ...
> ap510-vmeta f1c00000.video-decoder: adding to PM domain vpu-domain
> ap510-vmeta f1c00000.video-decoder: __pm_genpd_add_device()
> vpu-domain: Power-on latency exceeded, new value 1578 ns
>=20
> Neither of these debug messages provide much hint as to what the
> difference is, or the cause of the PM domain code being de-sync'd
> with its devices.
>=20
> Maybe the PM code needs more debugging in it, and maybe the debugfs
> file should always be present if debugfs support is enabled?

The vmeta driver does this in its probe function:

        pm_runtime_use_autosuspend(vi->dev);
        pm_runtime_set_autosuspend_delay(vi->dev, 100);
        pm_runtime_enable(vi->dev);

since it doesn't touch the hardware, and the hardware starts off at
boot time in "suspended" mode.

I think what's going on is that there's a difference in the expectation=
s
from the PM domain code vs the runtime PM code.  I refer to section 5
of the runtime PM documentation:

| 5. Runtime PM Initialization, Device Probing and Removal
|=20
| Initially, the runtime PM is disabled for all devices, which means th=
at the
| majority of the runtime PM helper functions described in Section 4 wi=
ll return
| -EAGAIN until pm_runtime_enable() is called for the device.
|=20
| In addition to that, the initial runtime PM status of all devices is
| 'suspended', but it need not reflect the actual physical state of the=
 device.
| Thus, if the device is initially active (i.e. it is able to process I=
/O), its
| runtime PM status must be changed to 'active', with the help of
| pm_runtime_set_active(), before pm_runtime_enable() is called for the=
 device.

However, the PM domain code seems to always power up the PM domain when
a device is attached to it:

int genpd_dev_pm_attach(struct device *dev)
{
=2E..
        pm_genpd_poweron(pd);

        return 0;
}
EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);

So, the PM domain code ends up disagreeing with the runtime PM code abo=
ut
the state of the device.

I think your commit (2ed127697eb1 "PM / Domains: Power on the PM domain
right after attach completes") is fundamentally wrong.  The assertion
you make in there is built upon the assumption that every driver will
call pm_runtime_set_active(), which is not an assumption you can make.

Instead, you should be doing is to hook into __pm_runtime_set_status()
and use that to trigger the PM domain power up so that the runtime PM
and PM domain state is always in step with each other.

What I'm certain of is that the current situation is just totally crazy=
=2E

--=20
=46TTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps u=
p
according to speedtest.net.
