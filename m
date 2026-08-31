Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D668C3DCDB5;
	Mon, 31 Aug 2026 09:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788169093; cv=none; b=OZLlooq4BYH6gFpK+n7/E0A4pkTj1po6KIMhU283uPF0fS99rdkWjU3d29k7WQExKL+E6w3zTP3HU554E3OKPneKweBYw3lH7iEL5jIneajH4qFi6edOcVB3ji87vxg0PWbcNiUcp9B8QrnVC2AnikGE4DxPSdUDSqSMVWpkEu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788169093; c=relaxed/simple;
	bh=mUsRJK0Zql2DnTj0RMUi1rKBcd2MSbiWbwrzZSJC/k0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRaKU22OmUVKfmKC7nkfhGb2lJbrWO/TEh71tzT1Mg8L+vSG2hukcawuji7j8wqlgH1+Pt/9uSmL7JTskY9Vyt4pwjOKMO5GRP6xmMMaH8R5+/yjBE2x+FePJFimW7WLW9wmoJYGkcgYh9fSUa73HaQcP2XfSoy9GJPpfK/2Os8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhydDlyo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhydDlyo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7341F00A3D;
	Mon, 31 Aug 2026 09:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788169091;
	bh=3vrtIGdoWsbxbpDo+ZZza41ll94uskRK10AVMveyUHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XhydDlyoOA4iOhzTHB8rE9Z84E1B9IJxT5zfVQNsabiNJkGSb18k85PE1KV+wjtY2
	 95nyLnVQQL4MmAzIUiW7BiBElv7GNoE3UdBCWtuKOOqYn/Uwf2+PCojtD4bJSgqO0H
	 kJtYOohfie4ZU1HumC3gFLn5MYTXMuzFVDuajpbbJ/ljMLdRcDmKg89lWlIQgKAHcl
	 ozewhCv2NxjS5CZC4tNntmRAfmKyFEWxaJe3iD7AlnoTQ2HSOdxXPo3qWs5Ema6m+g
	 FWcBJ9GYolkxvFKAm8GUvcf3R8liBV8NBALfIQsinILXc+7ALBN8PWdM7Dqkul3xJG
	 pCpniz3UnONHQ==
Date: Mon, 31 Aug 2026 11:38:07 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Joshua Yeong <joshua.yeong@starfivetech.com>
Cc: rahul@summations.net, anup@brainfault.org, lftan.linux@gmail.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, ulfh@kernel.org, 
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: power: Add RPMI device power service
 bindings
Message-ID: <20260831-fluorescent-garrulous-kraken-74eecd@quoll>
References: <20260830152812.312663-1-joshua.yeong@starfivetech.com>
 <20260830152812.312663-2-joshua.yeong@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260830152812.312663-2-joshua.yeong@starfivetech.com>

On Sun, Aug 30, 2026 at 11:28:11PM +0800, Joshua Yeong wrote:
> diff --git a/Documentation/devicetree/bindings/power/riscv,rpmi-mpxy-device-power.yaml b/Documentation/devicetree/bindings/power/riscv,rpmi-mpxy-device-power.yaml
> new file mode 100644
> index 000000000000..2b7df66ba172

A nit, subject: drop second/last, redundant "bindings". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v7.1-rc7/source/Documentation/devicetree/bindings/submitting-patches.rst#L23

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/riscv,rpmi-mpxy-device-power.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/riscv,rpmi-mpxy-device-power.yaml#
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
> +  ===========================================
> +  References
> +  ===========================================
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

Why isn't this just phandle to mbox? Or even implied by mbox channel? As
your example shows, having same value in two places points that it is
redundant.

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
> +        compatible = "riscv,rpmi-mpxy-device-power";
> +        mboxes = <&rpmi_shmem_mbox 0x9>;
> +        riscv,sbi-mpxy-channel-id = <0x1002>;
> +    };
> +...
> -- 
> 2.43.0
> 
