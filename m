From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 3/5] power: supply: sc27xx: Add fuel gauge low voltage
 alarm
Date: Sun, 25 Nov 2018 22:45:01 +0100
Message-ID: <20181125214501.GA9913@amd>
References: <cover.1542185618.git.baolin.wang@linaro.org>
 <ee1dd39f126bd03fb88381de9663d32df994d341.1542185618.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ee1dd39f126bd03fb88381de9663d32df994d341.1542185618.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com, broonie@kernel.org
List-Id: linux-pm@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-11-14 17:07:06, Baolin Wang wrote:
> From: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
>=20
> Add low voltage alarm support to make sure the battery capacity
> more accurate in lower voltage stage.
>=20
> Signed-off-by: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Should we also shut down the system when that happens, as battery is
empty?

Or is there any lower threshold when we should do the shutdown?
								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlv7F90ACgkQMOfwapXb+vJtRgCfS3fRJIeEdzw59EOEwnN8MoZ/
U7UAoJYHWQoh0LNWkvHLGSpc0IDzq2QH
=teVP
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
