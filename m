Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793905025;
	b=qmvp0LGC81d2okCHK4oUVKLq09ySukuyfrVgoTSlcfNKkjbhWzFA+gBj3lp6cr2IF0wR
	 kshRs/sf2/Ddf+oB7BGmeMRTgxE9JD0RGHIhSc/b3qQd/TIFbZqbNYiL29ZCYiOI+Wv/u
	 z8GOlyIyy4w1vV8Gpaqyxbke2e0Hv9FAolcpGreAiXBi2AuZYHmpN0u+9HILll0W4UkKn
	 gDtz6qggA8urRQInpVM5RMiH9y24lb/CtKZ3YdwgQOIwpWK1JWR8olYLxBQURko0FMYq1
	 IgYEB3MTHsJLQZvsQ4SIGbQblot9EwwFHv7Cxb7c8pQaDIpK9mS+TLPxNYFeZBqt0qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905025;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=WQ9sffyuRp/irYxXc7dRPeziYbjvSyitG8dEJ6yeqEg=;
	b=TssEsm2WRLgvOoh7e3GIcFoDmxN5cKqge227ploT94et4jkwvnBnzb8AI2JUVkIE38El
	 faCxr4h2N20tGtvJ3xmpOe0lhwjunCfSm9jq8brjCLNlnqunml8RvmiS0V6HtxNuj5+JB
	 ljJBn6h3jFM6VonBg8OmDY4sBDlrsNKGe9a/ERgMsVQdkti2inyvNyZh1uQPJFcY1kfl9
	 s2l4K0vrvd/WvwJGxuELcolMv8Wc6XU23GcSGwLAoX26ObleltJ/GQuem4v6ZNXfff2x7
	 tDylc6XC/4/KTEb4culLsQnXopw135RlVNmC1fmxSI+JkZxnlvpbdaEbhL+M+yFMyRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nSRL7qeZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B877E606A31B;
	Thu,  5 Nov 2026 18:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nSRL7qeZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3C31F00919;
	Thu,  5 Nov 2026 18:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793905024;
	bh=WQ9sffyuRp/irYxXc7dRPeziYbjvSyitG8dEJ6yeqEg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nSRL7qeZefZsFlhbewfbotp8isdhCFKOicgcQPuFTjUejyFw8L89bYizUJWdyBeeX
	 DSl3dtsx64ZntdIq0Euec2b587YGxISmGsI+JBa80+upYr7n0EMYVeA6a87B4QpCib
	 E4DlTWWHYVyAyF6o6QGbkxDvFJhiEfXmvA6ZDQrse+l0HP0KWkyhM/XEHlkp/0+qDO
	 uPv/qhdVQp7R8IMPu0vCr4Pnz6mLKt2wblai4ewjnD0U48c/s+Tyqm2tfW35BuFrqu
	 qLfEWbX+bBsVRRzhWsEVR6+tFQgbtuJHbwMC6YtW+xyLsNiqQIDSbGocuQxtu3JRt8
	 GfRbkJEVmHNow==
Message-ID: <4e393e6f-34d4-4d8d-a12a-270aea843f17@kernel.org>
Date: Thu, 5 Nov 2026 19:56:53 +0100
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
Subject: Re: [PATCH 0/9] google: Add support for Laguna CPM
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
 <20261028-armored-glistening-cheetah-6f3070@quoll>
 <aulBrFWi54E6a7Br@google.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <aulBrFWi54E6a7Br@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/11/2026 03:06, Brian Norris wrote:
> On Wed, Oct 28, 2026 at 02:24:35PM +0100, Krzysztof Kozlowski wrote:
>> Either you expect review or not. RFC means no.
> 
> OK, PATCH.
> 
>> If that's patch, then at
>> the top level of cover letter, as the most important thing, you explain
>> the dependency and merging proposal of this.
> 
> OK, I'll try to move it up. To be fair though, every change that has any
> dependency is clearly noted in its below-the-fold notes.
> 
>> You combined here like 5
>> different subsystens...
> 
> What do you recommend here? I believe the general principles of DT
> binding development suggest there should be a single binding doc for
> describing the "Central Power Manager" (and the services it supports).
> CPM supports functionality covered by many subsystems.

Standard upstreaming process for new SoCs.
https://lore.kernel.org/linux-samsung-soc/CADrjBPq_0nUYRABKpskRF_dhHu+4K=duPVZX==0pr+cjSL_caQ@mail.gmail.com/T/#m2d9130a1342ab201ab49670fa6c858ee3724c83c

and the perfect example:
https://lore.kernel.org/all/20231121-topic-sm8650-upstream-dt-v3-0-db9d0507ffd3@linaro.org/

> 
> While in theory, bindings can be written without corresponding software
> support (drivers), in practice it usually works out better to develop
> them together, to prove that the binding describes the hardware/firmware
> sufficiently.
> 
> And even if the binding goes separately, I don't think I can 100% split
> the driver support by subsystem, as they all require the same underlying
> CPM helpers, and those helpers don't have much meaning without their
> clients. So some multi-subsystem work is still necessary IMO.
> 
> So I don't really see how I can address your complaint. But I'm open to
You don't know how to split patchset per respective subsystems? Somehow
Linaro, Qualcomm and many other people managed to do that, so just ask
them. Linaro folks might be easiest to reach, through Peter Griffin for
example.


Best regards,
Krzysztof
