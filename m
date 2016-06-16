From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v8 2/4] power: reset: add reboot mode driver
Date: Thu, 16 Jun 2016 16:36:17 +0200
Message-ID: <20160616143616.GA11677@earth>
References: <1461567051-21734-1-git-send-email-andy.yan@rock-chips.com>
 <1461567336-21834-1-git-send-email-andy.yan@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44650 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754324AbcFPOgX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 16 Jun 2016 10:36:23 -0400
Content-Disposition: inline
In-Reply-To: <1461567336-21834-1-git-send-email-andy.yan@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Yan <andy.yan@rock-chips.com>
Cc: robh+dt@kernel.org, heiko@sntech.de, k.kozlowski@samsung.com, john.stultz@linaro.org, arnd@arndb.de, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, alexandre.belloni@free-electrons.com, moritz.fischer@ettus.com, f.fainelli@gmail.com, linux-pm@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 25, 2016 at 02:55:36PM +0800, Andy Yan wrote:
> This driver parses the reboot commands like "reboot bootloader"
> and "reboot recovery" to get a boot mode described in the
> device tree , then call the write interfae to store the boot
> mode in some place like special register or sram, which can
> be read by the bootloader after system reboot, then the bootloader
> can take different action according to the mode stored.
>=20
> This is commonly used on Android based devices, in order to
> reboot the device into fastboot or recovery mode.
>=20
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Reviewed-by: Moritz Fischer <moritz.fischer@ettus.com>
> Tested-by: John Stultz <john.stultz@linaro.org>
> Acked-by: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

What's the status of this patchset? It still has a few open
comments/issues, but I did not see a newer version.

-- Sebastian

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXYrldAAoJENju1/PIO/qaY6AP/0xIWgWuP7aA4I76hiYNaZ4t
lU/C5xUFpQWP4biGM0sG3VcMdyi2ZpyCM0gDpuD4Sx4GPH9Lmzc21Cr6b38V6WlB
80q/kAkb5s+Fw47xoH1lPJWp95jJeaRhxcTvJHDRvvK6nhjzs6JJhxCMlfky9baS
wJMAQPWLu5wv3pPFA7mbkPIy7e/FVFjbQvgjT5hKZo1qknp5UeOQe9bi7AsJJHfw
1qoYKsLLx/x0JtErc1EoYQjAoGLd1eTGAkbY9kvbghz9adPypkeXmu/Zh+/+CYIW
GX0zThWoajTUDkUZ+Ri48Uznx1LaLVhQWc4nW5nZVC8mqZ/iO0hEglnirLVljifA
0bDS2J4h9B47kInUbeCd8nlAZ7i/G32+yByhl4GmXVcU1bPaKz9wdjMgFdkjfYSa
0IIRhUdqtYvroE8Rb+yWESraE47hfXLMIO5qYzQIQW4xQR2Y5h7DRayCvx2p21Ac
9bkztSe6lWkK6lrPDlajbzxJwM8S4IrILQJvs8dl73+urNI0YF4AL4/K92mjco4u
tLF7DJR4wYZDQjEUvzbI1pOuHMlhoJ1Hy/ccIGMYYSWOmwBLfYB5YpSxqNlH5WDw
4bY1yJ2cUVhD17Iy4qLgvzvokjpKooDyqUEfVEV5UirVsCGuUQS/B/eoeX7jfK2h
lpyg9XOlrg2utCLM7Jz3
=i4Pg
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
