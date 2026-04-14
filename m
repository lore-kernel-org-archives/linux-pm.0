Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038B840DFAF;
	Tue, 14 Apr 2026 12:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776170018; cv=none; b=O4XzVkBw6+KHKDQwSlEXnoc/azA+goUU2eG913W5g8y2XRVmjVNxC+IENi4nqcs0uqGOjv7bPHNlNVKL96dhLHPSu3VeS2vgG/zRFly07mr5d+yXEhmjJpUEFBi+dbVuXvOeGDtJp2OZevvhr9mPjUDT9yUlpIs3ESfgndaDlMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776170018; c=relaxed/simple;
	bh=d3bktvVna1J5QQvrEvpiMs7fPfSFe03MCbAM/nAAbGc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GaWxm5mEocu5fUrsuOKnqNo/lA6tymjpDOPe2ckutvUbqTeP8EqfC3pi7jU97oiH99tp4Z/wkUmvaM7I0nWCAhpqMRjjj5z4G6LQQLjhRiamsTgMfsVxiWNjaWw7tBwFR8D50Dv9RiePk9tAZuHv18kGQ8pt9l8ToKRATAVpmt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=kz77AKNl; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="kz77AKNl"
Message-ID: <69196110-0eff-4442-ab31-21e8e84781d8@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1776170008;
	bh=d3bktvVna1J5QQvrEvpiMs7fPfSFe03MCbAM/nAAbGc=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=kz77AKNlRM42Ei5wKqG+wr9GAcyb8/2iizonAQxHaYw7kfdWEgckgaS9Bs9bXooMs
	 nqT55MrItap3FQ65IYwKYIG9CdqS+D8KhXdVeSmEIhPPf/EGZw+ZHKeIUEolXuP1kx
	 9LQ8bDTniToDhR0NZNkX+ISN5llnL4/x0VDR82GQ=
Date: Tue, 14 Apr 2026 14:33:26 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Subject: Re: [PATCH v2 1/8] dt-bindings: thermal: amlogic: Add support for T7
To: Conor Dooley <conor@kernel.org>
Cc: Guillaume La Roque <glaroque@baylibre.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20260413-add-thermal-t7-vim4-v2-0-1002d90a0602@aliel.fr>
 <20260413-add-thermal-t7-vim4-v2-1-1002d90a0602@aliel.fr>
 <20260413-impose-cartel-bd7d18f91a24@spud>
Content-Language: en-US
In-Reply-To: <20260413-impose-cartel-bd7d18f91a24@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/13/26 5:42 PM, Conor Dooley wrote:
> On Mon, Apr 13, 2026 at 12:52:42PM +0200, Ronald Claveau wrote:
>> Add the amlogic,t7-thermal compatible for the Amlogic T7 thermal sensor.
>>
>> Unlike existing variants which use a phandle to the ao-secure syscon,
>> the T7 relies on a secure monitor interface described by a phandle and
>> a sensor index argument.
>>
>> The T7 integrates multiple thermal sensors, all accessed through the
>> same SMC call. The sensor index argument is required to identify which
>> sensor's calibration data the secure monitor should return, as a single
>> SM_THERMAL_CALIB_READ command serves all of them.
>>
>> Introduce the amlogic,secure-monitor property as a phandle-array and
>> make amlogic,ao-secure or amlogic,secure-monitor conditionally required
>> depending on the compatible.
>>
>> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
>> ---
>>  .../bindings/thermal/amlogic,thermal.yaml          | 42 ++++++++++++++++++++--
>>  1 file changed, 40 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
>> index 70b273271754b..1c096116b2dda 100644
>> --- a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
>> +++ b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
>> @@ -21,7 +21,9 @@ properties:
>>                - amlogic,g12a-cpu-thermal
>>                - amlogic,g12a-ddr-thermal
>>            - const: amlogic,g12a-thermal
>> -      - const: amlogic,a1-cpu-thermal
>> +      - enum:
>> +          - amlogic,a1-cpu-thermal
>> +          - amlogic,t7-thermal
>>  
>>    reg:
>>      maxItems: 1
>> @@ -42,12 +44,39 @@ properties:
>>    '#thermal-sensor-cells':
>>      const: 0
>>  
>> +  amlogic,secure-monitor:
>> +    description: phandle to the secure monitor
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    items:
>> +      - items:
>> +          - description: phandle to the secure monitor
>> +          - description: sensor index to get specific calibration data
>> +
>>  required:
>>    - compatible
>>    - reg
>>    - interrupts
>>    - clocks
>> -  - amlogic,ao-secure
>> +
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - amlogic,a1-cpu-thermal
>> +              - amlogic,g12a-thermal
>> +    then:
>> +      required:
>> +        - amlogic,ao-secure
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: amlogic,t7-thermal
> 
> This can just be replaced by a else I think.
> 

Thank you for your feedback, I will replace this `if` condition by an
`else`.

>> +    then:
>> +      required:
>> +        - amlogic,secure-monitor
>>  
>>  unevaluatedProperties: false
>>  
>> @@ -62,4 +91,13 @@ examples:
>>          #thermal-sensor-cells = <0>;
>>          amlogic,ao-secure = <&sec_AO>;
>>      };
>> +  - |
>> +    a73_tsensor: temperature-sensor@20000 {
> 
> Can drop the label here, it has no users.
> 

Ok, I will remove this label.

> Otherwise, seems fine.
> 
> Cheers,
> Conor.
> 
> pw-bot: changes-requested
> 
>> +        compatible = "amlogic,t7-thermal";
>> +        reg = <0x0 0x20000 0x0 0x50>;
>> +        interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
>> +        clocks = <&clkc_periphs CLKID_TS>;
>> +        #thermal-sensor-cells = <0>;
>> +        amlogic,secure-monitor = <&sm 1>;
>> +    };
>>  ...
>>
>> -- 
>> 2.49.0
>>


-- 
Best regards,
Ronald
