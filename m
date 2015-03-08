From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC 3/4] power_supply: Introduce charger control interface
Date: Sun, 8 Mar 2015 02:55:16 +0100
Message-ID: <20150308015515.GB25160@earth>
References: <1425638007-9411-1-git-send-email-jenny.tc@intel.com>
 <1425638007-9411-4-git-send-email-jenny.tc@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MW5yreqqjyrRcusr"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36087 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750872AbbCHBzb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 7 Mar 2015 20:55:31 -0500
Content-Disposition: inline
In-Reply-To: <1425638007-9411-4-git-send-email-jenny.tc@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jenny TC <jenny.tc@intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Anton Vorontsov <anton.vorontsov@linaro.org>, David Woodhouse <dwmw2@infradead.org>, jonghwa3.lee@samsung.com, myungjoo.ham@gmail.com, Pallala Ramakrishna <ramakrishna.pallala@intel.com>


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 06, 2015 at 04:03:26PM +0530, Jenny TC wrote:
> Introduce power_supply charger control interfaces to control
> charging from charging framework like charger-manager. The interfaces
> are similar to the existing power supply get/set interfaces, but
> introduce a different set of properties in order to differentiate
> itself from other power supply properties which exposed in sysfs
>=20
> Signed-off-by: Jenny TC <jenny.tc@intel.com>
> ---
>  include/linux/power_supply.h |   28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>=20
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 30145d8e..a80a3ef 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -176,6 +176,32 @@ union power_supply_propval {
>  struct device;
>  struct device_node;
> =20
> +enum psy_charger_control_property {
> +	PSY_CHARGER_PROP_ENABLE_CHARGING =3D 0,
> +	PSY_CHARGER_PROP_ENABLE_CHARGER,
> +	PSY_CHARGER_PROP_RESET_WDT,
> +};
> +
> +/**
> + * struct power_supply_charger - power supply charger driver
> + * @get_property: get property function to retrieve charger properties d=
efined
> + *	in enum power_supply_charger_property
> + * @set_property: get property function to retrieve charger properties d=
efined
> + *	in enum power_supply_charger_property
> + *
> + * This structure is used by charger drivers to register with power supp=
ly
> + * charging driver
> + */
> +
> +struct power_supply_charger {
> +	int (*get_property)(struct power_supply_charger *psyc,
> +			    enum psy_charger_control_property pspc,
> +			    union power_supply_propval *val);

The charging framework can simply call the same get_property
as used by sysfs. This is already done by all kind of drivers.

> +	int (*set_property)(struct power_supply_charger *psyc,
> +			    enum psy_charger_control_property pspc,
> +			    const union power_supply_propval *val);

I guess this is needed for values, which are supposed to be
writable by the kernel / charging framework, but non-writable
by the sysfs. I suggest to add set_property_kernel() instead
(and make the above properties part of enum power_supply_property)

> +};
> +
>  struct power_supply {
>  	const char *name;
>  	enum power_supply_type type;
> @@ -200,6 +226,8 @@ struct power_supply {
>  	void (*external_power_changed)(struct power_supply *psy);
>  	void (*set_charged)(struct power_supply *psy);
> =20
> +	struct power_supply_charger *psy_charger;

Why is this a pointer?

> +
>  	/*
>  	 * Set if thermal zone should not be created for this power supply.
>  	 * For example for virtual supplies forwarding calls to actual

-- Sebastian

--MW5yreqqjyrRcusr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU+6wBAAoJENju1/PIO/qa0mkP/ifvObsa4yUQl5y+HD72GH6M
kfXAapnspk+LNos1ngfWlVbGnGKz0/V5ODwS7zBFPe5x5UQxQ1UTs7T6wG8iQwIK
vtnBhYZOksphLqGYlAQ6NuYgb0IZHs+zoMEQYzwDWza1LkwJ7RFpOncrmmSdXZoI
6nA4S81Ugii3yoaszEwGrbT3N0VMNn0zFvOy1hGrExiR5qIa9BSMPnLqbvPac6fd
EVGJ9CMb2hqnfz9XGjedXYEOuNRmIbtu7Mh7O8HEgca9tGAy7SR+CHyIzGw3QboC
iN35ULvdbEKwavEZmCHh0ts6fvcZiZLg/dNUczunl/8mEIX+Q8dsa7cvaSsA7UAs
xk69uaLnhHCc7AgRE0VE0fNwkIMBJiXvcp42+ZS6NlFcL2cSKFNcGSPyXHfp714K
wD1YD/Ah22syQrG4UgjngPy0vnnYNXVVjExt5Y/spgbuJsgXp9XA4iIi28m6WVYc
S2Y4VND6oCJ9sS++o375hkSCqZi9lyHulwc7XGTpWzzQzi3ckoXsVZBOOtTPQuiU
BCDlp2UrYuoQOtKuqbIKP08+t+BW5QelzNAJRwa6ROPbq5RekkHKUxSBJO+2RMbn
AH5GH8mw1AaVYGeuK6TK7+5YwDCLAYKlBlLOSoJc9QwSS+7qfc01qPucGID/1tXQ
cJEuD89gn54QgiMBcgjJ
=2u+m
-----END PGP SIGNATURE-----

--MW5yreqqjyrRcusr--
