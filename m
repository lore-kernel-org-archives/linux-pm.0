Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E784C6F0A;
	Tue, 19 May 2026 12:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779192493; cv=none; b=UB5Xs3YM+mIycGql/2odFPrPzuf+dJ2cYQMe/PRM2PfUfC+YxpRxEOp9OqtLMxrN9U5lZfsRBrP1uUZG+5axFLSVrSs/jTIDnQj00YLvYLPykfVPuf4zDNflUGzx4VhDSt8mgM9yQV7qCV6b1B97Yes+G0Wk2Nar4mNVXzM+8RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779192493; c=relaxed/simple;
	bh=HOH4zolnpjz17GuZevflHD1qmQ35A3RygmEY1pWBHCQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=TGX8zVy4Botg/+ps5sJumOeQEqqbT0WSZqMSR3by7mK7EIONDKaC2+dF8lHHtLe5LS1oTClty5ywEgOhXsXuf9wnQ0UT5XLxLvVuVrwzu/gfn+1PtliWmVhHxwG1ZRb/ZOeDSUpGynS6RbXYGeQEra5B+tQVLVAnLhSU24Wp6gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=MDLo8o7h; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="MDLo8o7h"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id BDE7F27713;
	Tue, 19 May 2026 14:08:08 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HPM6vn7VwL0t; Tue, 19 May 2026 14:08:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1779192488; bh=HOH4zolnpjz17GuZevflHD1qmQ35A3RygmEY1pWBHCQ=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To;
	b=MDLo8o7hPr4AET7m7AYF//xh93Cl0MwxKi543eqRJOXBWyE8iTv4D7kzUYU9dBcq6
	 qcZSSf3ADrzc9GoNnTgHzkgiUZYsIGJoYZrPiJp54itCF0lySVkczMwPd1JadRRtsE
	 nDREAOhOjI79bJTNQCq/rETRSH24HG48Esr7qg6R3GPFB5OtbLS6KA582enf4G9iaK
	 V+hYaiqvNLsfHcWGdHQYzDrXUICAOkuj+pmeqH1OZeqsOuF9qRhuNBvCCRGRHVOVrY
	 tytRUXhWDvSfYPxTsvVBTUtN0SENIOBjxeHvmiuajPUZ5QjGDu1dWL1DsWZ1OmbrNw
	 P4cLbI8NqyU7g==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 17:37:50 +0530
Message-Id: <DIMN3D9E8YCT.3T2PGAYYB2IOO@disroot.org>
To: "Krzysztof Kozlowski" <krzk@kernel.org>, "Conor Dooley"
 <conor@kernel.org>, "Kaustabh Chakraborty" <kauschluss@disroot.org>
Cc: "Lee Jones" <lee@kernel.org>, "Pavel Machek" <pavel@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "MyungJoo Ham"
 <myungjoo.ham@samsung.com>, "Chanwoo Choi" <cw00.choi@samsung.com>,
 "Sebastian Reichel" <sre@kernel.org>, =?utf-8?q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>, "Alexandre Belloni"
 <alexandre.belloni@bootlin.com>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Nam Tran" <trannamatk@gmail.com>,
 =?utf-8?q?=C5=81ukasz_Lebiedzi=C5=84ski?= <kernel@lvkasz.us>,
 <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <linux-samsung-soc@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v6 03/11] dt-bindings: mfd: add documentation for
 S2MU005 PMIC
From: "Kaustabh Chakraborty" <kauschluss@disroot.org>
References: <20260515-s2mu005-pmic-v6-0-1979106992d4@disroot.org>
 <20260515-s2mu005-pmic-v6-3-1979106992d4@disroot.org>
 <20260515-justly-recite-6028f4bfb24a@spud>
 <DIJK5FTQ5KWG.HOKZAOXHTGU7@disroot.org>
 <20260516-esquire-chitchat-0fffa597e2f3@spud>
 <DIKZ5L2HC2CV.YL3MZUJQ2EV6@disroot.org>
 <20260517-corrode-tuesday-a598ca734b38@spud>
 <d2f4cb7d-5c3e-4b9a-86ca-04262cbb9775@kernel.org>
 <20260518-succulent-plethora-2dba60fad426@spud>
 <0240eb13-6c56-4879-8db7-b990a220a78f@kernel.org>
In-Reply-To: <0240eb13-6c56-4879-8db7-b990a220a78f@kernel.org>

On 2026-05-18 12:23 +02:00, Krzysztof Kozlowski wrote:
> On 18/05/2026 11:45, Conor Dooley wrote:
>> On Mon, May 18, 2026 at 09:15:11AM +0200, Krzysztof Kozlowski wrote:
>>> On 17/05/2026 22:52, Conor Dooley wrote:
>>>> On Sun, May 17, 2026 at 06:39:37PM +0530, Kaustabh Chakraborty wrote:
>>>>>>>>>> +
>>>>>>>>> +    properties:
>>>>>>>>> +      compatible:
>>>>>>>>> +        const: samsung,s2mu005-rgb
>>>>>>>>> +
>>>>>>>>> +    required:
>>>>>>>>> +      - compatible
>>>>>>>>> +
>>>>>>>>> +    unevaluatedProperties: false
>>>>>>>>> +
>>>>>>>>> +  reg:
>>>>>>>>> +    maxItems: 1
>>>>>>>>
>>>>>>>> Move this above the child nodes please.
>>>>>>>
>>>>>>> But properties are sorted in lex order?
>>>>>>
>>>>>> Typically the binding is sorted in the same order as properties go i=
n
>>>>>> nodes. Common stuff like reg/clocks/interrupts therefore send up abo=
ve
>>>>>> child nodes.
>>>>>
>>>>> So, do I change this? For one, I don't see the same being followed in
>>>>> other schemas of samsung in the same dir (not that I'm trying to pose=
 it
>>>>> as an argument against your suggestion), and this was reviewed by
>>>>> Krzysztof and is adderssed in v7.
>>>>
>>>> If Krzysztof doesn't care, then I won't ask you to change it.
>>>
>>> This builds on top of bindings for previous Samsung PMIC devices, so
>>> that's why it keeps the compatibles for children, I guess. No one
>>> complained about this at v1-v2 reviews, so when I joined reviewing in v=
3
>>> I did not, either.
>>>
>>> I don't think the compatible should be here, but I also don't want to
>>> stall that patchset. I understand that it is inconsistent review from m=
y
>>> side, because other similar patchsets receive comment to drop the
>>> compatible. But I don't think we will be fair asking to drop the
>>> compatible now, when we did not ask for that in the early versions at a=
ll.
>>=20
>>=20
>> I think you misunderstood, we were talking about the ordering of the
>> properties in the binding file being alphanumerical, rather than the
>> more typical approach of approximately following the order of
>> dts-coding-style.
>
>
> Ah, then I misunderstood and, even though it is a nit, I do care because
> old code is then used for new patches. Bindings follow DTS rules, thus
> should be:
> 1. compatible
> 2. reg
> 3. core properties
> 4. vendor properties
>
> Kaustabh, can you change it please?

Ack, will do that in v8 then.

While at it, do you also want me to drop the multi-led compatible string?
So it would be:

  multi-led:
    $ref: /schemas/leds/leds-class-multicolor.yaml#

>
> Best regards,
> Krzysztof

