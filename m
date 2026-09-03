Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C3E18DB2A;
	Thu,  3 Sep 2026 06:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788417586; cv=none; b=BSF0RRR/YG5uu5ac86zN8WjsZfftNv5J0s6oMTBhs5q3UukigqU3ep18piXYev1sHUFE22i23WZ9ElS9Jt+2dib5tszHLc0uoRPBcZ7J9+oDoQmOUG8ZpaXuI6gvvAd9hNcTb2exzaLosH0o7cfhS/yxfIIt2KPoLQprjIvu4o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788417586; c=relaxed/simple;
	bh=9GpIj4ykMY5ePFG7wgCRhkjr8Tcs0fAGCtsV/XoHgf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NYRznVue2DxFRnnz2PB4SKe2a2HW9f4MiTM2ANrqGfcL59yD3Ya7RUqyeQGWdPqGjuPC5HvYIhkvwX7lOGwZbGMFGKMzEeOVHuiO9WfiBQS8I8GmAyXbWKCMmwaTprxvIsZBMh5OabUJKgunUjisv38rjJKjweOkn+Q9SHJ0faQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ad8Va8n1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ad8Va8n1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE821F00A3A;
	Thu,  3 Sep 2026 06:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788417581;
	bh=VPF7B3LTWDh/DW091/duRLfEkzauv9zKTVocOUIbt2k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ad8Va8n198IM2BqiMBl+Tai2HZgE8nxKlvdU1Z5QL4kw+gclDPq8ZlV2dJqBTBwbW
	 3f2RZTQR8+W0h0x17wktNc+rIeU6r65KreIQp/wzjJVRwHeHaiZgsJTaB9uc6qbCe0
	 g6fPjGM6//2biDjUHi+s99Fq/QPu1l5WE4fiGXeLWvlcQEAYdhF1Mu1aqBg96oomyM
	 xGoLpaZtZyqLnVO5bbNDIxFK5OzGcqcl1xg69uNwbS7epKB/u3hAywhHlzYpW4fV2O
	 O/odLtTKigUjPLXBmmoqjAJJkOYzkNnCRRwRYKnyHe/LVUfdC/cpK8k0a12PiGz0yI
	 TdgClfCBimyxg==
Message-ID: <85401168-1372-4904-b3af-cfcb837947db@kernel.org>
Date: Thu, 3 Sep 2026 08:39:33 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: power: Add RPMI device power service
 bindings
To: Joshua Yeong <joshua.yeong@starfivetech.com>
Cc: "rahul@summations.net" <rahul@summations.net>,
 "anup@brainfault.org" <anup@brainfault.org>,
 "lftan.linux@gmail.com" <lftan.linux@gmail.com>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "ulfh@kernel.org" <ulfh@kernel.org>, "pjw@kernel.org" <pjw@kernel.org>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
 "alex@ghiti.fr" <alex@ghiti.fr>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260830152812.312663-1-joshua.yeong@starfivetech.com>
 <20260830152812.312663-2-joshua.yeong@starfivetech.com>
 <20260831-fluorescent-garrulous-kraken-74eecd@quoll>
 <BJXPR01MB08380868E1DE7029DC52AB06F9B72@BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <BJXPR01MB08380868E1DE7029DC52AB06F9B72@BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/09/2026 13:30, Joshua Yeong wrote:
