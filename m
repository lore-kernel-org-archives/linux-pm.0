Received: from 12.546.mail-out.ovh.net (12.546.mail-out.ovh.net [188.165.57.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2942E2BDC3F
	for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2026 08:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.57.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776327930; cv=none; b=szCXylQDuBuMUoAyVonatQcUXqGgvl8ysGkq/PiszZeeT9igVoqEbS3rmk8RhPM4q8gVMttEargnKI6PH+wcaqGq1lCmQzTATdvrmcsPIE2LnVtCD4xK+VmNKAZ6DIHTLdAWl6rPB335/AFemMih+ELpY1KQNYxOmmZyp20qtQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776327930; c=relaxed/simple;
	bh=aw+BkfSLT9i7+XxykOTeoq6lWAXY6hQlNwsxo2cu4Hw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=VUzOyD/rarhxJy9IptO3tS1qN8dApa2wSGVwc0z4dJ8Ne0n7cLR2GuMI5/0TOFu54B0qvWlFKfPoM+HkxUy8oGLs7x6kjpvYlFmLqC7BSRYtE7fCg5zBQXLhgpl+MoP9hYixrJCZ1zf9Ug2J85G7A5CbngGFir81CLSBHPtE13w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (2048-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=WJj2u3Sw; arc=none smtp.client-ip=188.165.57.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="WJj2u3Sw"
Received: from ex.mail.ovh.net (unknown [10.111.174.41])
	by mo546.mail-out.ovh.net (Postfix) with SMTP id 4fxB0K1fYFz658n;
	Thu, 16 Apr 2026 08:25:21 +0000 (UTC)
Message-ID: <6fc8ddeb-d54d-473d-94d2-49dc78a07154@aliel.fr>
Date: Thu, 16 Apr 2026 10:25:19 +0200
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
To: Rob Herring <robh@kernel.org>
CC: Neil Armstrong <neil.armstrong@linaro.org>, Lee Jones <lee@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Beniamino Galvani
	<b.galvani@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel
 Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz
 Luba <lukasz.luba@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>, <linux-amlogic@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-i2c@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-pm@vger.kernel.org>
References: <20260403-add-mcu-fan-khadas-vim4-v2-0-70536b22439a@aliel.fr>
 <20260403-add-mcu-fan-khadas-vim4-v2-1-70536b22439a@aliel.fr>
 <20260415214815.GA602572-robh@kernel.org>
Content-Language: en-US
In-Reply-To: <20260415214815.GA602572-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CAS6.indiv.local (172.16.1.6) To DAG11EX2.indiv.local
 (172.16.2.112)
DKIM-Signature: v=1; a=rsa-sha256; d=aliel.fr; s=ovhex24454-selector1;
 c=relaxed/relaxed; t=1776327921; h=from:to:subject:date;
 bh=pFOmuggUuSRoz8cJkPKGP7DvDQuCHyf5KhKmxv5ivoA=;
 b=WJj2u3Sw9klNHCmqWBIBwUAd6tng48dLg+QKWHtKreX2JXQ67wigXe0TQP09NrQdmjUdwYsVTIyNXg4WsMawW2PmYK7jooYwzgx8we3T9RfQx1UZQXMpaipb4jkwQp18llokPWqyMOVBtBgrQPBrHmwTjeESar/AykfbQnBZNwp/pjzaIaW2WNcDq+ayKr+VpdIATbkHVjJTpB8++FJGaLn7Ol1tFFkyi1AGSgG98ENB42Y/mEsn2aeqTPV3QhE3SaopbBg7OcaxLDOhjq5VrsoBVb3M/ZQ9d/J23gPci+pOIg9idifu9W/UraOS+CQDDiVvyayR3TcF4gkqOf5YNw==
x-ovh-tracer-id: 11309101614479183212
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGn1Zxn7wlgRAk3Ls9HCSQIM4J7NsCvDBxD4MAUEzQ319Tl8D+J9DRCSxDWfnhZBirHrMBroybDTW/ifa7s/TX61Cq1qD7Plv4j4gqth9jElM8m8lL5uZaot7/CIcLhbmDQcxKVaGwJGKieR33WAaBijrVQPO30sMw94oTcS2ML8nPtfAsVfoiIzbsyHLnkFodLJa+IaEAujtZ7TULWFAR2dvLjd+30CuJOFupt+NPg60/KJvm8NS0WNT7b27RGiIs28KQWG7dLvMPlvP203CJnbo58FK18k6MC9luvcwxFxMp7VK/Kyynji+k+emjUreeA7ZNLd0jKJE7AShi72O9EK/Py+Qj7pqHOcFu0v99QnkqMJB32b0PzsZz78C1xa5o+Td1459KqjlMRtaidgNCiyUnIa8snrN6JAZTHZBdOpyJ1t0Qdgod0GBU+oll1AWzKYOB8WMck4/vqyf366h54XV3csqSAvMGnXmVieYrkzkzjxFkOilGcLN4Do2dalN99LVDjx3GW1UyV3b11o665Rqt4Kk8izf+4QDtdFIv/38vVISb7nnEqxHw+xQnEDwhZSW1Sh81XUad8bUy2pNAHeasPX5qPHxqLlVDYlmDV/weFzND9AK0qthn2R1CijJ4b9zO59gyCXlabD/w6m9y4Z7iNMp9G3Oyn1f7Ntu5iJA

On 4/15/26 11:48 PM, Rob Herring wrote:
> On Fri, Apr 03, 2026 at 06:08:34PM +0200, Ronald Claveau wrote:
>> The Khadas VIM4 MCU register is slightly different
>> from previous boards' MCU.
>> This board also features a switchable power source for its fan.
>>
>> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
>> ---
>>  Documentation/devicetree/bindings/mfd/khadas,mcu.yaml | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml b/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
>> index 084960fd5a1fd..67769ef5d58b1 100644
>> --- a/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
>> +++ b/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
>> @@ -18,6 +18,7 @@ properties:
>>    compatible:
>>      enum:
>>        - khadas,mcu # MCU revision is discoverable
> 
> The revision is no longer discoverable as was claimed?
> 

The firmware revision is still discoverable, and via the same register,
but the VIM4 MCU has a different register layout (eg: no DEVICE_NO
register). The new compatible is needed to describe a different MCU
variant, not a different revision of the same MCU.
I will remove the comment as it is confusing with new boards.

>> +      - khadas,vim4-mcu
>>  
>>    "#cooling-cells": # Only needed for boards having FAN control feature
>>      const: 2
>> @@ -25,6 +26,10 @@ properties:
>>    reg:
>>      maxItems: 1
>>  
>> +  fan-supply:
>> +    description: Phandle to the regulator that powers the fan.
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +
>>  required:
>>    - compatible
>>    - reg
>>
>> -- 
>> 2.49.0
>>


-- 
Best regards,
Ronald
