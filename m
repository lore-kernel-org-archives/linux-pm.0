Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A75B3E40EE;
	Thu, 17 Sep 2026 08:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789633051; cv=none; b=Fnbu4SlJQfOW4JnDnH2/ep53fEcCQ2rinGayrcarTWQvR5zUsNa4WBswTnYIjrPXqXHRQGU3VwQqOTnhcRu8AFgE/HGHzYWiPstEcgUVuW8gVCB6Zlv+9sKsD11M2PtZwHH9D3r3KmLutj8JLnXNmoXHYm6Oe5cieMk0y4YIZs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789633051; c=relaxed/simple;
	bh=6DeY+crVCFI1U65tkX0elvKoLDsDVfy0HEK4UKgz6+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSDfCwlg+10Bu3Q2IRMSuQXjfwGa9AeD2JsA+2n6k0ld1FJLGtNi4LHZ7DqRvcY/MU/P5uM5K3BrYAa76aLExnKaSkGIa0mwnX343Nvxw7feKoEHsrXzmKRbHpvvgrLFY4fzGoOJMoFjVkRHp3em47uY2Cg4ZIgHG6wpbqFmgiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kntv2M+0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kntv2M+0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1FE1F000FF;
	Thu, 17 Sep 2026 08:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789633036;
	bh=moOS9a2ue4aymrStDqxoSwzWledK2otC+8+Di3jTIDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kntv2M+0iYjxx/+YnvUU1DgzEhSpw9aiJk0DyojkM1md/LdGZuZVpSfqV7tpZhuzM
	 Xp5SOdj/11rE5vzqkTMLZrtnS3fi5aB42253woJrUApuoGLrzu9GpattKs1Ug1qNhY
	 x/tCSwVBKwa/4Ty0Y3Iu4+QGL9SvALXVLjp5+Syeaz6JyTW1ZhQdmRo81dN009e7Pf
	 wgpXqfqdyxTHjViKkNgfUhAtlUWgLupmnj/wR1fviNaThv+pow4uf7IhNyj2961l60
	 i20128IK2d8/OH2ZYWmT4XqcHPOg7Hq4CcvMzKmeWsvE4aoeqjq5+E90YJXVnIN4iO
	 zlR8WutGpTuQw==
Date: Thu, 17 Sep 2026 10:17:12 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ulf Hansson <ulfh@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 05/20] dt-bindings: display: ste,mcde: Allow power
 domains
Message-ID: <20260917-gifted-astute-asp-dfef8d@quoll>
References: <20260914-ux500-power-domains-v7-1-v2-0-9d0c17e1f816@kernel.org>
 <20260914-ux500-power-domains-v7-1-v2-5-9d0c17e1f816@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260914-ux500-power-domains-v7-1-v2-5-9d0c17e1f816@kernel.org>

On Mon, Sep 14, 2026 at 01:54:33PM +0200, Linus Walleij wrote:
> Document the MCDE power domain.
> 
> Keep the legacy EPOD regulator binding unchanged for now.
> 
> Assisted-by: LLM
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  Documentation/devicetree/bindings/display/ste,mcde.yaml | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

