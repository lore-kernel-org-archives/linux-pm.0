Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793096183;
	b=HMn7bbtF3wirgqP4QTmGhrw097/2WWVNX8Wvi0/MPuJ9Q1T8CCgomenv6eoFGRnR9VJ0
	 xeuTXWaLu+n/401JUB5jo6JI8j9jvFs9FlaxxcJ96eyrSyPNOuNvnmYcBCBMpJmXcywJh
	 UGp2d4KozF5Gb6O88gHA9lLTwDdWjosMBQUy11xvzTTbhQiJHxOkXxOF88O5jASeujiDS
	 Y/LocqJFGm8CvGGyW9b00JdNYtQsPUbn85aVAd9Pvo8IetDuiqwUmyYdB0/+UeHnjXTvX
	 eXMGNDlGuw4y0+WJ7cBK3Y3AZGGmScvXf5UgK7PUL/htBg0YQS9l43HVMiie/flGHkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793096183;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Nosy+usVuTRalJhDlMJRSmJy7mZ+XXkUctxepxTismw=;
	b=H8fxhLbYxPYfgXlF9UccNleDiQL4q69RZEUCZqbNKgj7waZjgaYn34+6eaX6dxtfPl/T
	 4/kHEXeqKjdqgvQlNmB/dcAwIr9cZYU1iI4Br8jUiSa4g60OcpKEsr+VMo61t8yBTaXp6
	 AUzQ6YhQpUUahcxKWrJc5uXCTgjgDiiIqyp6UzPtIQxaSBsFoVhcQvWtiAYfolrTTXQ4c
	 /NTvli2dqP3HpgwXRzbPEBI3OjbucC8zSKnGnIduyKKqO96O63/FS4TUMtlBOIeiOwEuL
	 AJ0MTsEIYgVAJF+boI0U/hirRtamYlGjTABc5KEt6JSXtbmMnnTs5ybiYAEdtqBomQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Rh+DGu/x";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06019606A31D;
	Tue, 27 Oct 2026 10:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rh+DGu/x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09221F01829;
	Tue, 27 Oct 2026 10:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793096182;
	bh=Nosy+usVuTRalJhDlMJRSmJy7mZ+XXkUctxepxTismw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Rh+DGu/x7G5c9120OgBPvXJmW56OvjJimMq1CE99woSfN0Z9nWU1t+pn57RzO+wbw
	 qbIDD2b4OZGV5WEvYYpuIk0anbG9bYLW+0H919KYQnPvGwAfxYYNCi9oMmXpqChO1e
	 UOT6PtxUzTkLMI4tV0ADVqrQzvlDVJDKeASDisuX3I5XvLottMo0WjcHJ+4GTOEcjX
	 Zf0NrXo414EyEKcW25WukVmNg3EhAt8fHQNTyanNNOB01ZmHYuZvsZ7aR3lYF5Ztci
	 U54TDtwXNmBEAGkFXUMqM7475GtPacqG71NnFDWTXkeVqRHBWwfuKCcdX45ed5TYgV
	 qEWJDvfQ+DShw==
Date: Tue, 27 Oct 2026 11:16:18 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Cunhao Lu <1579567540@qq.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Elaine Zhang <zhangqing@rock-chips.com>, 
	Ulf Hansson <ulfh@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Finley Xiao <finley.xiao@rock-chips.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: power: rockchip: Add RK3572 power
 domains
Message-ID: <20261027-uptight-stalwart-roadrunner-339a8f@quoll>
References: <20261026-add-board-ok3572-c-pmdomain-v3-0-70d614d3d921@qq.com>
 <20261026-add-board-ok3572-c-pmdomain-v3-1-70d614d3d921@qq.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261026-add-board-ok3572-c-pmdomain-v3-1-70d614d3d921@qq.com>

On Mon, Oct 26, 2026 at 11:21:38AM +0800, Cunhao Lu wrote:
> From: Finley Xiao <finley.xiao@rock-chips.com>
> 
> Define the RK3572 power-domain IDs. The driver uses the system GRF to
> check firmware shift-ready status after powering on a domain.
> 
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> 
> - Added the rockchip,grf property.
> - Made the phandle required only for RK3572.
> 

Some mess here. I don't get what's above, but does not fit commit msg.
Also there are no commit msg between the tags.

> Signed-off-by: Cunhao Lu <1579567540@qq.com>
> ---
>  .../bindings/power/rockchip,power-controller.yaml  | 17 ++++++++++++
>  .../power/rockchip,rk3572-power-controller.h       | 30 ++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
> index b41db576f95d..f8afb0fabe80 100644
> --- a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
> +++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
> @@ -43,6 +43,7 @@ properties:
>        - rockchip,rk3528-power-controller
>        - rockchip,rk3562-power-controller
>        - rockchip,rk3568-power-controller
> +      - rockchip,rk3572-power-controller
>        - rockchip,rk3576-power-controller
>        - rockchip,rk3588-power-controller
>        - rockchip,rv1126-power-controller
> @@ -57,6 +58,22 @@ properties:
>    "#size-cells":
>      const: 0
>  
> +  rockchip,grf:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: System GRF with firewall readiness status.

What is firewall? Is it for access control? If so, we have
access-controllers properties.

> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          const: rockchip,rk3572-power-controller
> +    then:
> +      required:
> +        - rockchip,grf
> +    else:
> +      properties:
> +        rockchip,grf: false
> +

Best regards,
Krzysztof

