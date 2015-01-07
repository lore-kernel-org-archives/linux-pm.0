From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v2 0/2] thermal: rcar: minor fixes
Date: Wed, 7 Jan 2015 09:30:15 -0400
Message-ID: <20150107133013.GA9484@developer>
References: <1420593191-3736-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1420593191-3736-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 07, 2015 at 10:13:09AM +0900, Yoshihiro Shimoda wrote:
> This patch series is based on linux-soc-thermal.git / fixes branch.
> (commit id =3D 5a723e81923410f0d3ae4c38974607b13befdda9)
>=20
> Changes from v1:
>  - The driver calculate the ENR value using IO resource sets in patch 1.
>  - Update description about the helper variables 'old' and 'new' in patch=
 2.
>  - Add "Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>" in patch =
2.
>=20
> Yoshihiro Shimoda (2):
>   thermal: rcar: fix ENR register value
>   thermal: rcar: change type of ctemp in rcar_thermal_update_temp()

Applied to my -fixes branch.


Thanks

>=20
>  drivers/thermal/rcar_thermal.c |   15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>=20
> --=20
> 1.7.9.5
>=20

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUrTTFAAoJEMLUO4d9pOJW20gIAJTpQlix/dDIrfzA3F5uPiZH
e38+vL3e7dBZGztbnviZNB76REU+lO3TPB9eZi/p0S884CM7r67j/w0o8zLbN8Vs
1GlAlRJiGnbt6BjfTxnR+VwmuSHjjb1i3Si4bJGYOT4Y6QiBRT6O6p0zax1oe7K8
j2lKhD9tMgiv10MpXiaaulSmYbHDqxJUyiZrbjB+7TnXhDTQrOAim8f3Mo/pl8tC
ORvoR0UzzRl/+zyj/eEQKnxvY8vEZiqhRxK3Rf9TBpcAmtBgMOmcvjt8ILbMg9cR
whOKc02QwQYyspQcHZ97n1kUHTF6jDTArXRhRXoAzjnEjNoKEHqUuDbwG6eqBnU=
=lBbn
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
