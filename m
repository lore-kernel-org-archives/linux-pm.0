Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDD1225A38;
	Fri,  9 Oct 2026 15:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791558379; cv=none; b=tgAUHJEq4UE1XXwb1GxPQDckPnpxcet1EA9jLbeSaIaAndPilQmaEm6DY2GKrYTSL9h/5+s8W/7gP4MOkBlMM1jEWXa2lIXBn6d63IuLZHeI9GlIWrOUV17IprRT8wlZDGnO5FRL7dak1UQ/W2WcV0XtDkDp+CilMlZGGzIhRuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791558379; c=relaxed/simple;
	bh=arjM4x1zh6Y25uW04ojFfMX4lhRk5epm0Qc7C4FmLPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WziWJPYGV/i8JKPEccC4A9YaCuo7CgcVyTEIUvcQ1pSrN3Fc1hANXZPCFORpeTV3r1WPwK0ezJyU1Zwq/d1ufQg83iBcKI0ZK4dcP6mBAnTAj4ejYoo+lLfhMp9iF/j5KYLv9VZRugWcb5ukcPv0AVJBMozZAVgfiPJQyqmr2G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4S2R1LN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4S2R1LN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D999A1F000FF;
	Fri,  9 Oct 2026 15:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791558374;
	bh=tQp9qKpSn0AbyXHJmWzYFGYGRhRlL+7tyxDSYmxGCHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k4S2R1LNC9kLWpX9AQaVbgAzpx43TZwz+y2OVOUd0IBU8w1ht52MCIOjMj9+ACSUi
	 fIg0O7VrZ3wZaW2KFPuwLozZ1rBVGq3GS7Asn0Wpb1KmZaj/3vEsL+EZL4fLygwMAG
	 3yvjL3+ICXHTpsJ27h4jNA4G1vwFMYeeMsvFWZJF0BZgYwF0m+Mb/yeD4wS+XCE/Sj
	 +EHCCYs3FI8AJno9htU0BK+2gNRkzRiqeLSWwldIknZayfPv5rYQ0+Du1qdH+r7Lcu
	 fB4FIQlfcVrO2mbnNxeMkxETPgvy/ZS3FkWsF9k847TdtiaNSsxMt9W9jd4icp5VnW
	 qsjVrX+v02E8Q==
Date: Fri, 9 Oct 2026 16:06:00 +0100
From: Conor Dooley <conor@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: devfreq: Document support for Airoha
 Subsystem Scale
Message-ID: <20261009-7326174694c52ccce16615b2@squawk>
References: <20261009073330.18175-1-ansuelsmth@gmail.com>
 <20261009073330.18175-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zaGhrI4uIhrDFZEJ"
Content-Disposition: inline
In-Reply-To: <20261009073330.18175-2-ansuelsmth@gmail.com>

--zaGhrI4uIhrDFZEJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 09, 2026 at 09:33:28AM +0200, Christian Marangi wrote:
> Airoha SoC contains multiple subsystems that are scaled to a
> specific OPP taking the CPU clock as reference. Such subsystem
> can enter idle or performance state based on the system load
> and power consumption conditions.
>=20
> Example of such subsystems are GSW (Gigabit Switch), NPU (Custom
> Risc Co-Processor for Network acceleration), SOE (Crypto Module) BUS...

The device you document here does not appear to exist at all, since it
just consumes a clock without any registers or anything. Why can't these
operating points be added to the actual consumers: the switch, the npu,
or event the bus itself in one case. In the bus case, I think that's
exactly what simple-pm-bus does?

Confused,
Conor.

