Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC7B349B02;
	Tue, 23 Jun 2026 08:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782204423; cv=none; b=Lq1McOKkHHanREsvNjRGOyUHhjl1fH5UdqRWZAEKJyrL6FtiGc9Khyv/nfkASmqW5q/G1scVsun3XT/8//Wvc9d1oXEPPtUxAe2yY6cg5dTCJFyri15zDw5uVoOJYJ6P/sBzb/NV/yGiWfjk/17r9Jt46/l88ENH7agZXxBNUqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782204423; c=relaxed/simple;
	bh=6vO769Z2othjMjBeAgBThXE93heAzAxGdoljJfl0WYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQ2VM6xSxEDKWKSUYOglTttN4JAkFLhoB7DJFgSGVJHfLbz/qkGo+C5G9KfDush4LrEfn9rXoA5o3/42nQfsaNFKvjC+o2zb00X8RYqXcVTCDAmyRf9AkBmBUirYmAjVoVJ98AYNvDm2dsMi3Hpqt3ZOvvdEDFldB2pwF4Q7sdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYxRw6uw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYxRw6uw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0538E1F000E9;
	Tue, 23 Jun 2026 08:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782204421;
	bh=WIwTC0VHw0jMFTXrlPYu0EBk9AhpcmV7JfkqaZxHCBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jYxRw6uwNPYdz2dtcmIZFKkjSmnce0AkzA2cipbsc8XfB7+QQrrLm9S3oXC3rR2He
	 4+JUClOGBhD684EXgDlTruzwYKbBNBwS0fr2on/Ik4F5iHhGidQ/a6jLHJ1Ik2UclH
	 5O5c1XcsbmFL9/1NEmzqwfVClgVUnUUHHUvM/Y26f74bZYVDdNoSLWzODeIqcVchHV
	 rcVqwq/zWumw/mNQ+m3R1QQ9k+1Em/hi/DsP8BLjFIqwXq2evXe+5/FVqUhcSFaw2e
	 KdxXZzxudLMBrS1boAHEUv8hs0863UZrsaDIgBNeNw+kMFuLkM6nYyBe/dOBVAX9+y
	 H3zgr4szmz/0g==
Date: Tue, 23 Jun 2026 10:46:57 +0200
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
Subject: Re: [PATCH 02/11] dt-bindings: Add the actual power domains on U8500
Message-ID: <20260623-just-grinning-peccary-d661ca@quoll>
References: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
 <20260618-ux500-power-domains-v7-1-v1-2-eb5e50b1a588@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260618-ux500-power-domains-v7-1-v1-2-eb5e50b1a588@kernel.org>

On Thu, Jun 18, 2026 at 07:00:48AM +0200, Linus Walleij wrote:
> This file has been left in an unfinished state just defining
> the root power domain for the U8500 SoC. Fix it up by adding
> the actual existing power domains in this SoC.
> 
> The PRCMU code and old regulator driver is mentioning some
> *_RET domains, this means "retention" and is a state in the
> domain and not a domain of its own.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

From/SoB mismatch.

> ---
>  include/dt-bindings/arm/ux500_pm_domains.h | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/include/dt-bindings/arm/ux500_pm_domains.h b/include/dt-bindings/arm/ux500_pm_domains.h
> index 9bd764f0c9e6..1c168e59ac90 100644
> --- a/include/dt-bindings/arm/ux500_pm_domains.h
> +++ b/include/dt-bindings/arm/ux500_pm_domains.h
> @@ -8,8 +8,23 @@
>  #define _DT_BINDINGS_ARM_UX500_PM_DOMAINS_H
>  
>  #define DOMAIN_VAPE		0
> +#define DOMAIN_VARM		1
> +#define DOMAIN_VMODEM		2
> +#define DOMAIN_VPLL		3
> +#define DOMAIN_VSMPS1		4
> +#define DOMAIN_VSMPS2		5
> +#define DOMAIN_VSMPS3		6
> +#define DOMAIN_VRF1		7
> +#define DOMAIN_SVA_MMDSP	8
> +#define DOMAIN_SVA_PIPE		9
> +#define DOMAIN_SIA_MMDSP	10
> +#define DOMAIN_SIA_PIPE		11
> +#define DOMAIN_SGA		12
> +#define DOMAIN_B2R2_MCDE	13
> +#define DOMAIN_ESRAM_12		14
> +#define DOMAIN_ESRAM_34		15
>  
>  /* Number of PM domains. */
> -#define NR_DOMAINS		(DOMAIN_VAPE + 1)
> +#define NR_DOMAINS		(DOMAIN_ESRAM_34 + 1)

In a separate commit, instead you need to drop NR_DOMAINS and move them
to driver. If this changes, then it is not ABI. We did similarly for
many clock bindings/drivers.

Best regards,
Krzysztof

