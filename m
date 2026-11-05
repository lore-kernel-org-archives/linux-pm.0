Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793908624;
	b=GC7nJ+zGJhdn6fPVRacndpSjKxAe6bBPiFcrNm4ShT0XG4o1OsOnwTg5JFmfAh6N9jYl
	 8t5hOeswzWDVeKD350ETBVhhoV1jsRo9drBBFE3VpU+QLt/slrRIbOBaGbzQ1oiIo3dRY
	 q5XQ1Nl1/3ToDjLp6byMP5loFj+5UEHen3JiidIFrBF/mveFQTJHbBeENlwXXOlUbeJI7
	 XNVmuhfyaGLnO7Pz15t+cJw+zCF10BodDFlRkWXXUAvAWWDxvPczdhWtNvQpGJU9tthLn
	 DEWXX4rgzL7KdhtfHZKVtb3ZQPnQK1dq45uqA1Y8Iz8MYkOtEdkoWwgUa5PGV1NDcgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793908624;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=An15+6Q2vdxwWmE0oN0s91oBzGP/evs72hqZz0pEBcY=;
	b=r3KtJBTWL4DQq0ia3SOegzboF7tZ9rnzDQ+lqU+tQw8adbhsueSaPS03kuJbBXXhL0Em
	 In5P7IXeA4858e54JWSkiIRNkP+Y1prbwJyY1i5G19cScqwqTSHu+M+Tu1oHB7nWvgA7f
	 jpDBFpo4ybg81mmGo78V3Bv1FTlxEz+JBo/aJyc95vK2hWKf8OquU9gGxaIGzbtBTataZ
	 seb4FvqO734NNyxhR/ax5SSo7rrw9P61BXg00pXYwod4HPeX+IiyGn7alWVcww6ZI22zk
	 pc0AmUv9D1fevzo5VI+jCfbdHzq7t/tXFKEtVbS7xlkNBhuWISoQB78f2ZuXr+zkNsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JTscwhw+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A44606A6D3;
	Thu,  5 Nov 2026 19:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JTscwhw+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07CD71F0089F;
	Thu,  5 Nov 2026 19:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793908623;
	bh=An15+6Q2vdxwWmE0oN0s91oBzGP/evs72hqZz0pEBcY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JTscwhw+mTShBq0wph9YhJwuRM3f0Dfn1aGxn2/HpuOvvVNb84RX/BvM1kJ5Q8YhP
	 OO13lpqAXlMv/4w2WzXx/1pByWA85tnqT8UV6kDiL059H+L6z5RGOu+mQYckOAx+tU
	 AODmIzFqxR/0mr59bRm/ijv0+75m3p3ET5rRike+P+9zI1TCFNfacLiGx3sEDYpusm
	 N/7J9I0Svkhbnd12oxdQXjXVhgkO7+MOrEhSJfjpAhRuQ6cEeAXiSoCJiNCniejsym
	 2nTfqlzWg5LYotXAqsWLsMfbznpcXqTRJQzejWCBqHIqbygr8bYVfr2Ur++U4jPI74
	 lsEqriE4pYaGA==
Message-ID: <86a7f015-3b0a-4cc3-b465-0065ee7b87ec@kernel.org>
Date: Thu, 5 Nov 2026 20:56:57 +0100
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
Subject: Re: [PATCH] dt-bindings: cpufreq: qcom-nvmem: Allow generic OPP
 tables
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: Ilia Lin <ilia.lin@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261015-opp-v1-1-f18fb6f9bae1@oss.qualcomm.com>
 <20261017-calm-tangerine-marmot-2e8bfc@quoll>
 <athPyI5nvYG4vmfl@hu-varada-blr.qualcomm.com>
 <cfc75bf5-eb1c-4433-a4d0-770c56778392@kernel.org>
 <auGNhbKwIMGsOsbK@hu-varada-blr.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <auGNhbKwIMGsOsbK@hu-varada-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/10/2026 06:52, Varadarajan Narayanan wrote:
> On Tue, Oct 27, 2026 at 04:50:56PM +0100, Krzysztof Kozlowski wrote:
>> On 21/10/2026 07:38, Varadarajan Narayanan wrote:
>>> On Sat, Oct 17, 2026 at 06:45:53PM +0200, Krzysztof Kozlowski wrote:
>>>> On Thu, Oct 15, 2026 at 04:25:28PM +0530, Varadarajan Narayanan wrote:
>>>>> The OPP table node-name pattern also matches peripheral OPP tables on
>>>>> supported SoCs. However, it only handles Qualcomm CPU and level OPP
>>>>> compatibles, causing unevaluatedProperties errors for generic
>>>>> operating-points-v2 tables.
>>>>
>>>> But the select should not select them. How can I reproduce the issue?
>>>
>>> Sorry for the delay, it was a long weekend here.
>>>
>>> With the attached patch, I get the following error.
>>>
>>> $ make LLVM=-18 ARCH=arm64 CHECK_DTBS=1 qcom/ipq5210-rdp504.dtb
>>
>> OK, I can reproduce. I wonder why do we need qcom-cpufreq-nvmem.yaml in
>> the first place. It duplicates top level compatibles and opp
>> compatibles. For qcom,qcs404 it does something useful - enforces cpu
>> power supplies. But for others?
> 
> CPR capable SoCs are added to this bindings file. Not sure if all of the
> SoCs present here are CPR capable. Will have to check. However, CPR
> capable SoC like IPQ9650 might need this and will face the same issue when
> I2C or SPI opp tables are added.
> 

Only QCS404 needs it. I'll send a patch to limit the binding which might
solve your problem as well. I'll Cc you.

Best regards,
Krzysztof