> On Mon, Aug 31, 2026 at 11:38:07AM +0200, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> On Sun, Aug 30, 2026 at 11:28:11PM +0800, Joshua Yeong wrote:
>>> diff --git a/Documentation/devicetree/bindings/power/riscv,rpmi-mpxy-device-power.yaml b/Documentation/devicetree/bindings/power/riscv,rpmi-mpxy-device-power.yaml
>>> new file mode 100644
>>> index 000000000000..2b7df66ba172
>>
>> A nit, subject: drop second/last, redundant "bindings". The
>> "dt-bindings" prefix is already stating that these are bindings.
>> See also:
>> https://elixir.bootlin.com/linux/v7.1-rc7/source/Documentation/devicetree/bindings/submitting-patches.rst#L23
>>
> 
> Ok, I will drop the redundant "bindings" word in v3.
> 
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/power/riscv,rpmi-mpxy-device-power.yaml
>>> @@ -0,0 +1,65 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/power/riscv,rpmi-mpxy-device-power.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: RISC-V RPMI device power service group based message proxy
>>> +
>>> +maintainers:
>>> +  - Joshua Yeong <joshua.yeong@starfivetech.com>
>>> +
>>> +description: |
>>> +  The RISC-V Platform Management Interface (RPMI) [1] defines a
>>> +  messaging protocol which is modular and extensible. The supervisor
>>> +  software can send/receive RPMI messages via SBI MPXY extension [2]
>>> +  or some dedicated supervisor-mode RPMI transport.
>>> +
>>> +  The RPMI specification [1] defines device power service group for
>>> +  accessing and controlling the power state of platform devices managed
>>> +  by a platform microcontroller. The SBI implementation (machine mode
>>> +  firmware or hypervisor) can implement an SBI MPXY channel to allow RPMI
>>> +  device power service group access to the supervisor software.
>>> +
>>> +  ===========================================
>>> +  References
>>> +  ===========================================
>>> +
>>> +  [1] RISC-V Platform Management Interface (RPMI) v1.0 (or higher)
>>> +      https://github.com/riscv-non-isa/riscv-rpmi/releases
>>> +
>>> +  [2] RISC-V Supervisor Binary Interface (SBI) v3.0 (or higher)
>>> +      https://github.com/riscv-non-isa/riscv-sbi-doc/releases
>>> +
>>> +properties:
>>> +  compatible:
>>> +    description:
>>> +      Intended for use by the SBI implementation.
>>> +    const: riscv,rpmi-mpxy-device-power
>>> +
>>> +  mboxes:
>>> +    maxItems: 1
>>> +    description:
>>> +      Mailbox channel of the underlying RPMI transport.
>>> +
>>> +  riscv,sbi-mpxy-channel-id:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>
>> Why isn't this just phandle to mbox? Or even implied by mbox channel? As
>> your example shows, having same value in two places points that it is
>> redundant.
>>
> 
> They look alike but they are in different namespaces, so the two values
> are not the same number. In this node "mboxes" points at the RPMI shared
> memory transport, whose #mbox-cells is 1 and whose cell is an RPMI
> service group ID 0x9 for device power. "riscv,sbi-mpxy-channel-id" is
> the SBI MPXY channel number that the SBI implementation then creates for

But SBI MPXY is also a mailbox, so you are encoding mailbox channel with
a different property.

> that service group. The node therefore describes a translation
> rather than a duplication, consume RPMI service group 0x9 on the
> transport and expose it to the supervisor as MPXY channel 0x1002.
> 
> The 0x1002 that does appear twice is spread over two nodes with two
> different audiences, sitting under two different mailbox controllers:
> 
> 
>     rpmi-shmem@12c10000 {            /* RISC-V machine mode only */
>             compatible = "riscv,rpmi-shmem-mbox";
>             reg = <...>;
>             #mbox-cells = <1>;
> 
>             power-domain@9 {         /* read by the SBI implementation */
>                     compatible = "riscv,rpmi-mpxy-device-power";
>                     mboxes = <&rpmi_shmem 0x9>;
>                     riscv,sbi-mpxy-channel-id = <0x1002>;

... so 0x1002 is:


>             };
>     };
> 
>     sbi-mpxy-mbox {                  /* RISC-V supervisor mode only */
>             compatible = "riscv,sbi-mpxy-mbox";
>             #mbox-cells = <2>;       /* cells: channel_id, MSG_PROT_ID */
>     };
> 
>     rpmi-device-power {              /* RISC-V supervisor mode only */
>             compatible = "riscv,rpmi-device-power";
>             mboxes = <&sbi_mpxy_mbox 0x1002 0x0>;

exactly this, no?

>             #power-domain-cells = <1>;
>     };
> 
> A phandle from the supervisor node to power-domain@9 would resolve its
> "mboxes" to the shared memory transport, which is not something the
> supervisor can drive. The windows are owned by machine mode and the
> only RPMI mailbox Linux implements is "riscv,sbi-mpxy-mbox". The
> supervisor reaches the platform controller through the SBI MPXY extension and
> that ABI addresses channels by number, so the channel id has to survive
> as a plain integer on both sides of the SBI boundary.
> 
> You can have a look at the diagram in RISC-V ratified specifications in
> https://github.com/riscv-non-isa/riscv-rpmi/releases/tag/v1.0 -> riscv-rpmi.pdf
> in Figure 2 High Level Architecture.
> 


Best regards,
Krzysztof
