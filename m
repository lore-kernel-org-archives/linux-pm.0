From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 1/3] arm64: defconfig: add allwinner sid support
Date: Sun, 12 May 2019 15:25:58 +0200
Message-ID: <20190512132558.745wbonxn6qrwvke@flea>
References: <20190512082614.9045-1-tiny.windzz@gmail.com>
 <20190512082614.9045-2-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lbhyzlowgxdvkbq7"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190512082614.9045-2-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yangtao Li <tiny.windzz@gmail.com>
Cc: rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org, catalin.marinas@arm.com, will.deacon@arm.com, davem@davemloft.net, mchehab+samsung@kernel.org, gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com, nicolas.ferre@microchip.com, paulmck@linux.ibm.com, andy.gross@linaro.org, olof@lixom.net, bjorn.andersson@linaro.org, jagan@amarulasolutions.com, marc.w.gonzalez@free.fr, stefan.wahren@i2se.com, enric.balletbo@collabora.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--lbhyzlowgxdvkbq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 12, 2019 at 04:26:12AM -0400, Yangtao Li wrote:
> Sid contains speedbin information and temperature sensor
> calibration information and more, which are important for SOC.
>
> This patch enables CONFIG_NVMEM_SUNXI_SID by default.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Applied for 5.3, thanks

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--lbhyzlowgxdvkbq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXNge5gAKCRDj7w1vZxhR
xeJXAP0WWHx9kGrJrvMvq9Mm+3L1Sd+z+4KFnlWWGuQScu8bXwD/d3EK/qKg46B+
ztgYKIXbsBFk0dYQ8tOvMmeB84JBkQw=
=kR0R
-----END PGP SIGNATURE-----

--lbhyzlowgxdvkbq7--
