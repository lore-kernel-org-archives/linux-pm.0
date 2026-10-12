Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977643164D6;
	Mon, 12 Oct 2026 18:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791829999; cv=none; b=TEXt1c31mfwiJcMEkB+x3Bi8zXqJKinhk2WJRvKM7DI6IKILCbAABUdEVGUzKq8UGKxTodhYxQswcPGRJ7lGx3P2KyFBtMImZzN2FjQiecIvmOKsJBJh+PgVGq0vadh8IFNFJMei78Er/jvlZdXZgsjCcdTW8uGgOibpRrkx0S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791829999; c=relaxed/simple;
	bh=2jev+X9eZWaUQdLUTWqQMpPip9naeKOc+lzPDDuyS/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YeDOqGMv5yhNmmf5u0A5foS5tZfhm87JGoyqO5EgWdTJfeBT2wIcp1hMNCQCrTICL14CI+yowqkaQGH2ggx3b0lLfcpUPSiEGBic1fufAxuUrKotsQ+FO8y6XAiFsyV2nB4rffo8I8y6PSC8ydw1eNe/fp1NLNsgA4eB1WmiHx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTkcw9zS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTkcw9zS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39FFE1F0089B;
	Mon, 12 Oct 2026 18:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791829998;
	bh=3N92RsPkx7NpDXko9YRy+joOmezpqIqNPIc1QdM/gl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UTkcw9zSYroB8h/NvMRzmSpVddePQ1UsezA9zSb3l3i2I2kCymW5e0wVoJIQPflHg
	 2LxDbIlNo4LdAeWpef1dr7mDFmtcNDH19Iq76kYndNRp1UNHheuw9qbBy319q+r9hj
	 f7xhc3WwfCl2X3h18ykX/MDKb339TTRu2qDGBfqVKgOGcyHvTDQfBuKbOYhdW7z6fj
	 X/aHx6U+q/zZJUmbfumPrlVHjO01rc9fuyOlwhwOL5opowpIIPjxwN7PiaIY1cdhwI
	 YdusQsZDAYiSmuFKwgnPK0pN7QERHfiziMvjz4LTz2XJpzgNEMVLMFTEtm/HUQ1rNt
	 Qx9TlBABGsqSw==
Date: Mon, 12 Oct 2026 19:33:14 +0100
From: Conor Dooley <conor@kernel.org>
To: "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: devfreq: Document support for Airoha
 Subsystem Scale
Message-ID: <20261012-clatter-exclude-f9d59f1cf2ff@spud>
References: <20261009073330.18175-1-ansuelsmth@gmail.com>
 <20261009073330.18175-2-ansuelsmth@gmail.com>
 <20261009-7326174694c52ccce16615b2@squawk>
 <CA+_ehUyP35PF6cm17dzeLcREVFEPv=89Do-s5-hm-T3mKveuKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NyqbRy2wVOJi22pa"
Content-Disposition: inline
In-Reply-To: <CA+_ehUyP35PF6cm17dzeLcREVFEPv=89Do-s5-hm-T3mKveuKQ@mail.gmail.com>

--NyqbRy2wVOJi22pa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 09, 2026 at 05:15:27PM +0200, Christian Marangi (Ansuel) wrote:
> Il giorno ven 9 ott 2026 alle ore 17:06 Conor Dooley
> <conor@kernel.org> ha scritto:
> >
> > On Fri, Oct 09, 2026 at 09:33:28AM +0200, Christian Marangi wrote:
> > > Airoha SoC contains multiple subsystems that are scaled to a
> > > specific OPP taking the CPU clock as reference. Such subsystem
> > > can enter idle or performance state based on the system load
> > > and power consumption conditions.
> > >
> > > Example of such subsystems are GSW (Gigabit Switch), NPU (Custom
> > > Risc Co-Processor for Network acceleration), SOE (Crypto Module) BUS.=
=2E.
> >
> > The device you document here does not appear to exist at all, since it
> > just consumes a clock without any registers or anything. Why can't these
> > operating points be added to the actual consumers: the switch, the npu,
> > or event the bus itself in one case. In the bus case, I think that's
> > exactly what simple-pm-bus does?
> >
>=20
> Can the consumer be registered as a devfreq with all the other thing?

What do you mean exactly? Are you asking if a node can be a switch and a
devfreq, or a bus and a devfreq, at the same time? The answer to that is
yes.

> Isn't that problematic?

It's not clear to me, what do you think might be problematic?

> Also one big problem is that some subsystem are used internally.
> Example SOE and BUS. (and also NPU)

What does "used internally" mean?

> How those can be configured to follow the CPU frequency and
> use the required-opp and opp?

At least in the bus case, you'd be far from the only device with a
devfreq driver. I don't see any accelerators that register with devfreq,
but I see there's a bunch of GPU drivers that do, so there's prior art
in that subsystem for being one. That should work (I think) and doesn't
involve registering fake consumers of clocks?

Cheers,
Conor.

