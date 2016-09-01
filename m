From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v9 3/4] doc: bindings: mfd: act8945a: Update the example
Date: Thu, 1 Sep 2016 14:47:46 +0200
Message-ID: <20160901124746.vbhrz4f53vb63d7t@earth>
References: <1472722201-31872-1-git-send-email-wenyou.yang@atmel.com>
 <1472722201-31872-4-git-send-email-wenyou.yang@atmel.com>
 <20160901112251.GK4921@dell>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="udxo73iwlyu6mjuc"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932383AbcIAMrv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 1 Sep 2016 08:47:51 -0400
Content-Disposition: inline
In-Reply-To: <20160901112251.GK4921@dell>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Wenyou Yang <wenyou.yang@atmel.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-kernel@vger.kernel.org, Wenyou Yang <wenyou.yang@microchip.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org


--udxo73iwlyu6mjuc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lee,

On Thu, Sep 01, 2016 at 12:22:51PM +0100, Lee Jones wrote:
> On Thu, 01 Sep 2016, Wenyou Yang wrote:
>=20
> > Since the act8945a-charger is regarded as a sub-device and it using
> > "interrupts" property, update the examples section.
> >=20
> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> > ---
> >=20
> > Changes in v9: None
> > Changes in v8: None
> > Changes in v7: None
> > Changes in v6: None
> > Changes in v4: None
> >=20
> >  Documentation/devicetree/bindings/mfd/act8945a.txt | 22 ++++++++++++++=
+-------
> >  1 file changed, 15 insertions(+), 7 deletions(-)
>=20
> This is a functional change.  I'll require a DT Ack.

Wenyou Yang forgot to take over Rob's Acked-By from the previous
version: https://patchwork.kernel.org/patch/9298871/

-- Sebastian

--udxo73iwlyu6mjuc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXyCNyAAoJENju1/PIO/qarMIP/25o6GOaCV4sS7BJuNU7JYGg
D2FnQBZ+1HKxLGrnndRHTx9BD0kYHpsIlQFPCTk5VBjkdXgL+l89TCp0W3Qy1aIQ
xMedxS6vhgYB5+KRpT0EqsWdHmuUbMDDt7YdL09ntR0XUqjhe8VxVejufwNO42zA
mhPWLL0sTytG76PHdmiDbvy/cS7N98NefyXY4CH1IQ19BTo8Qw7qg7u5CuJZeRkT
UI66vFC6d4RuqO7AGHqSndg/z5PMG20Z16O03dHN4U49LSxVyjklg6yh5ZRQ0MMt
vNzVb7c6ajvXUwIulfLcsCFk43BSGVvsWL/MrUA7vAY0eR6l7+ilgpyLlh5cTg0u
YzQJNGWX5MIALhHIlCT/GEwTBnqW7x3UErYtpHqZL6g0I4oyDxdwXzZktXt20uBj
vw7+BfFhYwAO0yfur709vB/oHBvIrXzxqO+7dKLWB3rmKBC/86JNLk0y6GLgq/Bo
2T45rE3rJ/ME0xegMZbgfsah3fKa/ZuRXadFSPK2Pti0T1UeJC6PKeXa2YJlTSWN
i8CDNGR37dcfmo83WptmOKOuq2PPWZ8uh6thnF/U3nQWdR5+ueKJJtD5uUzH1zOw
tEkRjHZ1SYd5/lu8RBA5AHwyjgv3hNU9hOGFjsbROt9U0cmB9Balb4WgfJe3dqgR
me0Ts/v75lmxt1ZaQnsd
=t9F4
-----END PGP SIGNATURE-----

--udxo73iwlyu6mjuc--
