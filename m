From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] PM / AVS: rockchip-io: depend on CONFIG_POWER_AVS
Date: Sun, 24 May 2015 21:54:46 +0200
Message-ID: <20150524195446.GL11066@earth>
References: <28649509.lINlAh7Sts@phil>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7vAdt9JsdkkzRPKN"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55077 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751267AbbEXTzJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 24 May 2015 15:55:09 -0400
Content-Disposition: inline
In-Reply-To: <28649509.lINlAh7Sts@phil>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>
Cc: Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, dianders@chromium.org, amstan@chromium.org


--7vAdt9JsdkkzRPKN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, May 23, 2015 at 03:41:30PM +0200, Heiko Stuebner wrote:
> The rockchip io-domain driver currently only depends on ARCH_ROCKCHIP
> itself. This makes it possible to select the power-domain driver, but
> not the POWER_AVS class and results in the iodomain-driver not getting
> build in this case.
>=20
> So add the additional dependency, which also results in the driver
> config option now being placed nicely into the AVS submenu.
>=20
> Fixes: 662a958638bd ("PM / AVS: rockchip-io: add driver handling Rockchip=
 io domains")
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Looks like the power supply entry in the MAINTAINERS file is missing
an "X: drivers/power/avs/" entry.

-- Sebastian

--7vAdt9JsdkkzRPKN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVYiyGAAoJENju1/PIO/qafGMP/33maP6gYFXlW86NlrOQBZnn
B2rGHAizS3hNib9z6SixlVjz5A0Ip28MSruDfI2o3HUmP2Inyg3kjELaJ3rv29ic
zVfP3IjmOsMoRopmCodHV91BvfVtLT8SV4xLyHX0OfV89zb3J43YEmUbfi1HysGk
wIhZeIcPt37WxSHVDtFPDyse0Ft6RWfW3DALPVNJqhVRNfKv1t/8UH+Ii/MGhZHO
mPSOsatRa1AmrBc6PLtcn7EkA4e5jfJmDl2H0G+qZHBTYw/Vuf/1qAzepbs1wVC7
yA97+yT25ZE3trjjZH2E22NuAFT8dcaxLtsWALP1/hpbBgEOT2dXcbL9N4C33qJ1
K5g4X2FyZlThrl+TxVjqe233j2xJlWbxGQyPspFlOABjb7Co2GEjLVnYKyPv2S01
O1NA0MjQ8WetUvJFECVtOatK3VuKIoDrCuBWp17FL0VtUfjzapBcsCRtAtbSqr/W
g1VteK7XSUeAzF5d+BolSsVGIXNOj7yrA2PJGKMKJyL8aDsGWDxB7spOGJwK83FK
KxGyQcUfhWVohBi7v+leZ2/xurkbT97ljVxSCpCDvClcRO9DXoHnv78bLzJsshwz
mwR3Hgxb3UBOntTclYyH/8rHUCMXeQTNkIF8rgQVtfQkisRpiAOlSsXr/MUIhLkW
Fc3WquoPem+7EIv2TgPu
=/nsy
-----END PGP SIGNATURE-----

--7vAdt9JsdkkzRPKN--
