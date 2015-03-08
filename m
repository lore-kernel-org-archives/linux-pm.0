From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC 4/4] charger-manager: Enable psy based charge control
Date: Sun, 8 Mar 2015 03:14:09 +0100
Message-ID: <20150308021409.GC25160@earth>
References: <1425638007-9411-1-git-send-email-jenny.tc@intel.com>
 <1425638007-9411-5-git-send-email-jenny.tc@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E13BgyNx05feLLmH"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425638007-9411-5-git-send-email-jenny.tc@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jenny TC <jenny.tc@intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Anton Vorontsov <anton.vorontsov@linaro.org>, David Woodhouse <dwmw2@infradead.org>, jonghwa3.lee@samsung.com, myungjoo.ham@gmail.com, Pallala Ramakrishna <ramakrishna.pallala@intel.com>
List-Id: linux-pm@vger.kernel.org


--E13BgyNx05feLLmH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 06, 2015 at 04:03:27PM +0530, Jenny TC wrote:
> At present charger manager support only regulator based charging
> control. But most of the charger drivers are registered with power
> supply subsystem. This patch adds support for power supply based
> charging control along with the regulator based control. With the
> patch, charging control can be done either using power supply
> interface or with regulator interface. The charging is setup
> based on battery parameters received through the battery info
> handlers.

[...]

(so far I only skipped over the patch)

[...]

> @@ -1704,6 +1968,10 @@ static int charger_manager_probe(struct platform_d=
evice *pdev)
>  		strncpy(cm->psy_name_buf, desc->psy_name, PSY_NAME_MAX);
>  	cm->charger_psy.name =3D cm->psy_name_buf;
> =20
> +	if (!power_supply_get_property(fuel_gauge, POWER_SUPPLY_PROP_MODEL_NAME,
> +						&val))
> +		cm->battery_info =3D psy_get_battery_info(val.strval);
> +
>  	/* Allocate for psy properties because they may vary */
>  	cm->charger_psy.properties =3D devm_kzalloc(&pdev->dev,
>  				sizeof(enum power_supply_property)

We are currently splitting battery data from fuel gauge data, so
acquiring the battery using the fuel gauge's MODEL_NAME is not very
nice.

-- Sebastian

--E13BgyNx05feLLmH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU+7BuAAoJENju1/PIO/qaG80QAJEpupphPFj2L2GEwrqWa8XX
F/krSMlGW32eqlFu/rhFlxM+YbS6V9hdnXQPsbfE7mX2JFpxDqGYn6z7RFB2WLkW
v365+34634JlbSFBYiQeuokwY78ZQ5lWb9ErRFOzRFXQ5vqx7GylUhpt9cOYHBef
8aedtCbyCKUqbChtQMrDIwIJuY87TprAz6+gzb30aO8hmOWh5Q+/MNBFqfsy9Z5V
qGPJvBzl2rnatgNmnrjWIKR5JL8wGv1h72bdHPh3mMYUcg7qhELXbhUJqH2bECak
1joaK3OjOSgz/kCx53Ni75EDmm2jaLbiXHHTe/mbo8MgTnquJQRWRGijoiD8gEVe
/ubB3DrKRilxbkzZcMlohfkeRW4Fv71TXaTT8vCs9kAcmiWUcxIDUY38KiSI7ScR
h4PA6HWT2axRvL0YIBnFpkiwDNCyQlO6XurOCK2oQLzXyvNh2n1Dk7LRM6WTKDfn
c6ApcWPt3dpOei7a+kWI8XaZkaFAHs2GlHDQBDD9/d5S1N9tF9SXQ2fRwpxUKpn4
hrP/7DZSY5uhhGYJYw+k2Gs+r5F9lkIPMdIvMkZUim+pwq+SXJToHxx54hzDYZpI
CSfkJXoTiBhFz8I9jNadd0/leFgchkP6ZbtwJ7xFb7mZoDKBiseK0rHVVKoQ1rvP
by3fMnUm9ZM0BdA3RoFg
=IslA
-----END PGP SIGNATURE-----

--E13BgyNx05feLLmH--
