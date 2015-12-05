From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/2] power: Fix unmet dependency on POWER_SUPPLY by
 POWER_RESET by uncoupling them
Date: Sat, 5 Dec 2015 01:59:37 +0100
Message-ID: <20151205005937.GF22936@earth>
References: <1449035947-16758-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0hHDr/TIsw4o3iPK"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449035947-16758-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Pavel Fedin <p.fedin@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
List-Id: linux-pm@vger.kernel.org


--0hHDr/TIsw4o3iPK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 02, 2015 at 02:59:06PM +0900, Krzysztof Kozlowski wrote:
> Actually reset/power off handlers do not really depend on power supply.
> Move the power reset out of power supply block so it will appear in main
> drivers section. This fixes following build warning (encountered on ARM
> exynos defconfig when POWER_SUPPLY is disabled manually):
>=20
> warning: (ARCH_HISI && ARCH_INTEGRATOR && ARCH_EXYNOS && ARCH_VEXPRESS &&=
 REALVIEW_DT) selects POWER_RESET which has unmet direct dependencies (POWE=
R_SUPPLY)
> warning: (ARCH_EXYNOS) selects POWER_RESET_SYSCON which has unmet direct =
dependencies (POWER_SUPPLY && POWER_RESET && OF)
> warning: (ARCH_EXYNOS) selects POWER_RESET_SYSCON_POWEROFF which has unme=
t direct dependencies (POWER_SUPPLY && POWER_RESET && OF)

nice catch. I don't really like the Makefile changes, though. I think
it would be better to make the power/ entry in drivers/Makefile into
"obj-y" and handle the details in drivers/power/Makefile.

-- Sebastian

--0hHDr/TIsw4o3iPK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWYjb2AAoJENju1/PIO/qaJbAP/jH/uj7XLvaG4ZoxU0JO4R63
vaaIRwuLJb0kihaiBFkBUA0p2bo/7U/iUnTMuLF00NS7Lp1LUQrUAIva3Y73WVwD
mAb3I9uy1EgwcRjF/d6fFS9hf8r8qPl0w6RE+4VBgZtPltArGvJbUdnEJSSOa51j
6ONRtsnlDQYB6ROSI2YW4C7TTB3ZHJDhlTy4FOqabNgpyP3zObJxzgrmAyr7zqML
pUTAZ8oD34YY+IWiy8dEqfKFJQxaQuPq6ZbEzSK8U3mqLWD8R6vqYhbxhDnbnMoJ
nLit2vitDqKwuDoZ5CfNTxQs5Nzh9rt8IiBY7D7q2JU+oSx4arHF2TzJchDodlb0
ObpTlC3TxizJIHfGO+ZZuntZJkTeIJCrIwW+XrZgf6PQr6Z1JNLg6DKd40g25pWn
YT0zrT9hoJnlgN226hBTsqo4eGE57qtyiamnCLtuvy/x2n3Frt5g7teK6KWDU/nW
FHaZakEcGUPd+SYbaccs5Yg9Nw0UF1nKhZpLwl7KaVV0x947YRXWeMQh+PMAlS8b
9TvXX7KEOarhz2zF+yxZxVhtpTiaWv6uCQQm4ucyzygSpO+OtWL2v89dKqgcRCwR
F8XoaL5dxrHs902DmyCx86tLYos0FkBJSo+KHjkqGC3q917kyEURcX+IAvcaYa7c
RYtD/kws7H1c8AezWVjn
=OZxX
-----END PGP SIGNATURE-----

--0hHDr/TIsw4o3iPK--
