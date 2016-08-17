From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v5 5/7] power: act8945a_charger: Add capacity level
 property
Date: Wed, 17 Aug 2016 13:47:53 +0200
Message-ID: <20160817114753.copygtkdmnohhybr@earth>
References: <1471337998-6467-1-git-send-email-wenyou.yang@atmel.com>
 <1471337998-6467-6-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wu4ezwotw2zqbfpc"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39680 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753082AbcHQLr6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 17 Aug 2016 07:47:58 -0400
Content-Disposition: inline
In-Reply-To: <1471337998-6467-6-git-send-email-wenyou.yang@atmel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wenyou Yang <wenyou.yang@atmel.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Brown <broonie@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-pm@vger.kernel.org


--wu4ezwotw2zqbfpc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 16, 2016 at 04:59:56PM +0800, Wenyou Yang wrote:
> Add the power supply capacity level property, it corresponds to
> POWER_SUPPLY_CAPACITY_LEVEL_*.
>=20
> It also utilizes the precision voltage detector function module
> to catch the low battery voltage.

Please use gpiod API instead of old gpio API.

-- Sebastian

--wu4ezwotw2zqbfpc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXtE7pAAoJENju1/PIO/qaBfAP/1GHyFHLLcL7B7Wdp9LVMm8u
9+nFBZTpM8wnupHGnxLJgn6VNPh9kqenorDh4siXMenetk9BwQnV0EeyeJ40bUqK
QH/gtGQlB+KGxLkEm1ZVlxYQCrfcJtj9TZ3lqzzevOmJ08grmmLj7qaBsfZcnPY0
Y9oxtGZssVOjT1QmCtKPK7T0SmhbDl9RmJcup4RH7lYTvyZm9WN0CARVY5ghWuL6
+BD7zDiGFLydZCW97Lskg2j1sFmX17jMmUqhct3DZg7zZvfT+ukEf7WVYn2/279H
wG78cn5/J4lhNR//puT4QQ0lbwjHrcuLrHaaEbcxgEtf0mwwe8NjnesiN4UJ8HVJ
hmOvN380RE060in1AqYA2ya8vPhCIdXSOAobvZFBTuk4soEfk3M56ZBaJGvfMrag
VCZtQnUhAW/W65T9DUr8p9NBOhWEaFQnISZXTACZsb+Sm2FV3XXKIeN2Zb5tS7ZZ
3MlfbqQW2bGkaugf3MeZO74fBeMUkYJP8Qrz9DbwUOJY8y8g/dQVXlXdGKlW6N7W
UXVIQG/fr9zeVic5pB3K5oYIt5J8yCNZtpPcGgLvjfPPVvMgQA+3xWDZRTfs6mEc
h2exOv/X8FSWkYyO2hiUr1T3y5BerCNsnNz0LgbTCmlur8DVExAm76EUBifE0smh
chy0Eq1PYYBWmYWWI0tU
=KesV
-----END PGP SIGNATURE-----

--wu4ezwotw2zqbfpc--
