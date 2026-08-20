Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A8C248896;
	Thu, 20 Aug 2026 06:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787208599; cv=none; b=i5wVeuRoNmlnW0QHy/rKypsNXWCQuaVMfvleTJwx4oKyhdbmth9z51FNwvzuhSml3ciyPgSl9uAGEg71gxjcO4EhgXhYdi7M2kchaylAf5haY79dDkkXbB5DMbD/G19F3wCZkEvV8HNkOE3qUB5gHYVONg72fV6DIvgbC+nXyRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787208599; c=relaxed/simple;
	bh=Ta/CkoczLjIHoORhvb40i+H3B47XPfAwx7N/wGjiz1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WSu80iGybPEvOQVm7lRXezLF6xPnW8qa9TVHuuIHqa2bvtDxB3+D6W/m4rod0MHkk3HetkByacje7ID4coREq3d+zB6UV+IUQMH60fuosxuDw/D+HTL2z2LuExpdA3/X/4oOABCmBNxg6+eqLPeW8EogkEpmBWhP6UqCHi+xz80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGaOAPnw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGaOAPnw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6761F000E9;
	Thu, 20 Aug 2026 06:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787208597;
	bh=+q3j/8Uj5Pt9CK1f8pR6oYJhtzbHpHZMqLityk9075Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XGaOAPnweTL9Kn92k7UV8y8uYv3K+DRedZ+8PPLLEB/nbqJJDmEMkcf0X0/Netdxd
	 PE+JGA1tlwPBQIxfi9EgeSw2sNeFTJ6jVOLbA8Oh8szNQG0mwSy90SfPRE/VIrqKq4
	 W7y437NS9p5ZUIl1jx3/qDgAogQWExdVXZYGqXcIA9mk+th4xws3wPbE97P3SxU6Bb
	 EDGXovMf32okbTXkl3hY7JCdYbcldHS8JzkLIo0p9CrSoo7qylG8MN0vtz+u+z8HUX
	 5udgjDhquQ3aZIF3HUFLCbwDew/ls8HHoaKUivdviFvBYKWHP0qmv6xolOqvHWoY5I
	 Ev34j2PJKrEsQ==
Message-ID: <7e4c40b5-e156-48fb-af0c-3c2d9271cb02@kernel.org>
Date: Thu, 20 Aug 2026 08:49:49 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: thermal: amlogic: Add A9 thermal
 bindings
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
 linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260811-a9-thermal-v2-0-7ddc33b11b9a@amlogic.com>
 <20260811-a9-thermal-v2-1-7ddc33b11b9a@amlogic.com>
 <20260813-international-optimal-limpet-dfb06e@quoll>
 <114b6c15-2975-44dd-8593-2fd23422b254@amlogic.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <114b6c15-2975-44dd-8593-2fd23422b254@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/08/2026 08:38, Xianwei Zhao wrote:
> Hi Krzysztof,
>     Thanks for your review.
> 
> On 2026/8/13 16:28, Krzysztof Kozlowski wrote:
>> On Tue, Aug 11, 2026 at 08:37:43AM +0000, Xianwei Zhao wrote:
>>> Document the thermal controller compatibles for the Amlogic A9 SoC.
>>>
>>> Describe the required "core" and "plck" clocks, add the optional
>>> "amlogic,hw-reset-temp" property, and update the schema constraints for
>>> A9-specific thermal controllers.
>>>
>>> Signed-off-by: Xianwei Zhao<xianwei.zhao@amlogic.com>
>>> ---
>>>   .../bindings/thermal/amlogic,thermal.yaml          | 28 +++++++++++++++++++++-
>>>   1 file changed, 27 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
>>> index 8cfa44dcda58..f73ee66bcc47 100644
>>> --- a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
>>> +++ b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
>>> @@ -23,6 +23,7 @@ properties:
>>>             - const: amlogic,g12a-thermal
>>>         - enum:
>>>             - amlogic,a1-cpu-thermal
>>> +          - amlogic,a9-thermal
>>>             - amlogic,t7-thermal
>>>
>>>     reg:
>>> @@ -32,7 +33,13 @@ properties:
>>>       maxItems: 1
>>>
>>>     clocks:
>>> -    maxItems: 1
>>> +    minItems: 1
>>> +    maxItems: 2
>>> +
>>> +  clock-names:
>>> +    items:
>>> +      - const: core
>>> +      - const: pclk
>>>
>>>     power-domains:
>>>       maxItems: 1
>>> @@ -52,6 +59,10 @@ properties:
>>>             - description: phandle to the secure monitor
>>>             - description: sensor index to get specific calibration data
>>>
>>> +  amlogic,hw-reset-temp:
>>> +    description: The hardware-controlled reset temperature value.
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> Thermal zones define that, not custom properties.
>>
> 
> There are some differences here. The thermal zone goes through a 
> software-controlled process and eventually triggers a restart or 
> shutdown. There is some time between the temperature reaching the 
> threshold and the actual restart or shutdown. In contrast, this 

This feels like Linux problem, not binding? Fix Linux.

> attribute configures a hardware-level protection mechanism that directly 
> triggers a restart when the temperature reaches the configured threshold.
> 
> If that's the case, do I also get it from Thermal zones?


Thermal zones define your hardware temperature constraints, not custom
properties.


Best regards,
Krzysztof
