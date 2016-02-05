From: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 6/6] arm64: add sysfs cpu_capacity attribute
Date: Fri, 5 Feb 2016 17:49:44 +0000
Message-ID: <20160205174944.GG11415@e106622-lin>
References: <1454500799-18451-1-git-send-email-juri.lelli@arm.com>
 <1454500799-18451-7-git-send-email-juri.lelli@arm.com>
 <56B4D98F.3090103@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56B4D98F.3090103-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dietmar Eggemann <dietmar.eggemann-5wv7dgnIgG8@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, morten.rasmussen-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On 05/02/16 17:19, Dietmar Eggemann wrote:
> Hi Juri,
>=20
> On 03/02/16 11:59, Juri Lelli wrote:
> > Add a sysfs cpu_capacity attribute with which it is possible to rea=
d and
> > write (thus over-writing default values) CPUs capacity. This might =
be
> > useful in situation where there is no way to get proper default val=
ues
> > at boot time.
> >=20
> > The new attribute shows up as:
> >=20
> >  /sys/devices/system/cpu/cpu*/cpu_capacity
> >=20
> > Cc: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
> > Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> > Cc: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > Cc: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
> > Signed-off-by: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>
> > ---
> >  arch/arm64/kernel/topology.c | 68 ++++++++++++++++++++++++++++++++=
++++++++++++
> >  1 file changed, 68 insertions(+)
> >=20
> > diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topol=
ogy.c
> > index f2513a6..f05cc07 100644
> > --- a/arch/arm64/kernel/topology.c
> > +++ b/arch/arm64/kernel/topology.c
> > @@ -40,6 +40,74 @@ bool arch_wants_init_cpu_capacity(void)
> >  	return true;
> >  }
> > =20
> > +#ifdef CONFIG_PROC_SYSCTL
> > +#include <asm/cpu.h>
> > +#include <linux/string.h>
> > +static ssize_t show_cpu_capacity(struct device *dev,
> > +				 struct device_attribute *attr,
> > +				 char *buf)
> > +{
> > +	struct cpu *cpu =3D container_of(dev, struct cpu, dev);
> > +	ssize_t rc;
> > +	int cpunum =3D cpu->dev.id;
> > +	unsigned long capacity =3D arch_scale_cpu_capacity(NULL, cpunum);
>=20
> Gives me an implicit declaration of function =E2=80=98arch_scale_cpu_=
capacity=E2=80=99
> error [without the commit fbc899610e1a ("arm64: Update
> arch_scale_cpu_capacity() to reflect change to define") on your
> git://linux-arm.org/linux-jl.git upstream/default_caps_v3 branch].
>=20
> Why don't you just return cpu_scale
>=20
> @@ -49,10 +49,8 @@ static ssize_t show_cpu_capacity(struct device *de=
v,
>  {
>         struct cpu *cpu =3D container_of(dev, struct cpu, dev);
>         ssize_t rc;
> -       int cpunum =3D cpu->dev.id;
> -       unsigned long capacity =3D arch_scale_cpu_capacity(NULL, cpun=
um);
>=20
> -       rc =3D sprintf(buf, "%lu\n", capacity);
> +       rc =3D sprintf(buf, "%lu\n", per_cpu(cpu_scale, cpu->dev.id))=
;
>=20
>         return rc;
>  }
>=20
> to get rid of this dependency?
>=20

Right! I'll fix this in the next version.

Thanks,

- Juri
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
