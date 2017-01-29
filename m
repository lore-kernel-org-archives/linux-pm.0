From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 2/8] devicetree: power: add battery state machine
 documentation
Date: Sun, 29 Jan 2017 19:06:20 +0100
Message-ID: <20170129180619.di5ul4owkzjveoct@earth>
References: <20170122071404.9654-3-matt@ranostay.consulting>
 <20170122222212.27086-1-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lfsdobtdvrnkcyni"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170122222212.27086-1-liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--lfsdobtdvrnkcyni
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 22, 2017 at 02:22:12PM -0800, Liam Breck wrote:
> I think Matt meant the following :-)
>=20
> Note: nominal-microvolt is not the correct term for termination voltage.
> Changed to termination-microvolt

That's right.

> Documentation on battery properties that can be defined for
> fine tuning fuel gauge state machines.

Maybe:

Documentation for batteries, that cannot identify themself. The
information is required by fuel-gauge and charger chips for
proper handling of the battery.

> From: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
> Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
> ---
>  .../devicetree/bindings/power/supply/battery.txt   | 34 ++++++++++++++++=
++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/batter=
y.txt
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b=
/Documentation/devicetree/bindings/power/supply/battery.txt
> new file mode 100644
> index 000000000000..398b4d622883
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
> @@ -0,0 +1,34 @@
> +Battery Characteristics
> +
> +Required Properties:
> + - compatible: Must be "fixed-battery"
> +
> +Optional Properties:
> + - termination-microvolt: dead battery voltage

I think this is not named optimally, since it's not
clear if its related to charging.

> + - design-microwatt-hours: battery design energy
> + - design-microamp-hours: battery design capacity
> +
> +Batteries must be referenced by chargers and/or fuel-gauges
> +using a phandle. The phandle's property should be named
> +"monitored-battery".
> +
> +Example:
> +
> +	bat: battery {
> +		compatible =3D "fixed-battery";
> +		terminate-microvolt =3D <3700000>;
> +		design-microwatt-hours =3D <5290000>;
> +		design-microamp-hours =3D <1430000>;
> +	};
> +
> +	charger: charger@0 {
> +		....
> +		monitored-battery =3D <&bat>;
> +		...
> +	};
> +
> +	fuel_gauge: fuel_gauge@0 {
> +		....
> +		monitored-battery =3D <&bat>;
> +		...
> +	};

The charger stuff does does not integrate well with
pre-existing support for power-supplies property
described in
Documentation/devicetree/bindings/power/supply/power_supply.txt

I think the proper chain would be:

bat: battery {
	compatible =3D "fixed-battery";
	terminate-microvolt =3D <3700000>;
	design-microwatt-hours =3D <5290000>;
	design-microamp-hours =3D <1430000>;
};

fuel_gauge: fuel_gauge@0 {
	...
	monitored-battery =3D <&bat>;
    power-supplies =3D <&charger>;
	...
};

charger: charger@0 {
	...
};

I added the power-supplies node to the fuel-gauge instead of the battery,
since fuel-gauge + fixed-battery is basically a smart battery.

-- Sebastian

--lfsdobtdvrnkcyni
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAliOLxkACgkQ2O7X88g7
+pqzBw//UCKoqaSqcFO5a0vuwDbfSiPqUyO22OPyRUOXOdy6aFjDn/sL4iZeQFGE
p2dHvr9qWGOTcRbHrzdFYcGT5fuqslNxhB3psPwE+pvcTISMHLfuMuWXrdSA3f3x
BvGNzluXKP9QPUoQfWvubH3Shq9CaoKm1vrBbEDAcUgfIkhYGgAOJMXVQOhjyquf
OaWtpg4uppRCoF6+m+8bWka3AJG3Mb42pf8e3JqbISqc5vKqAZpX5E/7bq8Yb1jf
Wn/zjk+7fKsI+U3MdKq1e3lr3zCHgx23pamEAdCbkDz4AL4R3Quw0C4uFR5T+48D
uYPNzawoFWvMvjZ3Na+XPkJRp5l9NFJBYs78sOjDwNo3hb5B43IZ2KbUFJ0ARi7v
p03tQ+V19U46tJU6oQTdSzBtd+bsA2/KPRZWZKl1kwe0oYOjAWGZacMRgh/qbh1i
w6M0ZpYwA6C3qXgsSk0TEN0fuEpJlW5LMNFS46xE6VlzpmoorIQ8JrmaQXUqrHpr
z1auWlqefarP4PO810aPQni1joABGXEcjMZozQuHITwmnva3PHpiztvNu9dsSfBH
eN0tSePhQv7kdpcg2t6noQh9hrMehNWwh6OckZqS/mgL9hKkv+nIiNqEWC0VqzCZ
NGYrZPEkPs1H7ovGCr+X3DvHAdhMO6ckmJFikBVtzYuS32O3XJc=
=knDq
-----END PGP SIGNATURE-----

--lfsdobtdvrnkcyni--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
