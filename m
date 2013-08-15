From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal: new asus driver
Date: Thu, 15 Aug 2013 15:24:01 +0800
Message-ID: <1376551441.2335.118.camel@rzhang-lenovo>
References: <1375829300-14081-1-git-send-email-felipe.contreras@gmail.com>
	 <1376551353.2335.117.camel@rzhang-lenovo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:2832 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759993Ab3HOHXS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 15 Aug 2013 03:23:18 -0400
In-Reply-To: <1376551353.2335.117.camel@rzhang-lenovo>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-pm@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>, linux-kernel@vger.kernel.org, corentin.chary@gmail.com, matthew.garrett@nebula.com, x86-drivers <platform-driver-x86@vger.kernel.org>

On =E5=9B=9B, 2013-08-15 at 15:22 +0800, Zhang Rui wrote:
> On =E4=BA=8C, 2013-08-06 at 17:48 -0500, Felipe Contreras wrote:
> > Simple driver to enable control of the fan in ASUS laptops. So far =
this
> > has only been tested in ASUS Zenbook Prime UX31A, but according to =
some
> > online reference [1], it should work in other models as well.
> >=20
> I'd rather prefer to do this in the vendor driver like asus-laptop.c.
> Say, it is the asus-laptop driver that knows the fan control ability =
of
> the platform and register to the thermal framework.
>=20
> > Another source was a patch acpi4asus-user's mailing list [2].
> >=20
> > [1]
> > http://forum.notebookreview.com/asus/705656-fan-control-asus-prime-=
ux31-ux31a-ux32a-ux32vd.html
> > [2]
> > http://www.mail-archive.com/acpi4asus-user@lists.sourceforge.net/ms=
g00065.html
> >=20
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> >=20
> > I've never implemented a driver like this, so I've no idea if this =
is the right way to do it.
> >=20
> >  drivers/thermal/Kconfig        |  7 ++++
> >  drivers/thermal/Makefile       |  1 +
> >  drivers/thermal/asus_thermal.c | 94 ++++++++++++++++++++++++++++++=
++++++++++++
> >  3 files changed, 102 insertions(+)
> >  create mode 100644 drivers/thermal/asus_thermal.c
> >=20
> > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > index e988c81..0c5b624 100644
> > --- a/drivers/thermal/Kconfig
> > +++ b/drivers/thermal/Kconfig
> > @@ -184,4 +184,11 @@ menu "Texas Instruments thermal drivers"
> >  source "drivers/thermal/ti-soc-thermal/Kconfig"
> >  endmenu
> > =20
> > +config ASUS_THERMAL
> > +	tristate "ASUS thermal driver"
> > +	depends on THERMAL
> > +	depends on X86
> > +	help
> > +	  Enables control of the fan in ASUS laptops.
> > +
> >  endif
> > diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> > index 67184a2..ab4ea6f 100644
> > --- a/drivers/thermal/Makefile
> > +++ b/drivers/thermal/Makefile
> > @@ -25,3 +25,4 @@ obj-$(CONFIG_DB8500_CPUFREQ_COOLING)	+=3D db8500_=
cpufreq_cooling.o
> >  obj-$(CONFIG_INTEL_POWERCLAMP)	+=3D intel_powerclamp.o
> >  obj-$(CONFIG_X86_PKG_TEMP_THERMAL)	+=3D x86_pkg_temp_thermal.o
> >  obj-$(CONFIG_TI_SOC_THERMAL)	+=3D ti-soc-thermal/
> > +obj-$(CONFIG_ASUS_THERMAL)	+=3D asus_thermal.o
> > diff --git a/drivers/thermal/asus_thermal.c b/drivers/thermal/asus_=
thermal.c
> > new file mode 100644
> > index 0000000..eceeee3
> > --- /dev/null
> > +++ b/drivers/thermal/asus_thermal.c
> > @@ -0,0 +1,94 @@
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/init.h>
> > +#include <linux/acpi.h>
> > +#include <linux/thermal.h>
> > +#include <linux/dmi.h>
> > +
> > +MODULE_AUTHOR("Felipe Contreras <felipe.contreras@gmail.com>");
> > +MODULE_DESCRIPTION("ASUS fan driver");
> > +MODULE_LICENSE("GPL");
> > +
> > +static struct thermal_cooling_device *cdev;
> > +
> > +static int fan_get_max_state(struct thermal_cooling_device *cdev,
> > +		unsigned long *state)
> > +{
> > +	*state =3D 0xff;
> > +	return 0;
> > +}
> > +
> > +static int fan_get_cur_state(struct thermal_cooling_device *cdev,
> > +		unsigned long *state)
> > +{
> > +	struct acpi_object_list params;
> > +	union acpi_object in_objs[1];
> > +	unsigned long long value;
> > +	acpi_status r;
> > +
> > +	params.count =3D ARRAY_SIZE(in_objs);
> > +	params.pointer =3D in_objs;
> > +	in_objs[0].type =3D ACPI_TYPE_INTEGER;
> > +	in_objs[0].integer.value =3D 0;
> > +
> > +	r =3D acpi_evaluate_integer(NULL, "\\_TZ.RFAN", &params, &value);
> > +	if (r !=3D AE_OK)
> > +		return r;
> > +
> > +	*state =3D value;
> > +
> > +	return 0;
> > +}
> > +
> > +static int fan_set(struct thermal_cooling_device *cdev, int fan, i=
nt speed)
> > +{
> > +	struct acpi_object_list params;
> > +	union acpi_object in_objs[2];
> > +	unsigned long long value;
> > +
> > +	params.count =3D ARRAY_SIZE(in_objs);
> > +	params.pointer =3D in_objs;
> > +	in_objs[0].type =3D ACPI_TYPE_INTEGER;
> > +	in_objs[0].integer.value =3D fan;
> > +	in_objs[1].type =3D ACPI_TYPE_INTEGER;
> > +	in_objs[1].integer.value =3D speed;
> > +
> > +	return acpi_evaluate_integer(NULL, "\\_SB.PCI0.LPCB.EC0.SFNV", &p=
arams, &value);
> > +}
> > +
> I checked a couple of BIOS, and it seems that both of these two metho=
ds
> can be invoked by ATKD.WMNB indirectly.
> So I'm wondering if it is proper to invoke these two methods directly=
,
> and if these are some features/functionalities that are still missing=
 in
