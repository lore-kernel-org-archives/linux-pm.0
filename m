Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FFF3B5851;
	Mon, 30 Mar 2026 10:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774865829; cv=none; b=DTfNmZbuQfD5gK2j2zfe01smNSf4rKWRiITHj7lxf00sq8GriM2DwzCKf5W1X4olWoDpY92+WZvAb20c2eReNkoSuK9rSuMlt1qOAmLeRT21J5aapqYHuxEEaZvlKMwUns1g/t2MNviprKs1rh2Dl7PHisT6fn4L7zVHnpo6mPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774865829; c=relaxed/simple;
	bh=Ld452RcoZcysSZOtj4dc3NFzl6z2qkqiQf9JTGIWh+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZUqft/z4p6taPwbUxADrjnmcUNLYQApAwKKikAAFXsDo2mp8kFn3A2yq/XogxSW7nCkI122hap+KqpufECqTUGRyp9TaWMdn99UW8DDNm9UwVjbmJ37WGTMR+BYtXR4RYBLYann09BQSZdIIbbVjsxSCZWeR7ZMmjPY8v+eQDPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvqtXA6d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvqtXA6d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC56C4CEF7;
	Mon, 30 Mar 2026 10:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774865828;
	bh=Ld452RcoZcysSZOtj4dc3NFzl6z2qkqiQf9JTGIWh+E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bvqtXA6dLvhwezPZmIJ0BTx+QIjqitUxW7MB1yqUdBERW0dlaXG+dLxgS8Weuu3OF
	 WaW0Zj9o/iFSeD6jTU1RYLQK3I7lfoNhfwDJNofeRse9SICqEMf+WkO+6u9rZwMUVP
	 ora99Q38ZS8/9PlUEutANYeRVsYnXSKwvCSAYHZ56cYAx8OAHY9RFlKxcWjW2D/nTK
	 dXfldU6hak5U4jmeKiTpkXFPt7HUB3iiNJobN60AyPVC3L8DVCd879AVTnBO3oKkgu
	 yEfzzj/nnXOK4UXDggh+mOPhRa+EyLh9SerjlHzbzbm0DhzjyEbr5QdLUqL9s3zS8v
	 Wb7Yg0C105Ljg==
Message-ID: <3bb6b71e-947b-4248-95ba-79852f743c1d@kernel.org>
Date: Mon, 30 Mar 2026 12:17:03 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v8 00/10] pmdomain: samsung: add support for
 Google GS101
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>, Peter Griffin <peter.griffin@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>,
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>
References: <20260318-gs101-pd-v8-0-241523460b10@linaro.org>
 <177409907930.268981.5882592990447577348.b4-ty@b4>
 <CAPDyKFoz-sm0pfvn5iSYFY0mrW38vaGRZsFvrVPqsv7BsYxeWQ@mail.gmail.com>
 <1fbf5c54-8793-4585-be33-ded77019adb2@kernel.org>
 <CAPDyKFrK3NLwaii-9FEmyaTzUAuVkMkLL3rWBQwQvT-M+PzEHA@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <CAPDyKFrK3NLwaii-9FEmyaTzUAuVkMkLL3rWBQwQvT-M+PzEHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 30/03/2026 12:13, Ulf Hansson wrote:
> On Mon, 30 Mar 2026 at 11:54, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 23/03/2026 12:13, Ulf Hansson wrote:
>>> Hi Krzysztof,
>>>
>>> On Sat, 21 Mar 2026 at 14:18, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>>
>>>>
>>>> On Wed, 18 Mar 2026 15:27:45 +0000, André Draszik wrote:
>>>>> This series adds support for the power domains on Google GS101.
>>>>>
>>>>> There are a few differences compared to SoCs already supported by this
>>>>> driver:
>>>>> * register access does not work via plain ioremap() / readl() /
>>>>>   writel().
>>>>>   Instead, the regmap created by the PMU driver must be used (which
>>>>>   uses Arm SMCC calls under the hood).
>>>>> * DTZPC: a call needs to be made before and after power domain off/on,
>>>>>   to inform the EL3 firmware of the request.
>>>>> * power domains can and are fed by a regulator rail and therefore
>>>>>   regulator control needed be implemented.
>>>>>
>>>>> [...]
>>>>
>>>> Applied, thanks!
>>>>
>>>> [01/10] dt-bindings: soc: google: add google,gs101-dtzpc
>>>>         https://git.kernel.org/krzk/linux/c/10084aeadadfab72648f6ed1cc78f7cd87b861ba
>>>> [03/10] dt-bindings: soc: samsung: exynos-pmu: move gs101-pmu into separate binding
>>>>         https://git.kernel.org/krzk/linux/c/3ec3c42b426fe5e2b48ff19c551dec50bc78788c
>>>> [04/10] dt-bindings: soc: google: gs101-pmu: allow power domains as children
>>>>         https://git.kernel.org/krzk/linux/c/c8229a5160eea145b796f54317d6e659cec9b080
>>>>
>>>> Best regards,
>>>
>>> Usually I pick up the power-domain related changes for the DT bindings
>>> and host them via an immutable branch called "dt". If needed, SOC
>>> maintainers can pull it to apply/test the corresponding DTS changes.
>>>
>>> That said, I am open to whatever you think is best here. Perhaps it's
>>> easier if you can drop the DT patches and provide your acks instead or
>>> if you can share them via an immutable branch for me to pull?
>>
>>
>> I did not pick up any pmdomain binding patches. I picked up only soc and
>> according to cover letter there are no dependencies between anything here.
> 
> As I understand it, they are all related and some even depend on each

I raised exactly that questions but no answers.

> other. I think keeping all four DT patches together makes sense.

Why? What is the dependency?

> 
> Although, as I said, if you think it's best to funnel them through
> your tree, please do and then share them via an immutable branch, so I
> can apply the pmdomain driver changes.

soc must go via my tree, but there is no reason to take the pmdomain
binding patch. So I did not take.

But anyway, I just noticed that I dropped everything: this introduces
new warnings which were nowhere addressed or explained. So regardless
how this should go, please do not apply anything - it's broken and
author is silent.


Best regards,
Krzysztof
