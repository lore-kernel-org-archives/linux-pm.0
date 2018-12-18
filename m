From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC/RFT 08/10] i2c: exynos5: use core helper to mark adapter
 suspended
Date: Tue, 18 Dec 2018 20:52:56 +0100
Message-ID: <20181218195256.hvmgl5wt3jeebz5k@ninjato>
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
 <CGME20181210210429epcas5p2b545f32165b5025e7cec0b5f5b98f783@epcas5p2.samsung.com>
 <20181210210310.12677-9-wsa+renesas@sang-engineering.com>
 <87b6a87b-92d3-a1eb-b77b-f91651c72270@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lmgdxylq2cyzuy6g"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87b6a87b-92d3-a1eb-b77b-f91651c72270@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>
List-Id: linux-pm@vger.kernel.org


--lmgdxylq2cyzuy6g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thanks for testing!

> Similar warning was already there ('HS-I2C is not initialized' message,
> without backtrace) during system suspend/resume. It looks that cpu freq
> is resumed too early, before any device drivers, but this is not an
> issue for this patchset.

Yes, this is actually a desired outcome :) Raise awareness if the
suspend/resume ordering has issues.


--lmgdxylq2cyzuy6g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwZUBQACgkQFA3kzBSg
KbaehxAAm4Uf0X43KMdWHwO/Iyha2jVgfyVJCnEMNu0j2wFzirDaaKvmPNyDqFyS
BRhqzCjVsl00sECsaLGQLn0WB1geFHvyj7IPjVy51zaunuPVosslaZsjaS6+TLui
x8IY3u5GxRT4MW6siGMqa8iyjZQ3F0Yk8ZmIhoFvaDC14J/7XGAkkKaNxEkA8KZD
kRCTbdXYnHiwegDOZ8sorv4XNCXynvNyJ7SIuy0aaaipJG/iqIlrED3Bc2+PFz/A
LZuVHv5/mPLSdXddNJ4hIi7cEfJN6n48Ey/XaMBOzHlFBcxpMFeOOpzO7YsNnqfa
SYRqYR315lD3oKP3VCQMGKqmM3AVXMy1rAbC8LnV2Q1GEH6+PWrUPC02IAgOtce9
n2EL+rxgPwepc3ttBspZWldmXX7rbjL7jI9fSKqT71jVugMNGhYz7avM8UkzpjWR
AVAKRS/+E0TW1triR0/vkl4i6UDw3yr47/vyOacrnGpnyU6MYgtJ3kqRICf51Yos
xCltgDSelxBMHPrARsQvuv1sHw9EyEFAIDXbA2Y2h/uMY17saFA+XFhghSsbw4HA
MyGwOHVeQp0dMsWG7llpvGdZBRkodI+5lEpdbC1Uxz51DKJnCiEEHRdE/vpDsDOf
0oK6W91eX5/cWTCvbZUpcW8dY7XAFS7XK2Mi7Lis8hGxoLJOHc4=
=ZoGD
-----END PGP SIGNATURE-----

--lmgdxylq2cyzuy6g--
