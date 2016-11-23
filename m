From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 03/15] wm8350_power: use permission-specific DEVICE_ATTR
 variants
Date: Thu, 24 Nov 2016 00:10:08 +0100
Message-ID: <20161123231008.jaycog5acvpoowoh@earth>
References: <1477769829-22230-1-git-send-email-Julia.Lawall@lip6.fr>
 <1477769829-22230-4-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t6bzhwngfulh5gl6"
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1477769829-22230-4-git-send-email-Julia.Lawall@lip6.fr>
Sender: kernel-janitors-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--t6bzhwngfulh5gl6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Julia,

On Sat, Oct 29, 2016 at 09:36:57PM +0200, Julia Lawall wrote:
> Use DEVICE_ATTR_RO for read only attributes.  This simplifies the source
> code, improves readbility, and reduces the chance of inconsistencies.
>=20
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
>=20
> // <smpl>
> @ro@
> declarer name DEVICE_ATTR;
> identifier x,x_show;
> @@
>=20
> DEVICE_ATTR(x, \(0444\|S_IRUGO\), x_show, NULL);
>=20
> @script:ocaml@
> x << ro.x;
> x_show << ro.x_show;
> @@
>=20
> if not (x^"_show" =3D x_show) then Coccilib.include_match false
>=20
> @@
> declarer name DEVICE_ATTR_RO;
> identifier ro.x,ro.x_show;
> @@
>=20
> - DEVICE_ATTR(x, \(0444\|S_IRUGO\), x_show, NULL);
> + DEVICE_ATTR_RO(x);
> // </smpl>
>=20
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>=20
> ---
>  drivers/power/supply/wm8350_power.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, queued.

-- Sebastian

--t6bzhwngfulh5gl6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlg2IdAACgkQ2O7X88g7
+poSKA/9Eptz6QYWi+EKSMoab7gBxSeeoJEpTGGbJhISlgR5LAgpvrTCsLF8Z4zE
c+xqHpbkXQKd8y895fzarCgYzqpnEZOKKUf2YFUUOeevDhhBYYIK2ltS7zLD++Ve
CCmfXXNbhn9pXjuENEDyKwBY3iqxQu3RFSJSrkhB6bJzp119tOkyERt58dzz/Tnb
7M5mRS1FqMhn//UbjhAs2a3VW+Pw7l7o6T3HLBXj9pDJpesfX1h2vztlUJh8zc8l
TVe0eYIRvV0eiV1l0xaaJITKdUzi676vgDccJsu/KRIcra4Qi0QDHD4VeiR3fLYX
UESXUh9PYB786WVqVo346ELiTmkK4/LT+frRqF1IU7sst2eE61bBam+tjEEWsyQA
KIx9s9KexIo+O/dKNbbmbnDq/XP8WKbRiP+pSWro+z1tp7CPez5BeAx++240vuGs
n49pq6I1/ReGL6edJxcPGlkTZtIhijSNPclVhiAZhbQy5GsMExvP4akPHSP8riCo
+a/Csy9PplmdMsQqWLuz6Cqkbiav1QLMHx+AcIgtEThitJdfSxcT6XM5f9a0iTFZ
scSc6Bgu6O4RSLx/uSbntCBjz1rVUfpLMsonpsKGf2YKhJWrqLFlgCZQQnjyOgbW
lVwTtoGI9257/s7SCK6P7M8tpxJHZpIKnv0BxL2LOj5bgrcxB6k=
=N6t3
-----END PGP SIGNATURE-----

--t6bzhwngfulh5gl6--
