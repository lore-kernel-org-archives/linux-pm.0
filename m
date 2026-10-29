Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793267834;
	b=qbYfB4a8DaqVza6CbLJvOuVMjLlSQBOVpIl0IT7y9iyww8JP50TV6Oz6PXcA8ZZJLM2v
	 ShcnF4GQWez4kLMmk/cXyh5DTW5lF2uXroYoijLJWGaQzJXLVbzd29dIBCfMPlivx3+7z
	 UV5WAa0Q86p9f8UnemprAR0UJjaNv/pMlaENImk9wK4TsoK+YdZmsSU6PMbvnyu7l9hwQ
	 7vERVFSa1iU9qEZb1KKfIM3/FxKOufYynWj3qKp5MSK+0WGrF3n+Hqi7mOX/Gm1aJ4S3q
	 9q+NEgJDMji653+nWZzMMy/lkhrmLhw2ACOa4ltgA/JrpbHpZbJfzEabwXZrv5VqznA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267834;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=YmRNAxJyESE0wnkrH6TNuhWwf1OgBNeC7IIYTZSjnoc=;
	b=oBnL4bRwk7FjRo9C91+T3UirrB5LDEaIubqIHNKxitlKDJHbTmQ5Vhe+pFhkT7k3wVX4
	 y2xPxOPGIfHnrUkZENmXsMVL8+5AYmI0p359xbrGI8DGCFIKwDVvIjYUa7/1VeLZZr0lt
	 DXQAgpN5ehbexijA9QF4XnVhLKnzh1HbTbilsmJEDGfYu91U+I7ipoSWQmjCLxVbXUHAD
	 kt55gP8tqcApX40UrUJRHXS/o/58pwPhlkYPK4EdyxHUiut5Fdz5L3uAVFcwDJVicK7SD
	 BeElZMIVgm0wORxGQDVR747uwZNr6AqWuexlV4cZIfvJRtkU8osIxWxwhX9oYLTLMsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cy8ylQ8v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F112606A320;
	Thu, 29 Oct 2026 09:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cy8ylQ8v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32301F031E1;
	Thu, 29 Oct 2026 09:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793267834;
	bh=YmRNAxJyESE0wnkrH6TNuhWwf1OgBNeC7IIYTZSjnoc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=cy8ylQ8v4phJB4hT+VhHaRbMuQJj1trYWzmGrogeRwpFbbV9XhMq/T/5Ny70VWoDp
	 Ix8hAUY0gIhzvykVQwFo/mLWpnw7l7YWJusqwWWmbdPcij7ukHsAUXAHEQnwRqgLj0
	 XeUzAcqVBzG/Dt7yw2iRJE/yt/sDa1Scc5iy1yh398uT8vkPKKgBBSMYwO+QRw+gVS
	 ALp6EZfns8A5kA9g5AYeiVM06za+BSKwVmeg4QO3/ZhfPFeriOu/elHIUxPflZT8PA
	 54CvwuRWJ4/JzQ+8kVbIeZl3O1A9AtbLrwKO3YTBqNC78jBPTo8Dtvy65G9tySlCRQ
	 kT47aoNiIFOBg==
Message-ID: <f3790c3a-c85c-42e0-98c8-2f3826002e2d@kernel.org>
Date: Thu, 29 Oct 2026 09:57:08 +0000
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
Subject: Re: [PATCH v3 1/3] dt-bindings: clock: qcom,camcc-sm8250: add
 interconnect provider
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Atanas Filipov <atanas.filipov@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Bjorn Andersson
 <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Jonathan Marek <jonathan@marek.ca>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Gjorgji Rosikopulos <gjorgji.rosikopulos@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261016170701.1504338-1-atanas.filipov@oss.qualcomm.com>
 <20261016170701.1504338-2-atanas.filipov@oss.qualcomm.com>
 <20261020-bloodhound-of-remarkable-debate-11afe3@quoll>
 <7ca815b3-4712-42e4-996d-4a1e53cad492@oss.qualcomm.com>
 <Sm-FvdxaOiXpzzGo30wECHdQF_-LtUaJCO3mGpBUxXfnVCYjOLE5DhNWdNmOMhYdkR1RMXhPzWuHhsZJkJ_Vzw==@protonmail.internalid>
 <20261028181040.3515955-1-atanas.filipov@oss.qualcomm.com>
 <f0618a27-cee2-4f39-a578-fcbf3c51607a@kernel.org>
 <zBYtlR-V2ox_dnVeOSMcJzI4WLeTqBjFSbrCEqJyODXGG08DlsA7SBaYHmy3vaaNIZWyv15641UejQAsYoLnHA==@protonmail.internalid>
 <uqtvrqp7rsmxcloz2fgzv2jbcofd3x7y6hm6plnan5mao4t5rr@6lxub7q3duti>
From: Bryan O'Donoghue <bod@kernel.org>
Content-Language: en-GB
Autocrypt: addr=bod@kernel.org; keydata=
 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
In-Reply-To: <uqtvrqp7rsmxcloz2fgzv2jbcofd3x7y6hm6plnan5mao4t5rr@6lxub7q3duti>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/10/2026 01:50, Dmitry Baryshkov wrote:
>  From my PoV, CAMNOX_AXI, is just the same NoC clock, just not being
> wired through RPM/RPMh. From this point of view the clock can be
> described as as an interconnect, it gives correct abstraction: no matter
> how the camera blocks are connected or how the connection between them
> is managed in hardware / firmware / clock devices, there is a bus (aka
> interconnect) between those camera blocks. If at some point the clock
> becomes managed by RPMh, it won't (significantly) change the hardware
> description

yeah I think it should be an icc provider - perhaps interconnect nodes 
make sense, not for one clock but for a number of clocks and components 
in the system JPEG, ICP voting on the bandwidth/clocks.

TBH my point here is more we need to soak up the CPAs clock logic in an 
putative cpas_icc_set() routine since I'm... as sure as I can be that 
icc_set_bw() on its own and CCF can't really capture that logic.

---
bod
