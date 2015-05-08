From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH RFC 1/5] ACPI / containers : add support for ACPI0010 processor container
Date: Fri, 08 May 2015 16:06:46 +0200
Message-ID: <2334052.J3vzukF2MM@vostro.rjw.lan>
References: <1430922690-6966-1-git-send-email-sudeep.holla@arm.com> <1430922690-6966-2-git-send-email-sudeep.holla@arm.com> <554C78C2.706@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <554C78C2.706@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Al Stone <ahs3@redhat.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Id: linux-pm@vger.kernel.org

On Friday, May 08, 2015 04:50:10 PM Hanjun Guo wrote:
> Hi Sudeep,
>=20
> On 2015=E5=B9=B405=E6=9C=8806=E6=97=A5 22:31, Sudeep Holla wrote:
> > ACPI 6.0 adds support for optional processor container device which=
 may
> > contain child objects that are either processor devices or other pr=
ocessor
> > containers. This allows representing hierarchical processor topolog=
ies.
> >
> > It is declared using the _HID of ACPI0010. It may also have _CID of
> > PNP0A05, which represents a generic container device.
>=20
> Container device helps support hotplug of nodes, CPUs, and memory,
> does this container device ACPI0010 used for the same purpose?

That's correct and the patch isn't.

Thanks!


> For my understanding, ACPI0010 is used to abstract CPU topology
> like cluster, not for hotplug purpose, maybe I missed something,
> or you just need this container driver for later use?
>=20
> Thanks
> Hanjun
>=20
> >
> > This patch enables the support for these ACPI processor containers.
> >
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >   Documentation/memory-hotplug.txt | 2 +-
> >   drivers/acpi/container.c         | 1 +
> >   2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/memory-hotplug.txt b/Documentation/memor=
y-hotplug.txt
> > index ce2cfcf35c27..bdbf7bb88d5d 100644
> > --- a/Documentation/memory-hotplug.txt
> > +++ b/Documentation/memory-hotplug.txt
> > @@ -124,7 +124,7 @@ config options.
> >
> >   - As a related configuration, if your box has a feature of NUMA-n=
ode hotplug
> >     via ACPI, then this option is necessary too.
> > -    ACPI0004,PNP0A05 and PNP0A06 Container Driver (under ACPI Supp=
ort menu)
> > +    ACPI0004, ACPI0010, PNP0A05 and PNP0A06 Container Driver (unde=
r ACPI Support menu)
> >       (CONFIG_ACPI_CONTAINER).
> >       This option can be kernel module too.
> >
> > diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
> > index c8ead9f97375..8c041b9ac359 100644
> > --- a/drivers/acpi/container.c
> > +++ b/drivers/acpi/container.c
> > @@ -36,6 +36,7 @@ ACPI_MODULE_NAME("container");
> >
> >   static const struct acpi_device_id container_device_ids[] =3D {
> >   	{"ACPI0004", 0},
> > +	{"ACPI0010", 0},
> >   	{"PNP0A05", 0},
> >   	{"PNP0A06", 0},
> >   	{"", 0},
> >

--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
