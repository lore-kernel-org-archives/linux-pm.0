Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64403AE1A2;
	Wed, 15 Jul 2026 16:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784131541; cv=none; b=GoBtCtbkKNOpVxfcBYx2kBub2NZgAoMUins4ntIjm0wTq86m4erdA5PtWmUra0oEA+POenD8F5ZzrvROIAqVlWvZP7ev0DphLDALyBsClNBvMzRfzRPQtfeVSLDgdcTA6K4TOZgpjlykJXS470+zj2R3uJJD5C0GhKjJB5L1IqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784131541; c=relaxed/simple;
	bh=nNURNQIDiS1ooR+480wYZx+MKMeLkiR4OpihSyIBdEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lII/GfCQDDaWniPTlMioGQczOx3/sBEcMYZqtcIxhCYNAD0cIgtlXkhCPjeqCyjrwW68VVrLJh8MvDIRbxvoCBMFfXq92ydQVQqH5JeAWjWrzFZvGOLXboQ9fqA5dSNLsau4r84ttvWMUJhNtOjKYmrEytadR2IQGvvuBAqcqUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CT13x8J0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CT13x8J0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272CC1F000E9;
	Wed, 15 Jul 2026 16:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784131531;
	bh=rT7bsQS8/zf1rCHInjAW3HLxDf78or085sWYXQzWL+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CT13x8J0V73sHX37wE1JTb+Dosg4T+RPnhqaRbxU6BaTbiZ+bBMEL9pq0qYRL8K5M
	 Ooq6cUEDrr558+WKU4nLzUK3oRgrNzR8Tc3PYYMVZ3NDyfg5w5aIoWcf1muNH09QyR
	 YH3++eKpb0AyLFVmWXkNaP6Zvske3SKhf5b53pce8/s01fJBYF/Br71fJxwt3n88N9
	 t38XbqmGVbyRK2QSA3IDZc/I18sY+wxluAKMY+A/4LXtxCo4oHE3CF0Td72ALqpzOV
	 DVk0La/sx2l5+ao+hMLA8Lmlvo9DTENuwFuubAHwiV0/nbivoJ8m6BHOufP04soxRO
	 EQg2asVRqpOCQ==
Date: Wed, 15 Jul 2026 17:05:27 +0100
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
Message-ID: <20260715-trickle-trash-afa8904a2aa8@spud>
References: <cover.1783670011.git.zhoubinbin@loongson.cn>
 <7df0780e1b3d4c499a48cd862a12bda895e7818f.1783670011.git.zhoubinbin@loongson.cn>
 <20260710-game-late-9347baafa7ab@spud>
 <CAMpQs4+zXcNnZQnxWM7WUAM-heBYrTejm_dy3yVA4EFUrjA4CQ@mail.gmail.com>
 <20260714-irritate-varying-9055895097b0@spud>
 <CAMpQs4Kd=qc6HNaup6GyWufPwhgd+cafLzRXhga1Z=Ez7LPXHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FboiViZLpLn3+H5A"
Content-Disposition: inline
In-Reply-To: <CAMpQs4Kd=qc6HNaup6GyWufPwhgd+cafLzRXhga1Z=Ez7LPXHA@mail.gmail.com>

