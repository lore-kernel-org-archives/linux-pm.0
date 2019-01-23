From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v5 2/7] x86, olpc: Use a correct version when making up a
 battery node
Date: Wed, 23 Jan 2019 21:56:27 +0100
Message-ID: <20190123205627.nbddtfuy6qdo2bgb@earth.universe>
References: <20190110174005.1202564-1-lkundrak@v3.sk>
 <20190110174005.1202564-3-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lpmyezh6u4iltf3f"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190110174005.1202564-3-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, x86@kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


--lpmyezh6u4iltf3f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 10, 2019 at 06:40:00PM +0100, Lubomir Rintel wrote:
> The XO-1 and XO-1.5 batteries apparently differ in an ability to report
> ambient temperature. Add a different compatible string to the 1.5
> battery.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Acked-by: Pavel Machek <pavel@ucw.cz>
>=20
> ---

I either need an Acked-by from the x86 platform maintainers, that I
can queue this through power-supply or a pull request for an immutable
branch (probably the better idea).

-- Sebastian

--lpmyezh6u4iltf3f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlxI1PsACgkQ2O7X88g7
+pqrZw/+Md3qBkUZYZAqMNoEDlok7+li3OlE4r+BFb0HQl72BLWRv373gEtloWfK
leEggi0wgJSrx/0vt6ZJxKnFPBKRI26V2LIuWNfM5mj/BqQGykdBENbkcYG6bE3D
uDCIuRqRxSDNJOhIDVr3CFMaLcW470Wc2Q1YAQA01sfmCFTSHuyj/2nmJmL+AcMN
9u7jEb//Y4hhcaLtuAG/UFcqC68Yey5epxHVxoN940XJyIUEx3EScRbbpNf1ZFWy
IcSLJeAQTKY9j6n/OB1E8b6ZJxp5ZVQqeuaGu5+3PBqDpYcVL8+wIGhP4n7CvOGK
7ZJCGLEChqRs2gUJhi17Rg/LgGBGl8myEnEYVKaeyy8Kh6g9a8jb9Q49R6AxISUH
pv9wi9nwL2/EPyqbg4UWNubKYXkSZKA/tFRetAofTvoJvF+FI3t/d3z+G6vv0W6M
OH9IzFZyKu419q6j64g37fBB4NPG3+pZu4FYEzhUfRpRQgYL5cHoH6ZwM+NpKdUM
FUlQvIhmTRsNzZCsfztIz4GOlTTdaZCEyt4jWt8dZcrm6Wle648jQblrjquSLapk
lkg+H1b6r/dzpf7gwoUQvU0tSUaZ+U0hpstSYL6lE/akmkXsuLMMkMA6qRHs+MPX
TgUvS/D9dqPutkHvLBV3HgMuDLu0VK2sDNA6DeLzsC7xP0SK6ak=
=UlIM
-----END PGP SIGNATURE-----

--lpmyezh6u4iltf3f--
