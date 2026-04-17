Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62DE35E944;
	Fri, 17 Apr 2026 09:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776418321; cv=none; b=N4kGM9eWW+DWDdqDQeVwl4PyghjQocSNKRqzwvLYdRWii+A6IvL5JHXxx9cpsd2oy6OeauVnE3HVCeXJ00M7DncYYAKj3ADoIAV9xtXt4qukxfD4IbY6cfRs7KbLIn6EJ9fL44GEbzappZnybN/wUwHUAFTVLfO7moVWabTg/Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776418321; c=relaxed/simple;
	bh=k2/NtjpEqjtp2ZMPsfxKYGQQDyh1+0ETw/LyMjy9rUk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bTBH5UYdj0Y+c64d80/6yvEjnxzu6DtERTIPUQT9IHESuE3hGfVWQ3K9TR4H+v3+W//IoWG5xK4HN92z9+pexQQlSMGzaxwi2EPUO2gPdYa/OLglVQEvUItkt3F4OrzvRMDq8j/0WL3u5HZ3PPT3Gt6YBz2Rwr05O563T3DW10I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=tLkFPJYl; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="tLkFPJYl"
Message-ID: <5514acb2-f4cd-499d-aabd-8f5d7a311be0@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1776418310;
	bh=k2/NtjpEqjtp2ZMPsfxKYGQQDyh1+0ETw/LyMjy9rUk=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=tLkFPJYlW4M7Y+rvGQG9WBzFs13d68haPvQJ2LRKkkR/r5yeZdVM953uDuGHwnlky
	 FXxNU8iXJ26PB2EBBuzXfCF0KMhhYWBcsHlmtVA8KBa+FEO7Crv69u8/mLOcwjzoWT
	 KKtDdFdd+ts0aTqVaEGF2HTGwIjAYuwvZ59WyfWs=
Date: Fri, 17 Apr 2026 11:31:49 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Subject: Re: [PATCH v2 1/8] dt-bindings: mfd: khadas: Add new compatible for
 Khadas VIM4 MCU
To: Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, linux-amlogic@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org
References: <20260403-add-mcu-fan-khadas-vim4-v2-0-70536b22439a@aliel.fr>
 <20260403-add-mcu-fan-khadas-vim4-v2-1-70536b22439a@aliel.fr>
 <20260415214815.GA602572-robh@kernel.org>
 <6fc8ddeb-d54d-473d-94d2-49dc78a07154@aliel.fr>
 <6758aaa2-ac1a-4751-aece-2b445b84f2bc@linaro.org>
Content-Language: en-US
In-Reply-To: <6758aaa2-ac1a-4751-aece-2b445b84f2bc@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/17/26 9:53 AM, Neil Armstrong wrote:
> On 4/16/26 10:25, Ronald Claveau wrote:
>> On 4/15/26 11:48 PM, Rob Herring wrote:
>>> On Fri, Apr 03, 2026 at 06:08:34PM +0200, Ronald Claveau wrote:
>>>> The Khadas VIM4 MCU register is slightly different
>>>> from previous boards' MCU.
>>>> This board also features a switchable power source for its fan.
>>>>
>>>> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
>>>> ---
>>>>   Documentation/devicetree/bindings/mfd/khadas,mcu.yaml | 5 +++++
>>>>   1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
>>>> b/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
>>>> index 084960fd5a1fd..67769ef5d58b1 100644
>>>> --- a/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
>>>> +++ b/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
>>>> @@ -18,6 +18,7 @@ properties:
>>>>     compatible:
>>>>       enum:
>>>>         - khadas,mcu # MCU revision is discoverable
>>>
>>> The revision is no longer discoverable as was claimed?
>>>
>>
>> The firmware revision is still discoverable, and via the same register,
>> but the VIM4 MCU has a different register layout (eg: no DEVICE_NO
>> register). The new compatible is needed to describe a different MCU
>> variant, not a different revision of the same MCU.
>> I will remove the comment as it is confusing with new boards.
> 
> Yes basically it was discoverable for earlier MCU version, but is not
> for this particular board version.
> 
> Keep the comment, but add a comment on the vim4 entry saying this variant
> is not discoverable.
> 
> Neil
> 

Ok make sense, I will do that.

>>
>>>> +      - khadas,vim4-mcu
>>>>       "#cooling-cells": # Only needed for boards having FAN control
>>>> feature
>>>>       const: 2
>>>> @@ -25,6 +26,10 @@ properties:
>>>>     reg:
>>>>       maxItems: 1
>>>>   +  fan-supply:
>>>> +    description: Phandle to the regulator that powers the fan.
>>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>>> +
>>>>   required:
>>>>     - compatible
>>>>     - reg
>>>>
>>>> -- 
>>>> 2.49.0
>>>>
>>
>>
> 


-- 
Best regards,
Ronald
