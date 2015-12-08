From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2] power: Fix unmet dependency on POWER_SUPPLY by
 POWER_RESET by uncoupling them
Date: Tue, 8 Dec 2015 14:39:23 +0100
Message-ID: <20151208133923.GA21934@earth>
References: <1449459912-29482-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449459912-29482-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, p.fedin@samsung.com, linux-samsung-soc@vger.kernel.org, arnd@arndb.de, olof@lixom.net
List-Id: linux-pm@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 07, 2015 at 12:45:12PM +0900, Krzysztof Kozlowski wrote:
> Currently the reset/power off handlers (POWER_RESET) and Adaptive Voltage
> Scaling class (POWER_AVS) are not built when POWER_SUPPLY is disabled.
> The POWER_RESET is also not visible in drivers main section of config.
>=20
> However they do not really depend on power supply so they can be built
> always. The objects for power supply drivers already depend on
> particular Kconfig symbols so there is no need for any changes in
> drivers/power/Makefile.
>=20
> This allows selecting POWER_RESET from main drivers config section and
> fixes following build warning (encountered on ARM exynos defconfig when
> POWER_SUPPLY is disabled manually):
>=20
> warning: (ARCH_HISI && ARCH_INTEGRATOR && ARCH_EXYNOS && ARCH_VEXPRESS &&=
 REALVIEW_DT) selects POWER_RESET which has unmet direct dependencies (POWE=
R_SUPPLY)
> warning: (ARCH_EXYNOS) selects POWER_RESET_SYSCON which has unmet direct =
dependencies (POWER_SUPPLY && POWER_RESET && OF)
> warning: (ARCH_EXYNOS) selects POWER_RESET_SYSCON_POWEROFF which has unme=
t direct dependencies (POWER_SUPPLY && POWER_RESET && OF)
>=20
> Reported-by: Pavel Fedin <p.fedin@samsung.com>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Thanks, queued.

-- Sebastian

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWZt2GAAoJENju1/PIO/qadxIP/024PnOZ7cIutEnHublKEBlH
7v4J7Y6nkeuN4NTFHebndqKZNI8Ph5tL6RwVzDynTuW6BuOUSu0JtcI9ROT4jnZX
M8Dach/M22WALvAgIcvn4eT5ljB1CPLxnI/bPrLdtAEh3TrBbA5lJr8cD4PV6wcY
LmZiH41qF8zd57jeOZtIIsRsQWRXkXcO/vL0XMV25OaMmLdhQOcUdzBRsgYnEDAK
j/HRttlUHrd7LJK/yj45SGEU6ya99ZgFSXi5wVVFWpLwLI/UShjF6xhaXseXGrKA
gSSp69j0jeLKbDcQoJ3W3BfRDFu9aUdQJz+JGY4fKdX1N2j7ZCvuat00eHt/xGBV
gE+fG/hvqh8xaxjowIb8qWe0x7eel3m755zV/2aUwdBr2Qdm6/yl7U66WdpDteXq
JO70CD24g/J6r6zYa4TK4lmGVSoyx8glGFesDFCfyTTpMPrfYdrBTGo16JpeHYQt
gYYmbc9KAHZiyZeNOYqbe+Ah370otUFgTVqIBYvDBOrSd3D/qHQXUvdcRqgfR5Xg
PCLGElbPsk/861ECkW3Z24bnTsboPaNuauWq2ZrK3ri9HBcRO1H311ubNvz88+bU
JsVhrxZkYNxTL0pV2PK+dEYtVbdt51gXhAvXtT7yY37IAKsHbhYy3hUMWxp5SaL1
NcgCwjcaeiUkRhaUE5bK
=70m0
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
