Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30BC38D407;
	Mon, 20 Jul 2026 06:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784527559; cv=none; b=V+ypI1f6+wfqf5vHLeMAc8PYDdyYJpc5aX8m7gtpjdxFF8MjkfotSQj7ErY+mMrUVUZwYQ833XxByIhPVLd3DyP6rfa9XpROIAo1BTq1RXE/5/wWmnulYaufzr3R094gsSlHlqOzY+NYEc1OcqQE620bO4bCaSxpP+ykLcyw6yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784527559; c=relaxed/simple;
	bh=Gv+9Jx0g9dhANdxesKIU4cXZo12aLzCoEIlpStBMIos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvamdXz9fiQI/dKPOo+nmS8YBFasyXMonuckmomzOsLmExk6YMvdsVluzpc4Fcvp/ZlxbB7lEC9YWLZTdIY4MqEsaKgG/1z8EXzCGxyS/nfeA4pB5vbaQKkVCQwC9E0Qnp0M0rMR2yfEKOo57jvY/Gg5NQBH+ZKCj7v2PdIjBWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7D7u13k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7D7u13k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A8E1F000E9;
	Mon, 20 Jul 2026 06:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784527551;
	bh=XJ27NF5mECz+3CgTj2zpeWRieXtQbm3hXE1VmWAZHXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e7D7u13kECFetN8Izj+Rcn/rbnQG7q63xIVDEa3daZ8SA4jfAWStwp4dxY98P66GK
	 rWL9OkDaoReq4Njv5zpmiAX5sqAg41YD4DAsOorAfnb3L3uDapvkqm1hAIVU/tNJQP
	 JUP+1O5ixM5y31G5dE4dqsm29OC0oH4tEafaEQcaLGmpl7TtXfS+uy4UuD8e2HTtpC
	 SRMhpxIi7znvhUJR/ZzzVhpnWZlzfl+4oQqYa0/3VgwFYny2T4ZO5VlLh+/Z0EnOK8
	 rWvU0hhRuffggv77ph/JgVf3A0yUk/JDKoQmxdul01sNJQZ5ZFHtOJLvHYV3UhrPy2
	 2vlF4bPjgMDkA==
Date: Mon, 20 Jul 2026 08:05:47 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nikolai Burov <nikolai.burov@jolla.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Ulf Hansson <ulfh@kernel.org>, 
	Matthias Brugger <mbrugger@suse.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, 
	Nikolai Burov <nikolai.burov+review@abscue.de>
Subject: Re: [PATCH v2 1/3] dt-bindings: power: Add MediaTek MT6858 power
 domain controller
Message-ID: <20260720-vigorous-groovy-cassowary-9912d9@quoll>
References: <20260715-mt6858-pmdomain-v2-0-6293e87fc093@jolla.com>
 <20260715-mt6858-pmdomain-v2-1-6293e87fc093@jolla.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260715-mt6858-pmdomain-v2-1-6293e87fc093@jolla.com>

On Wed, Jul 15, 2026 at 04:54:05PM +0300, Nikolai Burov wrote:
> Add a new compatible and document bindings for the power domain
> controller of the MT6858 SoC.
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

To provide review, please open and read the entire file.

> Signed-off-by: Nikolai Burov <nikolai.burov@jolla.com>
> ---
>  .../bindings/power/mediatek,power-controller.yaml  | 21 +++++++++++++++++++-
>  include/dt-bindings/power/mediatek,mt6858-power.h  | 23 ++++++++++++++++++++++
>  2 files changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> index 070c6e5666dc..d03e4a925163 100644
> --- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> +++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> @@ -25,6 +25,7 @@ properties:
>      enum:
>        - mediatek,mt6735-power-controller
>        - mediatek,mt6795-power-controller
> +      - mediatek,mt6858-power-controller
>        - mediatek,mt6893-power-controller
>        - mediatek,mt8167-power-controller
>        - mediatek,mt8173-power-controller
> @@ -56,7 +57,7 @@ properties:
>        faults while enabling or disabling a power domain.
>        For example, this may hold phandles to INFRACFG and SMI.
>      minItems: 1
> -    maxItems: 3
> +    maxItems: 6

And the rest? Why does this device have flexible number of access
controllers?

Best regards,
Krzysztof

