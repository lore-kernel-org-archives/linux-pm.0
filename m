Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537BF239085;
	Fri, 10 Jul 2026 16:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783700650; cv=none; b=XyX/zqoJtICgksdzyTZzWILiM+UNiV3sIHJoraiPIBkvIan2gIViFGzLdh3xyyEzYh5zmxkvsa4B/cOcG9UUt0iLvqZVaoNAx5lrMEUPCIMXTenTkrqrOTykiyR0KiNDGee+TLBFI5cvUmwhDfHfHYn/00IpXIK0SU3pUtFYei4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783700650; c=relaxed/simple;
	bh=wHx5IkOOT/UCpDD1/Pw+NmI+yv1DpE2YrFaeTLeJmsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpCpb7PZwtjj6NeAqd63VBRLLO3cOzzc1RolcHBNMm+NRoM1Mi6bJr9rxX5SfuZLA7sgihp2rmqzsIFrUQwYIQxNKdV0vVS1cA2Z5jwnIRZ11nBg7qb8FyfwlQNS55DyLProohWUWbFLpz9f7zgvfhfNksdjWZSxFp0/s1vqUlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFT7KLPO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFT7KLPO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E341F000E9;
	Fri, 10 Jul 2026 16:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783700649;
	bh=tStCh3igwWHuhpSCZZKDRXL0bnzsj3nIFU8ybNYbcss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZFT7KLPOc57vQZ6sv/BIcfsPSW3i5crYRRZFvAF6sRpPkR/jGlKKsOJgvdmHBNsDx
	 gvBA4XQSjZYOh3Ur82DvY0IgmQqi6OEepo4jdDPST0W9a+4Oe0QlL6Soxhvq/bm2r3
	 W7mBwtzMe10jYOiYqYTzCX49JPjNehgm3bOeHSuf8iPZVMsdctAG8wFoOV7z9fo60L
	 2pbRj3kPmfkGbBCjSyLLCl9bLrxHQLm1ulCxAN2k7d4Vlic2iDQ9MIG9z8PtXRVdkA
	 9DjTWOMaE+YCL5vSc3rJoOGBkHMiBBlv3cTVGhUt+5zY4DR3v0qAOY/3B2o7LgPoI8
	 EbLN4NrZbUt0Q==
Date: Fri, 10 Jul 2026 17:24:04 +0100
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
Message-ID: <20260710-causal-goldsmith-ee44aa5e26fd@spud>
References: <cover.1783670011.git.zhoubinbin@loongson.cn>
 <7df0780e1b3d4c499a48cd862a12bda895e7818f.1783670011.git.zhoubinbin@loongson.cn>
 <20260710-game-late-9347baafa7ab@spud>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1/5Ful0f6szmRtIu"
Content-Disposition: inline
In-Reply-To: <20260710-game-late-9347baafa7ab@spud>

--1/5Ful0f6szmRtIu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 05:21:22PM +0100, Conor Dooley wrote:
> On Fri, Jul 10, 2026 at 04:24:59PM +0800, Binbin Zhou wrote:
> > Add a new compatible string `loongson,ls2k0300-thermal` for the thermal
> > sensor found on the Loongson-2K0300 SoC.
> >=20
> > The hardware differs from the existing SoCs in its register layout: it
> > requires two register regions (one for the thermal sensor control and
> > another for the CPU ID).
> >=20
> > Update the binding to describe this new requirement.
> >=20
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > ---
> >  .../thermal/loongson,ls2k-thermal.yaml        | 68 ++++++++++++++-----
> >  1 file changed, 50 insertions(+), 18 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/thermal/loongson,ls2k-th=
ermal.yaml b/Documentation/devicetree/bindings/thermal/loongson,ls2k-therma=
l.yaml
> > index 79e691b08341..b5cbfd201105 100644
> > --- a/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.y=
aml
> > +++ b/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.y=
aml
> > @@ -10,13 +10,11 @@ maintainers:
> >    - zhanghongchen <zhanghongchen@loongson.cn>
> >    - Yinbo Zhu <zhuyinbo@loongson.cn>
> > =20
> > -allOf:
> > -  - $ref: /schemas/thermal/thermal-sensor.yaml#
> > -
> >  properties:
> >    compatible:
> >      oneOf:
> >        - enum:
> > +          - loongson,ls2k0300-thermal
> >            - loongson,ls2k1000-thermal
> >            - loongson,ls2k2000-thermal
> >        - items:
> > @@ -39,23 +37,46 @@ required:
> >    - reg
> >    - interrupts
> > =20
> > -if:
> > -  properties:
> > -    compatible:
> > -      contains:
> > -        enum:
> > -          - loongson,ls2k2000-thermal
> > +allOf:
> > +  - $ref: /schemas/thermal/thermal-sensor.yaml#
> > =20
> > -then:
> > -  properties:
> > -    reg:
> > -      minItems: 2
> > -      maxItems: 2
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - loongson,ls2k0300-thermal
> > +    then:
> > +      properties:
> > +        reg:
> > +          items:
> > +            - description: Thermal base register region
> > +            - description: CPU ID register region
> > =20
> > -else:
> > -  properties:
> > -    reg:
> > -      maxItems: 1
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - loongson,ls2k1000-thermal
> > +    then:
> > +      properties:
> > +        reg:
> > +          items:
> > +            - description: Thermal base register region
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - loongson,ls2k2000-thermal
> > +    then:
> > +      properties:
> > +        reg:
> > +          items:
> > +            - description: Thermal base register region
> > +            - description: Thermal data output register region
> > =20
> >  unevaluatedProperties: false
> > =20
> > @@ -69,3 +90,14 @@ examples:
> >          interrupts =3D <7 IRQ_TYPE_LEVEL_LOW>;
> >          #thermal-sensor-cells =3D <1>;
> >      };
> > +
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    thermal-sensor@16001500 {
> > +       compatible =3D "loongson,ls2k0300-thermal";
> > +       reg =3D <0x16001500 0x30>,
> > +             <0x16003ff0 0x8>;
>=20
> Quite frankly, the address and size of this look like the second
> register region here is actually a few bytes in a syscon that is being
> misrepresented.
> What lies at the addresses immediately before and after 0x16003ff0?

Hmm, I just realised that the new device is the 0300, making this second
reg property the "cpuid" region. That makes this doubly suspect looking.

>=20
>=20
> Thanks,
> Conor.
>=20
> > +       interrupt-parent =3D <&liointc1>;
> > +       interrupts =3D <20 IRQ_TYPE_LEVEL_HIGH>;
> > +       #thermal-sensor-cells =3D <1>;
> > +    };
> > --=20
> > 2.52.0
> >=20



--1/5Ful0f6szmRtIu
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCalEcpAAKCRB4tDGHoIJi
0oq6AP0YI747YOHbi6EOChJIa6/pAuIWGNhXdi/kv+AlL34hTgEAvzNzjQsqFjqJ
+YUo6ClhafbDB2Sj/MNVDFgHuT9iXQM=
=8LPt
-----END PGP SIGNATURE-----

--1/5Ful0f6szmRtIu--
