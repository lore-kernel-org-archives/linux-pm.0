From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] regmap: include <linux/ktime.h> from
 include/linux/regmap.h
Date: Mon, 23 Apr 2018 11:03:18 +0100
Message-ID: <20180423100318.GA19834@sirena.org.uk>
References: <ccea364eeb830b2092987d271c8308b97fe59d8f.1524465345.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ccea364eeb830b2092987d271c8308b97fe59d8f.1524465345.git.sean.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sean.wang@mediatek.com
Cc: matthias.bgg@gmail.com, rjw@rjwysocki.net, khilman@baylibre.com, ulf.hansson@linaro.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 23, 2018 at 02:42:44PM +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
>=20
> Similar to the readx_poll_timeout() macro calling ktime_* and using
> ktime_t type, which is declared in <linux/ktime.h>. So, make

I'm missing patch 2 here - what's the story, are there any
dependencies?

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrdr2IACgkQJNaLcl1U
h9BVuwf/VtE8pK33MXz12kl0OpPTVWose3BdVvLrb9ZnKlqo4+Bp2g/HS0i7JWi/
q0DYrM0EA08fDlJbNSIhvjkm71YmV01v76YSYEtIakh27tRgR733F1QhznS/nPkU
3K2Cw9MCDVdhXQj0XNH+Aw8bRIT+E1yS5tvG+1VG4vAS8G2QGsS0Wsxgj4BV+NhL
Zvozs296ty9HUwHUbAdnYD+ezRWzPieUpIckk7l7Z/J0zJsindjHs7scB7SPMliI
hovcNmkcU2cOlPA0GR5Qu0YXHw75ILNgyIiNYR/QDEHo7j3Y31Gu8719/SxZvSF0
AoXA932DOuTHbSdAS72nSs47D0rkZQ==
=nJUn
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
