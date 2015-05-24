From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 0/2] Add support for BQ25890 charger chip
Date: Sun, 24 May 2015 21:48:44 +0200
Message-ID: <20150524194843.GJ11066@earth>
References: <1432041880-7373-1-git-send-email-laurentiu.palcu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/0U0QBNx7JIUZLHm"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54827 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751301AbbEXTtH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 24 May 2015 15:49:07 -0400
Content-Disposition: inline
In-Reply-To: <1432041880-7373-1-git-send-email-laurentiu.palcu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laurentiu Palcu <laurentiu.palcu@intel.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


--/0U0QBNx7JIUZLHm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 19, 2015 at 04:24:38PM +0300, Laurentiu Palcu wrote:
> Changes since v1:
>  * add comment in DT bindings regarding default driver behavior when
>    "ti,thermal-regulation-threshold" property is missing;
>  * addressed all Krzysztof's comments, including addition of a reset
>    check counter. Better to be safe than sorry :)
>=20
> Hi,
>=20
> This series adds support for BQ25890 USB charger chip. Information about
> the chip can be found here:
>=20
> http://www.ti.com/product/bq25890

Thanks, queued.

-- Sebastian

--/0U0QBNx7JIUZLHm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVYisbAAoJENju1/PIO/qac68QAJY0lDgvwDJtROkN4Mx3kgsN
GTaGgi6j6MSzc/UhRIVnkkx7n262tSzgzLteRHkyRyfTWkXWTpd3Ly+zsLG/ZVfL
iI0b5egmDbPiEJPVET3gkSZiRJDbF4K7qprIxAOlI1uvezPWNHeGav3YJR68UULM
y275p8JJhX4mkNt12CKK10fY7Ak8IHY2kRjgPF5qInAEATDyIdYF7SagLbJOVyko
P6yYiS2Kc725jp0FaKmxrXSdolXvpgWsmr7vlLABG14cInNrBc2mXIuUWqkWbwzq
EGNqdJ98QHzqDjEK2TbfjQ/uUySpLV+a9NBMVbjOLCkXZcGEMZv2VzF/vbbRNDn0
mllj8NLYEIugDV5kg/wbwmXhWGMw6bnc4fj1NRka3+92pIIKcPuLyoTi36N1p368
kaMsBV3Sb0PekjXHeL4oR2XSefAUCtKmNUVpt+U12vk7Sg7QzfnFZY69ZcQRLHwJ
OJVjGr0dMy/cHe07Mz6oEIJo4gxMZXp2iUufTeY8iJzoPzJxKUAGQCmhlDguHbNe
Jyk05sv1G+ewOjWyzcgIFzSBSbjJZwjRnH1qfFKdBWGI1wAZI7KIBfK39ErAKDuS
sHOCCFzdNpS1zV7V3/RSLwmUSkff250kaHv2bA0a6S1HyZOF6erbGoFyItQ0HSAe
3a/rbBPTBtVAV/AyAsnd
=5nIs
-----END PGP SIGNATURE-----

--/0U0QBNx7JIUZLHm--
