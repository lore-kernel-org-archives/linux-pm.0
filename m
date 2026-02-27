Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1512743CEEF;
	Fri, 27 Feb 2026 17:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772213471; cv=none; b=U1qqtTIZ+AtJM9WzZKe4pX/TU9qHFNPjCiS6H/Mv2orufF6xfZW9eH6HcGoIZQC7nNV5I329MFastsW33P55I1ltjKW1DIzYtVL1lbcFkDCmaNVW0DaajwYeBB6SGwouB45v+OPLnuiPPHRY2u5jZBipsHe8+H58XfLZWvU0ATE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772213471; c=relaxed/simple;
	bh=+kQN8hx2nUovoqqKkfYdch+3i2snTC4fUUuhOffl+Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMzK2+jJCnWvsKVP3m7UPyvoGZXXyRIC1SzNRaWW2YfEYoqD7bEawFO+iHD9Ys/5t8J3mZ6WWEErO52h9m5EHWhSQo85dVcxisZnzQbH6KZR/ZVrpVSSKB0mHxifIEA0jbAb2NTFQPVobjv22HtJZ56pYVh2PhXkCpXDzJ0hHKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThvwsFHv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThvwsFHv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D885FC116C6;
	Fri, 27 Feb 2026 17:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772213470;
	bh=+kQN8hx2nUovoqqKkfYdch+3i2snTC4fUUuhOffl+Ng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ThvwsFHvfP5CcvaWwMjoXaBAxrEliA0Lfs650S8dgdLX1Xh5jhu5yO4Q1LULgCTUy
	 2rMCOkqdOUKEqVLsBdUmglCXziJ9kHMqELZRb1OJc7sa5jZcA0+80ODM60Hvk52tKu
	 ++GFqUcAN18czydcHQV/g7ufKCZ5rndk5d4kD++ioI68Ly5pgleaWCBqJcAGIXa1xU
	 Afa88JMRngWQ7h6+ltNo0I1lo4aDuousOa2QYvGRI5fvuM/K6dhZzyW9CtwBIX4r6/
	 OxTmNGfp4ZudbQ9Kj2G/yr1Xfgj6YuTpXeOmJjNz1wfjZ+gBmZPulkopvHljTvbhlk
	 6ZfgSB4zyaj6g==
Date: Fri, 27 Feb 2026 17:31:06 +0000
From: Conor Dooley <conor@kernel.org>
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, kernel@axis.com,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] dt-bindings: power: supply: Add TI BQ25630
 charger
Message-ID: <20260227-percolate-armful-ac15f947b2ff@spud>
References: <cover.1772201049.git.waqar.hameed@axis.com>
 <65f55d19b4bcf8f07300df5922ba1605bb669138.1772201049.git.waqar.hameed@axis.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qVBVKByzpOXcn9gg"
Content-Disposition: inline
In-Reply-To: <65f55d19b4bcf8f07300df5922ba1605bb669138.1772201049.git.waqar.hameed@axis.com>


--qVBVKByzpOXcn9gg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 04:35:33PM +0100, Waqar Hameed wrote:
> Add devicetree bindings for the TI BQ25630 battery charger. It's I2C
> controlled and sends interrupts.
>=20
> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
> ---
>  .../bindings/power/supply/bq25630.yaml        | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/bq2563=
0.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/bq25630.yaml =
b/Documentation/devicetree/bindings/power/supply/bq25630.yaml
> new file mode 100644
> index 0000000000000..57e4286dac7e9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/bq25630.yaml

Filename is missing "ti," to match the compatible.

> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/bq25630.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI BQ25630 battery charger
> +
> +maintainers:
> +  - Waqar Hameed <waqar.hameed@axis.com>
> +
> +description: |
> +  I2C controlled single cell Li-ion and Li-polymer 5A buck charger.
> +  Datasheet: https://www.ti.com/lit/gpn/bq25630
> +
> +allOf:
> +  - $ref: power-supply.yaml#
> +
> +properties:
> +  compatible:
> +    const: ti,bq25630
> +
> +  reg:
> +    const: 0x6b
> +    description:
> +      Device I2C address.
> +
> +  interrupts:
> +    maxItems: 1
> +    description: |
> +      Device sends active low 256 =B5s pulse. Type should therefore be
> +      IRQ_TYPE_EDGE_FALLING.
> +
> +  monitored-battery: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - monitored-battery
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    bat: battery {
> +        compatible =3D "simple-battery";
> +        voltage-min-design-microvolt =3D <1800000>;
> +        constant-charge-current-max-microamp =3D <1344000>;
> +        constant-charge-voltage-max-microvolt =3D <3700000>;
> +        charge-term-current-microamp =3D <128000>;
> +        precharge-current-microamp =3D <1000000>;
> +    };

This whole battery node can go, the tooling will falsify the phandle.

I wouldn't ack this anyway cos you're looking for RFC feedback, but the
binding looks pretty sane (although when it's simple enough it should!).
Marking it cr from a dt pov cos of the filename.
pw-bot: changes-requested

Cheers,
Conor.

> +
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        charger@6b {
> +            compatible =3D "ti,bq25630";
> +            reg =3D <0x6b>;
> +            interrupts =3D <13 IRQ_TYPE_EDGE_FALLING>;
> +            monitored-battery =3D <&bat>;
> +        };
> +    };
> +...
> --=20
> 2.39.5
>=20

--qVBVKByzpOXcn9gg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaaHU2gAKCRB4tDGHoIJi
0sSdAP96U45vLk+yncOzGl+zVZkQKMeK0L3cY7aeZWiSalffEgD/Qrmx3FrByUwK
RaxD2MkEyd5p8/5LwuIlOud6yHB7kg8=
=Fo/2
-----END PGP SIGNATURE-----

--qVBVKByzpOXcn9gg--
