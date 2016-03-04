From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH V7 1/4] ARM64: tegra: Remove unused #power-domain-cells
 property
Date: Fri, 4 Mar 2016 15:13:46 +0100
Message-ID: <20160304141346.GA28635@ulmo.nvidia.com>
References: <1457094186-15786-1-git-send-email-jonathanh@nvidia.com>
 <1457094186-15786-2-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36225 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420AbcCDONw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Mar 2016 09:13:52 -0500
Content-Disposition: inline
In-Reply-To: <1457094186-15786-2-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-tegra@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 04, 2016 at 12:23:03PM +0000, Jon Hunter wrote:
> Remove the "#power-domain-cells" property which was incorrectly
> included by commit e53095857166 ("arm64: tegra: Add Tegra210
> support").
>=20
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi | 2 --
>  1 file changed, 2 deletions(-)

Jon, can you resend this to arm@kernel.org to get this applied before
the final v4.5? Feel free to add:

Acked-by: Thierry Reding <treding@nvidia.com>

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJW2ZgWAAoJEN0jrNd/PrOhMvkP/0fAwrDJdhJHL/WDet2NWslk
Fj19kJPxlWLnBxNJ4ENnMg8HmVc3rO3fm78TzdNsw6OVcRnlvTwXKQPVeaBgOb53
tIqdCfEGJGmLfxH5QQOTwj1ay1TvV9HnXa7qzynm3zydsjYG+JLvlu4X/dQU8cg+
SQVRx9cUPh6c0V2eDDWqLyt3aQdtW5E8S/WUb1K5eoGgbMmu3Sd5A6AmnAdLUNFY
VQBenIreOLZK3V++iWzxhY9epRDjQ1x1Ol1GkAWz4kK5eSdb0+y6mHZ5YTux5PLV
Qf3ydNr0NCDO4VZXaCzyYoHtCX9gbOqsGqzVXaupHbgfiSyMUptk3fa/jkGZ4wR5
tMEAtPpRBUUwEIvJ+asKYL7dv4+K83FD0Gby5f+lReGatVbO9UldVX17MYh8DY3J
D7gW7Tsopbbuzv3aFlI0x8sGS3n4QF/ADF2EtnmKMhtH/Uyoy++T+QmQiLPH6x2Y
CMibVvUuBl0iPumP37Whe11NjaaDU9cYK1VurOHXHSulG8ZdV1tg1VnkGdL9tLQs
YGPU50q0+kWAFWPHzxO5NJa1Y9kAlcEK5V2XHplLB9k+XGEe3PBOxDxR07Fz9v/O
BdQItJSuDXX9GsqBfPu4AES4X1GXTQz4vYQVeVR+sfMg9eIj5GULq2KvfMyqE6Wn
rLz0TV3xfAWwZ3xMRYZm
=Y7Nm
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
