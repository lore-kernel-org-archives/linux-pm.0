Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F1434C9A6;
	Thu, 13 Aug 2026 07:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786604797; cv=none; b=KNdyesvhAByIZa9lZ1q7Gt9o99E8FoRk6+Co6W9YzhyGk8ma+H1L5l44W4o23BSlGwIc9w3kGY6lW2qughQmK/fwR2SsXTQP0hEFP7Jh+Qz4ljLq2L8QAqNyCTCaT8mtiNl9NwM6Kfw6OHj9flOimDCb5P1FcJQGt+5Wv57np28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786604797; c=relaxed/simple;
	bh=S2a4/EY4ol+MON2eK+E9sy9COVmHiqiV6FniuwrLris=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRc7bumiv8E1vbFqgpyDFUGmNiJkdKm+bzC7gu2lxpllgPgTEnu+kNuQmU+I9uSPbIESYdcx07n3GUt6xc4HSMkESoQzWa311SqSXf+kKGpp2WHG7vK1atxmjL/Qxhbzcl0vk//Fk6CWLS5AztMHHtH1yjVHbXijmQ/JoqRhxRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LO7XnNmk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LO7XnNmk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E071F000E9;
	Thu, 13 Aug 2026 07:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786604795;
	bh=5gkzFo2+VnKiba/m6QDHWuLmIQSEjcsqyeD9BtdYCdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LO7XnNmksRdPGuuVUvy4uIp1TNqnss+bW1hz0raYz9RVLB9K2Msgsgwbi+S77PMen
	 EU929j5yne48ccdwHerg5SVsXmfM/l/6Fsc13FOojuYOe4cA+efThVEz/GwEjv+U7g
	 bEUZuO4PJZ0PxH6thkO1thO+J+W63uADRHQ7BT64/Yjc3vPSNeCe1n4zJaSG47bJHR
	 /Plvnr6vRz1KaNK4XkEp1In1rN3T/LC5p7IJcb7XUmYuq1E4rA6o95MXLnlu675/Y8
	 ptXQEUJYFoSiQ8eJSCg0y24KdXivFsYdEEdgPRfs5Mkf3vnB6kIHeAKCl95shEvTqW
	 XPXivBMAj9aAA==
Date: Thu, 13 Aug 2026 09:06:24 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de, ogabbay@kernel.org, 
	zhangqing@rock-chips.com, royalnet026@gmail.com, alchark@flipper.net, 
	chaoyi.chen@rock-chips.com, diederik@cknow-tech.com, dri-devel@lists.freedesktop.org, 
	linux-rockchip@lists.infradead.org, iommu@lists.linux.dev, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 03/10] dt-bindings: power: rockchip: allow resets in a
 power domain node
Message-ID: <20260813-squid-of-splendid-hail-d968bf@quoll>
References: <20260812094106.1391698-1-gahing@gahingwoo.com>
 <20260812094106.1391698-4-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260812094106.1391698-4-gahing@gahingwoo.com>

On Wed, Aug 12, 2026 at 09:40:58PM +1200, Jiaxing Hu wrote:
> Some domains do not come up in a usable state on their own and need
> their resets cycled once power is on. The RK3576 NPU domains are one
> case: without it the first access after power-on takes an async SError.
> 
> pd-node has no resets property and every nesting level is
> unevaluatedProperties: false, so describing that in DT is rejected
> today. Add it alongside clocks.

This paragraph is redundant. Why are you explaining correct syntax?

> 
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> ---
>  .../bindings/power/rockchip,power-controller.yaml         | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
> index b41db576f..f23c1a118 100644
> --- a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
> +++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
> @@ -136,6 +136,14 @@ $defs:
>            A number of phandles to clocks that need to be enabled
>            while power domain switches state.
>  
> +      resets:
> +        minItems: 1
> +        maxItems: 30

30 resets per one power domain? and none got to the example in this
file?

> +        description: |

Do not need '|' unless you need to preserve formatting.

> +          A number of phandles to resets that need to be cycled once the power
> +          domain has been switched on, for domains whose logic does not come up
> +          in a usable state by itself.
> +
>        domain-supply:
>          description: domain regulator supply.
>  
> -- 
> 2.43.0
> 
