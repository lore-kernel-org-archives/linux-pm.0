From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v7 7/7] doc: bindings: act8945a-charger: Update properties
Date: Tue, 23 Aug 2016 05:03:29 +0200
Message-ID: <20160823030329.zy6kgncj2ov5ypnj@earth>
References: <1471848557-27278-1-git-send-email-wenyou.yang@atmel.com>
 <1471848557-27278-8-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6puhxbdy3pwi2vfy"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754489AbcHWDDf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Aug 2016 23:03:35 -0400
Content-Disposition: inline
In-Reply-To: <1471848557-27278-8-git-send-email-wenyou.yang@atmel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wenyou Yang <wenyou.yang@atmel.com>, Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>, Mark Brown <broonie@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-pm@vger.kernel.org


--6puhxbdy3pwi2vfy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 22, 2016 at 02:49:17PM +0800, Wenyou Yang wrote:
> Due the driver improvements, update the properties,
>  - Remove "active-semi,check-battery-temperature" property.
>  - Add the properties, "active-semi,irq_gpio"
>    and "active-semi,lbo-gpios".
>=20
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> Acked-by: Rob Herring <robh@kernel.org>

I wonder if it's too late to slightly break the DT API by
introducing a proper sub-device for the charger and having all those
charger specific details described there. Not being able to use the
devm_ functions because all properties are assigned to the parent
device is not very nice.

We could easily support reading timeouts and threshold information
=66rom the both (parent and sub-device) and just mark the parent
binding deprecated. The only real API break would be
"active-semi,chglev-gpios", which is currently broken anyways in the
driver as far as I can see (I should have reviewed this more
carefully previously).

In other words I suggest the following:

pmic@5b {
    compatible =3D "active-semi,act8945a";
    reg =3D <0x5b>;
    status =3D "okay";

    /* the following 3 are deprecated, but still supported */
    //active-semi,input-voltage-threshold-microvolt =3D <6600>;
    //active-semi,precondition-timeout =3D <40>;
    //active-semi,total-timeout =3D <3>;

    /* no longer supported, never worked properly */
    //active-semi,chglev-gpios =3D <&pioA 12 GPIO_ACTIVE_HIGH>;

    /* this is new, mfd should register charger sub-dev independently
     * of the subnode for backwards compatibility. Then optional
     * gpios/irqs are not available. But those either never worked
     * or did not exist before this update. */
    charger {
        active-semi,chglev-gpios =3D <&pioA 12 GPIO_ACTIVE_HIGH>;
        active-semi,lbo-gpios =3D <&pioA 72 GPIO_ACTIVE_LOW>;
		interrupt-parent =3D <&pioA>;
        interrupts =3D <45 GPIO_ACTIVE_LOW>

        active-semi,input-voltage-threshold-microvolt =3D <6600>;
        active-semi,precondition-timeout =3D <40>;
        active-semi,total-timeout =3D <3>;
    };
};

-- Sebastian

--6puhxbdy3pwi2vfy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXu7z4AAoJENju1/PIO/qaR1EP/js4kyC4ufhvqpScZkw6KcWU
nwwqMYwm2Y28/9aMg4ELkV6txQZ48YiwHS2E9PSrdgDjsju5/Gr1aj9r6yXwBd25
wbA4rKAYZmj23PGQFOttdeq6N+pJtxN00ZULcduT0UQZJ2RaxpYF+fQ0/l3eW+dq
j1E4y8GiX4DtAduJFsGT4fCyBGt0JSxN/rw9W0wmTa6HSHhUWTUG694H6/4v1KC/
Jpu2UHffOJM4e8RIw/1fBLJqJyddvDKBGCBig7SOq/NuHA05AKyIUvOD7usK31zq
fccXxBbT8DIcUjtF28+IvrFCdvG4Eq7NlIrmqZFXvf2P8pUzC7rB/Wtk+oL1WSZq
HisG4HB6g13P3pBIbZwlnupOS0Wg+F1BqU8ppQQb/ocA0pZZi6FLHpDN5QKm64ql
Gml3mgN+mUWJi7YjrfSX+QofUko7zzi5dT+jvyYByaIpJDIkE6O8btZjQpVjLf8i
X1YbHa9zD2upIHXWfQjYeRIbVq9jzTyVEwo75yX2CBKcOfvltIwazfolSpLL9lWI
Ye7OBuRJM8xduY/nkD5hThirG40WpywD80yxtkpo7np1782jF1z6VDgniqwHA0MJ
UpUVd+dDySWt1osoI4eELGfCZxzAHvPQozOxoPlvzdI1o63sZxZLJOc79yFNVorS
heHpOFwJb7bCWkYqrfut
=t8yW
-----END PGP SIGNATURE-----

--6puhxbdy3pwi2vfy--
