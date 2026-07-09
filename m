Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B4935B62C;
	Thu,  9 Jul 2026 17:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783619234; cv=none; b=PT27K4/t+ScZf7OFK80U3PWfzI51g0IL6YYJPDtbXv+WIR7S0yVLBrmpJMi/qLEWRX9LdNnOCL3ipyb1iibXgcefFKYwhGV/ZKCJj4ERkvdJ4TwhfiBI/Xhzq1RHN7QsAXmBnpUlzAQzL+we+Kk4a8NLkrYk46VVgr2/7h3bJvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783619234; c=relaxed/simple;
	bh=06/2miBpG4NkdvXK3SV9mtPtKjNnTumjr9HgfBwJo8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWiq7LIx02Cc8ssywYn+dPC5T+AgSjboxIR56OIoMAlMMZNE6ewXmxaKVQG03li4V8jq+sLlg352lmSq9DXvDd04rhPWcdQqvtyi1eYdbxK6QNazbNmUz9deQBoGvgDVxLzaHc4e7ruF/YadMoqS7LADm7lQugv4MegUfSznFcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8pqIKhb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8pqIKhb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0799C1F000E9;
	Thu,  9 Jul 2026 17:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783619233;
	bh=gCciP92ZI0EnoorGeU/orSgjZQNLlRaKdMjI/vAlnK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U8pqIKhbPDsdoeJpSjcgp87pmkIiG8SLSaM104p7/6Noev0pMwjI52LcII23HEWO1
	 p/CnZobolGGhszhYg0rYZbytwvseUaLPkQz6owhgSknDUNqPSPdgMHoIGgFH5bGQ6a
	 e2pXTexijUyOgmVBxenlQa9KnYrN4acDk2+pffZZ65o040KGZcRXrPWoD4O1koq6bn
	 pj1jfu1y/BZVny4Z/+eOSXKrHLq8jWjHZ6vzmfEZP0PjuYPzpso0W0g9NNz6UIKe7J
	 9ec4gwmG8oipma+65dC9mbfP66Tp9VohRD6gxX8fwFPysJuASgKIQgHH/Rn5Tvusy3
	 FsDMqyk6X17TQ==
Date: Thu, 9 Jul 2026 18:47:08 +0100
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Haoning.CHENG@cn.bosch.com, "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: thermal: imx: Document calibration
 offset property
Message-ID: <20260709-send-mashed-bac8c44ead01@spud>
References: <20260709-b4-symana21-11221-imx-thermal-support-upstream-6-18-v2-0-00ff72495e24@cn.bosch.com>
 <20260709-b4-symana21-11221-imx-thermal-support-upstream-6-18-v2-1-00ff72495e24@cn.bosch.com>
 <ak-5KdXFUldV2eTP@SMW015318>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="esoH4S///u0LPdL7"
Content-Disposition: inline
In-Reply-To: <ak-5KdXFUldV2eTP@SMW015318>

--esoH4S///u0LPdL7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 09, 2026 at 10:07:21AM -0500, Frank Li wrote:
> On Thu, Jul 09, 2026 at 04:10:21PM +0800, HaoNing Cheng via B4 Relay wrot=
e:
> > [You don't often get email from devnull+haoning.cheng.cn.bosch.com@kern=
el.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdent=
ification ]
> >
> > From: HaoNing Cheng <Haoning.CHENG@cn.bosch.com>
> >
> > Some boards need a small per-design correction to align the reported CPU
> > temperature with board-level measurements.
> >
> > Document the optional fsl,temp-calibration-offset-millicelsius property,
> > a signed offset in millicelsius that is added to the calculated sensor
> > temperature.
>=20
> why board difference cause such offset, I suppose it is cause by SoC
> variance. The offset may difference if you change to another chip. another
> words, if you have 1000 boards, Is this offset the same?

I think your "in other words" section here is confusing.
You're asking about "1000 boards", which would imply that it is 1000 of
the same design of board. The commit message says that the variance is
between designs. If 1000 of the same design of board have the same offset,
but 2 boards with different designs have different ones then this
property seems fair. Of course, if the variance is determined by the SoC
in use, then this should be deduced from the compatible, but the commit
message seems to be fairly clear about it not being SoC related.

>=20
>=20
> > The property is optional and the existing behaviour is kept
> > when it is omitted.
> >
> > Update the binding example to show its usage.
> >
> > Signed-off-by: HaoNing Cheng <Haoning.CHENG@cn.bosch.com>
> > ---
> >  Documentation/devicetree/bindings/thermal/imx-thermal.yaml | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/thermal/imx-thermal.yaml=
 b/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
> > index 949b154856c5..eb7243a7ebaf 100644
> > --- a/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
> > +++ b/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
> > @@ -59,6 +59,13 @@ properties:
> >    clocks:
> >      maxItems: 1
> >
> > +  fsl,temp-calibration-offset-millicelsius:
> > +    maxItems: 1
>=20
> suppose it int32, why need maxItems here?

  "-millicelsius$":
    $ref: types.yaml#/definitions/int32-array

What's missing are constraints on the max and min I think though.
pw-bot: changes-requested

Thanks,
Conor.

>=20
> Frank
>=20
> > +    description:
> > +      A signed calibration offset, in millicelsius, added to the calcu=
lated
> > +      sensor temperature to compensate for board-level measurement
> > +      differences. When absent, no offset is applied.
> > +
> >    "#thermal-sensor-cells":
> >      const: 0
> >
> > @@ -109,6 +116,7 @@ examples:
> >              nvmem-cells =3D <&tempmon_calib>, <&tempmon_temp_grade>;
> >              nvmem-cell-names =3D "calib", "temp_grade";
> >              clocks =3D <&clks IMX6SX_CLK_PLL3_USB_OTG>;
> > +            fsl,temp-calibration-offset-millicelsius =3D <(-6400)>;
> >              #thermal-sensor-cells =3D <0>;
> >          };
> >      };
> >
> > --
> > 2.43.0
> >
> >
> >

--esoH4S///u0LPdL7
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCak/emwAKCRB4tDGHoIJi
0pBqAP9YPAYWXklSPugB1dtOWcQhoSeQTrfQ4C/39Titj+z0xgD+JthpB204U0Pz
+KA/7Y06/va7cFZAdZiJl66l+G+89Qs=
=0JsK
-----END PGP SIGNATURE-----

--esoH4S///u0LPdL7--
