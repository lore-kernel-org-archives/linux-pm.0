Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9556652E04D;
	Fri, 18 Sep 2026 21:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789768540; cv=none; b=Oyzoua33bi45PyzodaAKaQZU9XvDn4AWLLw7K6CbyIvNvViRceq2PsjTiidEGVXzEVxBfSX3WgqHBl5caf9RJDA2MRkD9mzz/3/jEDjGJbFPAeKoGqSq4aH6fVTJVEBxmHUYbSlnR8lOHUcyP0iKwvfqk/jl5CDYstVrzrHRQjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789768540; c=relaxed/simple;
	bh=Jblea2EtzHcuEEed4oUdX0fP8eEpgvdXrkAaLbRrn8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aaUlSDmpzQU4sea9cxtPsq/yKEw8Ldp65Rifc2c8V91zHEUsSSaZulLcUAFysvbkQCqSDUN5BcGfq3VG0tkD0jJgJNKA6Xbfy0IVHQSVC/d5AW1aCcGDm+Tnv/NdyuXjImEpUn3Kuecu4hdE8YRd8HsKBb22IlgH2WwEO6ztiA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FR5oM+9/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FR5oM+9/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1521F00898;
	Fri, 18 Sep 2026 21:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789768539;
	bh=J8d54ZjF80j5PSeUUGJOwzN8j8yyoXk5bK5VrCr6trE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FR5oM+9/Q9Gt7NasIOp2sGg+Hd8SkJeOIApn+kgvLPBhyKowszo/f1INrNqWLrUZ8
	 fJfKV7IKFBaWQImHLJGKCr+oPg/r8j0jM8Fg0GpOtIk8E09QF4s7nJnVTsVN0LiigU
	 57rIx5IYFGLbweQoREwF4uiJOsVN95CDkR4i71gDGnrps4JYkTOTmrVSW0nSC+/xJg
	 8B+l6FkQ38lFMGoaib9NVAUFluoMu3jjNSbGhh1rhq6t3KeidD8TU+58wC3QfupWis
	 rijZ/Way9jBq3VyYXSqYvfPWzzc6ShiNElyYOzpzeBuJvKrEJGMZX/k6d7I4bSbe4c
	 7/5vvyRYXP7nQ==
Date: Fri, 18 Sep 2026 16:55:37 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Maxime Ripard <mripard@kernel.org>, dmaengine@vger.kernel.org,
	Simona Vetter <simona@ffwll.ch>, linux-pm@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org, Ulf Hansson <ulfh@kernel.org>
Subject: Re: [PATCH v2 19/20] dt-bindings: display: ste,mcde: Deprecate EPOD
 supply
Message-ID: <178976853742.2415043.13414750295183513008.robh@kernel.org>
References: <20260914-ux500-power-domains-v7-1-v2-0-9d0c17e1f816@kernel.org>
 <20260914-ux500-power-domains-v7-1-v2-19-9d0c17e1f816@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914-ux500-power-domains-v7-1-v2-19-9d0c17e1f816@kernel.org>


On Mon, 14 Sep 2026 13:54:47 +0200, Linus Walleij wrote:
> Make epod-supply optional and mark it deprecated.
> 
> The MCDE should use its power domain instead.
> 
> Assisted-by: LLM
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  Documentation/devicetree/bindings/display/ste,mcde.yaml | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

