From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] thermal: rcar_gen3_thermal: fix initialization
 sequence for H3 ES2.0
Date: Tue, 17 Oct 2017 00:07:22 +0200
Message-ID: <20171016220722.2szoquhmznzhqlwk@ninjato>
References: <20171016145259.27897-1-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qtjylg4i2vqxkb42"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171016145259.27897-1-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: linux-pm@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-pm@vger.kernel.org


--qtjylg4i2vqxkb42
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2017 at 04:52:59PM +0200, Niklas S=C3=B6derlund wrote:
> The initialization sequence for H3 (r8a7795) ES1.x and ES2.0 is
> different. H3 ES2.0 and later uses the same sequence as M3 (r8a7796)
> ES1.0. Fix this by not looking at compatible strings and instead
> defaulting to the r8a7796 initialization sequence and use
> soc_device_match() to check for H3 ES1.x.
>=20
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>

Looks good to me, and what Geert said :)

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--qtjylg4i2vqxkb42
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnlLZQACgkQFA3kzBSg
KbYriQ/8C77EyVpsIHaZ/IK/UFo/s/U67fBd13rrqbIC71RN5xKYKro/2V938i4Z
U5WBUlnRl0jgB6YseU2MbTfFLA7KOP/QBnw1o2oYEMhEIVdlfQaIBbw/lQqaQ7r+
kTGOU1EX8/CTRHOo1SZF97GAITINpi6QJkf1255sA/+6nehUiHWRASLxIwD5jA7h
ln4QKXlkXumeo+1XEpdvrdU7hwQ1QFc5zd4/7tBSQVSpB2n7MwWpFJ1HXzJYoLAj
+PQyONxMJRm1WwLze6MX2hYu7EyGP2/0+wVGZtBfZszuxponxIYRV3CTHhkOctsG
VNuYYfJhvu5yf0Wk2eeOMExjCgcMUI1NlDjAzFTlREgTAXXU3NstarUPV9VFJipM
CxBZR+XxjI5dLwwLZCBdlGhjtkM+Nsjt9QknClhoSwG0PpYcmVU1m6HtFDOvuqjD
Et9SuUIgNpqzs+xep7cT/cQBUf6cQR+xwflUfxnp6UhpVvMLH1Ixm5MjAwdmo/fq
li6i6/9yTJBXo6BLA1Jl3p7wHe1DO0mTSrE3/q2VR+S1VdZmh0kQmwdisT1GSOuv
qtj4LVwJtPE2+hVpXqJ4ujvpHoEkk2TG5vrqU7ComkF0GB0GnpwYwmFG00LAHK41
p6pN4+xMR+/kqDBCEyGF21cnQr6ToIMeGuUeDMyQ7fzqRlLHJHs=
=OfJp
-----END PGP SIGNATURE-----

--qtjylg4i2vqxkb42--