>=20
> Document all the required property and provide examples for the various
> subsystem OPP + subsystem scale nodes.
>=20
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../devfreq/airoha,subsystem-scale.yaml       | 114 ++++++++++++++++++
>  1 file changed, 114 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/airoha,subs=
ystem-scale.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/devfreq/airoha,subsystem-s=
cale.yaml b/Documentation/devicetree/bindings/devfreq/airoha,subsystem-scal=
e.yaml
> new file mode 100644
> index 000000000000..2cf7f23a926c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/devfreq/airoha,subsystem-scale.ya=
ml
> @@ -0,0 +1,114 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/devfreq/airoha,subsystem-scale.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Airoha SoC Subsystem Scale Driver
> +
> +maintainers:
> +  - Christian Marangi <ansuelsmth@gmail.com>
> +
> +description:
> +  Airoha SoC contains multiple subsystems that are scaled to a
> +  specific OPP taking the CPU clock as reference. Such subsystem
> +  can enter idle or performance state based on the system load
> +  and power consumption conditions.
> +
> +  Example of such subsystems are GSW (Gigabit Switch), NPU (Custom
> +  Risc Co-Processor for Network acceleration), SOE (Crypto Module) BUS...
> +
> +properties:
> +  compatible:
> +    const: airoha,an7581-subsystem-scale
> +
> +  clocks:
> +    maxItems: 1
> +
> +  operating-points-v2:
> +    description:
> +      OPP table of the related subsystem supported rates that referenced
> +      clocks will be scaled to.
> +
> +required:
> +  - compatible
> +  - clocks
> +  - operating-points-v2
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/en7523-clk.h>
> +
> +    npu_opp_table: opp-table-npu {
> +        compatible =3D "operating-points-v2";
> +
> +        npu_low: opp-400000000 {
> +           opp-hz =3D /bits/ 64 <400000000>;
> +        };
> +
> +        npu_high: opp-720000000 {
> +           opp-hz =3D /bits/ 64 <720000000>;
> +        };
> +    };
> +
> +    emi_opp_table: opp-table-emi {
> +        compatible =3D "operating-points-v2";
> +
> +        emi_low: opp-400000000 {
> +            opp-hz =3D /bits/ 64 <400000000>;
> +        };
> +
> +        emi_high: opp-540000000 {
> +           opp-hz =3D /bits/ 64 <540000000>;
> +        };
> +    };
> +
> +    bus_opp_table: opp-table-bus {
> +        compatible =3D "operating-points-v2";
> +
> +        bus_low: opp-200000000 {
> +           opp-hz =3D /bits/ 64 <200000000>;
> +        };
> +
> +        bus_high: opp-300000000 {
> +           opp-hz =3D /bits/ 64 <300000000>;
> +        };
> +    };
> +
> +    gsw_opp_table: opp-table-gsw {
> +        compatible =3D "operating-points-v2";
> +
> +        gsw_low: opp-200000000 {
> +            opp-hz =3D /bits/ 64 <200000000>;
> +        };
> +
> +        gsw_high: opp-500000000 {
> +           opp-hz =3D /bits/ 64 <500000000>;
> +        };
> +    };
> +
> +    npu-subsystem {
> +        compatible =3D "airoha,an7581-subsystem-scale";
> +        operating-points-v2 =3D <&npu_opp_table>;
> +        clocks =3D <&scuclk EN7523_CLK_NPU>;
> +    };
> +
> +    emi-subsystem {
> +        compatible =3D "airoha,an7581-subsystem-scale";
> +        operating-points-v2 =3D <&emi_opp_table>;
> +        clocks =3D <&scuclk EN7523_CLK_EMI>;
> +    };
> +
> +    bus-subsystem {
> +        compatible =3D "airoha,an7581-subsystem-scale";
> +        operating-points-v2 =3D <&bus_opp_table>;
> +        clocks =3D <&scuclk EN7523_CLK_BUS>;
> +    };
> +
> +    gsw-subsystem {
> +        compatible =3D "airoha,an7581-subsystem-scale";
> +        operating-points-v2 =3D <&gsw_opp_table>;
> +        clocks =3D <&scuclk EN7523_CLK_GSW>;
> +    };
> --=20
> 2.55.0
>=20

--zaGhrI4uIhrDFZEJ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaskC2AAKCRB4tDGHoIJi
0vHQAP9VdBfVFtl2ISLYhS47stNP+ai3qyFcWCFZ6CIQaGCO0QEAuCa0IZD8T1iw
wtFRHl5l0EynvOJijfAoExZEoHNzcwo=
=Mdmf
-----END PGP SIGNATURE-----

--zaGhrI4uIhrDFZEJ--
