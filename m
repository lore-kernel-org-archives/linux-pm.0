From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: power: add bindings for sbs-charger
Date: Sat, 17 Dec 2016 17:32:12 +0100
Message-ID: <20161217163212.bwjxxeiqw5eklhoc@earth>
References: <1479990823-25841-1-git-send-email-nicolas.saenz@prodys.net>
 <1479990823-25841-3-git-send-email-nicolas.saenz@prodys.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v54ueoboizpug7ie"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1479990823-25841-3-git-send-email-nicolas.saenz-gbiq2sxWoaasTnJN9+BGXg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolas Saenz Julienne <nicolas.saenz-gbiq2sxWoaasTnJN9+BGXg@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--v54ueoboizpug7ie
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 24, 2016 at 01:33:43PM +0100, Nicolas Saenz Julienne wrote:
> Adds device tree documentation for SBS charger compilant devices as defin=
ed
> here: http://sbs-forum.org/specs/sbc110.pdf
>=20
> Signed-off-by: Nicolas Saenz Julienne <nicolas.saenz-gbiq2sxWoaasTnJN9+BGXg@public.gmane.org>
> ---
> v2 -> v3:
> - add part number as compatible
>=20
>  .../bindings/power/supply/sbs_sbs-charger.txt      | 24 ++++++++++++++++=
++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/sbs_sb=
s-charger.txt
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/sbs_sbs-charg=
er.txt b/Documentation/devicetree/bindings/power/supply/sbs_sbs-charger.txt
> new file mode 100644
> index 0000000..f6b6027
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/sbs_sbs-charger.txt
> @@ -0,0 +1,24 @@
> +SBS sbs-charger
> +~~~~~~~~~~
> +
> +Required properties:
> + - compatible: should contain one of the following:
> +	- "lltc,ltc4100"
> +	- "sbs,sbs-charger"

That's not what I meant. The idea is to specify "lltc,ltc4100" with
"sbs,sbs-charger" as fallback. Then the driver for now only handles
"sbs,sbs-charger", but if any vendor registers need to be supported
we have a more specific compatible value in DT, that can be used to
identify the device.

> +Optional properties:
> +- interrupt-parent: Should be the phandle for the interrupt controller. =
Use in
> +    conjunction with "interrupts".
> +- interrupts: Interrupt mapping for GPIO IRQ. Use in conjunction with
> +    "interrupt-parent". If an interrupt is not provided the driver will =
switch
> +    automatically to polling.
> +
> +Example:
> +
> +	ltc4100@9 {
> +		compatible =3D "sbs,sbs-charger";
> +		reg =3D <0x9>;
> +		interrupt-parent =3D <&gpio6>;
> +		interrupts =3D <7 IRQ_TYPE_LEVEL_LOW>;
> +	};

So the example would look like

compatible =3D "lltc,ltc4100", "sbs,sbs-charger";

-- Sebastian

--v54ueoboizpug7ie
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhVaIwACgkQ2O7X88g7
+poPnQ/+PNRw3DO1VQPAWQWafN0s2sAFiEOtlyvs8cnXRdoL71bBJ3i+o85Ad+wS
nyySEH+vnllK47/Z3CrtDBGbGMqazzJ/72Cx5hCOnz9QG3WC7b6c0InIhnWS7BiF
OuIRMJHZN7KhNSqYgj77+csUn6tSsZkGqDAL/efIeODsAI7Ng+0eH7VQAsssAfiS
xhZ8OF4IWQMLK+jnp+Qyl+R44WbuyIgza0KHgPlgQ4rDW7hFtMOc6hbdS6f+HTdn
MV8gBHCkJp6lq/LjlSJWkFvNVHqCcFOcJE/B1F4NEdiBaNZEta3JVWjvSTFFOABl
1LCtTMTOFRSc+cH++AMnIxBScLX6YFihC6c9DzfRhnPtFHOlpfBD8bH452eVX5mB
+d19POriwX6U3PIp+CtFDsqkuFDXMylYyYUw6MD1wQpYT7sFdnSMGEDhVXxo+PMC
Kwu1fKMjYU8AOuaMUvTIY2MqT1B0uriFHocErYuPVBPfTMg3/KDHsNv0sF5RcCON
7tDJbup00secMKuoh/KOXUIDFw/5sYFdEowAdvcY7s/9vyJZZX7HjpWHTpRUWHHx
6fyHKmdVjmx+yUL1jDcPu811Ns4QY5QnB2yRDorM/LfLqeqPfnH4pQi/3gNjwKBJ
h8RGiCbST1C9N2KNOd11lTH6366MumE9FJ8ss2YAxJDmizsAfxE=
=bLUR
-----END PGP SIGNATURE-----

--v54ueoboizpug7ie--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
