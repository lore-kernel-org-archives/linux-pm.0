Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AD2496D3C;
	Thu,  8 Oct 2026 10:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791456068; cv=none; b=jbVoP4ZVkBrQP1mMjbGrOwWZhkXy66hWYessHTdjdbObqfdwfZhAgcgvHQivu36VaKv1s0nt4dq8jo/dh9OcOuYSL/Hh096wB1nvOQketzRmzmePQpAumPOvGP982jx45V3k+lZ8U/tYlNcb5Spdo2s6Bj2luqRNX6IGqKRlucs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791456068; c=relaxed/simple;
	bh=RD+41Prv2YBVEcszEbTrjKHioJWroWvXmK1RbDFydcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSLJdizz0M/Igf4so3N5Tvk7Au5DYNspYFrGwyxINsRcY5AlU5wbQ5M0M0B8V2dlOY55TuCsD4H7DWuTIUS+RC9duxzqSR5/LNEK2QZ7kmiAyaY2+Ppd73tbWyS8ScUwxPPJxckaOCJqkoNnNcUTpmw/RVHtvMPwIETLIJUajZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0101qdY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0101qdY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221DF1F000FF;
	Thu,  8 Oct 2026 10:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791456066;
	bh=CtJ3sX2t+k7O4SihyHn6wnh9lqmM5VVL6sBh7af1M/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A0101qdYFBu0hUVMqtM+aCFz4o+0NWpEnRDNdaj/I8FD5Xhzxqf/1ZOCj3D/V64qb
	 MIRYuo7DOzLQ8vee5yJD3Cs/VMw+3uvclyQWbROOSSbOx8HNkWJ5t6aT5su1T/zPSU
	 y7QARURDdMneNgMtCkB/YmlPEfD9i+rlISonSDPe2V3g5KyA3UeMXTOIzptrKhL5Z6
	 cFLON65qhOeFcUrucEP5mWiUPP+upav+fE59jV+BBliO0ip3Z79pBtWJoc7mYeiIEs
	 6i/uXx30dBWfsuKTRS7maSircJRMMehivTLDRsKzcBXy81f6IJ+oHClXbuREmW4Lq6
	 C5mcS4T6pSJGQ==
Date: Thu, 8 Oct 2026 11:41:00 +0100
From: Conor Dooley <conor@kernel.org>
To: Joshua Yeong <joshua.yeong@starfivetech.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	rafael@kernel.org, viresh.kumar@linaro.org, ulfh@kernel.org,
	rahul@summations.net, anup@brainfault.org, lftan.linux@gmail.com,
	alex@ghiti.fr, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] dt-bindings: dvfs: Add RPMI performance service
 bindings
Message-ID: <20261008-3b6200fdf4f51048d888b4f5@squawk>
References: <20261008091032.2832333-1-joshua.yeong@starfivetech.com>
 <20261008091032.2832333-3-joshua.yeong@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gR/v5yiG/AmM4XPJ"
Content-Disposition: inline
In-Reply-To: <20261008091032.2832333-3-joshua.yeong@starfivetech.com>

--gR/v5yiG/AmM4XPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 08, 2026 at 05:10:26PM +0800, Joshua Yeong wrote:
> Add device tree bindings for the RPMI performance service group based
> controller for the supervisor software.
>=20
> A CPU names its performance domain through "performance-domains". Any
> other device names it through "power-domains": the controller is also a
> power domain provider, with one power domain per performance domain and
> the levels the domain advertises as the performance states of that
> power domain.
>=20
> The RPMI performance service group is defined by the RISC-V Platform
> Management Interface (RPMI) specification.
>=20
> Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
> ---
>  .../bindings/dvfs/riscv,rpmi-performance.yaml | 88 +++++++++++++++++++
>  1 file changed, 88 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dvfs/riscv,rpmi-per=
formance.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/dvfs/riscv,rpmi-performanc=
e.yaml b/Documentation/devicetree/bindings/dvfs/riscv,rpmi-performance.yaml
> new file mode 100644
> index 000000000000..ec7856cb7257
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dvfs/riscv,rpmi-performance.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dvfs/riscv,rpmi-performance.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RISC-V RPMI performance service group
> +
> +maintainers:
> +  - Joshua Yeong <joshua.yeong@starfivetech.com>
> +
> +description: |
> +  The RISC-V Platform Management Interface (RPMI) [1] defines a modular =
and
> +  extensible messaging protocol for platform management functions. The s=
upervisor
> +  software can send and receive RPMI messages via SBI MPXY extension [2]
> +  or via a dedicated supervisor-mode RPMI transport.
> +
> +  The RPMI specification [1] defines performance service group (performa=
nce
> +  domain) for accessing and controlling platform-managed performance-rel=
ated
> +  resources, as implemented by a platform microcontroller. Supervisor so=
ftware
> +  can interact with the RPMI performance service group through an SBI MP=
XY
> +  channel or through a dedicated supervisor-mode RPMI transport.
> +
> +  The node is a performance domain provider. A CPU references its domain
> +  through the generic "performance-domains" property described in
> +  dvfs/performance-domain.yaml.
> +
> +  The node can also be a power domain provider, with one power domain fo=
r each
> +  performance domain. Any other device that runs in one of the domains
> +  references it through "power-domains", and each level the domain adver=
tises
> +  is a performance state of that power domain.
> +
> +  For example, with the provider labelled "performance", a CPU that runs=
 in
> +  domain 0 and a device that runs in domain 1 reference their domains as:
> +
> +    cpu@0 {
> +        ...
> +        performance-domains =3D <&performance 0>;
> +    };
> +
> +    gpu@40000000 {
> +        ...
> +        power-domains =3D <&performance 1>;
> +    };
> +
> +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +  References
> +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +  [1] RISC-V Platform Management Interface (RPMI) v1.0 (or higher)
> +      https://github.com/riscv-non-isa/riscv-rpmi/releases
> +
> +  [2] RISC-V Supervisor Binary Interface (SBI) v3.0 (or higher)
> +      https://github.com/riscv-non-isa/riscv-sbi-doc/releases
> +
> +properties:
> +  compatible:
> +    description:
> +      Intended for use by the supervisor software.
> +    const: riscv,rpmi-performance
> +
> +  mboxes:
> +    maxItems: 1
> +    description:
> +      Mailbox channel of the underlying RPMI transport or SBI message pr=
oxy channel.
> +
> +  "#performance-domain-cells":
> +    const: 1
> +
> +  "#power-domain-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - mboxes
> +  - "#performance-domain-cells"

Why is performance-domain-cells mandatory? Is it not possible for a
domain to only control non-cpu devices? If that's the case, this should
be relaxed to require that either cells property is present I think.

Also, all other rpmi/mpxy series have been written such that there's
both M and S mode bindings in a single file. Why has that approach not
been taken here?

Thanks,
Conor.

     =20
  -
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    rpmi-performance {
> +        compatible =3D "riscv,rpmi-performance";
> +        mboxes =3D <&mpxy_mbox 0x1003 0x0>;
> +        #performance-domain-cells =3D <0x01>;
> +        #power-domain-cells =3D <0x01>;
> +    };
> +...
> --=20
> 2.43.0
>=20

--gR/v5yiG/AmM4XPJ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCasdzOwAKCRB4tDGHoIJi
0uhVAP9nNf2cQXzey6OUbr27FRH3piqVaIY+SNqdVwz/4k9OhgEAgbUoO/rGaoWG
Di7inGBeW+S88LtFFpy6dE23NMe2ew0=
=ch7d
-----END PGP SIGNATURE-----

--gR/v5yiG/AmM4XPJ--
