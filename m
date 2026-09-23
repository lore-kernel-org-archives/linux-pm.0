Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD80534445;
	Wed, 23 Sep 2026 15:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790176842; cv=none; b=BoJMbyDZ0zNwzo+Ea3kvbQVkCzo1hnr5bZvjv1Bdv68RFqCxCQq/ajoLgOhr8ljfX5UiMiycFuHAcLJVtMu8jFxCwfOXikfAYBMQgqKV5r1y9tgn87B2DrYR4WdnwR3WvBqlEj0foS/GaKxmbbLvKrIz27XMAJ7s6M8aA7d2Xv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790176842; c=relaxed/simple;
	bh=0C54jny/GqShlf76MT3qk0YX6HN9yFkK8ZUPFcX/iFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sguTzIOoFIcWj9rnYNUUaK/tO4HOtU+3A61+C2/AeT52hlf9Jguv8f09ErGg7gFyRqC2Pecskdvnmw2JC8T1Qm0NRAgVee7nds1RM8bMLLiEdb8h2r6X3Vf/CKRsXAHTfPerMU9WUKZQ9VtOu0d30OWmRjOOnQL7IB29u1jhLIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmf+SlqT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmf+SlqT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E826E1F000FF;
	Wed, 23 Sep 2026 15:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790176840;
	bh=x7hz/wkv4TIP3tFV0atbeAtIVV/ATXHLJDQELrGuxLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cmf+SlqTaFJfYHX3sPm69koXlm9CC2phElbCF3QFWipRsHqfNXfjmXgo1N3kSzuVo
	 39j8AsPtsVJsZzNHaJDJ9bvjelWWcNwUehLTjZ+H45O9I/fPCGukKXZ/XGLwCRdiuJ
	 pSt1A5uCI9wb8Nv7Sc2WGuJSKK7wFPmI5H2bPOat5tDgoZKRqS9i2q59Y/vcmkTJdF
	 RLO2xKif7mqKBByMy5EeuEhtEsMURKlm1Wt5+JR2eemcdpIl2oGbc/6uOzDtV16eSO
	 Ynpy7Gxwxx6a3RzdUcRLSbltyuUhqbVlK4k/oBgXslQBwUd1msjf7kCrkW19E+anUL
	 RQ19e+5JSteXQ==
Date: Wed, 23 Sep 2026 16:20:34 +0100
From: Lee Jones <lee@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 18/20] mfd/regulator: db8500-prcmu: Remove EPOD
 regulators
Message-ID: <20260923152034.GI3864833@google.com>
References: <20260914-ux500-power-domains-v7-1-v2-0-9d0c17e1f816@kernel.org>
 <20260914-ux500-power-domains-v7-1-v2-18-9d0c17e1f816@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914-ux500-power-domains-v7-1-v2-18-9d0c17e1f816@kernel.org>

On Mon, 14 Sep 2026, Linus Walleij wrote:

> Remove the obsolete DB8500 PRCMU regulator drivers.
> 
> Drop the regulator build hooks and the db8500-prcmu-regulators MFD
> cell now that EPODs are power domains.
> 
> Assisted-by: LLM
> Acked-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  drivers/mfd/db8500-prcmu.c             | 239 ----------------
>  drivers/regulator/Kconfig              |  12 -
>  drivers/regulator/Makefile             |   2 -
>  drivers/regulator/db8500-prcmu.c       | 501 ---------------------------------
>  drivers/regulator/dbx500-prcmu.c       | 155 ----------
>  drivers/regulator/dbx500-prcmu.h       |  55 ----
>  include/linux/regulator/db8500-prcmu.h |  38 ---
>  7 files changed, 1002 deletions(-)

Looks good.  What's the plan?

-- 
Lee Jones
