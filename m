Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904872;
	b=1lDZemIfuzpPW/3OzhaBepa2u9Udy/W2Yppkbm6SOcNlpdu3ennNpoV7lJ+rg5jcjT+6
	 YSB6IfJB1Nj7RzvXKSSAH95mKEy93Xzy6D0+aYc0SxrvhZzLLNsw5D5u31LQv0iEwAsw3
	 Uf1oWJQZ7jfoJDj/kQiGIXj7RkfTb2gfVDoXbcWAFoB91pXrkHL+9/T0IUoAhCojRPXf0
	 oWTyAv3m8xfrBKoUR2h6PtPO9X9YpeUpuIdbGBywqiiVL7KwlyA/hDCV9w3tWz6m8qYxk
	 5xU+HqdXldhQQOl5oK9Mjo2Dz1RGnLdKVlel5H9z2XPGGtKrWJ80yrzmnNN6cTgP2SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904872;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=UdclqZLMN8B5DrcYZKdaCch6tVOM2QIot5gM9jwffKU=;
	b=4kXY2fb3rn30U7StfZ6Iswu7cPY0FjEe1u8ptsQ02enPttYIHCsnsiIbGoVUfV/H5T53
	 /w2Ea2Nw3yoWLLVwYckzZQ4SWYa9E5uE/EEdGkZq+UW059/lmphW2yfopOFq58/SIkxNE
	 eFcLifWWZtu4oT5zfv9meTHMEtKF9L4Jc/4XTkZVLeFEJg1uTUSArHFqGbRIJDyDnGG+U
	 ZjI03UvdRj1knBrw5fYY3+/aiFOIE8WzsmhDFlYEufG/xbOAkBWOpxSIraz9t+NzezTC6
	 BhSFuM6yVaqFRJGAEOsXVym/dVzC8GLK5WOA7LmaEVldUIJxyTEpx9luniih9BVaCzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WCGjVmcZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6947A606A326;
	Thu,  5 Nov 2026 18:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WCGjVmcZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644061F00919;
	Thu,  5 Nov 2026 18:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793904872;
	bh=UdclqZLMN8B5DrcYZKdaCch6tVOM2QIot5gM9jwffKU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WCGjVmcZqY+BxtWg2dhw9Yy/V28eGIQkYuKoqsLQHtRAz3NuW7BuFuJhFX91MZ4X3
	 i+mXrBQDbjXs9GjdrptYpEkMcV0ei6Nh8X5wz0Y5junD0G0NmwtDTZoA+wjkW9Fvxt
	 nq3prAoEKk5RRGTz+tVQ1OGsn9QN5zeNJBf6LEVqxC5hyTnwE3krNryI2JJ3ke1T1w
	 WYSQdSuDuIT/NFIXh3zy4RhkSXPmeeycjljDpdg8jGDH4BjzeDUAKO+yhYYSPyqFKP
	 wKvdi8U7kCCZIFXadRTf1TQu+3DUjZNU7i1MpETgQwh932OpQzbfbnqNWVR7UJANRV
	 C07pmgQ+1uU3w==
Message-ID: <d4a430de-715a-4936-8adb-35ff57a52b5f@kernel.org>
Date: Thu, 5 Nov 2026 19:54:22 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] dt-bindings: soc: google: Add Google Tensor CPM
 binding
To: Brian Norris <briannorris@chromium.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Thomas Gleixner <tglx@kernel.org>,
 Ulf Hansson <ulfh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Peter Griffin <peter.griffin@linaro.org>, devicetree@vger.kernel.org,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Radu Rendec <radu@rendec.net>,
 linux-arm-kernel@lists.infradead.org,
 Mariano Marciello <mmarciello@google.com>,
 Douglas Anderson <dianders@chromium.org>, linux-clk@vger.kernel.org,
 =?UTF-8?Q?Jakub_G=C5=82owacki?= <jglow@google.com>
References: <20261026214359.3122870-1-briannorris@chromium.org>
 <20261026144346.2.Ib692ddd35c1dbea1757d9b1db6c1c7e938fc4ea6@changeid>
 <20261028-rapid-daffodil-rat-0adc6a@quoll> <aulIoq2oVjJ3DVzL@google.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <aulIoq2oVjJ3DVzL@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/11/2026 03:36, Brian Norris wrote:
