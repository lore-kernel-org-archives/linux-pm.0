Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2E0360ECE
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 08:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784104296; cv=pass; b=YLv38BEt6BJR3kYLhcz2KzT0T6xPPbMlabGPEKKi5w2U1KoMxZ05S+WDf01RcFD4WGAynrwp9Kep7w1PT+qOxSlOJ24tiq8qs2s9O3dgq/vojpCbwd79KcLRZLRcLVodCFVogW9joOPLBqEzEskymNkQqek+I2IeppuP0EKyTu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784104296; c=relaxed/simple;
	bh=tbJh1cvggz9fj6wWtOnktnlMx38fPOjiOCsgOQsZ8fA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oekZVK1tEFBdl6J4/he0HdTNAP1T79mIZ8h0jbvI4Ncc5cze4cGjGwwdYSteLBVesb/vQrPu0q7RdHbHIT06uujXZazNu2QyFhjhbbcLP151eUgiI7NlxCLxCkxgox1IUgP2MZrW/HoNu4Hi1iZnlp/qEvrXriKXFL/yqgfPfuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pI+hNLYz; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pI+hNLYz"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c1677c91969so71776566b.1
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 01:31:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784104293; cv=none;
        d=google.com; s=arc-20260327;
        b=g56YG2eurQ4XqZ22Otmm24EYzF2sLuYSqKUStWSRT2SWOp+tvDrx3MvRubGZPtXi2s
         jZujr4qCGS2cO6iWLNXWU5Oj2WbAmWuRHz2UjuohY2VYPvkeWdLMDm48b7JSjJDpkc7Q
         jV7m+vvcVL52X8XlTs/ccpThumTMNcI/uCeZbXVg+vsgsFtj4jCbt93Ldkg4u8VsgOp8
         aFsPTwR13el//KG728CDeF27xKWWzwIbKwqKiveBIAyM7oAz7eGahY/RKvID41r5QPUU
         kvXHJZn0wsjeKH/bjFpeVU5+MkDPmPvu58IZpTmCCf//UncAtF54jr2H70dsFMnegobU
         ZTxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SIO4iai7ZG36bPwEvbqCHAeg6bos5dE8xe5cg3XB4/c=;
        fh=Ls1TVbwhsIY/NlYhiBv+J7nWkLdKv7NbmX2m/Y+0PjI=;
        b=ggUNIoIzzudG+vgsJGPEyyALeGka9fosPBWd+ZzMzeQogyFWZ/Afd0b5oJqDAm7V/7
         HZXtS6ePmXAO9b0ksIup2d2HH6HSl79ObDrXLrsSnOJlmw6PAGJsvjLmvQCNf03HQdlo
         y70IXSUSSg/qPOFsvdJjeiqjMP5MBT2fA8wj8W/4m3dIAGYVGG6VRfVZwo5UTSZF1eVf
         75pdrjmlzBM7ZTLaNsRsTiugLIx48kH63C9/7FSyNhG9Cb1f5MzCEkWyT0Q8tSmd2+do
         9jyHoS2jvXGmlnD2PUAmjh2yodVw1uyRBDTYidiKmNiS6EgBSWfA0xn/urPD51PzPodC
         6tyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784104293; x=1784709093; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SIO4iai7ZG36bPwEvbqCHAeg6bos5dE8xe5cg3XB4/c=;
        b=pI+hNLYz2l3NFvmV0ENGLWnH6o5LZ/YD9yBqZdOqMoQGGreZRy76vRFZSavqZKRvSi
         urLDW0FF8oe9T0RycziasqVYuV6tKUjaZmzyA6uP/GQHp1BnEGA7oIM3KNk3A59a7OcD
         /Ly60pxBe54P6swF6qoutmqSP9iCS60GupVjyyH95jwW1pnuOqWMODOdEmYMtE5nWhg0
         OwfhH3oKKyzjSYq+aMaEg7AEG+JT5AXP4JuX8b6pp8ljxPpu1d3VfiSsw2mmXBmi1W9b
         QhCWjBaRWRloC+9GBtQeqwHvFpBHtyIujifGCvTyIaHLcWFbssCuHM3iBA8VKq3CKAz+
         R1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784104293; x=1784709093;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SIO4iai7ZG36bPwEvbqCHAeg6bos5dE8xe5cg3XB4/c=;
        b=CUrfU+dvmXrYgBPTwFwb2KI0geQmKOsbnrNi2kIvfIwty/KQknjrFexwrmETc5m4Nf
         ZHM92QwPj+59qJHL8hcj9i7DOYfHs5tZ0kmYxJ+M3Qe1QAkUlDD9MMFD5bUYXWTBuife
         Jus4eRlv/jQzc5EzhLT2xACqoSGvD/D1BTNFsYXKyEY4XsVfJ1VzI+sPsN84gSwv8KtC
         njkGZXZJi1AgNw2SojQKDQ5VUK6TdlVagm+HrlHB9Oz9Ra6cAJlQGBmh7G46UJYd6s8q
         HWZcCROkvVxiucYlGpdYouuMQcBnkzmpMv4Y3YNTb6LV2XqhOVqWU+x49HF5ODiRbkql
         pznA==
