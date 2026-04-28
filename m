Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E94843C047;
	Tue, 28 Apr 2026 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777388996; cv=none; b=JFF5478XoK2Xxw1H3hTgav6D/fOMMn2ktB9HVXDF6dgHPCsPM/D+3u6muW2jB+rNkpBiiDJ4hI2jqYlIrbU5MGkGmSuUQp/xX+l5Ww30kVXDzSq9MULkfswE9TvamwyiEafN9tlX/DwHb2604sFOCyIjqmfOD0rVsXH+vOF9ezo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777388996; c=relaxed/simple;
	bh=6Wn5RlgVJ7Tb8uQ9GRdxiAw+akTPiDx9gaJheqB2gfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RMud+rC+lvY3vDcDxMG3VHB4Cx6iq+jinmdyXqlj2cNlGU+c7WTpVkY3lM/FwADEIC+Uu4eP4K2PlkQrhsXHNbEXFIIiKxj9HITQXePo70JStLM4iNB0oSa6bX81n0FFSvvRYrTodfIoGpVrqV1tEHfgWooPboDPM3Qcxy8HO1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pw5gTGfa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pw5gTGfa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A36C2BCAF;
	Tue, 28 Apr 2026 15:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777388995;
	bh=6Wn5RlgVJ7Tb8uQ9GRdxiAw+akTPiDx9gaJheqB2gfw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Pw5gTGfaVCzIb3NLSczGXOmu2MwATrBI5cEWgRCc2w92/GygUUobT0mRn64L/X/Zs
	 qL6dFgnUIkx9mP+TQRkDEVfv+WW3EnvTQZazvLidM7wsmxVWxSbAytDQEVxoWqsrDL
	 IkRQXgQ0hVysvPXX/tY1rzl/mmqoZIauopLlq+SH/qdS0YrA8qKN4M5qTRJiI8HOc8
	 73zugE83OnDvWOVHOGUbym0Pmi4wQHdJiAZYvzAaa5yn0g5i1bLjV7QOUIBYQjHejp
	 k1Jrk2OmAqJSPtxblv8DnAEFPZiuyWPCoamTTAz7g7iigCvul345fPPKc5jMxHNqvM
	 xRp8CUvhuNtEQ==
Message-ID: <534f0795-0002-4c04-a83c-fa1b3ce68216@kernel.org>
Date: Tue, 28 Apr 2026 17:09:49 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: power: supply: sgm41542: document
 sgm41542
To: Chris Morgan <macromorgan@hotmail.com>
Cc: Chris Morgan <macroalpha82@gmail.com>,
 linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 xsf@rock-chips.com, sre@kernel.org, simona@ffwll.ch, airlied@gmail.com,
 tzimmermann@suse.de, mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 jesszhan0024@gmail.com, neil.armstrong@linaro.org, heiko@sntech.de,
 conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org
References: <20260427170914.5062-1-macroalpha82@gmail.com>
 <20260427170914.5062-2-macroalpha82@gmail.com>
 <20260428-bulky-nebulous-reindeer-ed45ed@quoll>
 <PH0PR19MB997338F0B06B7B99AA0ED3C6C4A5372@PH0PR19MB997338.namprd19.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <PH0PR19MB997338F0B06B7B99AA0ED3C6C4A5372@PH0PR19MB997338.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/04/2026 16:09, Chris Morgan wrote:
> On Tue, Apr 28, 2026 at 09:47:00AM +0200, Krzysztof Kozlowski wrote:
>> On Mon, Apr 27, 2026 at 12:09:09PM -0500, Chris Morgan wrote:
>>> From: Chris Morgan <macromorgan@hotmail.com>
>>>
>>> Document the SG Micro sgm41542 battery charger/boost converter.
>>>
>>> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
>>> ---
>>>  .../supply/sgmicro,sgm41542-charger.yaml      | 99 +++++++++++++++++++
>>>  1 file changed, 99 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/power/supply/sgmicro,sgm41542-charger.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/power/supply/sgmicro,sgm41542-charger.yaml b/Documentation/devicetree/bindings/power/supply/sgmicro,sgm41542-charger.yaml
>>> new file mode 100644
>>> index 000000000000..3e5041e5b551
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/power/supply/sgmicro,sgm41542-charger.yaml
>>
>> Filename must match compatible.
> 
> Acknowledged.
> 
>>
>>> @@ -0,0 +1,99 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/power/supply/sgmicro,sgm41542-charger.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: SGM41542 Battery Charger
>>> +
>>> +description: |
>>
>> Do not need '|' unless you need to preserve formatting.
>>
> 
> Will fix.
> 
>>> +  The SGMicro SGM41542 is a single cell battery charger/boost controller.
>>> +
>>> +maintainers:
>>> +  - Chris Morgan <macromorgan@hotmail.com>
>>> +  - Xu Shengfei <xsf@rock-chips.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: sgmicro,sgm41542
>>> +
>>> +  input-current-limit-microamp:
>>
>> Missing vendor prefix.
>>
> 
> This *appears* to be a standard value (perhaps not formally, but in use by
> enough devices to suggest a defacto standard), which is why I did not use
> the vendor prefix here. Do I need to add that for this one?

I know, I found these other properties but I think they were just coming
from old schema.

If it is really a common property, then should be defined in a common
schema and this did not happen.

> 
>>> +    description:
>>> +      Optional value to clamp the maximum input current limit to for
>>> +      the device. If omitted, the default value for the hardware will
>>> +      be used (2400000).
>>> +    minimum: 100000
>>> +    maximum: 3800000
>>> +
>>> +  input-voltage-limit-microvolt:
>>> +    description:
>>> +      Optional value to clamp the maximum input voltage limit to for
>>> +      the device. If omitted, the default value for the hardware will
>>> +      be used (4500000).
>>> +    minimum: 3900000
>>> +    maximum: 12000000
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  monitored-battery:
>>
>> You miss definition of this property. I guess this is power supply, so
>> reference proper schema for power supplies. Look at other bindings to
>> for some example code.
> 
> I'll look at this some more, I might have a few more questions. But I will
> make the changes requested.
> 
>>
>>> +    description: |
>>> +        A phandle to a monitored battery node. Values for the following
>>> +        are used by the driver and if not present will result in default
>>> +        values being applied:
>>> +        constant-charge-current-max-microamp
>>> +        constant-charge-voltage-max-microvolt
>>> +        charge-term-current-microamp
>>> +        precharge-current-microamp
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  regulators:
>>
>> No need for regulators node, just define here otg-vbus directly. But
>> honestly, your example is incomplete or you defined something implied by
>> the compatible. If you have a fixed 5V regulator, what is the point of
>> defining it in the DT?
> 
> The regulator can be adjusted within a range around 5V, and is referenced
> by the USB subsystem. Should I still omit it from the device tree or instead
> define the min and max values?

If it can be adjusted then it's fine, can stay.


Best regards,
Krzysztof
