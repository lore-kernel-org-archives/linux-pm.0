Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116637;
	b=226wDvF/8N5DfSfrD435mhJ+PWow3OPVkFatGJyJC0Dcc3OEijijglp3OC9T/IUrJHk1
	 CWUlfQXF142L08vjBUWa89Tk3LN1KG8CP2xgjhrpleRsrOpCiHi3PvJvRAhCxi41Y8Mp6
	 KsuNirH35YmvHHkZiV3/u1jBTAN55osWwAYge9TCtec/qbD5nx2vs8VndjwTQlp59/Cmn
	 /MvHG6HIKt41j388Uyvl2T1mKAouOpi5d0dSDG4Ftb+9wQgP4POw2GX6BvrA5LkCicTHm
	 dqrVbYk/ePPme97YlDZHulMuJjiENB8p73LHpiajBgxIwoSTKQwJaNeBoqRG1BqskVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116637;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=IT/YPbY1Zg8iM3T4dqpAupS8e72oCMI73jmy9cNsL14=;
	b=RnJgcc7sJ8Xpz8bKWRsZenLnBoMKoJt9MO0zD9YYNg9fXLqPwBsrAgAWddntEyzhLRpZ
	 fmsGFQBHqaGh42zkKEHqVS5BA/NFCuxZoqKR8b3JPD0itqu+5+L3bGSYD8lwFH0+lY0Rx
	 h3Pnig8mnxdk222r7JMaG7VlsPfPbQ0AsWJJDIVBdSVTUAQG6aJ8cWq/jw0SCS9TpRdjz
	 FlL4LUUGTb2T3atu4BbJhX5OdBB0NtuIEia35gK4lpG3fz2HQqrJ/PwN5ZoSkkelXqAn5
	 hc9eFsBHk4ZRt3//Vkmc52AYTvxVTgxipU17DZTgvuEua6YXBWgklHCPxKx85hjH0xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dUsucV1b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943D3606A336;
	Tue, 27 Oct 2026 15:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dUsucV1b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C771F01828;
	Tue, 27 Oct 2026 15:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793116637;
	bh=IT/YPbY1Zg8iM3T4dqpAupS8e72oCMI73jmy9cNsL14=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=dUsucV1b9FEgI1P9D6FHO5lE2BX2PFzxzoJSg7zad1WNJ2FyJvyiTyLD3SGNigjqx
	 aDb4vPFLpRrjUyo8+abEqMncRWxIeIVSDDOXKEu8xZMgb/eprBewRSAvhZmMqynNGP
	 MhSNipR0RiOYTWZlc5PxOUvnqvJ1y0avybG0RjcIkKNytNFrj3r3xsqZVVnjdKxqex
	 X7apL6CiXEsY1vY5K+PgJpbf1zWKoScGHTFU4G5yWLHqGda3uRZB8OU3SZHviNYqA+
	 DsBegKInjK3io7h8syDXRbmQfmSqW7mN17ZotSBzzbuYHG/3tcBR+qy2W+2aJAumSM
	 KPE3XgWpKWX8w==
Message-ID: <83695285-207e-4d0f-ada0-2273953e2eb9@kernel.org>
Date: Tue, 27 Oct 2026 16:57:12 +0100
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
Subject: Re: [PATCH 1/3] dt-bindings: power: cw2015: add cw2215, cw2217, and
 cw2218
To: Chris Morgan <macroalpha82@gmail.com>, linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 sre@kernel.org, t.schramm@manjaro.org, Chris Morgan <macromorgan@hotmail.com>
References: <20261027131751.1724448-1-macroalpha82@gmail.com>
 <20261027131751.1724448-2-macroalpha82@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20261027131751.1724448-2-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/10/2026 14:17, Chris Morgan wrote:
>  
> -allOf:
> -  - $ref: power-supply.yaml#
> -
>  properties:
>    compatible:
> -    const: cellwise,cw2015
> +    enum:
> +      - cellwise,cw2015
> +      - cellwise,cw2215
> +      - cellwise,cw2217
> +      - cellwise,cw2218
>  
>    reg:
>      maxItems: 1
> @@ -31,8 +32,6 @@ properties:
>        it is to mail two batteries to a test facility of CellWise and receive
>        back a test report with the binary blob.
>      $ref: /schemas/types.yaml#/definitions/uint8-array
> -    minItems: 64
> -    maxItems: 64

This needs min/maxItems constraints.

>  
>    cellwise,monitor-interval-ms:
>      description:
> @@ -41,7 +40,14 @@ properties:
>  
>    power-supplies:
>      minItems: 1
> -    maxItems: 8 # Should be enough
> +    maxItems: 8  # Should be enough

Why changing? yamllint complained?

> +
> +  shunt-resistor-micro-ohms:
> +    description: |

Do not need '|' unless you need to preserve formatting.

> +      The value, in micro-ohms, of the shunt resistor used for sampling
> +      the battery current.
> +    minimum: 1000000
> +    maximum: 50000000
>  
>    monitored-battery: true
>  
> @@ -49,6 +55,28 @@ required:
>    - compatible
>    - reg
>  
> +allOf:
> +  - $ref: power-supply.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - cellwise,cw2015
> +    then:
> +      properties:
> +        shunt-resistor-micro-ohms: false
> +
> +        cellwise,battery-profile:
> +          minItems: 64
> +          maxItems: 64
> +
> +    else:
> +      properties:
> +        cellwise,battery-profile:
> +          minItems: 80
> +          maxItems: 80

default for shunt-resistor-micro-ohms? or is it required for new devices?


Best regards,
Krzysztof
