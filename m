Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6319A519DF4;
	Fri, 18 Sep 2026 16:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789749922; cv=none; b=E2UAQL1dzQyfCoROOSLwokV78WIWak224on0tBxmfXjNq8lxa98OyNrYb1yn3D4gVI8O5CHT9jyLwIV707r6/vvf25Usz8YbZtkjUTOzrPhBGg501n2Z496xQQVSwJwJGugbN86zY01lS4URQdupVb+Kqo7fj5U8JB9rpAs7wYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789749922; c=relaxed/simple;
	bh=JSThcUrSD9d3bIVSbKFCAkriwYQ2bNjsEP5KWhJecRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zx2Cx5228laMU7s0CvFhYGIN+0iC6RklnGQ5GJ96/C9a7FzjdaHTsjjU93vRCSVjbNUas8g2Px5++g2rUgt8lTOqTV77SB/j1AkwF8iNtnzHF8BvdRbDEW5HHsIWuRKifZkdSMTjn84Wttaa/iUBF8A+Lz+2hRZd0rCuJBp/ldo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0ZxH+mQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0ZxH+mQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD441F000FF;
	Fri, 18 Sep 2026 16:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789749921;
	bh=p/afdDpUjxDvfFW6cnI4C09DF82vIDcSPuyrBSmUfI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m0ZxH+mQR/Uf05x4/48ROHKNATIza8gPxVi9lr/10jZq9xCYRtDE/fWPiXpPDIptg
	 NEwjz9dqpcwCeEqhaOsJleFsQGsJNGJEUZfhpuL5wpWm9JBoHt0mUR4OVdjyWmjCbG
	 dzzdxEP3OyCH2hiqgVHf/fcLd/xNuh6plVyoSkSOn56fTM+nkksaoa12NoOPvvm+mP
	 lvhPZOcyBajJLlVgdxPBw3CN9YfXVWn4+S6njb/t25DJZgpd7o0eLiSlBsVpTNbPmr
	 3RvoEByxqiK8FJ8YFKt909e9VmG4CpOs2Mj/K4vtODVKrThWr7KcCSooCUMeNdMFtV
	 SRRp9VjR6oPdQ==
Date: Fri, 18 Sep 2026 11:45:19 -0500
From: Rob Herring <robh@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 3/7] dt-bindings: devfreq: event: rockchip,dfi: add rk3576
Message-ID: <20260918164519.GA435751-robh@kernel.org>
References: <20260917-b4-rockchip-dfi-rk3576-support-v1-0-a5752a29f7bd@collabora.com>
 <20260917-b4-rockchip-dfi-rk3576-support-v1-3-a5752a29f7bd@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-b4-rockchip-dfi-rk3576-support-v1-3-a5752a29f7bd@collabora.com>

On Thu, Sep 17, 2026 at 04:04:09PM +0200, Sebastian Reichel wrote:
> From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> 
> The RK3576 has DFI hardware for monitoring the DDR's bandwidth much
> like other rockchip SoCs do. Unlike the RK3588 however, it only has two
> memory channels, so only two per-channel pclks for DFI.
> 
> Add a compatible for this SoC's variant, and add it to the conditionals
> at the bottom of the bindings file.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../bindings/devfreq/event/rockchip,dfi.yaml       | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml b/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
> index d6e06a9bea19..964f1827496a 100644
> --- a/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
> +++ b/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
> @@ -14,6 +14,7 @@ properties:
>      enum:
>        - rockchip,rk3399-dfi
>        - rockchip,rk3568-dfi
> +      - rockchip,rk3576-dfi
>        - rockchip,rk3588-dfi
>  
>    clocks:
> @@ -68,6 +69,28 @@ allOf:
>          - clocks
>          - clock-names
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - rockchip,rk3576-dfi
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description:
> +                clock driving the DDR monitoring logic for memory channel 0
> +            - description:
> +                clock driving the DDR monitoring logic for memory channel 1
> +        clock-names:
> +          items:
> +            - const: pclk_ddr_mon_ch0
> +            - const: pclk_ddr_mon_ch1

Names are already defined at the top-level, just:

minItems: 2
maxItems: 2

(On clocks too)

Rob
