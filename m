Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794218805;
	b=TPHPdzifQ7vZ23WA+gf1bNVGsFaXibfmVPT164BvRTHATTBcw8E7GLRuZdyyk0VTuiUe
	 3CG9HD41343YlhLkzSRTh9I9d3/rFYF+0OFB1o9cf2cN+MpGQKG8Qn5PaL1mzJvx/G2kP
	 DdQdWMHzadgg5sn1ZBS/gFpxB91KPyS1TPHFdja6dY2aohnb+FHUpgRBbM43KPX/TvnlR
	 egs0diFm0CKbpjc7yPx/VgBYkP3V1JeVV8EP2cZOjsS9F9Hwv6HgtlaQe9BuH/EBRNoPD
	 KRdNpAzSXzrqDNACSplE8OYz+3k1+v+EIXJjtKEVhHomuJhmQYCfL0FW+70vYmgIEuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794218805;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=8w4ouvn8GAV3fcHokFzFm1nhmbZuRMSblkfq3Ny21VM=;
	b=wGvUcMBPXRzt7ZQLPo2Mv+zz0vU8VVvYa6bST4cK9yBnuh7+E8+k/KCrVf2SRVH3HXhD
	 wEOfIfN5sxeIUaqWiI1qL/vvPPAkHabxLFberg7lZ/OOycrG7N68VvALSLY3wmwZ1zyif
	 YnVhUBQNcFHhNO+yNvmqv3PrDdemhrYIvw8pbLryaQorvjLprBEd0mZQOE0FAZZOOZUQE
	 Q3vuZxh0DGWmYLUYNM7dCbRhkEg5qILHv+jVB0VejjucWC2CgyTs3z9ULFueAXtXGoCuE
	 JPh0vg7Dvpocg+q4SZ711oqHzN5iuwBsEDB4wAh/MA6U9SSejIVojUrigRNcrt5Lw0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ozGw+CCs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D51606A321;
	Mon,  9 Nov 2026 10:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ozGw+CCs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FB91F0089F;
	Mon,  9 Nov 2026 10:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794218804;
	bh=8w4ouvn8GAV3fcHokFzFm1nhmbZuRMSblkfq3Ny21VM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ozGw+CCs2dwrEqQXpZ6bC52PnXO0aaKwY0bVubxDrDy/7IGPG3nuFY8sg1V4ELuGX
	 tqExMyCubR8D8Pu6Djc5xNYXblC0emOLA6FxMqkrFj5KcsW6RTmHmSFbeB2+oSV7eK
	 V68U07qFmhkvTR8YDUq8FFP/X8AHDp5UDQf+HlP9t/xymhpDWYSTr5xLsnJJDZZzTQ
	 dA6zz4VGVef0hCvfnm1UH2MO0YsNm+6QHjVBFpLxvLop39Z2QNRVvXhy6HxCe5RYxC
	 3auwWQTi7V0LsVynqdiIo/4e0rHX+FGrl3QkLqg28cKrGqavCdL0vAkWY49ot7Qwrr
	 wYApfAIv+3zvA==
Message-ID: <d16585cc-44bb-4f8d-9853-a67cb63d49b3@kernel.org>
Date: Mon, 9 Nov 2026 11:06:39 +0100
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
Subject: Re: [RESEND PATCH 1/3] power: supply: max17040: pass the device
 fwnode to the power supply core
To: Hugo Karlsson <huggek@klattorp.se>, sre@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 matheus@castello.eng.br, me@iskren.info, m.szyprowski@samsung.com,
 clamor95@gmail.com, sebastian.reichel@collabora.com
References: <20261108154241.198160-1-huggek@klattorp.se>
 <20261108154241.198160-2-huggek@klattorp.se>
 <3b4d9f8a-2b5b-49c6-a2fa-666548029975@kernel.org>
 <b7672bea-edea-40e2-a4b9-b06d026265a1@klattorp.se>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <b7672bea-edea-40e2-a4b9-b06d026265a1@klattorp.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09/11/2026 09:53, Hugo Karlsson wrote:
>  > Please run scripts/checkpatch.pl on the patches and fix reported
>  > warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
>  > patches and (probably) fix more warnings.
> 
> Thanks, sorry in regards to that. I ran both, the only findings are
> for the "Assisted-by: " line, which checkpatch does not recognise
> ("Non-standard signature" and "Unrecognized email address"); --strict
> reports no checks on the code itself
> 
> It seems it was removed in 1e035297ffda at the 13 October as Sebasation 
> could just drop it on the applied series, but that´s maybe something I 
> need to do myself and send a patch v2? Or is that just cosmetic?

It's cosmetic, please drop assisted-by if you send v2.

Best regards,
Krzysztof
