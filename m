From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH V4 03/16] soc: tegra: pmc: Fix sparse warning for
 tegra_pmc_init_tsense_reset
Date: Mon, 25 Jan 2016 14:21:57 +0100
Message-ID: <20160125132157.GQ20452@ulmo.nvidia.com>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
 <1449241037-22193-4-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ubuMVesmirrCclZT"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:32824 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932090AbcAYNWC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Jan 2016 08:22:02 -0500
Content-Disposition: inline
In-Reply-To: <1449241037-22193-4-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Vince Hsu <vinceh@nvidia.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org


--ubuMVesmirrCclZT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 04, 2015 at 02:57:04PM +0000, Jon Hunter wrote:
> Sparse reports the following warning for tegra_pmc_init_tsense_reset:
>=20
> drivers/soc/tegra/pmc.c:741:6: warning: symbol
> 'tegra_pmc_init_tsense_reset' was not declared. Should it be static?
>=20
> This function is only used internally by the PMC driver and so fix this
> by making it static.
>=20
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/soc/tegra/pmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Thierry

--ubuMVesmirrCclZT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWpiF1AAoJEN0jrNd/PrOhdB0P/RNfaAqivqwB0FW9sxq48lKz
T1qpLmm1j3pAEWtRfA4swjXc7ARMmskZpKbuijNEwn8Ioga+no1fxwZOXa7+6Rq0
MDLgZitqPOb2SUjlOewDdMbR13kh4pEYxF1Qe+uijsO7sOuWzjtHK7Ohn2A2Go0K
O+JnkSuDR631FOHQY7XoS9UpjYytSdYglveSycjO7d9AvokxEHgrn2g2yzPw3Oxu
m/IgQY57VQ9krOmlyMUhOBSJPk63/63Oxo4W+J44GkjusqiPjpGT1ThqWYGHgtsC
5LMEO5WGi1hNsBg/458l1ECqF72KXmJnOAdCw0HCdoVK0X2aqeZVmtP17vEtdbs7
acmk5sC11ZIfIeo+BQ3IYBPoPvnWISUHbvUvjDwfAVgWLhafEX+yEmek77KvTev4
a4Qpe5qYQTSV3Bbw5S+rMNKoVzp3wXOwI5pIlAnx4YyMNS3XJNoQihQ1sYIwNcmg
CFBCvxdtbxOD1rh6YLl3qg6eq8xsGRi37UWHQPY3AzGCHS67krdM8r1BeO77wsal
6pJ3Cy1l/rFN5FetX3qN8CbTeF+aAVCZUVSJm+lCPK9bUEsNbWoxovXTviORs6yk
bZy/5hyExCPewj2o01ok6ZvgJjs8A/sI7bUp0dW/DuDIZ60g12Oh+NavjRsB0Q4i
evwxyRwpL6dvGIYNqDAK
=VmBC
-----END PGP SIGNATURE-----

--ubuMVesmirrCclZT--
