From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH V5 12/14] clk: tegra210: Add the APB2APE audio clock
Date: Tue, 2 Feb 2016 15:37:02 +0100
Message-ID: <20160202143702.GA10098@ulmo.nvidia.com>
References: <1453998832-27383-1-git-send-email-jonathanh@nvidia.com>
 <1453998832-27383-13-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33582 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752882AbcBBOhI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Feb 2016 09:37:08 -0500
Content-Disposition: inline
In-Reply-To: <1453998832-27383-13-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 28, 2016 at 04:33:50PM +0000, Jon Hunter wrote:
> The APB2APE clock for the audio subsystem is required for powering up the
> audio power domain and accessing the various modules in this subsystem on
> the tegra210 device. Add this clock for tegra210.
>=20
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/clk/tegra/clk-id.h               | 1 +
>  drivers/clk/tegra/clk-tegra-periph.c     | 1 +
>  drivers/clk/tegra/clk-tegra210.c         | 1 +
>  include/dt-bindings/clock/tegra210-car.h | 2 +-
>  4 files changed, 4 insertions(+), 1 deletion(-)

Applied, thanks.

Thierry

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWsL8OAAoJEN0jrNd/PrOh/hoQAJVttYAR4oii5jKSlINFsQtZ
/1ETAlw1MhYfoCP7joV6/lLDtHPgNwoXMZAjB2bly2C1b4bXEu0M0a0xmdeuP/ZM
yOj8Q7qsb6yDYi8qgtlpaU3VBrg6/0N5ILHwpSgHrDstwqwPAbw5wUSkWOgYHQZm
l35pwX66wlD/+OWds6VZsdu6ww+Zi3SaOb4kGf3cvGIJitdVLSzCmYFU2eTJOjdZ
1NEIfeYVM92crFKF2n84YAe0S2Lp9XcReuAGAch2sCxZI2EidEZaLWJWaOgJC11Q
eVgZgXSbaxRQfeQphNHHs+koOYq9y/PaCGi97RHcXp1hh/YqE7CfecUJMzDjRfEF
GfoshzuY8ibSL2MJsOkl0/oTbGhzCZ4vewKBT1r8x3hmlr33RnljUsMMkzRIy+A9
e46CIPskDerqMbzoOI9fvdb3dx0FFnN4FVv5Ns1zbfJD6guDuTi/lJe9i25rh8ZM
99C+sNf1gSetTmgnsDU6Yf/Z96GWJOlSR3Jyk9icNiIkwnfTxXKYlCrRuJ7XAB1k
5oicGs1WvN3fqTUa5ofv2aUKSnj81QD5UE1J2B4SIgpHA6jHRDkW0qOP8N64Zpc0
rtWz/AAvwdt8ed5pMW2tkNrONDNrKe+pLrzJ1DqGFX1Lw3eGC3IomVp/lGuxFkMq
4JZ2R4sIwvcXz0uhkJbc
=hCJn
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
