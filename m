Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3FD3655E4;
	Mon, 31 Aug 2026 16:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788194503; cv=none; b=dOU6DNhgKAKuwvxtx3aUkw50Ey6IXzRx7dZbhinZXsrTvflqmFZ/YwWttzE5t7dxzsQmFC7qpVH+9nfKLHC7f5/kd5CqxXpaxE3rR37LX0qlQEfaH77L4XyC2fgiHeTYHcgdtef/zUzFdfzA9WJIytarB3VO4tTp6xeaRU8ZDH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788194503; c=relaxed/simple;
	bh=1YHVgaIhVDUEhOG2pgPD2/BeAnB6kBQa9SFrIeJWuI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKRZoYkciUXyBOKahm8YxaYmYCPdFR+ZpqnBJXqvEmuRN8tsTYiF+ioYD0xLz2200hLbtFdcVMxGSuSEf/T0zP+AzSya/YoHUijUv02nQhLjDnmOaTQEVadPI0jVsMq9gEnpQMYxAXVq+hzQjo6ykzSEh3ewLnqyV2cFHEoKleA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hlw5yJ+g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hlw5yJ+g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E3A1F000E9;
	Mon, 31 Aug 2026 16:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788194501;
	bh=KbeZZ7+hcGKd4km3JCmhGTKowXSg86VoMpeJipGz+MU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Hlw5yJ+gOXKIm+3VfgLM4h6EAJt3OwhEx2su6JcoATyMt4L9mxuCNXJsgWyeSwndr
	 CnLi5FqM3xN3mUR3g7RjYuo+amUpC5cOz8fEedb6Am1cfI7jhSQ4tzX3DMOCYdXoT+
	 c7eFPVQVrVm4r6YkLMsFmC1WLZbclY2APzYhkIyFQ7mULYNijiFJpGHrrj7vA/t4I/
	 YJdrH9CHqOc6I0oef/xP24SgSupHClwszspUBmtvOorS8ZC8VFsyXb9f8UNjF4HvsY
	 ISgmykVEOM+OHYZjNX2MgwOlVSgNLdYrNrrRTTnVQ+L0oMNaCaiDEYEmjTbBqGd8Jn
	 SExECFwiNCP7Q==
Date: Mon, 31 Aug 2026 17:41:36 +0100
From: Conor Dooley <conor@kernel.org>
To: Joshua Yeong <joshua.yeong@starfivetech.com>
Cc: rahul@summations.net, anup@brainfault.org, lftan.linux@gmail.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	ulfh@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr,
	linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: power: Add RPMI device power service
 bindings
Message-ID: <20260831-squeamish-pulverize-7e8334767707@spud>
References: <20260829205520.1691-1-joshua.yeong@starfivetech.com>
 <20260829205520.1691-2-joshua.yeong@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2QJMYTI2ERRE10FT"
Content-Disposition: inline
In-Reply-To: <20260829205520.1691-2-joshua.yeong@starfivetech.com>

--2QJMYTI2ERRE10FT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2026 at 04:55:18AM +0800, Joshua Yeong wrote:
> Add device tree bindings for the RISC-V Platform Management Interface
> (RPMI) device power service group, both for the supervisor-facing power
> domain controller and for the SBI MPXY channel which the SBI
> implementation uses to expose the service group.
>=20
> Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>

Carbon copy of the clock bindings, right?

This stuff is past the stage of being frozen I assume? Github is
currently being slow as molasses for me and I cannot load the links.

If so
Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

Cheers,
Conor.