>=20
> > >
> > > Document all the required property and provide examples for the vario=
us
> > > subsystem OPP + subsystem scale nodes.
> > >
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > ---
> > >  .../devfreq/airoha,subsystem-scale.yaml       | 114 ++++++++++++++++=
++
> > >  1 file changed, 114 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/devfreq/airoha,=
subsystem-scale.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/devfreq/airoha,subsyst=
em-scale.yaml b/Documentation/devicetree/bindings/devfreq/airoha,subsystem-=
scale.yaml
> > > new file mode 100644
> > > index 000000000000..2cf7f23a926c
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/devfreq/airoha,subsystem-scal=
e.yaml
> > > @@ -0,0 +1,114 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/devfreq/airoha,subsystem-scale.ya=
ml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Airoha SoC Subsystem Scale Driver
> > > +
> > > +maintainers:
> > > +  - Christian Marangi <ansuelsmth@gmail.com>
> > > +
> > > +description:
> > > +  Airoha SoC contains multiple subsystems that are scaled to a
> > > +  specific OPP taking the CPU clock as reference. Such subsystem
> > > +  can enter idle or performance state based on the system load
> > > +  and power consumption conditions.
> > > +
> > > +  Example of such subsystems are GSW (Gigabit Switch), NPU (Custom
> > > +  Risc Co-Processor for Network acceleration), SOE (Crypto Module) B=
US...
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: airoha,an7581-subsystem-scale
> > > +
> > > +  clocks:
> > > +    maxItems: 1
> > > +
> > > +  operating-points-v2:
> > > +    description:
> > > +      OPP table of the related subsystem supported rates that refere=
nced
> > > +      clocks will be scaled to.
> > > +
> > > +required:
> > > +  - compatible
> > > +  - clocks
> > > +  - operating-points-v2
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/clock/en7523-clk.h>
> > > +
> > > +    npu_opp_table: opp-table-npu {
> > > +        compatible =3D "operating-points-v2";
> > > +
> > > +        npu_low: opp-400000000 {
> > > +           opp-hz =3D /bits/ 64 <400000000>;
> > > +        };
> > > +
> > > +        npu_high: opp-720000000 {
> > > +           opp-hz =3D /bits/ 64 <720000000>;
> > > +        };
> > > +    };
> > > +
> > > +    emi_opp_table: opp-table-emi {
> > > +        compatible =3D "operating-points-v2";
> > > +
> > > +        emi_low: opp-400000000 {
> > > +            opp-hz =3D /bits/ 64 <400000000>;
> > > +        };
> > > +
> > > +        emi_high: opp-540000000 {
> > > +           opp-hz =3D /bits/ 64 <540000000>;
> > > +        };
> > > +    };
> > > +
> > > +    bus_opp_table: opp-table-bus {
> > > +        compatible =3D "operating-points-v2";
> > > +
> > > +        bus_low: opp-200000000 {
> > > +           opp-hz =3D /bits/ 64 <200000000>;
> > > +        };
> > > +
> > > +        bus_high: opp-300000000 {
> > > +           opp-hz =3D /bits/ 64 <300000000>;
> > > +        };
> > > +    };
> > > +
> > > +    gsw_opp_table: opp-table-gsw {
> > > +        compatible =3D "operating-points-v2";
> > > +
> > > +        gsw_low: opp-200000000 {
> > > +            opp-hz =3D /bits/ 64 <200000000>;
> > > +        };
> > > +
> > > +        gsw_high: opp-500000000 {
> > > +           opp-hz =3D /bits/ 64 <500000000>;
> > > +        };
> > > +    };
> > > +
> > > +    npu-subsystem {
> > > +        compatible =3D "airoha,an7581-subsystem-scale";
> > > +        operating-points-v2 =3D <&npu_opp_table>;
> > > +        clocks =3D <&scuclk EN7523_CLK_NPU>;
> > > +    };
> > > +
> > > +    emi-subsystem {
> > > +        compatible =3D "airoha,an7581-subsystem-scale";
> > > +        operating-points-v2 =3D <&emi_opp_table>;
> > > +        clocks =3D <&scuclk EN7523_CLK_EMI>;
> > > +    };
> > > +
> > > +    bus-subsystem {
> > > +        compatible =3D "airoha,an7581-subsystem-scale";
> > > +        operating-points-v2 =3D <&bus_opp_table>;
> > > +        clocks =3D <&scuclk EN7523_CLK_BUS>;
> > > +    };
> > > +
> > > +    gsw-subsystem {
> > > +        compatible =3D "airoha,an7581-subsystem-scale";
> > > +        operating-points-v2 =3D <&gsw_opp_table>;
> > > +        clocks =3D <&scuclk EN7523_CLK_GSW>;
> > > +    };
> > > --
> > > 2.55.0
> > >

--NyqbRy2wVOJi22pa
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCas0n6gAKCRB4tDGHoIJi
0juvAQCgazTuztS3AV1jWBURL+C8Ou4sFeDXDl+1LV7A51MhgQEA/KeuiV3cQkNC
RRBbR5jBssFP8UPvHODyEgkU8ctkXQI=
=P/rb
-----END PGP SIGNATURE-----

--NyqbRy2wVOJi22pa--
