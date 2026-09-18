Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEFF52CCE9;
	Fri, 18 Sep 2026 21:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789768438; cv=none; b=cdS3EKDyi7qmeVgleacBVrvCU34NeoGUi7rcbQUImk1G0k/qlhbEzTJtPzbP54gqLqI6eXSsPtXkgRfJpfyAo1c49fFQuBLvPptkZJQihJJcFZQcPTdagYsT6YlnmAxxGDmpxjRqA3czsL+cTqt6SbysutqPVY4U0hiSHNAMZYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789768438; c=relaxed/simple;
	bh=MXdHWxef+PoBWOlvtuNUSMQoSGEq4fCSOFzHdPaXsDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObCxqZuMcMO5W1P0+/kDGuMDg/57Zc+asOrbLCxk3pwO1t36ZATWjhZUCS7AN4ctO9giI0SRnWP7+Sl6ntrMU9nmI9xBxKAZEnXOsKfgp+F5ahowLOwHpAKBrtFoUyr8sdtfocwvCCQjK/t6L6+I2MuALru/jNn36t5c/E8jzbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOse+aHd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOse+aHd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E448C1F000FF;
	Fri, 18 Sep 2026 21:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789768437;
	bh=J0OVTGPgWTDcP7IeXfZpR+F08h8lgiCM2uhTjTHEnHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BOse+aHdWkqCl9jRalTVS9IY0rpnulBUFT1S4W7GGNoZgeAJnRznJGubEV2g+vSQj
	 pDORAHH08ft6C5FEFTsOqszrtyOWvG4Ty6k7pB1PT1Zk6CLDkpMjFXAY3eYstITnYI
	 MpXo+u/Ibwct5b+cBSZhLGyexOMih9EB5/jd61BkvnltjjpqXMXPQsVxquLnxzUkCz
	 xqluq/f28D2BvCyrtVE/VPdSxjB0fDyiaqUVlzKKOU8bu+B9aiSBXlh+jMt9/XUOYc
	 nwlzZonWWZJrp2qT826QptvlxOADJRlCv03kL8kfxeZk5zLScDUIQnIi0DCR5PVs0f
	 U0JAvvfi7NdfA==
Date: Fri, 18 Sep 2026 16:53:55 -0500
From: Rob Herring <robh@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
	dri-devel@lists.freedesktop.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 09/20] dt-bindings: arm: pmu: Allow power domains
Message-ID: <20260918215355.GA2371991-robh@kernel.org>
References: <20260914-ux500-power-domains-v7-1-v2-0-9d0c17e1f816@kernel.org>
 <20260914-ux500-power-domains-v7-1-v2-9-9d0c17e1f816@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914-ux500-power-domains-v7-1-v2-9-9d0c17e1f816@kernel.org>

On Mon, Sep 14, 2026 at 01:54:37PM +0200, Linus Walleij wrote:
> Allow ARM PMU nodes to reference their power domain.
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/pmu.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/pmu.yaml b/Documentation/devicetree/bindings/arm/pmu.yaml
> index f47baaefcdac..305c1a9668f4 100644
> --- a/Documentation/devicetree/bindings/arm/pmu.yaml
> +++ b/Documentation/devicetree/bindings/arm/pmu.yaml
> @@ -88,6 +88,9 @@ properties:
>      # Don't know how many CPUs, so no constraints to specify
>      description: 1 per-cpu interrupt (PPI) or 1 interrupt per core.
>  
> +  power-domains:
> +    maxItems: 1

The PMUs are per core, so you really need to support more than 1. 
However, I think the PMUs would always be part of the core domain and 
the A9 docs[1] don't show any sort of PMU domain.

We already support power-domains in the CPU nodes, wouldn't that be more 
accurate?

Rob

[1] https://support.arm.com/documentation/ddi0407/b/clocking--resets--and-power-management/iem-support/cortex-a9-mpcore-power-domains
