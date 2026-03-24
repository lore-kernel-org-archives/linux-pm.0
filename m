Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CC63DB633;
	Tue, 24 Mar 2026 09:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774344484; cv=none; b=EPVnIiThQmsJyifuUFAkE3Cqz6Lv9YsfTbP9ZymNi2aewa+WvqKPqyHapFfT0I5D/6MIbeKt8j18qHLA69+DRMagLXMuUmYQJemNN0PC0W5AF8toWRW9SZVfjs1ykRHV+zmKWU1r/k4qRu3fPbuQIuB0P2MYKQlaVZTPW0LD+As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774344484; c=relaxed/simple;
	bh=2Y5b9Y+8gqbYvolqCw34mtuwtxhdkLrG8o8Cc94yDPE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ncq5JhRI3pVIZFQy3WaGB9bNYAEMWg9Ud6hVFFQMpr/pes0O3DVwsC1/lnfdzwHgn7QOjaJflA4udYg/ZDz0qY9EZeqHR3r0XlbwgnI8F9EfLW110V+VEZj3TQBHbegdALMTSvwjCBPDKG/6aK92tilj6tqw+1Dc05EW8aG1dWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIRNtBSE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIRNtBSE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5D8C2BC9E;
	Tue, 24 Mar 2026 09:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774344484;
	bh=2Y5b9Y+8gqbYvolqCw34mtuwtxhdkLrG8o8Cc94yDPE=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=FIRNtBSEhsKoOFvOH6ZknX/vnKSD/XmryGY01s7+QKF30s4vvgCt/l4TpMZLCq0q9
	 r6CaEedoEIrD0WRNRamxXlxoDRgPTyICskpKPyBMFNfO37Mprza0QxzrGliBJv6lnb
	 HQI1lY0YsZBNHXTrVJ0QYJGp1AptoE6nV1owVtJmYVIhJqcOJ3qfrUidorStBwpxVp
	 2bVk2reThcTZxcaqhfGFLyXQApK8GgTZRmztvuraMGJw1Cv0LovJyxRmAQqi249WiU
	 7f27EDmvXcbgbDpTHHTG5VRVv1MiNyvu61QEbzOCbuHuBFXu9E7xJgV1x23NNt0Kj9
	 FImVA4NufxBGA==
Message-ID: <de289d93-c1f9-4fe9-ac86-5dd13b869d06@kernel.org>
Date: Tue, 24 Mar 2026 10:27:58 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ARM: dts: st: spear: fix dtbs warning on spear
 thermal sensor
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Gopi Krishna Menon <krishnagopi487@gmail.com>
Cc: rafael@kernel.org, daniel.lezcano@kernel.org, rui.zhang@intel.com,
 lukasz.luba@arm.com, robh@kernel.org, krzk+dt@kernel.org,
 vireshk@kernel.org, conor+dt@kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev,
 daniel.baluta@nxp.com, simona.toaca@nxp.com, d-gole@ti.com, m-chawdhry@ti.com
References: <20260323133814.14152-1-krishnagopi487@gmail.com>
 <20260323133814.14152-3-krishnagopi487@gmail.com>
 <20260324-smoky-radical-hyrax-1274a9@quoll>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20260324-smoky-radical-hyrax-1274a9@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/03/2026 10:26, Krzysztof Kozlowski wrote:
> On Mon, Mar 23, 2026 at 07:08:09PM +0530, Gopi Krishna Menon wrote:
>> Running DTBS checks on st/spear1340-evb.dtb results in the following
>> warning:
>>
>> thermal@e07008c4 (st,thermal-spear1340): Unevaluated properties are not allowed ('thermal_flags' was unexpected)
>>   from schema $id: http://devicetree.org/schemas/thermal/st,thermal-spear1340.yaml
> 
> How is it possible if there is no such file?
> 
> Did you just add new warning in patch #1 and then claim in patch #2 that
> you fix it?
> 
> You completely miss the point why this change is needed: how could the
> DTS work before? It could not. And that should be your justification for
> the patch, with explanation why it could not work.

... or you would notice that code was working and this part is just
redundant. Then fix would be completely different, though.

Best regards,
Krzysztof
