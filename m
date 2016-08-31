From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v8 10/11] doc: bindings: power: act8945a-charger: Update
 properties.
Date: Wed, 31 Aug 2016 16:48:18 +0200
Message-ID: <20160831144818.b3i4fplqsfom7uql@earth>
References: <1472109599-21915-1-git-send-email-wenyou.yang@atmel.com>
 <1472110826-22328-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gk56p4kmqtzymzuq"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935131AbcHaOsX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 31 Aug 2016 10:48:23 -0400
Content-Disposition: inline
In-Reply-To: <1472110826-22328-1-git-send-email-wenyou.yang@atmel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wenyou Yang <wenyou.yang@atmel.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Brown <broonie@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org


--gk56p4kmqtzymzuq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 25, 2016 at 03:40:26PM +0800, Wenyou Yang wrote:
> Due the driver improvements, update the properties,
>  - Remove "active-semi,check-battery-temperature" property.
>  - Add the properties, "active-semi,irq_gpio"
>    and "active-semi,lbo-gpios".
>  - As act8945a-charger is regarded as a sub-device, update
>    the compatible and examples.
>=20
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> Acked-by: Rob Herring <robh@kernel.org>

Thanks, queued.

-- Sebastian

--gk56p4kmqtzymzuq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXxu4yAAoJENju1/PIO/qanxAQAKg69po6yvpFyrK1skP2brrN
oe0yYUOyje0g5CZo8RsnlmQBcteEBY56PBayGMQ31yV1mn3i0dAr/a+z557+Lp8Z
RaylErt3t56QGOV4zO5vJEJodEGMDjO9RdJyS3r0fA2IGQb14oAclb5DdTja9PuS
152auP8i9OnUeT3/PPPIHAUEe4LMHTjhuVtYT1Ra3rD+Movm26j6+t3LCAvXyNj8
W4pcL0L2Q+PDCyB4F1Q9KipuqW/t0tgVRbY4uiR7Udl0f5hnrTZG/lFx36/DmFab
R9LuR8I0Oy7zwwKm0LpyMaIQ8bHQwRV92c1cpjvBo7TZJZ+TPSPDG9cZ1bvkmEjp
uLzAj85NzAx3tlLIFUk2ldwb+8hhz9LfjRsHMsbfFjDnE7+xPQpT+L62mGFa/BwH
aMItVBM0Fn+hBiQ7uXs6RsxEzC0hQPDqlsl1JEC9n2ECeD826YfZiSPiOCD6t+EX
Cy5uGkMhwUvUpkD7O/aYKbJYOSJc7SO0IBI0kTsQEUiBJxhtQniWpUFdGmvJW+f9
IfjFcJMcbTkHThmUwfRCWgxWA+LIwib23KSnon2piP8hN3gvua62rNQ7HtiiVIz9
RFEWUQBlwsXrjWD0OfhJBCw+emvBC5FQkEOfDpppSNPcUHGy/WtjJVmW41rQDIXL
9ts+4SY1QPpCKjB9Id8A
=yCxp
-----END PGP SIGNATURE-----

--gk56p4kmqtzymzuq--
