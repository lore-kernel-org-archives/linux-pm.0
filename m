From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v5 6/7] power: act8945a_charger: Add max current property
Date: Wed, 17 Aug 2016 13:51:37 +0200
Message-ID: <20160817115137.sldoet7dfxeusoxm@earth>
References: <1471337998-6467-1-git-send-email-wenyou.yang@atmel.com>
 <1471337998-6467-7-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pvyxxmfpsqa35p34"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1471337998-6467-7-git-send-email-wenyou.yang@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wenyou Yang <wenyou.yang@atmel.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Brown <broonie@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--pvyxxmfpsqa35p34
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Aug 16, 2016 at 04:59:57PM +0800, Wenyou Yang wrote:
> Add the power supply's current max property,
> POWER_SUPPLY_PROP_CURRENT_MAX.

Please also switch chgin_level to gpiod API.

-- Sebastian

--pvyxxmfpsqa35p34
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXtE/JAAoJENju1/PIO/qaLwgP/RLAzaLDgmQ2Q0Rzkr/aEpOg
7BCKO3T8I2uniVAhnAiX8UiO6TUgV6nglRJqkj3cCOW28UNd01gvlvKrxDBp/zRF
4aR/CMhjceJExgjekEXXtP5Ae2nX5O4PVZL57c1mZQVMUb2KK1/9Nm98USZQZfA5
YSBKXi7thfJ/wpFNT5b+3IphBkJrtnBOboquhDkPv+/TXYIYyGDQLl+fFcO196qa
nouJfqVbWF2uztaPgjSMmUQBfezKbOQIEn0fPIyvnkM9QnTAE1lGK3PorGakxejE
1tCquIp4GequcBizI/vZlwpTNSikg1bGQDNjNrd3+ux2raVydGRP5xM8hu5tmyzG
OUrU1/iR8SECdk8UhkHS8i+5KTaxEzWkiIyCzicP/1Gw1KwXnn8n1olcQECLJcLS
04Dt9XXAv5X6ue5uckCRDVzDbgONHPXN9BI4ugZtu/8s4aLLmQlzZ34IMO+BoM7Q
9iYUxL/7tQUZa5/0OIIgSPRjj/h/VjxuhtuSXBH14rr7pv1VonsZ8/8ZEhAMdicG
U5WF0oeEW6rvTz7r5PjJh+8pJjBRkkdMaG40m61ROid8u4w8PQagx9e4lrOpNZAh
yJRIy2mF6Xg9785KD4wOI6NnNoXB9JyQP2unUfaQ2yDZKUwzaF3KLXAmCps7wBme
QarjXF3g+cz2FoEWowKp
=LMRf
-----END PGP SIGNATURE-----

--pvyxxmfpsqa35p34--