> ---
>  .../power/riscv,rpmi-device-power.yaml        | 65 +++++++++++++++++++
>  .../power/riscv,rpmi-mpxy-device-power.yaml   | 65 +++++++++++++++++++
>  2 files changed, 130 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/riscv,rpmi-de=
vice-power.yaml
>  create mode 100644 Documentation/devicetree/bindings/power/riscv,rpmi-mp=
xy-device-power.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/power/riscv,rpmi-device-po=
wer.yaml b/Documentation/devicetree/bindings/power/riscv,rpmi-device-power.=
yaml
> new file mode 100644
> index 000000000000..5afdc40df7e0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/riscv,rpmi-device-power.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/riscv,rpmi-device-power.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RISC-V RPMI device power service group based power domain control=
ler
> +
> +maintainers:
> +  - Joshua Yeong <joshua.yeong@starfivetech.com>
> +
> +description: |
> +  The RISC-V Platform Management Interface (RPMI) [1] defines a
> +  messaging protocol which is modular and extensible. The supervisor
> +  software can send/receive RPMI messages via SBI MPXY extension [2]
> +  or some dedicated supervisor-mode RPMI transport.
> +
> +  The RPMI specification [1] defines device power service group for
> +  accessing and controlling the power state of platform devices managed
> +  by a platform microcontroller. The supervisor software can access RPMI
> +  device power service group via SBI MPXY channel or some dedicated
> +  supervisor-mode RPMI transport.
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
> +    const: riscv,rpmi-device-power
> +
> +  mboxes:
> +    maxItems: 1
> +    description:
> +      Mailbox channel of the underlying RPMI transport or SBI message pr=
oxy channel.
> +
> +  "#power-domain-cells":
> +    const: 1
> +    description:
> +      Platform specific DOMAIN_ID as defined by the RISC-V Platform Mana=
gement
> +      Interface (RPMI) specification.
> +
> +required:
> +  - compatible
> +  - mboxes
> +  - "#power-domain-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    power-controller {
> +        compatible =3D "riscv,rpmi-device-power";
> +        mboxes =3D <&mpxy_mbox 0x1002 0x0>;
> +        #power-domain-cells =3D <1>;
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/power/riscv,rpmi-mpxy-devi=
ce-power.yaml b/Documentation/devicetree/bindings/power/riscv,rpmi-mpxy-dev=
ice-power.yaml
> new file mode 100644
> index 000000000000..2b7df66ba172
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/riscv,rpmi-mpxy-device-powe=
r.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/riscv,rpmi-mpxy-device-power.ya=
ml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RISC-V RPMI device power service group based message proxy
> +
> +maintainers:
> +  - Joshua Yeong <joshua.yeong@starfivetech.com>
> +
> +description: |
> +  The RISC-V Platform Management Interface (RPMI) [1] defines a
> +  messaging protocol which is modular and extensible. The supervisor
> +  software can send/receive RPMI messages via SBI MPXY extension [2]
> +  or some dedicated supervisor-mode RPMI transport.
> +
> +  The RPMI specification [1] defines device power service group for
> +  accessing and controlling the power state of platform devices managed
> +  by a platform microcontroller. The SBI implementation (machine mode
> +  firmware or hypervisor) can implement an SBI MPXY channel to allow RPMI
> +  device power service group access to the supervisor software.
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
> +      Intended for use by the SBI implementation.
> +    const: riscv,rpmi-mpxy-device-power
> +
> +  mboxes:
> +    maxItems: 1
> +    description:
> +      Mailbox channel of the underlying RPMI transport.
> +
> +  riscv,sbi-mpxy-channel-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      The SBI MPXY channel id to be used for providing RPMI access to
> +      the supervisor software.
> +
> +required:
> +  - compatible
> +  - mboxes
> +  - riscv,sbi-mpxy-channel-id
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    device-power-service {
> +        compatible =3D "riscv,rpmi-mpxy-device-power";
> +        mboxes =3D <&rpmi_shmem_mbox 0x9>;
> +        riscv,sbi-mpxy-channel-id =3D <0x1002>;
> +    };
> +...
> --=20
> 2.43.0
>=20

--2QJMYTI2ERRE10FT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCapWuwAAKCRB4tDGHoIJi
0qjTAP9LJfBoXWTp5spj+xWhnI1+nc0iTLQo47IGSxWkoIis7gEA662EtseuouP5
8OlHNKK8t9DevUKH7F8NK/2HmABkLQI=
=CLai
-----END PGP SIGNATURE-----

--2QJMYTI2ERRE10FT--
