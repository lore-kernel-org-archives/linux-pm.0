Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0996B37BE63;
	Sun, 20 Sep 2026 18:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789928049; cv=none; b=OhJPpR04LJKsaigIJQYqb/6z+PapqkAflRSMC8XzB1tJj0zd2YVHjK/+TKyP3untctjMTwxLj/VXydLpF7DocM0DY0j838ZYsc8/kOXFrBk3ZveAVNfuQ8dUPL6eBwZXIMS3jBR6iVm1y5PdsX+5Gw5J0Icn4mUYf2/J3Ut7hRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789928049; c=relaxed/simple;
	bh=t5OkIKRNMdJSJczm9uYxncFKQ0T4pNQV2EIe6AY89TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1IpBNhtpwhcP9vGsUpoipAxIgsY4+vzI8xxFoqop5nmVhakj6H9oUAiQyRiTf3RZ8jbv75qfiPye+JpwCjmCxxEZEZsVvqJhI2Cia+kzOgg+kUmHP2YtWs3uJ1lWmx8eQx0+DEzHNcqvdJRF8dZLoZcDoJye/C7qI27HP7cMIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EoINsmAr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EoINsmAr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3EEE1F000FF;
	Sun, 20 Sep 2026 18:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789928047;
	bh=tcm6HGCLUSSy/9FlI6paPBg6JDS2N6Hp/BFuNZUtfdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EoINsmArbCovjSAJC0rpHdjj7hhbtXO2lqFrWeIWT7NyaVFfnjBGT2U4sJrYNi1U4
	 uGFtAzp21dGUznmVktj5kpPygX2WtYd0GN8y/DLU6l2M+4SkSjZuh/bXKl0/+h/yj3
	 y+QNPnRDUbcp+czdnsASxXmSR76vKdyCdPL7KqOJeje6s9GvJX3lHtlrjEZBXK/3bg
	 B/AjxDA/bWiBQLVOTN4+Rf298+E06Z79KyqbDipA8jBwbPfywVQLvNvuOwx7wUWlwS
	 PNMcK7XbRL2jL/jjPTsB850HPSnCB3FIKWxl//lqaYMy2Qg3SEmHBGFpZlKj2E+pfE
	 17c3hO0n4S5Zg==
Date: Sun, 20 Sep 2026 20:14:04 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: power: supply: ab8500: Add AB8505
 charger
Message-ID: <20260920-demonic-relaxed-penguin-1a2eda@quoll>
References: <20260918-ab8500-charger-dt-v2-0-5f17c332a2a7@kernel.org>
 <20260918-ab8500-charger-dt-v2-1-5f17c332a2a7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260918-ab8500-charger-dt-v2-1-5f17c332a2a7@kernel.org>

On Fri, Sep 18, 2026 at 06:56:51PM +0200, Linus Walleij wrote:
> AB8500 and AB8505 expose different charger interrupt sets. Add a unique
> AB8505 charger compatible with the AB8500 compatible as its fallback.
> Use the variant-specific string to require the fourteen main and USB
> charger interrupts on AB8500 and the nine USB charger interrupts on
> AB8505.
> 
> Also clarify that autopower_cfg describes the AB8500 facility, since the
> corresponding AB8505 register bit is reserved.
> 
> Fixes: eb917497734c ("dt-bindings: power: supply: ab8500: Convert to DT schema format")
> Assisted-by: LLM
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  .../power/supply/stericsson,ab8500-charger.yaml    | 70 ++++++++++++++++------
>  1 file changed, 53 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-charger.yaml b/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-charger.yaml
> index 4f19744844e9..73f5df2d7a36 100644
> --- a/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-charger.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-charger.yaml
> @@ -12,10 +12,58 @@ maintainers:
>  
>  allOf:
>    - $ref: power-supply.yaml#

Please move the allOf after the "required:" block. The constraints
shouldn't not be before the actual top-level properties for readability.


With this:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

