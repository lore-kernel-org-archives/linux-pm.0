Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EC44DB56C;
	Tue, 14 Jul 2026 16:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784048063; cv=none; b=q2U9qnJp0IvjgeYJBDLFSmxKqgThdU2gXAOIpiVNKR428Atp11kvNDFeXVwdIgixhFfTqFFric1Tx4DMqT84BLzhxMlAE3a4WMf12yXb/EsG5oyIkXTiO/s+YmgK6J8OT/jIv3hQDyXn9Ty0eGDULwjYN++WuF0RRqq/VpR+e0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784048063; c=relaxed/simple;
	bh=Sm1SxbPpqj/ww3QZH1OjL/J5OFtjvvxD40VS6UtKY4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ampeU1l/73GTLLZd7HDbRKRG9aqfSnEJcF2Dv+WkavlEwJ9MjBE1syaacpcUOPX3Bx4eCwmEAC8vwERwkKCFAjNYdfVjjpYlfTnYbqXGE5ETwIfgp+v0OsH3FmAXO0fF2Kec6+tIOFRaKGy8xms4+uVO3G2YUueFoM7S1ewZZVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOP03A3Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOP03A3Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46EFC1F00A3A;
	Tue, 14 Jul 2026 16:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784048062;
	bh=Q+tLcyOwHtF2vvwf2acxQjCBICX2eNchtDxbM2AnFOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QOP03A3QAhh4nkGMFgFpCegL6XCrStv7YQS8bIi7KUlu3F27XjlSE2EGt0jOsK3HX
	 0d/CFKzHpL0J4xggxpeZtVFTWPAaA+50KeuLt30r+jJYkZmTiicJhvdlW92q6LhNcJ
	 Dxvg/J99U95HozGHJGubsNdW8sVqUL69Zkc51n1URbMKZl7TBlHLONv7e1D3XUz7be
	 9nXGa0vy9oo24HThn/6X54YVQA7VN4+aW9MlA6t7Ktt1y9hkI8kLHdnjwMyT31E5db
	 V+dGaRWihiYlQ7kDBrCSnJxoZE9S459WaozPER9pNwoXHIlL4F8pyAy2nGNKG4vVLT
	 m1ATK56XdRCXg==
Date: Tue, 14 Jul 2026 17:54:17 +0100
From: Conor Dooley <conor@kernel.org>
To: Binbin Zhou <zhoubb.aaron@gmail.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>,
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
Message-ID: <20260714-irritate-varying-9055895097b0@spud>
References: <cover.1783670011.git.zhoubinbin@loongson.cn>
 <7df0780e1b3d4c499a48cd862a12bda895e7818f.1783670011.git.zhoubinbin@loongson.cn>
 <20260710-game-late-9347baafa7ab@spud>
 <CAMpQs4+zXcNnZQnxWM7WUAM-heBYrTejm_dy3yVA4EFUrjA4CQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mxs6UIz3nJYmRMyR"
Content-Disposition: inline
In-Reply-To: <CAMpQs4+zXcNnZQnxWM7WUAM-heBYrTejm_dy3yVA4EFUrjA4CQ@mail.gmail.com>

