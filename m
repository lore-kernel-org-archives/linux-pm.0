From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2] power_supply: fix return value of get_property
Date: Wed, 22 Jun 2016 16:37:17 +0200
Message-ID: <20160622143716.GB16084@earth>
References: <1466028784-24459-1-git-send-email-rklein@nvidia.com>
 <576266A9.9030906@samsung.com>
 <04e70c84-f34d-2c61-0d8b-80cbeaac356e@nvidia.com>
 <2d2e4c90-472d-fa1a-6fbc-dfb99e80069d@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2d2e4c90-472d-fa1a-6fbc-dfb99e80069d@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rhyland Klein <rklein@nvidia.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 21, 2016 at 02:08:05PM -0400, Rhyland Klein wrote:
> On 6/16/2016 11:40 AM, Rhyland Klein wrote:
> > On 6/16/2016 4:43 AM, Krzysztof Kozlowski wrote:
> >> On 06/16/2016 12:13 AM, Rhyland Klein wrote:
> >>> power_supply_get_property() should ideally return -EAGAIN if it is
> >>> called while the power_supply is being registered. There was no way
> >>> previously to determine if use_cnt =3D=3D 0 meant that the power_supp=
ly
> >>> wasn't fully registered yet, or if it had already been unregistered.
> >>>
> >>> Add a new boolean to the power_supply struct to simply show if
> >>> registration is completed. Lastly, modify the check in
> >>> power_supply_show_property() to also ignore -EAGAIN when so it
> >>> doesn't complain about not returning the property.
> >>>
> >>> Signed-off-by: Rhyland Klein <rklein@nvidia.com>
> >>> ---
> >>> v2:
> >>>  - Modify power_supply_show_property() to not complain if it
> >>>    sees a return value of -EAGAIN after calling
> >>>    power_supply_get_property().
> >>>
> >>>  drivers/power/power_supply_core.c  | 6 +++++-
> >>>  drivers/power/power_supply_sysfs.c | 2 +-
> >>>  include/linux/power_supply.h       | 1 +
> >>>  3 files changed, 7 insertions(+), 2 deletions(-)
> >>
> >> I don't like it for two reasons:
> >> 1. There is still a short window when the information will be
> >> inaccurate. See comment below.
> >>
> >> 2. Although the code is not very complicated but it adds another field
> >> and some checks just for differentiating EAGAIN/ENODEV. It is
> >> unnecessary complexity.
> >>
> >>>
> >>> diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_=
supply_core.c
> >>> index b13cd074c52a..a39a47672979 100644
> >>> --- a/drivers/power/power_supply_core.c
> >>> +++ b/drivers/power/power_supply_core.c
> >>> @@ -491,8 +491,11 @@ int power_supply_get_property(struct power_suppl=
y *psy,
> >>>  			    enum power_supply_property psp,
> >>>  			    union power_supply_propval *val)
> >>>  {
> >>> -	if (atomic_read(&psy->use_cnt) <=3D 0)
> >>> +	if (atomic_read(&psy->use_cnt) <=3D 0) {
> >>> +		if (!psy->initialized)
> >>> +			return -EAGAIN;
> >>>  		return -ENODEV;
> >>> +	}
> >>> =20
> >>>  	return psy->desc->get_property(psy, psp, val);
> >>>  }
> >>> @@ -775,6 +778,7 @@ __power_supply_register(struct device *parent,
> >>>  	if (rc)
> >>>  		goto create_triggers_failed;
> >>> =20
> >>> +	psy->initialized =3D true;
> >>
> >> If someone calls power_supply_get_property() here, then ENODEV will be
> >> returned which is wrong.
> >>
> >> The problem is not solved entirely... I am not convinced that introduc=
ed
> >> complexity is worth fixing it.
> >>
> >=20
> > Right now, without this patch, this causes the thermal function
> > "update_temperature" in:
> >=20
> > thermal_zone_device_register->
> >   thermal_zone_device_update->
> >     update_temperature
> >       (->thermal_zone_get_temp() from the original stack)
> >=20
> > to print a warning as it sees ret !=3D -EAGAIN. This causes a warning
> > "failed to read out thermal zone". I think the idea there is if anything
> > other than "try again" it complains. While this doesn't cause functional
> > problems, I do think avoid the warning is worth while.
> >=20
> > I think that there is an onus on the power_supply code to be accurate in
> > its return codes, and EAGAIN is the correct one we should be returning.
> > I don't see how someone would call power_supply_get_property, but I
> > agree there is the possibility that if someone did call there, that it
> > could return the wrong value.
> >=20
> > We could wrap the setting of initialized and use_cnt inside a mutex,
> > which should prevent anyone calling anything in between if we wanted to
> > completely plug that hole. I am not fond of the idea of adding a struct
> > member for such a small, specific case, but as we found before, I don't
> > think there is another way to differentiate otherwise.
> >=20
>=20
> Sebastian, do you have an opinion on this?

Instead of adding a mutex, just set "psy->initialized =3D true" after
increment of use_cnt. I'm fine with the patch otherwise.

-- Sebastian

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXaqKaAAoJENju1/PIO/qab7UP/2U03kyx3WneueVHux015obp
1yu/b+6UxuvYPgYVQbXiRw5gz4eS/ZOgu+MjuBpsj/p0cCvgT7sC5yR4trORFhyV
Bn/zvZ4VddDS2Mvm4u+x+d22achLbSvxGxvYcOklItxr00EtKLjX3D5Ii3U9ilgw
7qLQJRm+DE3Vhf0BNt18joz+IeoZydGrOWrjMeviP01pP0Z5Marapbu+fClfMutH
U5IxRBIkpYVtjG+iwpgecyvGt7dH+8eZqBPbg7PhHyvZdUzJFJla70EUFJthtTuP
IrPBzj96zT9dJj09UKB0pG8qFgdlENC6+GjZfkM7kTK/gZcoDlzQ6SuqQBVN06Yh
BJh/LizhPVnRnoKyGNQKMD4hgA7T40ogTf/dE+pB2+3uXxeW8JKmIic5XC6zZmmC
rb4hmD1mnqB72MWoly5c9IrX2D/nXVpR6cJCifNEzn34jB6J/eYrFbf7JDYjTKGG
JWYGu+/as1+y4XyveCn6I0X2pXhXYm62+vy0TTj/5bDliu71MFvkurVPXP/GbWax
SLby+2CwIhyBDOTp980SFe2d2exEd0RAzfFjjLCmyA3S96aP/64HnVal4QDHHfhR
lDvGhd+YvADhdOk4ag1vAuYBRjcohYeyoVu9Obsdyfb2rhrV5rlBhXp0+Cr6G8kL
CG9hFx+cJzoDIZ+9/vxw
=ukZA
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
