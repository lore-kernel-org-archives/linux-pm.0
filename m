Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADF3424D7C;
	Wed, 12 Aug 2026 10:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786531394; cv=none; b=TCvrhdsepjWTtU7K+e9W9qXcApBUXcZZGXcG+2r4ZtIrg741E25hkkJaRL2rmGRk8Mg5Cs1UfmrEzYCDaKIhL3oyWlHrjoYVz736XbIqOKghtH+9I6FML4duSGIir1QOXD6M6KO5sF5X/eekkr8dchd1ao/WnUWEhFSndgGVUxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786531394; c=relaxed/simple;
	bh=SY7TzhA7Ok0veY7GBmSUMAEdyo5mNMQZRbN1lxKK2jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=un7ohpKsxd28JlcqIrSTBcZW1TbURDGvhnZ0e/I98xzpW2b2bBh5r9n8aunRWdybqEKX13kvWEtmdKVzNEjOq5rWFE+q0f4w9FMqFR6iv0VE7ykZellGPx6CJoyawWsv1oW8AKCpT+XuyW0Qnh2xIYdU3+wm8u5ViINTm5YNKMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltMzeIQZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltMzeIQZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3C31F000E9;
	Wed, 12 Aug 2026 10:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786531393;
	bh=zTxtUzbw2CP7qzFDOd8XF82HMw4zOXtbtAjcgTQm07Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ltMzeIQZcdZIqZprcX/FAsp9b8pPmHH3UiKGIPZihGl77y6b+AticxA7JACKpWWUx
	 0PRXseHzevvsyFXTYWDSulY2m8HGvkQ9f5EgV2hKeEmBo+ZTSkBfN6A5DiHPfr3GYH
	 hLqjtHx+N+zPRg63DHV3krOfwWrkRK6M3q/z4DZzVkylsz8NmWYh9obxH7AgzHt78G
	 e+Leq+hOzXoxZuF0BFtjBYT9EX+FPuOza+tUVoUZlSVdr3/kU47cn4PNTNjbTkSfQw
	 EmoMb6tgP7h+H9Qwvb4CNlYbPZ4eDS+Otlao+UaSjA5MaEbu/1NZcZIWeuUZJ8Ke31
	 yOnTf/b/Zdy/g==
Date: Wed, 12 Aug 2026 12:43:06 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Golla Nagendra <nagendra.golla@amd.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, michal.simek@amd.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, rafael@kernel.org, 
	git@amd.com, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH V3 4/6] dt-bindings: dma: xlnx,zynqmp-dma: Add Versal Net
 compatible support
Message-ID: <20260812-benevolent-ammonite-of-mathematics-5dcafc@quoll>
References: <20260810100452.426320-1-nagendra.golla@amd.com>
 <20260810100452.426320-5-nagendra.golla@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260810100452.426320-5-nagendra.golla@amd.com>

On Mon, Aug 10, 2026 at 03:34:50PM +0530, Golla Nagendra wrote:
> From: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
> 
> Introduce a new compatible string amd,versal-net-dma-1.0 for
> Versal Net ZDMA.The new compatible requires xlnx,zynqmp-dma-1.0 as a
> fallback.
> 
> Add a reset property to describe the per-channel reset line exposed
> on Versal Gen2 and Versal Net. Mark the resets property as required
> for both Versal Gen2 and Versal Net, and not applicable for other
> platforms.

I cannot find previous discussion in my inbox and cover letter has no
links to previous versions (when finally will you start using b4?), so
you might get the same review over and over.

> 
> Note that making resets required for Versal Gen2 results in an ABI
> break but this is unavoidable. When DMA is used by two software components
> back to back (e.g., firmware before Linux boot), DMA functionality fails
> due to configuration differences or the DMA being left in a bad state by
> the previous user. The channel can only be cleanly re-configured after
> a DMA channel reset,making it essential.

So this was never working? What exactly is unavoidable?

> 
> Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
> Co-developed-by: Golla Nagendra <nagendra.golla@amd.com>
> Signed-off-by: Golla Nagendra <nagendra.golla@amd.com>
> ---
> Changes in V3:
> - Use allOf:if:then: to restrict the resets property per-compatible,
>   making it required for amd,versal2-dma-1.0 and amd,versal-net-dma-1.0
>   and explicitly setting resets: false for all other platforms
> - Add amd,versal-net-dma-1.0 compatible string with xlnx,zynqmp-dma-1.0
>   as fallback
> - Switch compatible from enum to oneOf to accommodate the new multi-item
>   entry for Versal Net
> - Add ABI break justification
> ---
>  .../dma/xilinx/xlnx,zynqmp-dma-1.0.yaml       | 25 ++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
> index 2da86037ad79..87c65aef5c7d 100644
> --- a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
> +++ b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
> @@ -18,15 +18,31 @@ maintainers:
>  
>  allOf:
>    - $ref: ../dma-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - amd,versal2-dma-1.0
> +              - amd,versal-net-dma-1.0

> +    then:
> +      required:
> +        - resets
> +    else:
> +      properties:
> +        resets: false

Entire allOf goes after "required:" block, by convention, see
example-schema.

Best regards,
Krzysztof

