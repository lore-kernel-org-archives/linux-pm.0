From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: remove power allocator from list of default
 governors
Date: Wed, 5 Aug 2015 11:49:41 -0700
Message-ID: <20150805184938.GC4161@localhost.localdomain>
References: <20150804163921.GA36852@dtor-ws>
 <20150805083755.GC2688@e104805>
 <20150805163539.GA3603@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E/DnYTRukya0zdZ1"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33623 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751686AbbHEStp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 5 Aug 2015 14:49:45 -0400
Content-Disposition: inline
In-Reply-To: <20150805163539.GA3603@dtor-ws>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Tushar Dave <tushar.n.dave@intel.com>, Lan Tianyu <tianyu.lan@intel.com>, Punit Agrawal <Punit.Agrawal@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


--E/DnYTRukya0zdZ1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 05, 2015 at 09:35:39AM -0700, Dmitry Torokhov wrote:
> On Wed, Aug 05, 2015 at 09:37:55AM +0100, Javi Merino wrote:
> > On Tue, Aug 04, 2015 at 05:39:21PM +0100, Dmitry Torokhov wrote:
> > > As it currently stands the power allocator governor can not handle
> > > thermal zones that are not specifically crafted and therefore can not=
 be
> > > used as a default governor.
> > >=20
> > > Users need to explicitly enable this governor for thermal zones that =
do
> > > have enough information for its operation.
> > >=20
> > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > ---
> > >  drivers/thermal/Kconfig | 8 --------
> > >  1 file changed, 8 deletions(-)
> > >=20
> > > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > > index 0390044..34d05d3 100644
> > > --- a/drivers/thermal/Kconfig
> > > +++ b/drivers/thermal/Kconfig
> > > @@ -82,14 +82,6 @@ config THERMAL_DEFAULT_GOV_USER_SPACE
> > >  	  Select this if you want to let the user space manage the
> > >  	  platform thermals.
> > > =20
> > > -config THERMAL_DEFAULT_GOV_POWER_ALLOCATOR
> > > -	bool "power_allocator"
> > > -	select THERMAL_GOV_POWER_ALLOCATOR
> > > -	help
> > > -	  Select this if you want to control temperature based on
> > > -	  system and device power allocation. This governor can only
> > > -	  operate on cooling devices that implement the power API.
> > > -
> >=20
> > Currently the only way we have for a thermal zone configured from
> > device tree to use a governor from the kernel boot is by using
> > THERMAL_DEFAULT_GOV_*.  If we remove this option some devices won't
> > have a workable thermal framework until userspace is up and running.
>=20
> Why would step wise, or fair share be not workable (even if not optimal)
> thermal frameworks? It doe snot take that long to get to [early]
> userspace. Half of the boot time the thermal framework is not working
> anyway because half of the devices that can act as colling devices are
> not yet logically there.
>=20
> >=20
> > Would you rather have the power allocator governor accept every
> > thermal zone?
>=20
> If it is to be one of default governors then yes, it needs to be able to
> manage all thermal zones, the same way as the other 3 governors can, as
> far as I know.

I believe fairshare also relies on platform data to be properly set,
otherwise, it would not be functional. That's probably why I overlooked
this point. That said, I would say, if we follow this logic, a similar
patch is needed for fairshare.

Javi, ideally, the governor would need to have a workable
default settings for any thermal zone that miss the platform settings.
Do you think it would be doable for power allocator?

BR,

>=20
> Thanks.
>=20
> --=20
> Dmitry

--E/DnYTRukya0zdZ1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJVwlq+AAoJEMLUO4d9pOJW1qoIAI3m2rK2JSjUyEKEBCFpjfhU
WZdJyHTXDC/u3HcwmZIevA5LAm8AQnTZw/khrXP5E4anzuw3Q4zhPmfSlCUEyYhp
kQMEMVGcGlfh7bfWzfu5Uc73gTDYmMMWtg0gFjBB251cZXfmxyuHS/FhOPqo9uFe
1ocbZacJlPSlCEMRoGsan3xLAta5dZ/RcrYHeCfs8mUwkvHEvjeddoDwcf4vJ010
eEQlmqWOWWgoPjxV7DHQBzLjmOSgAs/aViZUkDWNhd2eXJDOMB7WiV3SrLSHYPqJ
lPBvpy9Hw3Xuk3q94Zn8/rxkn6B4NHVtlxJm6Oat9Qb3sVAHTEa0zwGUKUj0g7g=
=UfiG
-----END PGP SIGNATURE-----

--E/DnYTRukya0zdZ1--
