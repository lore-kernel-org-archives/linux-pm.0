Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793605229;
	b=ZCofa6FyHdqodi26jT5ycr7WbF09jGqBk7anPjqLcqTuUyJcI31ZLsCl4KrsJyMa7N+X
	 TxDK1CIbY2ygCfcKLfUln55SVXm20K66/W1CeY1Y8UPLOfrmCNgNF3hE9e7nr9mLKhico
	 Kno75NPy25jjeyh8PnC4rcVGIS65/hp9rwJhWHXxlsUMcMbu7f507I4iSrQO1+SkFQZyq
	 F7jyvkk/NQyF/fTiyA0I8KpAz5Skk+aI+or3GvB5XiOKbj0CG8Ft/nQF/60xcLFnGdVJc
	 yf15ps3620+gfI8sh+kYW3YB2kNMeN/RI5k0DyHsgY0hUCYHRAJg2rc9zCKkylfYkMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793605229;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=KcTB0FSdieALLEtzQ3OvHWQhboJsqvbWGd/BgRl3cB8=;
	b=uyYAe80W+gaOCOAivM4JEpXhzbmrJNhVt846j1pU0feXlIGqLS32+msTgS+A4OxlYLTq
	 4ZBa2J+xeEoc+tLXzCthdw0OOFV4AVBqjNFjc7eY1WPsbETwrureFtJUjPJsyrXcq6pdL
	 brm45/uVvCt97/gODv1gSGMmIizTi5uhjlTPehFPPEsAlVm9Gq3zfaFDmcFnGhcOp4wfD
	 Fzc5VdQs6Cy4NFWt8vVp4a3AnrC+NeysFcSod0HFFf1C+qJqegH/hmEi64agYbt8azspw
	 FN6l+Gzrg8VdNl6u5TrLTpSG9syAVaHf3sWTlCV0m6TSkGCW8eHEPS/VeCrbISx+qjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ibYyg+gf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26157606A326;
	Mon,  2 Nov 2026 07:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ibYyg+gf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA601F000C1;
	Mon,  2 Nov 2026 07:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793605228;
	bh=KcTB0FSdieALLEtzQ3OvHWQhboJsqvbWGd/BgRl3cB8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ibYyg+gfiuBYC5XPW6RPIPgSO2rnDRlkxOnjFYYsWj4FGUuiq4Fr24RuJDK1fV8+w
	 9aasGac12GpzHeufE7vF3WfHtlnjIlkPZFhP7hyDLVhIScDjW1EegSd2irfMyR0ZLv
	 u+fTY4FwSc/JgCPwFol6vVnwdHFGrSQWsVquhWJiPrC2SPv4/VOWBSu4v9VByBF6EF
	 YXAJHyCQD/66PH143yj/a+cXmBL0U7semGncKiA3ntbyiZS5qpRgeBjizHGKeGa5KN
	 W+Ut4MkLVfPkvn6cJ1Kga9WQM9gRVSuZKtFCKdsumDYMse7Bzcc/v7KgJ08Slde/Gt
	 JIu9nAgQTXm4g==
Message-ID: <4d021a7f-59cc-4077-9d9b-e4d4cb72dd97@kernel.org>
Date: Mon, 2 Nov 2026 08:40:23 +0100
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
Subject: Re: [PATCH 2/2] power: supply: max17040: fail probe when requesting
 the alert IRQ fails
To: Jianing Li <m13940358460@163.com>, Sebastian Reichel <sre@kernel.org>
Cc: Iskren Chernev <me@iskren.info>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Matheus Castello <matheus@castello.eng.br>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261102073148.1233-1-m13940358460@163.com>
 <20261102073148.1233-3-m13940358460@163.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20261102073148.1233-3-m13940358460@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/11/2026 08:31, Jianing Li wrote:
> MAX17048 and MAX17049 skip polling work initialization when an IRQ is
> available because SOC alerts replace polling. If requesting that IRQ
> fails, max17040_probe() clears client->irq and returns success anyway.
> The driver then has neither an interrupt handler nor a polling worker.
> 
> Clearing client->irq also makes the suspend and resume callbacks take
> the polling path, which operates on an uninitialized delayed work item.
> 
> Propagate the IRQ request error instead of registering a device with
> inconsistent interrupt and polling state. The managed resources unwind
> the already registered power supply and, for polling models, cancel any
> queued work.

That's LLM commit msg and you are not suppose to use LLM for that.

Best regards,
Krzysztof
