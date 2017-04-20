From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH V4 5/7] ARM: sun8i: Use - instead of @ for DT OPP entries
Date: Thu, 20 Apr 2017 10:02:02 +0200
Message-ID: <20170420080202.olu2mhel6xtmnnjt@lukather>
References: <cover.1492666725.git.viresh.kumar@linaro.org>
 <d13e447e9cc080d81c4f2db3bd5433506d3ef739.1492666725.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mndni4cticg6cqm6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d13e447e9cc080d81c4f2db3bd5433506d3ef739.1492666725.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: arm@kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>, Krzysztof Kozlowski <krzk@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--mndni4cticg6cqm6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 20, 2017 at 11:14:16AM +0530, Viresh Kumar wrote:
> Compiling the DT file with W=3D1, DTC warns like follows:
>=20
> Warning (unit_address_vs_reg): Node /opp_table0/opp@1000000000 has a
> unit name, but no reg property
>=20
> Fix this by replacing '@' with '-' as the OPP nodes will never have a
> "reg" property.
>=20
> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reported-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Acked-by: Rob Herring <robh@kernel.org>

This patch doesn't apply, please make sure to base them on linux-next

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--mndni4cticg6cqm6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJY+Gr3AAoJEBx+YmzsjxAgzn8QAImLiepFAPjtY1bir1+hXIjW
mJUYDkTPz/gFh8NI7k6kjT3J7zXE2cn1ptx3INdZ4jYnah1MiqNzG/LU6I6A2GH+
cwOtoV/ASkPTvO5ewoCeKCEJQjfxBLMPZFjiL7IWu/gaLMT5V/Yaf3wPkSjXtjAT
5unOc4oWbo8XxFscdLg0NAbX5axaCrfe8kQZDo6aWr0erO7z8BCiQ8AXWGmDREUa
9C0d0XnqpPzjbHssT8PDu5nYABLZsjpQIR4QP1wXmf6XSn/SL3HS9LvOZflBVpRn
JT41nG99jueHhi9i+EomqDyGfGT9JIMrfPJDBY3yEj2n3Trmken+ACHBw6sX6L2I
ygoHEf42d0kFXpkHRcRdLR0U0QXtHZu9Onq37CeVJiZqETZh9vwwYyqGcr/g1IBJ
epijGVFquNU8OhDi8fEA+3Jta+kBj7MVLPpiqC0NglHemEmFzJj9a+7xFeopYOWI
ToHgWu4s5DvPmnCba0v9QEfjqRJVrWzDhWW91dbZuPq4bpCHbqGyQBmkoezcuoJs
yX8kDaVQJMEQOdcJAqksi2hB2iEueGibvpPtLY12T+T0SQm2GmdYpeJ3umkK+nUp
4JgsoP3S1t8jJosRE1P0sW4nfyElqoLoBFE7xTWLi2OFsXkW3CSUhFSX3wabyofh
aX4xQhUNGqe70//+NUej
=VxCM
-----END PGP SIGNATURE-----

--mndni4cticg6cqm6--
