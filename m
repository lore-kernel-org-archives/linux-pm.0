From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 13/17] thermal: int340x: allow compile test
Date: Thu, 17 Sep 2015 15:48:00 -0700
Message-ID: <1442530080.2489.5.camel@spandruv-desk3.jf.intel.com>
References: <1441858273-4017-1-git-send-email-edubezval@gmail.com>
	 <1441858273-4017-14-git-send-email-edubezval@gmail.com>
	 <CAMuHMdXd5=qZd17czeYPQMBDaUYyC7JCB+1S49dVPfgm=Xp_iQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:52789 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751633AbbIQWsW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 17 Sep 2015 18:48:22 -0400
In-Reply-To: <CAMuHMdXd5=qZd17czeYPQMBDaUYyC7JCB+1S49dVPfgm=Xp_iQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Rui Zhang <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>, "lan,Tianyu" <tianyu.lan@intel.com>, Ilkka Koskinen <ilkka.koskinen@linux.intel.com>

On Thu, 2015-09-10 at 08:31 +0200, Geert Uytterhoeven wrote:
> On Thu, Sep 10, 2015 at 6:11 AM, Eduardo Valentin <edubezval@gmail.co=
m> wrote:
> > --- a/drivers/thermal/Kconfig
> > +++ b/drivers/thermal/Kconfig
> > @@ -317,7 +317,7 @@ config INTEL_QUARK_DTS_THERMAL
> >
> >  config INT340X_THERMAL
> >         tristate "ACPI INT340X thermal drivers"
> > -       depends on X86 && ACPI
> > +       depends on (X86 && ACPI) || COMPILE_TEST
> >         select THERMAL_GOV_USER_SPACE
> >         select ACPI_THERMAL_REL
> >         select ACPI_FAN
>=20
> This driver selects INTEL_SOC_DTS_IOSF_CORE, which uses an x86-specif=
ic
> header file.
>=20
> drivers/thermal/int340x_thermal/int3400_thermal.c: In function
> =E2=80=98int3400_thermal_get_uuids=E2=80=99:
> drivers/thermal/int340x_thermal/int3400_thermal.c:120: error:
> dereferencing pointer to incomplete type
>=20
> Missing #include <linux/fs.h>
>=20
> drivers/thermal/int340x_thermal/acpi_thermal_rel.c: In function
> =E2=80=98acpi_parse_trt=E2=80=99:
> drivers/thermal/int340x_thermal/acpi_thermal_rel.c:85: error: implici=
t
> declaration of function =E2=80=98acpi_has_method=E2=80=99
>=20
> Missing #include <acpi/acpi_bus.h>
>=20
> drivers/thermal/int340x_thermal/acpi_thermal_rel.c: In function
> =E2=80=98acpi_parse_trt=E2=80=99:
> drivers/thermal/int340x_thermal/acpi_thermal_rel.c:125: error:
> implicit declaration of function =E2=80=98acpi_bus_get_device=E2=80=99
>=20
> Definition depends on CONFIG_ACPI
>=20
Yes. This has dependency on ACPI. We need to also include ACPI modules
to build. For IOSF we need to have stub functions for core calls.

Thanks,
Srinivas

> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linu=
x-m68k.org
>=20
> In personal conversations with technical people, I call myself a hack=
er. But
> when I'm talking to journalists I just say "programmer" or something =
like that.
>                                 -- Linus Torvalds
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


