Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F5552D2DC;
	Fri, 18 Sep 2026 21:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789768463; cv=none; b=K0NI+VnbxhMvWu2sQBB66w5u3W36bCBgSqBl4QPI05y88PKZ+CKXoQOvFOuD0FWTMBA2fLkQn9a+QsppHwfvTFsgF1AoufUyLWWQXhKCT6pyxiwr+z4UvEKR5Fv5gp0WaeQkQAngSk41gISeuSW3+pxRLlxZ9BGRfYhacGXeMQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789768463; c=relaxed/simple;
	bh=oGuD9EqWYn+fzwhSHwppJthOjTmZjA7l1crgRCsQZSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PX0nn8IGrmdBbEv417VNp8UAn1N2OtRTm7kKf0j+KAN/FextGmyoC5AQPjj75dv13WXMEGk7HsmBV2GvJzBKN1TQISpd22jzcjzJ0GUnD7z6ybi+zckM6nS6PDeR8HlOgd0Nu1q+96lZfvjag1GfnspV7J3IQwe+f0QEtlSR38E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1PxyPvP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1PxyPvP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8101F000FF;
	Fri, 18 Sep 2026 21:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789768462;
	bh=Lco0nsfOk/y1oLd4zNBhcBNCczg5cJsEqylfHR9vG+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z1PxyPvPAQI8S9FUlJC53CweFvKxnBH/6aUfb/nP/Mj+xboet4C6ZO0QiGEpF0N6o
	 +EniklQnUAiSTgJt9mP7ubukOU27ICP+pC2c/4wpiqaSv608ilBBYQVVUx2iIZsU+f
	 ivQcMh5CsgyVliIIoPx2frq5qKWRjYrhSe8hJ3dcKo515UOjXjKeJwvtap8LdPbboQ
	 9R8Hs2CpNmPCbGnbrd0YGqqgyCquflXVJ5AZIIA1qTuqAdGmGN5lzooz1ehdKJIMvY
	 uzrJ0HzdmksvWFQiif6tuJMmNux74FiryAR+Dd6DSijVZenXkUpdRAyVzxPoD1mjnk
	 qVht87VZt9j4g==
Date: Fri, 18 Sep 2026 16:54:20 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Frank Li <Frank.Li@kernel.org>, dri-devel@lists.freedesktop.org,
	Lee Jones <lee@kernel.org>, David Airlie <airlied@gmail.com>,
	Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, Simona Vetter <simona@ffwll.ch>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v2 10/20] dt-bindings: clock: stericsson,u8500-clks:
 Allow power domains
Message-ID: <178976846033.2410726.8701362101092342072.robh@kernel.org>
References: <20260914-ux500-power-domains-v7-1-v2-0-9d0c17e1f816@kernel.org>
 <20260914-ux500-power-domains-v7-1-v2-10-9d0c17e1f816@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914-ux500-power-domains-v7-1-v2-10-9d0c17e1f816@kernel.org>


On Mon, 14 Sep 2026 13:54:38 +0200, Linus Walleij wrote:
> Allow the DB8500 clock controller node to reference its power domain.
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  Documentation/devicetree/bindings/clock/stericsson,u8500-clks.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