X-Forwarded-Encrypted: i=1; AHgh+RrRgkm6hpCpAALH7N1FypuT27JWYKMZ322nErTRIpl3Mu9PSBtb0ydsTqJxaADAlHkX58eJ51Thzw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCTEogf/+JPX+Izz9F122/ilAdKJnDWkNQ8qPH55HFTQTyht/q
	JwMhSlNYYqzJzh2LBNUdO83cll+Oc8xf8mUmzZHLK3X1Gw/WDojydYygfepCDgiDzADkmZLIo5r
	At+Kby/xSV4BddwqCmNVfY1um0IR82xE=
X-Gm-Gg: AfdE7cn9eoXWYmtBiy1wd/F0cyGfRvily3sWweYtGwtgY0/u1XbLxMWEKxzjOZgoQLo
	eiLoAalRlORk9bcPASt+2uLquneWpy29VShnKuq3Kwg+jVGPN0HN98sejVeOjV84gZSjryARsAB
	JaeJlU6NUQpDYpxaY7PeE3M3sJjA+m/lFgFWl873KE/zH1yKJHA4JsD1XnSsS7JZMPc/a/K1dD0
	wRQoNvG95x9Sdb+TC1ugracvBli+cwMDKU6Fo3+/9n4/GERmlybeYwBnAcRq2G3ZwjyAbM=
X-Received: by 2002:a17:906:478f:b0:c12:979c:5a5e with SMTP id
 a640c23a62f3a-c1678ff1a33mr107871966b.0.1784104293130; Wed, 15 Jul 2026
 01:31:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1783670011.git.zhoubinbin@loongson.cn> <7df0780e1b3d4c499a48cd862a12bda895e7818f.1783670011.git.zhoubinbin@loongson.cn>
 <20260710-game-late-9347baafa7ab@spud> <CAMpQs4+zXcNnZQnxWM7WUAM-heBYrTejm_dy3yVA4EFUrjA4CQ@mail.gmail.com>
 <20260714-irritate-varying-9055895097b0@spud>
In-Reply-To: <20260714-irritate-varying-9055895097b0@spud>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Wed, 15 Jul 2026 16:31:21 +0800
X-Gm-Features: AUfX_mybVa7Y7V3mpGKZQK3bq9KTd6uD6axAeXZjqDD49GTseSW4kybm7O4RuKY
Message-ID: <CAMpQs4Kd=qc6HNaup6GyWufPwhgd+cafLzRXhga1Z=Ez7LPXHA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: thermal: loongson,ls2k-thermal: Add
 compatible for Loongson-2K0300
To: Conor Dooley <conor@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Conor:

