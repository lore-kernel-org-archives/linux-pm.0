From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v2 11/14] power: supply: bq24190_charger: Get
 input_current_limit from our supplier
Date: Tue, 29 Aug 2017 13:40:03 +0200
Message-ID: <20170829114003.rcj6l5up4277urxq@earth>
References: <20170815200502.17339-1-hdegoede@redhat.com>
 <20170815200502.17339-12-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2hyh4nsrt7j57ide"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56290 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbdH2LkI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Aug 2017 07:40:08 -0400
Content-Disposition: inline
In-Reply-To: <20170815200502.17339-12-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Liam Breck <liam@networkimprov.net>, Tony Lindgren <tony@atomide.com>, linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org


--2hyh4nsrt7j57ide
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 15, 2017 at 10:04:59PM +0200, Hans de Goede wrote:
> On some devices the USB Type-C port power (USB PD 2.0) negotiation is
> done by a separate port-controller IC, while the current limit is
> controlled through another (charger) IC.
>=20
> It has been decided to model this by modelling the external Type-C
> power brick (adapter/charger) as a power-supply class device which
> supplies the charger-IC, with its voltage-now and current-max representing
> the negotiated voltage and max current draw.
>=20
> This commit adds support for this to the bq24190_charger driver by calling
> power_supply_set_input_current_limit_from_supplier helper if the
> "input-current-limit-from-supplier" device-property is set.
>=20
> Note this replaces the functionality to get the current-limit from an
> extcon device, which will be removed in a follow-up commit.

I'm fine with the general approach, but ...

> [...]
> +	bdi->input_current_limit_from_supplier =3D
> +		device_property_read_bool(dev,
> +					  "input-current-limit-from-supplier");
> [...]

I wonder if we actually need this. I think we can just enable it
unconditionally when we have a parent power supply providing the
information.

-- Sebastian

--2hyh4nsrt7j57ide
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmlUpAACgkQ2O7X88g7
+ppuGBAAkLr6i2NQ89qrmrMC08EH4j0jvVt9KNacP6efL7+O9sx9XUaOMbjWoJdn
BjOHkxHEjk/tL+u031hJwrp859+yM3WD4x0iWTPiCu4ugCJhVe7Lw27Oyan3Qtga
yYNIP4Ib+6OsSsWXbcy2RS4hNdnACZCPuhmzmcdD4StZYSHOlrjIsY01lckeM7yX
7AN/vz9WdYWjTFzqXJWWU734MrpbA7gv1QY9TzWjcTBEB0QRvAyeQkBv+t6Cumeo
QuQxdVTbsKX71CUh5Ad6ihBPgJIJQdWdUsVdEV8Y0LdviBJmBU2DBvOidlKMs1ZF
mV7m6cQjCPhIDNLHG6+360kyptxn7KJv2hjfFTkUvmY9mzD6r4dpM61iV/L3lpd9
z9l1+DPCEmkl5qndWcQ7gZLCX+bLA05zPrK+JNm1BRf+rciQG4aTMmtFSmydXUXN
L3MIoaJbonJerbCs8AokLtCCkwOuFrMq28dM++pDN0cyFPklQT1NPEkXVM794g7p
2sl4ThRWWAdgII1204dS7Zf1dtwv8/LjC46HI3Nyf70qs8dY14ZPHaqGR0lg3SG/
UX6l5ZCbS1QX/6vw6m2g4u2DJgdx2J1fv4jyeH5ZfOwIhleCfJjKKvi6hhtzXop4
MKEYihT76vTNPEPdoSZvQsKuHntfxeswJwzoqwxz+AAI2fI8t7g=
=CW+c
-----END PGP SIGNATURE-----

--2hyh4nsrt7j57ide--
