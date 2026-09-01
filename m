Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D0C30568B;
	Tue,  1 Sep 2026 18:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788285788; cv=none; b=MjNVNHxMvIsmj2l7rU+ssnsrcMwZnop0Yo7r7tqi33FPm8aBeDS2OAfNZXqyQZf5wtq7735Ti1KYzU3nhmv0teYHH4xREnRsl8p0EcB331oJoAV2LC6F1lWkUvEdL2Vvz8xIHXv6a1bj1QvwIOcA+8JDTickHgcuxcteu4xKWwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788285788; c=relaxed/simple;
	bh=qs2SX8F5Og2czgNdzK+mMq6jg51pQlKUmsN26fJDni0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRN+NihyO65lsnulpJkK+zhTBeGt89Dg6ZHYYv7+cMNcRD0w/2Uj7/cquQii49HS3uHPmjEGLOj8ZijNQWQ/F1Cj1+oemypXKOBFkv2RJ05R34mgZasIrTltH1iIRXWTjOMN8x0a3o8NQu3v6V7SAS0iwvwSUTAAqIbNwGysxLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlN9LDRK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlN9LDRK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A999C1F000E9;
	Tue,  1 Sep 2026 18:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788285786;
	bh=LN2ENGkJIguIkuNp78+34IIF1/xG02KYlfbiil+BNbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dlN9LDRKxHK+QstIKyaHTt5/8CZWx7xU27dJvI8fnkvIsinVAryqeIoK/eFVMTiGe
	 9mipeViuXLpZXfE7eiC07AGyKDNWv0SOIHmLxdOQt29sNV3OtmxQSYBOJdIarvToKi
	 WYgwkvJCnaLgJvfoxRYIOw4HkzvI/CIu9peZQue7EdNzw691jEoNmxv0Camjc/9cnu
	 lUbcvutqTRFWO3iNLXayzy7eXol7cnsHOoRUJZ/dxZV0kOeO1iQtL1HmrC7IT04TWs
	 17CGqS5d62E9pnjqQOj/humAvhcg13vfMeyCSjAqtuUXcKtwKFbiVBRJYmsgHtEXQJ
	 9ptaGxt/P0xxw==
Date: Tue, 1 Sep 2026 19:03:02 +0100
From: Conor Dooley <conor@kernel.org>
To: Marek Vasut <marex@nabladev.com>
Cc: linux-pm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Flaviu Nistor <flaviu.nistor@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: hwmon: tmp102: Fix up TMP103 bindings
Message-ID: <20260901-stammer-outward-dde753ce2c32@spud>
References: <20260901174847.97261-1-marex@nabladev.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wmu9DbT3vuFr7WDB"
Content-Disposition: inline
In-Reply-To: <20260901174847.97261-1-marex@nabladev.com>

--wmu9DbT3vuFr7WDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 01, 2026 at 07:47:54PM +0200, Marek Vasut wrote:
> The TMP102 and TMP110 are backward compatible, therefore the valid
> compatible strings are "ti,tmp110", "ti,tmp102" and "ti,tmp102" .
>=20
> The TMP103 is not backward compatible with TMP102, but it does share a
> schema now, therefore the only valid compatible string for the TMP103
> should be "ti,tmp103" .
>=20
> Make exactly those three compatible strings valid and everything else
> rejected.
>=20
> Fixes: d67ec24d3f07 ("dt-bindings: hwmon: tmp102: move ti,tmp103 out of t=
rivial-devices.yaml")
> Signed-off-by: Marek Vasut <marex@nabladev.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
(I am just realising now that the reason for this was the binding
in-tree having been cocked up)

> ---
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Flaviu Nistor <flaviu.nistor@gmail.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-hwmon@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
> V3: New patch
> ---
>  Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml b/Doc=
umentation/devicetree/bindings/hwmon/ti,tmp102.yaml
> index 55d9f106465d7..477f478b9dd0f 100644
> --- a/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
> @@ -13,11 +13,10 @@ properties:
>    compatible:
>      oneOf:
>        - items:
> -          - const: ti,tmp102
> -          - const: ti,tmp103
>            - const: ti,tmp110
> -      - enum:
> -          - ti,tmp102
> +          - const: ti,tmp102
> +      - const: ti,tmp102
> +      - const: ti,tmp103
> =20
>    interrupts:
>      maxItems: 1
> --=20
> 2.53.0
>=20

--wmu9DbT3vuFr7WDB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCapcTVgAKCRB4tDGHoIJi
0pqoAQD/EQ4f7IN4g+fkj/cjLpGRvDzBQUO5piAhC9MQrx59aAD/Y068xCi6f6xX
j5oma8wMOcMWJwbOQu/3eG2FGRkr1Q0=
=IAIA
-----END PGP SIGNATURE-----

--wmu9DbT3vuFr7WDB--
