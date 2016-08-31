From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v8 02/11] power: act8945a_charger: Achieve properties
 from its node
Date: Wed, 31 Aug 2016 16:44:46 +0200
Message-ID: <20160831144446.2quz6f3rcphqk3go@earth>
References: <1472109599-21915-1-git-send-email-wenyou.yang@atmel.com>
 <1472109599-21915-3-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cur4wgixbw74xfh5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1472109599-21915-3-git-send-email-wenyou.yang@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wenyou Yang <wenyou.yang@atmel.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Brown <broonie@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--cur4wgixbw74xfh5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, Aug 25, 2016 at 03:19:50PM +0800, Wenyou Yang wrote:
> Since the act8945a_charger is regarded as a sub-device, all properties will
> be assigned to its own device node. All properties can be achieved from its
> own node, instead of from its parent device.

Thanks, queued.

-- Sebastian

--cur4wgixbw74xfh5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXxu1cAAoJENju1/PIO/qa8KcQAIoVV/raWu/OquExcbppbKjN
YUx3eQGm57FjTyY1Hc3+f1iG3Csg3jFnn4agX2AE+oWVncyYLePRiTnm4s1vQUyF
1Y2jekSAa6miSTUBhDIvTASne3JcMPQz25MXf494hNW5a5BD+M9TBHkOPFn0XeWB
obnQYdNq0gWMAKtL4qaJKJJa3WjX/StIm436uzrGdiKR1Aig2mK4OfHuyTTlYIlP
xkbZLqmUx/YGNOddc9g/HqaReBsV7WKvOx7Oa6YE9amYZEPeq4u1+DBmVVTPFi5e
wOj6pZKOXgDq/CSoKLaK0kcc/hguCGQaxkR0VeAeWY+x+vkOFQw0acdga13QtWPG
xkgf5F/kS2szW0Gl8fpwTQx6N2f2MnKFnoFciFWHhFizRV5N+q3JVHof/DXAKAip
L8lBExRCSVNIvddCL4In3zwsaQ+BV4O7Bdfwz2B7uzHyA4wQBqce+0QBTimgswMZ
m97zs8JK56fsHFlWD2aXt70m2xIgQzTgde1KCJz7Uy6GvCzlatXhGzLSgeIPDC/y
zR+a5ZsjerKFEaBpjW8ob0uqiF0J3fEqkqXAh9+ccXGwFV91KcXEqpEfEBS/K1nA
hAyL7G2d5cWR5moK3rsmVfU9/N6RRA8zheKUtJ7pgToc2ZqNj2uFHrLhDQc6vP14
HJENs08b7N96r5zMwVSU
=N4fL
-----END PGP SIGNATURE-----

--cur4wgixbw74xfh5--
