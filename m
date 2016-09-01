From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v9 1/4] power: act8945a_charger: Add capacity level
 property
Date: Thu, 1 Sep 2016 14:43:58 +0200
Message-ID: <20160901124358.64hsgqcpexnd7hmu@earth>
References: <1472722201-31872-1-git-send-email-wenyou.yang@atmel.com>
 <1472722201-31872-2-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2aq7uk26rfyfq4ul"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1472722201-31872-2-git-send-email-wenyou.yang@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wenyou Yang <wenyou.yang@atmel.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-kernel@vger.kernel.org, Wenyou Yang <wenyou.yang@microchip.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--2aq7uk26rfyfq4ul
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 01, 2016 at 05:29:58PM +0800, Wenyou Yang wrote:
> Add the power supply capacity level property, it corresponds to
> POWER_SUPPLY_CAPACITY_LEVEL_*.
>=20
> It also utilizes the precision voltage detector function module
> to catch the low battery voltage.

Thanks, queued.

-- Sebastian

--2aq7uk26rfyfq4ul
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXyCKNAAoJENju1/PIO/qalFMP/1WDU4NfQAJ5GdlLLX2Zdy6U
rXM6ArePp820CExYUJ5mpLSVT5bRfWjlu5IRjPzwEVHvMMGZgeLpC+aWMjp7jLuh
F/UrAR4xkq3FECp74ALEZP4nx2+YqwPnBKIVjlD4lTLsuIl/kIePkXktf1TY2Q9m
O0q6tqcDFzNsprNBLbojrY1ktQQ4+ytOxskYLAMoyfzQkZh+nLHyVspWq498ScOy
qXN5RsdQtzo1ByjQxIg8Oynx2oF5jxFu2xa+CHYyFQsOM2j5RSzo5HvX2OU0zil+
ADVlquAGnT5xCI4hfBG/IEeQJs6XmR9O30S3QeHjCqMiLZX9Pbu4V52zVeaninIG
IZ6qBAvWwvEaza8Ew+WQ4d86Z4B6b1V6fVKeawkSQVR7iKdR0v021sHC1kupmO5D
QgLvKMKrrzAcXtM1J/kNpKYwkY5idQxcJGlU+0NkHVFdJnsMs3+52V/eQKUE3iJi
GrESktBgKXO3nYK+WOI+qVyJbpkpdvqng/6q+nyBHFvOjqB8IPb4HSkfcfPYFWPl
M11Wpa0C9sIIZJKT9b1Ae6x8dDTby/fXdPj5FXLkwapfKAGR4HvtI30OKVweyvPn
HVtJ57b/yhWnkyJD31kOWNPaaA/yTGeZvVOq7sTevw95DEt8xESfGTCSMt6AHENn
yR5z1SS4elqnIZLAkheh
=Wp89
-----END PGP SIGNATURE-----

--2aq7uk26rfyfq4ul--
