From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v4 1/2] cpufreq: Add sunxi nvmem based CPU scaling driver
Date: Wed, 17 Apr 2019 10:32:12 +0200
Message-ID: <20190417083212.mng5p276kyot3nvw@flea>
References: <20190416155209.24216-1-tiny.windzz@gmail.com>
 <20190416155209.24216-2-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="psruohnblxprxqcd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190416155209.24216-2-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yangtao Li <tiny.windzz@gmail.com>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org, rjw@rjwysocki.net, davem@davemloft.net, mchehab+samsung@kernel.org, gregkh@linuxfoundation.org, nicolas.ferre@microchip.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--psruohnblxprxqcd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 16, 2019 at 11:52:08AM -0400, Yangtao Li wrote:
> For some SoCs, the CPU frequency subset and voltage value of each OPP
> varies based on the silicon variant in use. The sun50i-cpufreq-nvmem
> driver reads the efuse value from the SoC to provide the OPP framework
> with required information.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--psruohnblxprxqcd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXLbkjAAKCRDj7w1vZxhR
xbzdAQDVXEZNf6LbdNqHjBzS2ujcjdlY6nI4E2lZas2cnk9DJwEA3E3en227I2pT
ZdgykUAdmZ0iSc8o2PioP61AY2DvqA0=
=+DVI
-----END PGP SIGNATURE-----

--psruohnblxprxqcd--
