Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F8644163B;
	Thu, 13 Aug 2026 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786609706; cv=none; b=p0McMlQvLc8XYBKXCWS6TLQ2heyq1VvO56YdFTpvZB28NXsEPxe05yg3hXQJshQO8zj+mC39OVnkYyGttKiJs7B4XRCrvDW6OpiAPflOqiBx/vaGP23EmI7UKobxTg6ki7AopCzmBGD7zw15TpNiv2NFk6T2HLPBUVqGr0SvC4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786609706; c=relaxed/simple;
	bh=yzQucKFIEm6q15TqegSfh8nSVXck2W//aSuyU2Mxuj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ClCWMLo4tRqDtiM5QN3PlikOwfPBDhu7TTaEd4CTigsbY5UDbczdYzg11cpYC2YzXS6EV8pPEc2PliDCodLIMbWuchrqGp3YXLYmzrmwVOf38ycWBbg3/S5vS2SEcasbq+IjMLfHgX5jU/P2sGMeUX5Oo4XditlHnrya9VrqdNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IajlGgYQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IajlGgYQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C921F000E9;
	Thu, 13 Aug 2026 08:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786609704;
	bh=DrCppzolJDbBGIHmFRLxn1uZx4F/MBvG12Nh0mtaG60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IajlGgYQjxra7W4hfzoJNu+BNaUAhnLcNO2HkVMOZXk90QPBw6EiBMGmJHwpwRozR
	 Qe7KJ5NJ0YqYdeQowxb1IWsOJZ/vhKJ8obkWVH0UdyD5/X1cSyF0FGfzfHFUDupR4B
	 rU8ZyGxFbPXo2m35TlASGS9+0OEzaSIn5Rmmp8yMwiE2n7D7G4acUCLiWd7TygkpL2
	 XnHKjDFES1rTI1mOQIZodldz7plUuTl+1uykPr0ZLpUURa+FvJoX9u9ClIh56FpEgh
	 hTkp0HDmYvOPtbVtgljVTtUXtTKDb4DKRZxCJ+U1zbDkglC6246gtLcnchGVXdku7p
	 iPAPSinKCXp+g==
Date: Thu, 13 Aug 2026 10:28:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: thermal: amlogic: Add A9 thermal
 bindings
Message-ID: <20260813-international-optimal-limpet-dfb06e@quoll>
References: <20260811-a9-thermal-v2-0-7ddc33b11b9a@amlogic.com>
 <20260811-a9-thermal-v2-1-7ddc33b11b9a@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260811-a9-thermal-v2-1-7ddc33b11b9a@amlogic.com>

On Tue, Aug 11, 2026 at 08:37:43AM +0000, Xianwei Zhao wrote:
> Document the thermal controller compatibles for the Amlogic A9 SoC.
> 
> Describe the required "core" and "plck" clocks, add the optional
> "amlogic,hw-reset-temp" property, and update the schema constraints for
> A9-specific thermal controllers.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  .../bindings/thermal/amlogic,thermal.yaml          | 28 +++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
> index 8cfa44dcda58..f73ee66bcc47 100644
> --- a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
> @@ -23,6 +23,7 @@ properties:
>            - const: amlogic,g12a-thermal
>        - enum:
>            - amlogic,a1-cpu-thermal
> +          - amlogic,a9-thermal
>            - amlogic,t7-thermal
>  
>    reg:
> @@ -32,7 +33,13 @@ properties:
>      maxItems: 1
>  
>    clocks:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: core
> +      - const: pclk
>  
>    power-domains:
>      maxItems: 1
> @@ -52,6 +59,10 @@ properties:
>            - description: phandle to the secure monitor
>            - description: sensor index to get specific calibration data
>  
> +  amlogic,hw-reset-temp:
> +    description: The hardware-controlled reset temperature value.
> +    $ref: /schemas/types.yaml#/definitions/uint32

Thermal zones define that, not custom properties.

> +
>  required:
>    - compatible
>    - reg
> @@ -73,6 +84,21 @@ allOf:
>        required:
>          - amlogic,secure-monitor
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - amlogic,a9-thermal

Why is one clock valid as well for the new device?

Best regards,
Krzysztof

