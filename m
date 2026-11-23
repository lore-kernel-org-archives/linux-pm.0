Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795422139;
	b=SYScUn8ROGZN5IwI4JRWKAmJacHqjidWHaPR+zXcKrfoISf1eP3yuOg+W79V8B1Keceu
	 fhfXj5KZzmq9EBM6IcT/1vmFGUU5NEMaplvRxq7j9VbcNRGU9bveeVFk6HcBKC2sn4wyR
	 7hpSQDzbQBKZgv+KoE+PrI2I6t0rbox3ic/RjEo3E5hqjrRgQSlYEK1iGV8vHemeB4mhl
	 X/5GUDfDuXlHerSIyquvrpeNeTi2Nd0O6s8A/0zf4phIbEocWZLXcXRitpgsqfBbSAKVK
	 7WwxrX+7co2zjYXi6nmUNS+4pQbPZezG3djNRqEalzZJ+sBRDvx6DQZ4/e3Nd2R25zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795422139;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:Cc:References:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=73m+z5TqVU0MAxErwiYYlUqlp41gWEEPpRofeciV0Wc=;
	b=EjriNQWBaX7ETpo9UFITjFaN/pxobf5HUAEJNf1wKs1TAPFwm8XaSk0FUeHEpfMCn+xJ
	 vevWcuMLX/wh2NNsYZJpf/2Vlwqc3PUZ66dm0pEjno1tDVbHuxxHzuR8B23osAR+65lSi
	 xSpJd9WwLKzhBxiIIu9R19HtjtaPv3JKyZj7pORDYHIMb/rSLC5BO4GEPjEI7mewMgABv
	 J2o99TT5xxjdw8NaRnZsT3XdF8YwZwJt1W7ny+aH3Nnl7ThrYppO7PN1wwUvHnmxB1VMM
	 QZrIQK3kbxcPlFEJtAkpnhkZdFBt0nn6SavrZGG9pj6xA/nOUcn0dAjYafYhwtiVoRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZpApYrM5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E03A606A31A;
	Mon, 23 Nov 2026 08:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZpApYrM5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9921F000C0;
	Mon, 23 Nov 2026 08:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795422138;
	bh=73m+z5TqVU0MAxErwiYYlUqlp41gWEEPpRofeciV0Wc=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=ZpApYrM5afsD+IbcmB492hA5DOfEhUVon0j3/JBZFxp9j9AX+e02N5MXgvunGP+XV
	 Hg7phgdkgYNN4+0O41/VM5EXvXng4LOO1WjMEY8JhQmFXj4iV8P6+UA1QIL+MKh3wM
	 DBxNltoS4ak5tZ8jCLzxn1SOGcM1h277Bg+BgUdh3UOfsLPxL1O5aAwCrquh79/Qn5
	 36OftNF2F2pXc1/jte7lhUY4RUY+zUQUxVZedg35ilImcgxAN69RBz02NIMs7FPOf0
	 8NsPrc7rV6+W9tBy4xw35BxFtVef8u0H3L181h7eLE1X0OfRlB7ytWjdfqia8jcSwC
	 KK2ROQfWnoo0A==
Message-ID: <6a0f3bf9-d3e0-465c-a12b-482b2b9a7fc3@kernel.org>
Date: Mon, 23 Nov 2026 09:22:12 +0100
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
Subject: Re: [PATCH v2 1/3] dt-bindings: power: domain-idle-state: Add
 system-state
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Maulik Shah <maulik.shah@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Kevin Hilman <khilman@baylibre.com>
References: <20261113-s2idle_state-v2-0-ad604182e7e7@oss.qualcomm.com>
 <20261113-s2idle_state-v2-1-ad604182e7e7@oss.qualcomm.com>
 <20261116-icy-free-lionfish-c3eed8@quoll>
 <d3060950-04ea-4f9b-b160-0e068946e623@oss.qualcomm.com>
 <20261123-humble-native-ibex-7d2f72@quoll>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20261123-humble-native-ibex-7d2f72@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/11/2026 09:20, Krzysztof Kozlowski wrote:
> On Tue, Nov 17, 2026 at 10:34:52AM +0530, Maulik Shah wrote:
>>
>>
>> On 16-11-2026 17:28, Krzysztof Kozlowski wrote:
>>> On Fri, Nov 13, 2026 at 10:25:25AM +0530, Maulik Shah wrote:
>>>> Some domain idle states require system-wide coordination and are not
>>>> applicable while the platform is up and running.
>>> You repeated the property description. Say something more. Why they are
>>> not applicable when platform is running? So if not running, when are
>>> they applicable? Why?
>>
>> On certain platforms CPU subsystem deepest idle state requires co-ordination with SAIL subsystem
>> such that both must be powered down in coordinated sequence. During wakeup SAIL subsystem must
>> be powered up before CPU can resume. The wakeup can take a second or more.
>>
>> Selecting this state during opportunistic CPU idle can therefore cause substantial wakeup delays and
>> repeatedly interrupt SAIL operation whenever the CPUs become idle.
> 
> The idle state latency times define that. No need for a new property.

And honestly, you already got similar review, which you just ignored.

Keep sending the same, while ignoring review, till it gets accepted -> NAK

Best regards,
Krzysztof
