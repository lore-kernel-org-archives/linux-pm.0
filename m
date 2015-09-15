From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCHv2 3/4] power: Add Qualcomm SMBB driver
Date: Tue, 15 Sep 2015 14:43:34 +0200
Message-ID: <20150915124333.GA1442@earth>
References: <1438278837-29967-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1438278837-29967-4-git-send-email-bjorn.andersson@sonymobile.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1438278837-29967-4-git-send-email-bjorn.andersson@sonymobile.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, Courtney Cavin <courtney.cavin@sonymobile.com>
List-Id: linux-pm@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 30, 2015 at 10:53:56AM -0700, Bjorn Andersson wrote:
> From: Courtney Cavin <courtney.cavin@sonymobile.com>
>=20
> Add the Qualcomm Switch-Mode Battery Charger and Boost driver, found in
> pm8941.
>=20
> Signed-off-by: Courtney Cavin <courtney.cavin@sonymobile.com>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> ---
>=20
> Changes since v1:
> - Corrected authorship
> - Dropped MODULE_ALIAS

Acked-By: Sebastian Reichel <sre@kernel.org>

I think the first patch made it into 4.3, so I can simply queue this
patch together with the DT binding?

-- Sebastian

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJV+BJxAAoJENju1/PIO/qauP4P+gJDUgBEiRdF/oC0JuIW+V+e
bQ4y4W2ualuGhzE4SSmeD48a0b7oYmeteSlbh0+0l9PlxqiSFm/sy9pNM8oe6Nfe
KQ+fFqLchOMRYOw2uSEDcdLj0JlJm5h8tZmymwqMv7NYvaPaF1i0Jz63mZ30b3w9
SSHEY5xmZ2MEzYeVu+fiZ57hOrhKEKAoUbv+ZP5K6Jq8tatrxy4yzO/6p8nZq4zn
9tYzqtUKT4bCppZB3nQwXv/oEsCPOEDt9BpdwlKEIOpgexs95rT3qAdzTWPsooe6
yB1dkq7KZjrwFobS6VDdiXsG7i1THNx1+Q1d0HAtI+xKW4R8NesgvAaebVRA0Xgu
VWhqPEGunPMMXaRLvNq9Zuq1hQxNRA1hxcjrrEdYhExwd7L1XZxhOSplKexqkB+N
WmhKJn5KOjxqarWon2qoWQi2daa0ZWYdwC1EUvdyBBBuJdW/x1S2L9lCZWdYMKls
EXD0Ljh0/NvlsDqyBUKN/GmOV66+GfiSh03grXqm5LYkByB26IJZJFXX9JwMKYPW
045BQQj1DmFod/IyANNBLD7fkwY2wXSQOXF5hv15I9QLsUxM5Ygs5e1M8SzSux3d
I76wFJ3sRX5olYqBZmgHWl1hHj96Lwzf2x9y+d7zVj8Jt/vGNqYq+rr+8U28i4MW
oTurvT31V8V4Meuyk0/K
=QVI1
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
