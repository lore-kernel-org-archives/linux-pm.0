From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v1 3/7] power: power_supply_core: Add *_battery_info
 fields for pre- and end-charge current
Date: Fri, 24 Mar 2017 10:07:37 +0100
Message-ID: <20170324090737.n6rkh6czomgrkpxz@earth>
References: <20170321220921.5834-1-liam@networkimprov.net>
 <20170321220921.5834-4-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i4minoqwvx6pur37"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756416AbdCXJHn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 Mar 2017 05:07:43 -0400
Content-Disposition: inline
In-Reply-To: <20170321220921.5834-4-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Liam Breck <kernel@networkimprov.net>


--i4minoqwvx6pur37
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 21, 2017 at 03:09:17PM -0700, Liam Breck wrote:
> From: Liam Breck <kernel@networkimprov.net>
>=20
> Battery chargers use precharge_current_ua and endcharge_current_ua
> at the beginning and end of a charging cycle. These values are set
> according to battery capacity.
>=20
> Depends-on: https://patchwork.kernel.org/patch/9633613/
> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> ---
>  drivers/power/supply/power_supply_core.c | 6 ++++++
>  include/linux/power_supply.h             | 5 +++++
>  2 files changed, 11 insertions(+)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index 61e20b1..17088c5 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -498,6 +498,8 @@ int power_supply_get_battery_info(struct power_supply=
 *psy,
>  	info->energy_full_design_uwh =3D -EINVAL;
>  	info->charge_full_design_uah =3D -EINVAL;
>  	info->voltage_min_design_uv  =3D -EINVAL;
> +	info->precharge_current_ua   =3D -EINVAL;
> +	info->endcharge_current_ua   =3D -EINVAL;
> =20
>  	if (!psy->of_node) {
>  		dev_warn(&psy->dev, "%s currently only supports devicetree\n",
> @@ -527,6 +529,10 @@ int power_supply_get_battery_info(struct power_suppl=
y *psy,
>  			     &info->charge_full_design_uah);
>  	of_property_read_u32(battery_np, "voltage-min-design-microvolt",
>  			     &info->voltage_min_design_uv);
> +	of_property_read_u32(battery_np, "precharge-current-microamp",
> +			     &info->precharge_current_ua);
> +	of_property_read_u32(battery_np, "endcharge-current-microamp",
> +			     &info->endcharge_current_ua);
> =20
>  	return 0;
>  }
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index e84f1d3..864214c 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -152,6 +152,9 @@ enum power_supply_property {
>  	POWER_SUPPLY_PROP_MODEL_NAME,
>  	POWER_SUPPLY_PROP_MANUFACTURER,
>  	POWER_SUPPLY_PROP_SERIAL_NUMBER,
> +/* where to place these? inserting above causes sysfs errors */
> +	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
> +	POWER_SUPPLY_PROP_ENDCHARGE_CURRENT,
>  };

Ack on adding standard property for charge current of pre & end
phase. Please do this in its own patch. This requires modification
of a few places, see for example the following commit adding
CHARGE_CURRENT_MAX: 2815b786c3bb86fff97f1f6e2f0874903ff2339b

>  enum power_supply_type {
> @@ -301,6 +304,8 @@ struct power_supply_battery_info {
>  	int energy_full_design_uwh;	/* microWatt-hours */
>  	int charge_full_design_uah;	/* microAmp-hours */
>  	int voltage_min_design_uv;	/* microVolts */
> +	int precharge_current_ua;	/* microAmps */
> +	int endcharge_current_ua;       /* microAmps */
>  };
> =20
>  extern struct atomic_notifier_head power_supply_notifier;
> --=20
> 2.9.3
>=20

--i4minoqwvx6pur37
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljU4dkACgkQ2O7X88g7
+pqQEw/+PD/soOxcQ/5BGDt/pNN1awjCLJewLo5YzXqLQlikImAW/x6tO4/rZLq5
zAtPs09erPatYlrSydjNKBMB/F1K5lrKZJvSEPVi5oMf845HTiray3HYgxCpP0rb
rVWTjMB4g1PWsOrrgEHl41nDU4uVIMfMAb7ZwJsH83PcCSxuUWYP5LdgxUluHUHZ
of2WblbsQh8kroIjik9G624Lnpx8ZgxBqJP6WCS9inSfnVHl9VnHGTxiBPLPF//e
YVh1+ux0vQ3+aV5jb3Fs6kQqKsCIYjBCcn/ijYvSzkILNKwqMBLGrAanur+uCzMt
Z5GzwldKeIcFURl3b0kb0DHk3ZJGwzFw7i/hdNNvIMbhVWUWxFfXZViPtaJCz/m5
FiEvWnirEHrP7nbcRr+N7oGtPOG/wiqU8VMDCXK31hWEjoHANNELwjoz+fG8dCFQ
XWnVyw/Eco5v4pfgsJGSwVeAlWeyFxzaJzlekK4p9sIKLwMnHUMJ083RO5suif9f
IYwE5+NlUzQpmRNpgQgG1BXjBdcbsAZ0aFlZbz2NrZZ7Lg+iQF/Jddxi7aDRqCXP
TaJU39XgzOQQudJw/ZYNRX4HbJEMXaW2y6Tz3RDU3nuI7EeEzVWI94/izxM5ZqK0
oRSWdZvUb/Tu4i+10gvMF1QD2eUaWlQdV1BSJm3NbByUCrs2ttA=
=cIbi
-----END PGP SIGNATURE-----

--i4minoqwvx6pur37--