--mxs6UIz3nJYmRMyR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 02:53:40PM +0800, Binbin Zhou wrote:
> Hi Conor:
>=20
> Thanks for your reply.
>=20
> On Sat, Jul 11, 2026 at 12:21=E2=80=AFAM Conor Dooley <conor@kernel.org> =
wrote:
> >
> > On Fri, Jul 10, 2026 at 04:24:59PM +0800, Binbin Zhou wrote:
> > > Add a new compatible string `loongson,ls2k0300-thermal` for the therm=
al
> > > sensor found on the Loongson-2K0300 SoC.
> > >
> > > The hardware differs from the existing SoCs in its register layout: it
> > > requires two register regions (one for the thermal sensor control and
> > > another for the CPU ID).
> > >
> > > Update the binding to describe this new requirement.
> > >
> > > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > > ---
> > >  .../thermal/loongson,ls2k-thermal.yaml        | 68 ++++++++++++++---=
--
> > >  1 file changed, 50 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/thermal/loongson,ls2k-=
thermal.yaml b/Documentation/devicetree/bindings/thermal/loongson,ls2k-ther=
mal.yaml
> > > index 79e691b08341..b5cbfd201105 100644
> > > --- a/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal=
=2Eyaml
> > > +++ b/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal=
=2Eyaml
> > > @@ -10,13 +10,11 @@ maintainers:
> > >    - zhanghongchen <zhanghongchen@loongson.cn>
> > >    - Yinbo Zhu <zhuyinbo@loongson.cn>
> > >
> > > -allOf:
> > > -  - $ref: /schemas/thermal/thermal-sensor.yaml#
> > > -
> > >  properties:
> > >    compatible:
> > >      oneOf:
> > >        - enum:
> > > +          - loongson,ls2k0300-thermal
> > >            - loongson,ls2k1000-thermal
> > >            - loongson,ls2k2000-thermal
> > >        - items:
> > > @@ -39,23 +37,46 @@ required:
> > >    - reg
> > >    - interrupts
> > >
> > > -if:
> > > -  properties:
> > > -    compatible:
> > > -      contains:
> > > -        enum:
> > > -          - loongson,ls2k2000-thermal
> > > +allOf:
> > > +  - $ref: /schemas/thermal/thermal-sensor.yaml#
> > >
> > > -then:
> > > -  properties:
> > > -    reg:
> > > -      minItems: 2
> > > -      maxItems: 2
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            enum:
> > > +              - loongson,ls2k0300-thermal
> > > +    then:
> > > +      properties:
> > > +        reg:
> > > +          items:
> > > +            - description: Thermal base register region
> > > +            - description: CPU ID register region
> > >
> > > -else:
> > > -  properties:
> > > -    reg:
> > > -      maxItems: 1
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            enum:
> > > +              - loongson,ls2k1000-thermal
> > > +    then:
> > > +      properties:
> > > +        reg:
> > > +          items:
> > > +            - description: Thermal base register region
> > > +
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            enum:
> > > +              - loongson,ls2k2000-thermal
> > > +    then:
> > > +      properties:
> > > +        reg:
> > > +          items:
> > > +            - description: Thermal base register region
> > > +            - description: Thermal data output register region
> > >
> > >  unevaluatedProperties: false
> > >
> > > @@ -69,3 +90,14 @@ examples:
> > >          interrupts =3D <7 IRQ_TYPE_LEVEL_LOW>;
> > >          #thermal-sensor-cells =3D <1>;
> > >      };
> > > +
> > > +  - |
> > > +    #include <dt-bindings/interrupt-controller/irq.h>
> > > +    thermal-sensor@16001500 {
> > > +       compatible =3D "loongson,ls2k0300-thermal";
> > > +       reg =3D <0x16001500 0x30>,
> > > +             <0x16003ff0 0x8>;
> >
> > Quite frankly, the address and size of this look like the second
> > register region here is actually a few bytes in a syscon that is being
> > misrepresented.
> > What lies at the addresses immediately before and after 0x16003ff0?
>=20
> Yes, it can be viewed as part of the system configuration registers,
> which appear somewhat disorganized. Within this section,
> 0x16003fe0=E2=80=930x16003ffc represents eight chip ID registers.
>=20
> 0x16003fe0 --> the 4th chip id
> 0x16003fe4 --> the 5th chip id
> 0x16003fe8 --> the 6th chip id
> 0x16003fec --> the 7th chip id
> 0x16003ff0 --> the 0th chip id
> 0x16003ff4 --> the 1st chip id
> 0x16003ff8 --> the 2nd chip id
> 0x16003ffc --> the 3rd chip id
>=20
> Perhaps I shouldn=E2=80=99t have referenced `0x16003ff0` separately here.=
 It
> would be more reasonable to declare the entire chip ID address space
> as a separate syscon and have it referenced by thermal driver.

Probably, but even being of size 0x20 feels suspiciously small and that
it is likely that this is part of an even larger grouping of misc.
registers.

>=20
> For example:
>=20
> In DTS{i}:
> chipid_syscon: syscon@16003fe0 {
>        compatible =3D =E2=80=9Cloongson,ls2k0300-cphipid-syscon=E2=80=9D,=
 =E2=80=9Csyscon=E2=80=9D;
>        reg =3D <0x0 0x16003fe0 0x0 0x20>;
> };
>=20
> In thermal driver:
> Use
> `syscon_regmap_lookup_by_phandle(np, "loongson,chipid"); `
> Or:
> `syscon_regmap_lookup_by_compatible("loongson,ls2k0300-cphipid-syscon");`
>=20
> get the chip id address space.
>=20
> >
> >
> > Thanks,
> > Conor.
> >
> > > +       interrupt-parent =3D <&liointc1>;
> > > +       interrupts =3D <20 IRQ_TYPE_LEVEL_HIGH>;
> > > +       #thermal-sensor-cells =3D <1>;
> > > +    };
> > > --
> > > 2.52.0
> > >
>=20
> --=20
> Thanks.
> Binbin

--mxs6UIz3nJYmRMyR
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCalZpuQAKCRB4tDGHoIJi
0hrJAP9oL8N9deSXz9dWt+ZEZYfbS19yv8wqpWxkFNHzB6DWwQEAtSc8DI7IDfPv
ibyhUOue/ShcNI/iaFNCSty4HW1vkw0=
=x7Y7
-----END PGP SIGNATURE-----

--mxs6UIz3nJYmRMyR--
