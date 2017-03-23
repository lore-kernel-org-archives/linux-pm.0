From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v11 01/10] devicetree: power: Add battery.txt
Date: Thu, 23 Mar 2017 11:20:06 +0100
Message-ID: <20170323102006.2ftvsoukgmqh7dtv@earth>
References: <20170320094335.19224-1-liam@networkimprov.net>
 <20170320094335.19224-2-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wyruurc7noqn5522"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170320094335.19224-2-liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--wyruurc7noqn5522
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 20, 2017 at 02:43:26AM -0700, Liam Breck wrote:
> From: Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
>=20
> Documentation of static battery characteristics that can be defined
> for batteries which cannot self-identify. This information is required
> by fuel-gauge and charger chips for proper handling of the battery.
>=20
> Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
> Signed-off-by: Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
> ---
>  .../devicetree/bindings/power/supply/battery.txt   | 43 ++++++++++++++++=
++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/batter=
y.txt
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b=
/Documentation/devicetree/bindings/power/supply/battery.txt
> new file mode 100644
> index 0000000..53a68c0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
> @@ -0,0 +1,43 @@
> +Battery Characteristics
> +
> +The devicetree battery node provides static battery characteristics.=20
> +In smart batteries, these are typically stored in non-volatile memory=20
> +on a fuel gauge chip. The battery node should be used where there is=20
> +no appropriate non-volatile memory, or it is unprogrammed/incorrect.
> +
> +Required Properties:
> + - compatible: Must be "simple-battery"
> +
> +Optional Properties:
> + - voltage-min-design-microvolt: drained battery voltage
> + - energy-full-design-microwatt-hours: battery design energy
> + - charge-full-design-microamp-hours: battery design capacity
> +
> +Battery properties are named, where possible, for the corresponding=20
> +elements in enum power_supply_property, defined in
> +https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
include/linux/power_supply.h#n86

The above paragraph does not belong into DT bindings. Apart
=66rom that

Acked-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

FYI: I will wait for Acked-by from Rob Herring on this patch.

-- Sebastian

> +Batteries must be referenced by chargers and/or fuel-gauges
> +using a phandle. The phandle's property should be named
> +"monitored-battery".
> +
> +Example:
> +
> +	bat: battery {
> +		compatible =3D "simple-battery";
> +		voltage-min-design-microvolt =3D <3200000>;
> +		energy-full-design-microwatt-hours =3D <5290000>;
> +		charge-full-design-microamp-hours =3D <1430000>;
> +	};
> +
> +	charger: charger@11 {
> +		....
> +		monitored-battery =3D <&bat>;
> +		...
> +	};
> +
> +	fuel_gauge: fuel-gauge@22 {
> +		....
> +		monitored-battery =3D <&bat>;
> +		...
> +	};
> --=20
> 2.9.3
>=20

--wyruurc7noqn5522
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljToVUACgkQ2O7X88g7
+ppQFQ//do825NO1V+6Bkasx3/VjL8J1sZuH/wUVu6RluthpJx1Sfl41HhKzTbLO
9Tz9rRPX+Lzk9jx+qZo5GoHKcKuqRNeP2BZYNzQzS3MgYjC9C8dA0N2yHf/Dpd84
/8TMIz9hIrExstFcIcUaYlDAfsFYJTW77a5k7w3NGRCYEDod5Dby83d/xBTKfkv9
9GDOTvkRN0oIz2g8FEPPzA5F7roboYJJ1zzcT8lcpfaMaEbKI/oHftC2puZ5dgPX
U7i3+1xz3V+QNLZH4ukx0fOIZ7Eh7gMZyHz4HPQfcJhquIDekvSYuoM9JawNksio
gu5E9aL5q4Lky4Bbm63F7ToJ+FOtA1HIyL2XeUdPL8K4K4HTNFu62zsQwp3eaVyW
LiueZUeoh2YFt22XaDiDdd/QodwAmGNP5YCrvGmvldcMWJs/PZpyffxmsOx1zqq2
LurH1TMd07EbkeYdpxQnE0kWOBH6lWqTJ6FZCyiETNLDcfCeKPjZBB5F2j123YTg
UR4jVTnJJ+U/ik4XtznIwPoKkq+12LBfFCbz5l7xAqNq3xkYEYB4cLXTM10I/tsP
7hgY5M6VxW2JoTIPr4EUSn3KOZLSsMLNBXh78pQv7wA6sKW0ADcnWFq2+gsuHlwW
1gTSXoTXo2fHMhnFINaXKXn0j7mDcJnKfXPy62dgEybuYPWsd9Q=
=ZleC
-----END PGP SIGNATURE-----

--wyruurc7noqn5522--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