> On Wed, Oct 28, 2026 at 02:19:23PM +0100, Krzysztof Kozlowski wrote:
>> On Mon, Oct 26, 2026 at 02:43:40PM -0700, Brian Norris wrote:
> 
>>> --- /dev/null
>>> +++ b/include/dt-bindings/interrupt-controller/irq-cpm-google.h
>>> @@ -0,0 +1,16 @@
>>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>>> +/*
>>> + * This header provides constants for CPM IRQ.
>>> + *
>>> + * Copyright 2025-2026 Google LLC
>>> + *
>>> + */
>>> +#ifndef _DT_BINDINGS_INTERRUPT_CONTROLLER_IRQ_CPM_H
>>> +#define _DT_BINDINGS_INTERRUPT_CONTROLLER_IRQ_CPM_H
>>> +
>>> +#define CPM_IRQ_RTC_ALARM_NO			0
>>
>> Keep naming consistent. Clocks has _CLK suffix, so this should not use
>> prefix.
>>
>>
>>> +#define CPM_IRQ_AOC_MIN				7
>>
>> Anyway, ABI constants should be indexed from 0 and incremented by 1.
> 
> What do you mean by this? Do I need to make up names for the
> unused IDs between 0 and 7? On an initial search, I don't believe they
> have any meaning at all. Does that mean I should make up some kind of
> "RESERVED_<N>" naming here?

No, I meant CPM_IRQ_AOC_MIN is 1.

> 
> Between 7 and 156, these are just ... 150 different "service numbers"
> within the AOC (Always On Connectivity) subsystem. I can name them
> AOC_0, AOC_1, ... AOC_149 if that helps.
> 
> Or are you suggesting that I pack the actual use cases (so, 0 and 7-157)
> into 0-151? I thought it was valuable to directly use the firmware
> indexing where possible; if I change those, then the indexing loses its
> inherent meaning, and we also have to add another layer of translation.

We do not use hardware numbers as bindings and ABI, because that's
pointless - no benefits, only risks. Similarly you do not define GIC
interrupt numbers, pinctrl pin numbers, MMIO addresses as bindings. None
of these bind anything between DTS and software, so not a binding.

There are some exceptions like SCMI firmware, but that's not the case here.

> 
>>> +#define CPM_IRQ_AOC_MAX				156
>>> +#define CPM_IRQ_AP_GDMC_WAKE			157
>>> +
>>> +#endif  /* _DT_BINDINGS_INTERRUPT_CONTROLLER_IRQ_CPM_H */
> 
> 
>>> --- /dev/null
>>> +++ b/include/dt-bindings/soc/google,lga-lpcm.h
>>> @@ -0,0 +1,54 @@
>>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>>> +
>>> +#ifndef __DT_BINDINGS_SOC_GOOGLE_LGA_LPCM_H
>>> +#define __DT_BINDINGS_SOC_GOOGLE_LGA_LPCM_H
>>> +
>>> +/*
>>> + * LPCM IDs of each SSWRP.
>>> + */
>>> +#define LGA_LPCM_CPM			0
>>
>> What are all these?
> 
> The binding doc says:
> 
>       Each reset is specified by an LPCM ID (cell 1) and a reset ID (cell 2).
>       See <dt-bindings/soc/google,lga-lpcm.h> for LPCM IDs and
>       <dt-bindings/reset/google,lga-cpm-reset.h> for reset IDs.
> 
> and
> 
>       Each clock is specified by an LPCM ID (cell 1) and a clock ID (cell
>       2). See <dt-bindings/soc/google,lga-lpcm.h> for LPCM IDs and
>       <dt-bindings/clock/google,lga-cpm.h> for clock IDs.
> 
> These are the IDs used in the firmware interface to talk about these
> things, as many of the SoC resources involved (clocks, resets, power
> domains) are grouped in this way (by subsystem (SSWRP / LPCM), and then
> with indexing within each subsystem).
> 
> In reading again, I see that the definitions and explanation of these
> terms and the SoC organization are split a bit between the pmdomain
> commit message and the binding doc. Where would you prefer I elaborate
> more? In the binding doc, the comments here, or both?

I just try to understand their placement. Bindings should not be in the
soc directory, except a few things without clear subsystem owner. If
this applies for both clocks and resets, maybe this could be firmware,
but another point is that you should not need these in DTS. Somehow you
split one clock/reset ID into two - LPCM ID and clock/reset ID. Just
don't, unless you want to say that for example LSION_CLI16_UART_CLK is
in multiple LPCM places?

Best regards,
Krzysztof
