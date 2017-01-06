From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/3] devicetree: property-units: add mWh and mAh units
Date: Fri, 6 Jan 2017 01:24:31 +0100
Message-ID: <20170106002431.dvj7zwduncmrstak@earth>
References: <20170105021007.22088-1-matt@ranostay.consulting>
 <20170105021007.22088-2-matt@ranostay.consulting>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cqqlla7kayfpepc4"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170105021007.22088-2-matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--cqqlla7kayfpepc4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 04, 2017 at 06:10:05PM -0800, Matt Ranostay wrote:
> Add entries for microwatt-hours and microamp-hours to property
> units.
>=20
> Signed-off-by: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/property-units.txt | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/property-units.txt b/Docum=
entation/devicetree/bindings/property-units.txt
> index 12278d79f6c0..5e8d220cc2b6 100644
> --- a/Documentation/devicetree/bindings/property-units.txt
> +++ b/Documentation/devicetree/bindings/property-units.txt
> @@ -25,8 +25,10 @@ Distance
>  Electricity
>  ----------------------------------------
>  -microamp	: micro amps
> +-microamp-hours : micro amp hours
>  -ohms		: Ohms
>  -micro-ohms	: micro Ohms
> +-microwatt-hours: micro Watt hours
>  -microvolt	: micro volts
> =20
>  Temperature

Acked-By: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

As there is no hard-dependency I expect this goes through the DT
subsystem independently of the remaining patchset. Please ping me,
if I should queue it via the power-supply tree instead.

@Matt: You miss a few CC for this patch:

=2E/scripts/get_maintainer.pl -f Documentation/devicetree/bindings/property=
-units.txt
Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> (maintainer:OPEN FIRMWARE AND FLATTENED DE=
VICE TREE BINDINGS,commit_signer:1/1=3D100%,authored:1/1=3D100%,added_lines=
:39/39=3D100%)
Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> (maintainer:OPEN FIRMWARE AND FLATTENED=
 DEVICE TREE BINDINGS,commit_signer:1/1=3D100%)
devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TR=
EE BINDINGS)
linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org (open list)

-- Sebastian

--cqqlla7kayfpepc4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhu47wACgkQ2O7X88g7
+ppv8w/+OUcLMOEg+FJngER/7EoQ63eB6ofM6Ww/JlIwcFWwgnDE7fluqX7ebDc4
tj3DFRYEFBYwo6Oq47GyYpOPUPpOZGZJrukiFjZrbcP4knGbfAiPbLnB5GXD6rrj
QnyeljI+Axo0NUFaVBTYEqdd+yU03O7DMaNVpEqjX47/IPJJ0L0KpoQcYZsEeU4T
Afz1VciC7gsrRkI8H/fmpB7dZF+/nYcWmEfbMa8FYuepIoFf1Jb9eXfPuEdU3lOS
gVY4q9pAAf7n36ykKKrcxau9yLPuWdbV6O1TbwhmZJ/V0dDVGxPjDNJ3N/QJAA+a
h/O2ARx9IWtPjovk+/34EKWFkzk/IlUPJumqJXd0M6vfsA0Rqec3iIy5WOy2+FYj
hMCfCd/VWyadCnyske/rbLiDUKHQbb7DpGRTtm3U3CqiTIUPTlrrBaIT57nJ7Wns
PY6g9oMUptihLFOXPvVF7W2vn38xza8ovtycvUuYejdlEqXA3qHD/QKlvKVXBgiZ
L4R+2TjJ+fIwfVSVlddP0W240cAGXam4xskMvljjah6CNtj2jXaaFlqzhVwdWIzk
dwhJfXL8Q+aCvcYtTVWEzsVpMJYB7YMJXi51vkVubeEend7U9sBi2C/cUBOXEYdS
Qtv2W6MB8ZF1KOUKJDOgIFWKprVjfktX7h8Fz7xb9y5z7/1rs+Q=
=fafh
-----END PGP SIGNATURE-----

--cqqlla7kayfpepc4--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
