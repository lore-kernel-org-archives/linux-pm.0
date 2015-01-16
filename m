From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Add entry for Maxim PMIC-s on Samsung boards
Date: Fri, 16 Jan 2015 19:57:28 +0100
Message-ID: <20150116185727.GB6422@earth.universe>
References: <1421407190-6771-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yEPQxsgoJgBvi8ip"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1421407190-6771-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: rtc-linux@googlegroups.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Alessandro Zummo <a.zummo@towertech.it>
List-Id: linux-pm@vger.kernel.org


--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jan 16, 2015 at 12:19:50PM +0100, Krzysztof Kozlowski wrote:
> Add myself as supporter for Maxim 77686 PMIC and Maxim 14577/77693 MUIC
> drivers:
>  - mfd (all of them),
>  - extcon (extcon-max14577, extcon-max77693)
>  - power (max14577_charger.c, 77693 on LKML [1]),
>  - regulator (all of them),
>  - clock (clk-max77686.c)
>  - RTC (rtc-max77686.c).
>=20
> Lately I am the author of major contributors to them. These
> drivers are used on Exynos-based boards (Trats 2, Gear 1 and Gear 2).

Acked-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian

--yEPQxsgoJgBvi8ip
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUuV8UAAoJENju1/PIO/qajo0P/R4YpdVXsja1M96iSi8WGJm/
cTm/1qXQaltsC7+0G1W6aF9o/5ofNsH+ybc4pVcMLTnvZVT1JgQK+i0LoMbN7gHk
N5w7qH7JJ4z6wPQ+4v7YBpGZZsIlpZL3IW/HsV3lxw6JrQXlKTj8PFjp5sQ8sVFb
OZJbO7yRU3rF7crcC2oCodBWys9dDeSgfx04Gzee+7RF9JA+bQ8M93+XD0EsmH+Y
7l5QbMmjH10rNOiMqQ5NxubQNgB+dOJRDFJdNiMIBglQwT5mDXup0Siu7OjqiAKy
3cq7tODHV6D0ZSwrpDnP2xf9Nl5m0d0Iioav3toZrXBGlhrd70dqnqEfpebj5T2L
Sq1IG93vOJBbO6prSY9C3QF9kfIt0PCf6ZaugwfTOiUNob2phhegHEAbVTJViRsn
aMqDZ8zfoQKJPyYUjJ6Wqc8pIxz28ROCWNnmBIdERnw1px+2HjejJKp2dLKjupz5
Qn8PDdSgLhaBmNTHJt3e73/eR9Bwys150uOV7BCruf3KS3+kxoDg4eO7gPw0beyu
VvZjW+WJ22HYa9/rM+Dci/HER+JUv0HsgtGj645NrMA1L6Z4L+IFZMHXfbwHLBri
0jtKypTbYbPJxmw/3eCZgoVqo03fkZuIU2wEtnCkD6c8hb8WBl7oxlHYPQ5Wvp+s
hUavmfMWQ6i/bX/jgzwu
=lpyl
-----END PGP SIGNATURE-----

--yEPQxsgoJgBvi8ip--