> the asus-laptop driver.
>=20
> CC Corentin and Matthew.
>=20
CC x86 platform drivers mailing list as well.

> thanks,
> rui
> > +static int fan_set_cur_state(struct thermal_cooling_device *cdev,
> > +		unsigned long state)
> > +{
> > +	return fan_set(cdev, 1, state);
> > +}
> > +
> > +static int fan_set_auto(struct thermal_cooling_device *cdev)
> > +{
> > +	return fan_set(cdev, 0, 0);
> > +}
> > +
> > +static const struct thermal_cooling_device_ops fan_cooling_ops =3D=
 {
> > +	.get_max_state =3D fan_get_max_state,
> > +	.get_cur_state =3D fan_get_cur_state,
> > +	.set_cur_state =3D fan_set_cur_state,
> > +};
> > +
> > +static int __init fan_init(void)
> > +{
> > +	if (strcmp(dmi_get_system_info(DMI_SYS_VENDOR), "ASUSTeK COMPUTER=
 INC."))
> > +		return -ENODEV;
> > +	cdev =3D thermal_cooling_device_register("Fan", NULL, &fan_coolin=
g_ops);
> > +	if (IS_ERR(cdev))
> > +		return PTR_ERR(cdev);
> > +	fan_set_auto(cdev);
> > +	return 0;
> > +}
> > +
> > +static void __exit fan_exit(void)
> > +{
> > +	fan_set_auto(cdev);
> > +	thermal_cooling_device_unregister(cdev);
> > +}
> > +
> > +module_init(fan_init);
> > +module_exit(fan_exit);
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