--FboiViZLpLn3+H5A
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 04:31:21PM +0800, Binbin Zhou wrote:
> Hi Conor:
>=20
> On Wed, Jul 15, 2026 at 12:54=E2=80=AFAM Conor Dooley <conor@kernel.org> =
wrote:
> >
> > On Tue, Jul 14, 2026 at 02:53:40PM +0800, Binbin Zhou wrote:
> > > Hi Conor:
> > >
> > > Thanks for your reply.
> > >
> > > On Sat, Jul 11, 2026 at 12:21=E2=80=AFAM Conor Dooley <conor@kernel.o=
rg> wrote:
> > > >
> > > > On Fri, Jul 10, 2026 at 04:24:59PM +0800, Binbin Zhou wrote:
> > > > > Add a new compatible string `loongson,ls2k0300-thermal` for the t=
hermal
> > > > > sensor found on the Loongson-2K0300 SoC.
> > > > >
> > > > > The hardware differs from the existing SoCs in its register layou=
t: it
> > > > > requires two register regions (one for the thermal sensor control=
 and
> > > > > another for the CPU ID).
> > > > >
> > > > > Update the binding to describe this new requirement.
> > > > >
> > > > > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > > > > ---
> > > > >  .../thermal/loongson,ls2k-thermal.yaml        | 68 +++++++++++++=
+-----
> > > > >  1 file changed, 50 insertions(+), 18 deletions(-)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/thermal/loongson,l=
s2k-thermal.yaml b/Documentation/devicetree/bindings/thermal/loongson,ls2k-=
thermal.yaml
> > > > > index 79e691b08341..b5cbfd201105 100644
> > > > > --- a/Documentation/devicetree/bindings/thermal/loongson,ls2k-the=
rmal.yaml
> > > > > +++ b/Documentation/devicetree/bindings/thermal/loongson,ls2k-the=
rmal.yaml
> > > > > @@ -10,13 +10,11 @@ maintainers:
> > > > >    - zhanghongchen <zhanghongchen@loongson.cn>
> > > > >    - Yinbo Zhu <zhuyinbo@loongson.cn>
> > > > >
> > > > > -allOf:
> > > > > -  - $ref: /schemas/thermal/thermal-sensor.yaml#
> > > > > -
> > > > >  properties:
> > > > >    compatible:
> > > > >      oneOf:
> > > > >        - enum:
> > > > > +          - loongson,ls2k0300-thermal
> > > > >            - loongson,ls2k1000-thermal
> > > > >            - loongson,ls2k2000-thermal
> > > > >        - items:
> > > > > @@ -39,23 +37,46 @@ required:
> > > > >    - reg
> > > > >    - interrupts
> > > > >
> > > > > -if:
> > > > > -  properties:
> > > > > -    compatible:
> > > > > -      contains:
> > > > > -        enum:
> > > > > -          - loongson,ls2k2000-thermal
> > > > > +allOf:
> > > > > +  - $ref: /schemas/thermal/thermal-sensor.yaml#
> > > > >
> > > > > -then:
> > > > > -  properties:
> > > > > -    reg:
> > > > > -      minItems: 2
> > > > > -      maxItems: 2
> > > > > +  - if:
> > > > > +      properties:
> > > > > +        compatible:
> > > > > +          contains:
> > > > > +            enum:
> > > > > +              - loongson,ls2k0300-thermal
> > > > > +    then:
> > > > > +      properties:
> > > > > +        reg:
> > > > > +          items:
> > > > > +            - description: Thermal base register region
> > > > > +            - description: CPU ID register region
> > > > >
> > > > > -else:
> > > > > -  properties:
> > > > > -    reg:
> > > > > -      maxItems: 1
> > > > > +  - if:
> > > > > +      properties:
> > > > > +        compatible:
> > > > > +          contains:
> > > > > +            enum:
> > > > > +              - loongson,ls2k1000-thermal
> > > > > +    then:
> > > > > +      properties:
> > > > > +        reg:
> > > > > +          items:
> > > > > +            - description: Thermal base register region
> > > > > +
> > > > > +  - if:
> > > > > +      properties:
> > > > > +        compatible:
> > > > > +          contains:
> > > > > +            enum:
> > > > > +              - loongson,ls2k2000-thermal
> > > > > +    then:
> > > > > +      properties:
> > > > > +        reg:
> > > > > +          items:
> > > > > +            - description: Thermal base register region
> > > > > +            - description: Thermal data output register region
> > > > >
> > > > >  unevaluatedProperties: false
> > > > >
> > > > > @@ -69,3 +90,14 @@ examples:
> > > > >          interrupts =3D <7 IRQ_TYPE_LEVEL_LOW>;
> > > > >          #thermal-sensor-cells =3D <1>;
> > > > >      };
> > > > > +
> > > > > +  - |
> > > > > +    #include <dt-bindings/interrupt-controller/irq.h>
> > > > > +    thermal-sensor@16001500 {
> > > > > +       compatible =3D "loongson,ls2k0300-thermal";
> > > > > +       reg =3D <0x16001500 0x30>,
> > > > > +             <0x16003ff0 0x8>;
> > > >
> > > > Quite frankly, the address and size of this look like the second
> > > > register region here is actually a few bytes in a syscon that is be=
ing
> > > > misrepresented.
> > > > What lies at the addresses immediately before and after 0x16003ff0?
> > >
> > > Yes, it can be viewed as part of the system configuration registers,
> > > which appear somewhat disorganized. Within this section,
> > > 0x16003fe0=E2=80=930x16003ffc represents eight chip ID registers.
> > >
> > > 0x16003fe0 --> the 4th chip id
> > > 0x16003fe4 --> the 5th chip id
> > > 0x16003fe8 --> the 6th chip id
> > > 0x16003fec --> the 7th chip id
> > > 0x16003ff0 --> the 0th chip id
> > > 0x16003ff4 --> the 1st chip id
> > > 0x16003ff8 --> the 2nd chip id
> > > 0x16003ffc --> the 3rd chip id
> > >
> > > Perhaps I shouldn=E2=80=99t have referenced `0x16003ff0` separately h=
ere. It
> > > would be more reasonable to declare the entire chip ID address space
> > > as a separate syscon and have it referenced by thermal driver.
> >
> > Probably, but even being of size 0x20 feels suspiciously small and that
> > it is likely that this is part of an even larger grouping of misc.
> > registers.
>=20
> According to the manual, the chip configuration registers are not
> contiguous but are scattered throughout the memory. They are generally
> as follows:
>=20
> 0x16000100 - 0x16000154:  General Chip Configuration / Chip Sampling
> Parameters / Chip Counter Registers
> 0x16000400 - 0x16000424:  PLL Clock Configuration Registers -> This is
> already used in clk driver;
> 0x16000490 - 0x160004a8:  GPIO Remapping Configuration Register ->
> This is already used in pinctrl driver;
> 0x16000500 - 0x1600050c:  USB PHY Configuration Register
> 0x16001040 - 0x160014c0:  Interrupt routing Registers -> This is
> already used in irqchip driver;
> 0x16001500 - 0x16001524:  Thermal Registers -> This is already used in
> thermal driver;
> 0x16001600 - 0x1600180c:  External Interrupt Registers -> EIO irqchip dri=
ver;
> 0x16003fe0  - 0x16003ffc:  CHIP ID Registers
>=20
> Expanding the range to `0x16000100 - 0x16003ffc` might not be the best ap=
proach.
> In contrast, the chip ID register is independent. Additionally, apart
> from the first section of general-purpose chip configuration
> registers, the other registers are referenced by their respective
> modules.
>=20
> So, is `reg =3D <0x0 0x16003fe0 0x0 0x20>;` a good choice?

Yeah, it is genuinely not a contiguous region, suspect as it may look!
This seems fine, thanks.

--FboiViZLpLn3+H5A
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCalevxwAKCRB4tDGHoIJi
0lDLAQDu6AjKg74+kqvhVdYkB1JqPrZjz5kG+X3lErk6G60FLQEA9RG17mVZ9OR3
FOsdEYDvAtMg60UdM8V4VKu68e/qZAQ=
=XcdU
-----END PGP SIGNATURE-----

--FboiViZLpLn3+H5A--
