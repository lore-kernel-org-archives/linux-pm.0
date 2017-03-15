From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v10 3/8] devicetree: power: bq27xxx: Add
 monitored-battery documentation
Date: Wed, 15 Mar 2017 23:06:27 +0100
Message-ID: <20170315220627.g6lcatf43als6tnt@earth>
References: <20170315192653.26799-1-liam@networkimprov.net>
 <20170315192653.26799-4-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dryamcuzrp4vrld7"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170315192653.26799-4-liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
Cc: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--dryamcuzrp4vrld7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 15, 2017 at 12:26:48PM -0700, Liam Breck wrote:
> From: Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
>=20
> Document monitored-battery =3D <&battery_node>
>=20
> Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
> Signed-off-by: Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Acked-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

-- Sebastian

> ---
>  Documentation/devicetree/bindings/power/supply/bq27xxx.txt | 11 ++++++++=
++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.txt b=
/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
> index b0c95ef..cf83371 100644
> --- a/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
> +++ b/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
> @@ -28,9 +28,18 @@ Required properties:
>   * "ti,bq27621" - BQ27621
>  - reg: integer, i2c address of the device.
> =20
> +Optional properties:
> +- monitored-battery: phandle of battery information devicetree node
> +
> +  See Documentation/devicetree/bindings/power/supply/battery.txt
> +  If either of the referenced battery's *-full-design-*-hours properties=
 are set,
> +  then both must be.
> +
>  Example:
> =20
> -bq27510g3 {
> +bq27510g3 : fuel-gauge@55 {
>      compatible =3D "ti,bq27510g3";
>      reg =3D <0x55>;
> +
> +    monitored-battery =3D <&bat>;
>  };
> --=20
> 2.9.3
>=20

--dryamcuzrp4vrld7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljJuuMACgkQ2O7X88g7
+ppopQ//Z8JmLCFE0wFkk40Ykk+t37WamBrxOxHRUp2keZ5opvyZq4Vq/nxKl7H8
3z1wN7ec/RRuYu8GScczNi3SfQJuregoZj61rDIlsaepMn12NJwvDdlHsS0rBAQf
xffHon0Cl3LQyT8sHw67oer+tKsgmoCf+Gfnaca9h2SnMqa1cnO0sOron5yxrX4k
DbouM8Dxl/fyL4XXEl/7g2ISkrHKm73LesjwL7cKOxqNAxAwBjcPT/JMaTFJas7G
iADLnd5KXpajbi3ISmD3VMG+H4nULTDAWvbPTnqgh2aiWnz/VHAL4GgvF/lCx41V
6n3nCmhGa1hEc7BCZEYu1MicY1lxTBER47PXjjBBomNVkp/5G7P8pEb16fnVC6aH
RgB1i1zF70fiehjkQ/O3fxjUPxfXnoACSsZt6od7GyPffZnt+tu75rEJiq+DNMFc
msqK8RQSTfcblKurg9h5z2S/XQGzXMZ4yDAkBAXTo2IC2WXsrm2ntUJxiQnHNyFn
Ke/jTMEuoEJsE1NIJO5mNwQ+NTRgW/IJZjEnOAAX57Jm8ULV0J5SVFHrpMtM5vn1
9nuQkOv0wDjZfQ1GPKJDn5jH6to+BmqYWVcNFZryHz8fA381PTw2hVR/9zsxnYmK
kcJUm314RD/YwAlaeSwTP8R0gyubuDdw7pWekf1NMV7qCE46Eeo=
=wN3o
-----END PGP SIGNATURE-----

--dryamcuzrp4vrld7--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
