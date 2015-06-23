From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 7/8] cpufreq: st: Provide runtime initialised driver for
 ST's platforms
Date: Tue, 23 Jun 2015 09:28:57 +0100
Message-ID: <20150623082857.GG3245@x1>
References: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
 <1434987837-24212-8-git-send-email-lee.jones@linaro.org>
 <1435046411.4528.6.camel@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1435046411.4528.6.camel-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ajitpal.singh-qxv4g6HH51o@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Tue, 23 Jun 2015, Paul Bolle wrote:

> On Mon, 2015-06-22 at 16:43 +0100, Lee Jones wrote:
> > --- a/drivers/cpufreq/Kconfig.arm
> > +++ b/drivers/cpufreq/Kconfig.arm
> =20
> > +config ARM_ST_CPUFREQ
> > +> 	> bool "ST CPUFreq support"
> > +> 	> depends on SOC_STIH407
> > +> 	> help
> > +> 	>   OPP list for cpufreq-dt driver can be provided through DT o=
r can be
> > +> 	>   created at runtime.  Select this if you want create OPP lis=
t at runtime.
>=20
>=20
> > --- a/drivers/cpufreq/Makefile
> > +++ b/drivers/cpufreq/Makefile
>=20
> > +obj-$(CONFIG_ARM_ST_CPUFREQ)		+=3D st-cpufreq.o
>=20
> > --- /dev/null
> > +++ b/drivers/cpufreq/st-cpufreq.c
>=20
> > + * This program is free software; you can redistribute it and/or m=
odify
> > + * it under the terms of the GNU General Public License as publish=
ed by
> > + * the Free Software Foundation; either version 2 of the License, =
or
> > + * (at your option) any later version.
>=20
> > +#include <linux/module.h>
>=20
> > +MODULE_DEVICE_TABLE(of, sti_cpufreq_of_match);
> >=20
> > +module_platform_driver(sti_cpufreq);
>=20
> >=20
> > +MODULE_AUTHOR("Ajitpal Singh <ajitpal.singh-qxv4g6HH51o@public.gmane.org>");
> > +MODULE_DESCRIPTION("Creates an OPP list for cpufreq-cpu0 at runtim=
e");
> > +MODULE_LICENSE("GPL v2");
>=20
>=20
> (There's a mismatch between the license used in the comment at the to=
p
> of this file and the ident used in the MODULE_LICENSE() macro. See
> include/linux/module.h.)
>=20
> st-cpufreq.o can only be built-in. But the code contains of few lines
> that are only useful if the code can be modular. Was ARM_ST_CPUFREQ
> perhaps meant to be tristate?

All noted.  Will fix.  Thanks Paul.

BTW, do you have a script that does this now, or are you still
hand-rolling these?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
