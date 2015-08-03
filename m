From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: kconfig: select THERMAL_WRITABLE_TRIPS for x86
 thermal
Date: Mon, 3 Aug 2015 10:19:35 -0700
Message-ID: <20150803171932.GA4118@localhost.localdomain>
References: <1438494401-3984-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <20150803031033.GA25688@localhost.localdomain>
 <1438616943.17718.2.camel@spandruv-DESK3.jf.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:36149 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171AbbHCRTq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Aug 2015 13:19:46 -0400
Received: by pdco4 with SMTP id o4so10859762pdc.3
        for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2015 10:19:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1438616943.17718.2.camel@spandruv-DESK3.jf.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 03, 2015 at 08:49:03AM -0700, Srinivas Pandruvada wrote:
> On Sun, 2015-08-02 at 20:10 -0700, Eduardo Valentin wrote:
> > Srinivas,
> >=20
> > On Sat, Aug 01, 2015 at 10:46:41PM -0700, Srinivas Pandruvada wrote:
> > > After the commit "thermal: core: Add Kconfig option to enable writabl=
e trips",
> > > user space tools like thermal daemon and Chrome OS DPTF thermal contr=
oller
> > > can no longer receive async events for thermal thresholds. Since we n=
eed to
> > > enable the new config introduced by above commit to allow writable tr=
ips.
> > > Selecting CONFIG_THERMAL_WRITABLE_TRIPS for x86 thermal drivers.
> >=20
> > I am fine with enabling the config on x86 drivers. However the
> > description is somewhat confusing. Are you sure you are not receiving
> > async events or you are not able to write on trip point files?
> >=20
> > Because that's all this option does (quoting thermal_core.c):
> >                 if (IS_ENABLED(CONFIG_THERMAL_WRITABLE_TRIPS) &&
> >                     mask & (1 << indx)) {
> >                         tz->trip_temp_attrs[indx].attr.attr.mode |=3D S=
_IWUSR;
> >                         tz->trip_temp_attrs[indx].attr.store =3D
> >                                                         trip_point_temp=
_store;
> >                 }
> >=20
> >=20
> > I am not really sure if this change is going to give your events back.
> >=20
> >=20
> > can you please confirm what you are trying to achieve here?
> >=20
> Sorry for the confusion. Since we can't write thresholds, we can't get
> asynchronous events for thresholds. This config prevents writable trips,
> hence we need to select this config.

OK... Can you then please rephrase your commit log? I don't see why the
kernel would not send you the events, even if you cannot write the
threshold. The events will go for the thresholds set by the kernel.
If you are not allowed to change the threshold, you are going to receive
the events at the wrong time, probably, right? Or did I miss something?

>=20
> Thanks,
> Srinivas
>=20
> > >=20
> > > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.c=
om>
> > > ---
> > >  drivers/thermal/Kconfig | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >=20
> > > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > > index 118938e..0e3b576 100644
> > > --- a/drivers/thermal/Kconfig
> > > +++ b/drivers/thermal/Kconfig
> > > @@ -275,6 +275,7 @@ config X86_PKG_TEMP_THERMAL
> > >  	tristate "X86 package temperature thermal driver"
> > >  	depends on X86_THERMAL_VECTOR
> > >  	select THERMAL_GOV_USER_SPACE
> > > +	select THERMAL_WRITABLE_TRIPS
> > >  	default m
> > >  	help
> > >  	  Enable this to register CPU digital sensor for package temperatur=
e as
> > > @@ -296,6 +297,7 @@ config INTEL_SOC_DTS_THERMAL
> > >  	tristate "Intel SoCs DTS thermal driver"
> > >  	depends on X86
> > >  	select INTEL_SOC_DTS_IOSF_CORE
> > > +	select THERMAL_WRITABLE_TRIPS
> > >  	help
> > >  	  Enable this to register Intel SoCs (e.g. Bay Trail) platform digi=
tal
> > >  	  temperature sensor (DTS). These SoCs have two additional DTSs in
> > > @@ -322,6 +324,7 @@ config INT340X_THERMAL
> > >  	select ACPI_THERMAL_REL
> > >  	select ACPI_FAN
> > >  	select INTEL_SOC_DTS_IOSF_CORE
> > > +	select THERMAL_WRITABLE_TRIPS
> > >  	help
> > >  	  Newer laptops and tablets that use ACPI may have thermal sensors =
and
> > >  	  other devices with thermal control capabilities outside the core
> > > --=20
> > > 2.4.3
> > >=20
>=20
>=20

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJVv6KfAAoJEMLUO4d9pOJWeZAH/iguIHSJcMd8+qhSIiu5KAY8
rfiqj4F1s18Ekvk2vRxQfUpURC0Ol3k3Xds1iOm8KeEWFBxO0mnnXGmX75VvlJSr
tlXzul3prciowGpLYFf2JDD+FBWbczfDSxpNnIt6WnMVqjQUHi4uYU1oxHe6iehR
+Rl4XNTRCaBsjJYJQ/XtOi5LTwHujogoxd66/AxWhPrqZeLHcb4mSIWbhDo6gDRT
y8sdW2xlP6Vdm57Om6NyGzQ5rrNWDrziHh3wtRVxmRNmTQRFeMFm1y3viu1HLQzx
CEHNws2Q3QQHnCabXhteAx9yvxgsAQqqhvZT51j4uQyS+EISjc/LDevPKg9ux2A=
=yAhQ
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