On Wed, Jul 15, 2026 at 12:54=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Tue, Jul 14, 2026 at 02:53:40PM +0800, Binbin Zhou wrote:
> > Hi Conor:
> >
> > Thanks for your reply.
> >
> > On Sat, Jul 11, 2026 at 12:21=E2=80=AFAM Conor Dooley <conor@kernel.org=
> wrote:
> > >
> > > On Fri, Jul 10, 2026 at 04:24:59PM +0800, Binbin Zhou wrote:
> > > > Add a new compatible string `loongson,ls2k0300-thermal` for the the=
rmal
> > > > sensor found on the Loongson-2K0300 SoC.
> > > >
> > > > The hardware differs from the existing SoCs in its register layout:=
 it
> > > > requires two register regions (one for the thermal sensor control a=
nd
> > > > another for the CPU ID).
> > > >
> > > > Update the binding to describe this new requirement.
> > > >
> > > > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > > > ---
> > > >  .../thermal/loongson,ls2k-thermal.yaml        | 68 ++++++++++++++-=
----
> > > >  1 file changed, 50 insertions(+), 18 deletions(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/thermal/loongson,ls2=
k-thermal.yaml b/Documentation/devicetree/bindings/thermal/loongson,ls2k-th=
ermal.yaml
> > > > index 79e691b08341..b5cbfd201105 100644
> > > > --- a/Documentation/devicetree/bindings/thermal/loongson,ls2k-therm=
al.yaml
> > > > +++ b/Documentation/devicetree/bindings/thermal/loongson,ls2k-therm=
al.yaml
> > > > @@ -10,13 +10,11 @@ maintainers:
> > > >    - zhanghongchen <zhanghongchen@loongson.cn>
> > > >    - Yinbo Zhu <zhuyinbo@loongson.cn>
> > > >
> > > > -allOf:
> > > > -  - $ref: /schemas/thermal/thermal-sensor.yaml#
> > > > -
> > > >  properties:
> > > >    compatible:
> > > >      oneOf:
> > > >        - enum:
> > > > +          - loongson,ls2k0300-thermal
> > > >            - loongson,ls2k1000-thermal
> > > >            - loongson,ls2k2000-thermal
> > > >        - items:
> > > > @@ -39,23 +37,46 @@ required:
> > > >    - reg
> > > >    - interrupts
> > > >
> > > > -if:
> > > > -  properties:
> > > > -    compatible:
> > > > -      contains:
> > > > -        enum:
> > > > -          - loongson,ls2k2000-thermal
> > > > +allOf:
> > > > +  - $ref: /schemas/thermal/thermal-sensor.yaml#
> > > >
> > > > -then:
> > > > -  properties:
> > > > -    reg:
> > > > -      minItems: 2
> > > > -      maxItems: 2
> > > > +  - if:
> > > > +      properties:
> > > > +        compatible:
> > > > +          contains:
> > > > +            enum:
> > > > +              - loongson,ls2k0300-thermal
> > > > +    then:
> > > > +      properties:
> > > > +        reg:
> > > > +          items:
> > > > +            - description: Thermal base register region
> > > > +            - description: CPU ID register region
> > > >
> > > > -else:
> > > > -  properties:
> > > > -    reg:
> > > > -      maxItems: 1
> > > > +  - if:
> > > > +      properties:
> > > > +        compatible:
> > > > +          contains:
> > > > +            enum:
> > > > +              - loongson,ls2k1000-thermal
> > > > +    then:
> > > > +      properties:
> > > > +        reg:
> > > > +          items:
> > > > +            - description: Thermal base register region
> > > > +
> > > > +  - if:
> > > > +      properties:
> > > > +        compatible:
> > > > +          contains:
> > > > +            enum:
> > > > +              - loongson,ls2k2000-thermal
> > > > +    then:
> > > > +      properties:
> > > > +        reg:
> > > > +          items:
> > > > +            - description: Thermal base register region
> > > > +            - description: Thermal data output register region
> > > >
> > > >  unevaluatedProperties: false
> > > >
> > > > @@ -69,3 +90,14 @@ examples:
> > > >          interrupts =3D <7 IRQ_TYPE_LEVEL_LOW>;
> > > >          #thermal-sensor-cells =3D <1>;
> > > >      };
> > > > +
> > > > +  - |
> > > > +    #include <dt-bindings/interrupt-controller/irq.h>
> > > > +    thermal-sensor@16001500 {
> > > > +       compatible =3D "loongson,ls2k0300-thermal";
> > > > +       reg =3D <0x16001500 0x30>,
> > > > +             <0x16003ff0 0x8>;
> > >
> > > Quite frankly, the address and size of this look like the second
> > > register region here is actually a few bytes in a syscon that is bein=
g
> > > misrepresented.
> > > What lies at the addresses immediately before and after 0x16003ff0?
> >
> > Yes, it can be viewed as part of the system configuration registers,
> > which appear somewhat disorganized. Within this section,
> > 0x16003fe0=E2=80=930x16003ffc represents eight chip ID registers.
> >
> > 0x16003fe0 --> the 4th chip id
> > 0x16003fe4 --> the 5th chip id
> > 0x16003fe8 --> the 6th chip id
> > 0x16003fec --> the 7th chip id
> > 0x16003ff0 --> the 0th chip id
> > 0x16003ff4 --> the 1st chip id
> > 0x16003ff8 --> the 2nd chip id
> > 0x16003ffc --> the 3rd chip id
> >
> > Perhaps I shouldn=E2=80=99t have referenced `0x16003ff0` separately her=
e. It
> > would be more reasonable to declare the entire chip ID address space
> > as a separate syscon and have it referenced by thermal driver.
>
> Probably, but even being of size 0x20 feels suspiciously small and that
> it is likely that this is part of an even larger grouping of misc.
> registers.

According to the manual, the chip configuration registers are not
contiguous but are scattered throughout the memory. They are generally
as follows:

0x16000100 - 0x16000154:  General Chip Configuration / Chip Sampling
Parameters / Chip Counter Registers
0x16000400 - 0x16000424:  PLL Clock Configuration Registers -> This is
already used in clk driver;
0x16000490 - 0x160004a8:  GPIO Remapping Configuration Register ->
This is already used in pinctrl driver;
0x16000500 - 0x1600050c:  USB PHY Configuration Register
0x16001040 - 0x160014c0:  Interrupt routing Registers -> This is
already used in irqchip driver;
0x16001500 - 0x16001524:  Thermal Registers -> This is already used in
thermal driver;
0x16001600 - 0x1600180c:  External Interrupt Registers -> EIO irqchip drive=
r;
0x16003fe0  - 0x16003ffc:  CHIP ID Registers

Expanding the range to `0x16000100 - 0x16003ffc` might not be the best appr=
oach.
In contrast, the chip ID register is independent. Additionally, apart
from the first section of general-purpose chip configuration
registers, the other registers are referenced by their respective
modules.

So, is `reg =3D <0x0 0x16003fe0 0x0 0x20>;` a good choice?
>
> >
> > For example:
> >
> > In DTS{i}:
> > chipid_syscon: syscon@16003fe0 {
> >        compatible =3D =E2=80=9Cloongson,ls2k0300-cphipid-syscon=E2=80=
=9D, =E2=80=9Csyscon=E2=80=9D;
> >        reg =3D <0x0 0x16003fe0 0x0 0x20>;
> > };
> >
> > In thermal driver:
> > Use
> > `syscon_regmap_lookup_by_phandle(np, "loongson,chipid"); `
> > Or:
> > `syscon_regmap_lookup_by_compatible("loongson,ls2k0300-cphipid-syscon")=
;`
> >
> > get the chip id address space.
> >
> > >
> > >
> > > Thanks,
> > > Conor.
> > >
> > > > +       interrupt-parent =3D <&liointc1>;
> > > > +       interrupts =3D <20 IRQ_TYPE_LEVEL_HIGH>;
> > > > +       #thermal-sensor-cells =3D <1>;
> > > > +    };
> > > > --
> > > > 2.52.0
> > > >
> >
> > --
> > Thanks.
> > Binbin

--=20
Thanks.
Binbin
