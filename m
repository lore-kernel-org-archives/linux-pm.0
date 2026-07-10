Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554FD426410;
	Fri, 10 Jul 2026 16:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783700493; cv=none; b=l9eBSG9/7agWioJErbPfdZcZQkgE01vY7qDR5zLGWrkOoeDEu2SMyyHVKdrBC1GHIy36wdqLUNFESIj0nUMAZEVg4ZlAdBE+mwuotmvj/qLDQEomJXysVLs18imX5kTJB+SnTRWFIfoRk+mqD0zwakpTPq5wDFa0Lz3742Fmwys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783700493; c=relaxed/simple;
	bh=090bQxO8vlcwYjrZvOptfagoaSHKHG3fev16M5tnUtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZ7oPexsMhxx/NQnOqgN01hKXBBaX771RIZG/2U6wcoVUvgCXhXYdNbnWt/CF/XrZoUvQRbU3thHKUbVAHFGhtHoizieNPRfyN5hXuqHUUZ+uSSgZHvtL07j63MKCyfHCwoZyy7sAG7AAUjoeQe7h3xDYTeXSSg3qREarXsyo00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBEmVcr6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBEmVcr6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E17F1F000E9;
	Fri, 10 Jul 2026 16:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783700486;
	bh=CJDU3D9yg4K1vmjkdjLK8KGWRUqIASourvqWCH96tRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aBEmVcr64U4zmgO7KIxPxoyeEunXb4HqnJsHV9esELWfpM/SS9DZPwdUKGSR13iEA
	 GM67Ro+nmI6UBC5S9UsHeO8NTBI1XiBZgK7QGjBtRzhNSrcviRTOZNBJwUZ6/n8rcF
	 Cc6KgQqZsj5tOq4RCLOGJpTADCDQD0yB2Xg5i4AgNjeDleNFk97BmIPFSIBrwPX67F
	 9QCyCzDB1l2KVmfOeBkOjUpEHdrOyXhvn4aSjlxu7lUX61eUF0S838clVdKvYhQtUW
	 vFBJge/pPywsceIMkd0rLAiz5P93gQguCyU1rCpcJ8rM/p490JHPw8VbbTyE/UJGQL
	 Mwpj0dgppokCw==
Date: Fri, 10 Jul 2026 17:21:22 +0100
From: Conor Dooley <conor@kernel.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: thermal: loongson,ls2k-thermal: Add
 compatible for Loongson-2K0300
Message-ID: <20260710-game-late-9347baafa7ab@spud>
References: <cover.1783670011.git.zhoubinbin@loongson.cn>
 <7df0780e1b3d4c499a48cd862a12bda895e7818f.1783670011.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PRGKOus06or6gaTT"
Content-Disposition: inline
In-Reply-To: <7df0780e1b3d4c499a48cd862a12bda895e7818f.1783670011.git.zhoubinbin@loongson.cn>

--PRGKOus06or6gaTT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 04:24:59PM +0800, Binbin Zhou wrote:
> Add a new compatible string `loongson,ls2k0300-thermal` for the thermal
> sensor found on the Loongson-2K0300 SoC.
>=20
> The hardware differs from the existing SoCs in its register layout: it
> requires two register regions (one for the thermal sensor control and
> another for the CPU ID).
>=20
> Update the binding to describe this new requirement.
>=20
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  .../thermal/loongson,ls2k-thermal.yaml        | 68 ++++++++++++++-----
>  1 file changed, 50 insertions(+), 18 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/thermal/loongson,ls2k-ther=
mal.yaml b/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.=
yaml
> index 79e691b08341..b5cbfd201105 100644
> --- a/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
> @@ -10,13 +10,11 @@ maintainers:
>    - zhanghongchen <zhanghongchen@loongson.cn>
>    - Yinbo Zhu <zhuyinbo@loongson.cn>
> =20
> -allOf:
> -  - $ref: /schemas/thermal/thermal-sensor.yaml#
> -
>  properties:
>    compatible:
>      oneOf:
>        - enum:
> +          - loongson,ls2k0300-thermal
>            - loongson,ls2k1000-thermal
>            - loongson,ls2k2000-thermal
>        - items:
> @@ -39,23 +37,46 @@ required:
>    - reg
>    - interrupts
> =20
> -if:
> -  properties:
> -    compatible:
> -      contains:
> -        enum:
> -          - loongson,ls2k2000-thermal
> +allOf:
> +  - $ref: /schemas/thermal/thermal-sensor.yaml#
> =20
> -then:
> -  properties:
> -    reg:
> -      minItems: 2
> -      maxItems: 2
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - loongson,ls2k0300-thermal
> +    then:
> +      properties:
> +        reg:
> +          items:
> +            - description: Thermal base register region
> +            - description: CPU ID register region
> =20
> -else:
> -  properties:
> -    reg:
> -      maxItems: 1
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - loongson,ls2k1000-thermal
> +    then:
> +      properties:
> +        reg:
> +          items:
> +            - description: Thermal base register region
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - loongson,ls2k2000-thermal
> +    then:
> +      properties:
> +        reg:
> +          items:
> +            - description: Thermal base register region
> +            - description: Thermal data output register region
> =20
>  unevaluatedProperties: false
> =20
> @@ -69,3 +90,14 @@ examples:
>          interrupts =3D <7 IRQ_TYPE_LEVEL_LOW>;
>          #thermal-sensor-cells =3D <1>;
>      };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    thermal-sensor@16001500 {
> +       compatible =3D "loongson,ls2k0300-thermal";
> +       reg =3D <0x16001500 0x30>,
> +             <0x16003ff0 0x8>;

Quite frankly, the address and size of this look like the second
register region here is actually a few bytes in a syscon that is being
misrepresented.
What lies at the addresses immediately before and after 0x16003ff0?


Thanks,
Conor.

> +       interrupt-parent =3D <&liointc1>;
> +       interrupts =3D <20 IRQ_TYPE_LEVEL_HIGH>;
> +       #thermal-sensor-cells =3D <1>;
> +    };
> --=20
> 2.52.0
>=20

--PRGKOus06or6gaTT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCalEcAQAKCRB4tDGHoIJi
0mhNAP0ZA31Cl7Igl+boWiSEHApgBG27Ywh7URn4L+9jTyAXLQEA09T1ur9ba+9F
I+IZTamEPx6OiS+wb3FBxviBZBqzngA=
=0pH9
-----END PGP SIGNATURE-----

--PRGKOus06or6gaTT--
