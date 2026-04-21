Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC5C3B3BEA;
	Tue, 21 Apr 2026 09:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776764737; cv=none; b=SvJb9GCraHwi8ioSgbLly96tvpicR7jz+lGRwHSiOlFVNiOaVK66Txwpx4iY5fTL/NydEuU2h9871FMX7TCeTi975rfusa0gMs9PCdnKyLLhH2TOxAYVTWJaLRjH5PrbB+MEByfbUb7AC+dBy+EsGXWyT8Vxg9mbMEADcGAYveY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776764737; c=relaxed/simple;
	bh=+pWxADjbyAE/GMK2ZySAS6xYdGVF6YeiaKrsK83rTTA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Me6RuVEYgZZP/0hHmp1oGH+N30GFkWDVxn+afb1j6VtPXIOHA9+HCFRghZuUvvNIW5LluGCCp52GhvjxZex2FLfVi5IdKT82aRYuHxZM1CObyDJB+zoNDmdd44X7Wg7k8KM7WEf1YqERYk2V5jl4jMnVF0Aq+mkPuYfPNKqpXuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=iQmmBRGa; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="iQmmBRGa"
Message-ID: <ff92f28b-8ffa-4ba1-ae7b-a825e4d15fc2@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1776764715;
	bh=+pWxADjbyAE/GMK2ZySAS6xYdGVF6YeiaKrsK83rTTA=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=iQmmBRGaq5waN8O2LVDi0CcM0VTSK51R0OKI1Ib0sy8pkN8F9eb9++2ERvr5CIIPu
	 iBPR37EhhrZ9A0CWJc8nE4TkVU93cDwAWESd9TIensXbcEOotRQW4kvCwLFan2dkEM
	 oMPFdQL6jlayPuV93MbhCCKqvDX95/9lb8ScWH9o=
Date: Tue, 21 Apr 2026 11:45:13 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Subject: Re: [PATCH v3 1/8] dt-bindings: mfd: khadas: Add new compatible for
 Khadas VIM4 MCU
To: Conor Dooley <conor@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
References: <20260417-add-mcu-fan-khadas-vim4-v3-0-a6a7f570b11b@aliel.fr>
 <20260417-add-mcu-fan-khadas-vim4-v3-1-a6a7f570b11b@aliel.fr>
 <20260420-viable-plot-862e0c545837@spud>
Content-Language: en-US
In-Reply-To: <20260420-viable-plot-862e0c545837@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/20/26 6:22 PM, Conor Dooley wrote:
> On Fri, Apr 17, 2026 at 06:27:17PM +0200, Ronald Claveau wrote:
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
>> index 084960fd5a1fd..a80718f7595ce 100644
>> --- a/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
>> +++ b/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
>> @@ -18,6 +18,7 @@ properties:
>>    compatible:
>>      enum:
>>        - khadas,mcu # MCU revision is discoverable
>> +      - khadas,vim4-mcu # Different MCU variant, not discoverable
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
> 
> Can you limit this by compatible please?
> pw-bot: changes-requested
> 

Thanks for your feedback, I will add that.

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
