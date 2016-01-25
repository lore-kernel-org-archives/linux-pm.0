From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH V4 07/16] soc: tegra: pmc: Remove non-existing power
 partitions for T210
Date: Mon, 25 Jan 2016 14:27:54 +0100
Message-ID: <20160125132754.GS20452@ulmo.nvidia.com>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
 <1449241037-22193-8-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0blaZc+aUkVqY8MO"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33999 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbcAYN2A (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Jan 2016 08:28:00 -0500
Content-Disposition: inline
In-Reply-To: <1449241037-22193-8-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Vince Hsu <vinceh@nvidia.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org


--0blaZc+aUkVqY8MO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 04, 2015 at 02:57:08PM +0000, Jon Hunter wrote:
> The power partitions L2, HEG, CELP and C1NC do not exist for T210 but were
> incorrectly documented in the TRM. These will be removed from the TRM and
> so also remove their definitions for T210.
>=20
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/soc/tegra/pmc.c | 4 ----
>  1 file changed, 4 deletions(-)

Applied, thanks.

Thierry

--0blaZc+aUkVqY8MO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWpiLZAAoJEN0jrNd/PrOhLEcP/1kgrFtJlUwI2SkNI+9mHH+f
kWIkXAU7xXZNalyelPW73esbcPTDEmkgrMAF3FkyNus5qVESYV/oTn1rkEKXJEE7
ulcd+P1md/uot5ZG5fmQQpGehjVK7wGVutFkoQiLemLN1JODGWnhq5jVHbFTzAg+
23Fpl5xiXRNUP453cP6d/3EfGalhoQoBoDpJd7HfDrxH1wtfKrIfRvMOqfv1Pj+4
fyPvUHwGvQs31lYRqkimdn+C15TmVvFnMBwsKDVDucGxT4oWy3AaXXJWpCAJyaex
PtO9rsowL9mUG0N6cinICjiNu6GuI1fcAd9i0hWbCm7gLVDbNzSGu1xV+U1lokWk
fFCbTjZAwN45JI0V9Uj5QKNnpXCUTAP6mZLfgxSfNOeuMHzF1KoLESKQxSMHzquS
1noF4wfdodmcs5jsCv1n32lFO8OXyqOk6KaNMBTwCkCI6vuaOX6QImc8iMVdHEro
1fhm/hV34iXvwWwwZ6MJik31KDco4HEHF1TdKIdbmzjsFzOw0TTOfkpC5fwplMsT
N4a0P0V49qkZSgXviUv8g+0dNf9Ibg93lCCR9yjiWpADba0hFPzoFXPIFKddE3aX
CGmpUEhs+yJ8II/nLapCyEgPky2Iq8RVE5k2mOrdb9M2krO86K3ZI3ScoTMDOalw
vE/a4vz/7ceHULaMV+z0
=uEJj
-----END PGP SIGNATURE-----

--0blaZc+aUkVqY8MO--
