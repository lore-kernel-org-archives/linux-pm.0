From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/2] power: reset: add driver for Hardkernel's Odroid
 boards
Date: Sun, 25 Jan 2015 15:32:07 +0100
Message-ID: <20150125143207.GD2719@earth.universe>
References: <1414588409-8065-1-git-send-email-m.szyprowski@samsung.com>
 <20150122010631.GL13715@earth.universe>
 <54C05373.60308@samsung.com>
 <54C22C5A.9050701@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WChQLJJJfbwij+9x"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43783 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751138AbbAYOcN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 25 Jan 2015 09:32:13 -0500
Content-Disposition: inline
In-Reply-To: <54C22C5A.9050701@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Tobias Jakobi <Liquid.Acid@gmx.net>, Daniel Drake <drake@endlessm.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>


--WChQLJJJfbwij+9x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, Jan 23, 2015 at 12:11:22PM +0100, Marek Szyprowski wrote:
> Frankly, I analyzed this case once again and I came to conclusion
> that there is no need to make a separate reset driver for Odroid
> boards. There is nothing special, specific to whole board about
> this gpio. It is rather a property of MMC host controller and eMMC
> card that is connected to it. When only gpio toggling code is
> moved to reset handler registered from mmc controller, the board
> properly performs reboot with a generic exynos4 code.

OK, so I guess this will be fixed independently via mmc subsystem.

> The poweroff code in above driver is just a generic Exynos4 code,
> so again there is no need to duplicate it.

OK. It seems there is a driver for that in arch/arm/mach-exynos.
Otherwise I would have suggest to create something like
syscon-reboot for shutdown.

> By moving the code to mmc driver, the same approach can be used for other
> Odroid boards (XU/XU3) and maybe even other boards which need manual
> resetting of eMMC cards to properly perform reboot procedure.

I suggest to start a new thread for discussing this, which includes
linux-mmc. It might be interesting to provide some more details about
eMMC_nDET, since MMC already contain a reset signal (which seems to
be used according to the odroid schematics I found).

-- Sebastian

--WChQLJJJfbwij+9x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUxP5hAAoJENju1/PIO/qav08P/AplNz4asQ5B3jZsMKlzdCGz
fbWIuk6XslHRo6LQnnDKelbw0PgmpCR22W+0AycEC5ClR6ayBcW+KOscDe4kzHI+
yvmZrKrv4j9sPZkSuCY3Q7yFo13Oi25y6nqJ+xQiNMxEp6r4sZmCV7FpTtxcaNRS
V3eSvN5PIAXc7npP35lTJdVpjsLphyzczRtbiR6+VqUus8gQGKE6AhiSLGzGfzCi
9onLZDY/7CLT+lrd0sO7kMq5m1BTFFbkxLcJv57AkQ+XXYCCmQPRD4E3k0PWS592
PrX8y5ttiAX4GBf7SRHkX05WMzBsKVt1NotiNqvJ2sJvxr0Hid5EZAAfm9BwVNnn
jnnGLP2m8qaITnQnpftYQgwtQ9j8rWly/EAn8uhXz71WoqEJDBrKCn2J/qwvS+RE
alGBpTd9nqCeXNxInDL/gBzJjEvmMiQGZTXeKNqahmYTUiIwdx8wmPyLbJjGxNem
PBTlX7GNC2MTztvhe1lUlodWvKyhZ9AgjALn4v5/jFC8L+YnuHk0WLu3cNpJlARd
JYBErptHD7VuE8IlxKCwDmRPoVRwqDNoM3fwVqQKL3+upXws6hN58dAGuDjBvCjx
T832pfkxie01ANqUOtIfGA9qoRYK/+ZTCQjsAqJNfaZarnxjj6gTuKwG+MlFd3sJ
E4mfJ0n+TrBrYaFpFxXo
=L7uC
-----END PGP SIGNATURE-----

--WChQLJJJfbwij+9x--
