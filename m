Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1912A3328E3;
	Tue, 24 Mar 2026 23:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774394722; cv=none; b=kcC8ZZZp5uRWfGFOfYiD+cD5/Ex+w1BWNit4938W2B9VtKMJsIyBFTEBa24+Di9e+Wj9oHisMN/hxB/MGJUZQDoAM/4ziTkdZVM3YVnSKvSelEgfnXRflnA4RFp04L7D3qIKovPXfw6Xin7NuGXBN1/bnSmC97lFr1cV4ezGQsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774394722; c=relaxed/simple;
	bh=8M2lfLTY30frg/KZdYPe5W7EMROR9Qeg+pO68+yl6Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwEKSVioHDp9FNmmbGsHrLxsA8L/NzRyT3TIoNbsoL+lGbv/GshX6ANe+KUAXbXMtnCDMvN5mh8GYl4mWnDGZrzpVXtUr4by56255jS00Rd91j3Llp/VlK8/sYUij1fQMBbYoi8gNkWOqyyL5QWn8vk1UBHv4Fz9swf4Bdgl89s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUpZcUDx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUpZcUDx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C481C19424;
	Tue, 24 Mar 2026 23:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774394721;
	bh=8M2lfLTY30frg/KZdYPe5W7EMROR9Qeg+pO68+yl6Kc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uUpZcUDxNxE64Me8evCj/8m/kPF0rqXW7NULInKarHq6hDsx+EqcsOsDT6YLE5YOv
	 84fGJofuOiE+XO1hX9kXSjaWRfDKUxSVi5nGliR4H0V9q3sK7Q2gfLO0QLoWEHj7jy
	 Pz565Tn2iB0vhZsZYq3eF61JXpEgYloT3UIJuVAvpRLfS9siV1zagiZPAM4c8J/y8D
	 VKu0mdfWbmlNkzT2VDYl/pU1NOb79EUW2nLU0ZL3/gzxQhFVQ3YOi/ehEazBVjpy8E
	 NuWE95DnBOqmilyUXeULaVocQ+bME4KzYMeJECGqpCuAJ5WKsm1mMmWlDEettZg+3Y
	 7POC+XZ5K5oBQ==
Date: Tue, 24 Mar 2026 18:25:20 -0500
From: Rob Herring <robh@kernel.org>
To: "Kevin Hilman (TI)" <khilman@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: power: Add power-domains-child-ids
 property
Message-ID: <20260324232520.GA2225579-robh@kernel.org>
References: <20260310-topic-lpm-pmdomain-child-ids-v1-0-5361687a18ff@baylibre.com>
 <20260310-topic-lpm-pmdomain-child-ids-v1-1-5361687a18ff@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310-topic-lpm-pmdomain-child-ids-v1-1-5361687a18ff@baylibre.com>

On Tue, Mar 10, 2026 at 05:19:23PM -0700, Kevin Hilman (TI) wrote:
> Add binding documentation for the new power-domains-child-ids property,
> which works in conjunction with the existing power-domains property to
> establish parent-child relationships between a multi-domain power domain
> provider and external parent domains.
> 
> Each element in the uint32 array identifies the child domain
> ID (index) within the provider that should be made a child domain of
> the corresponding phandle entry in power-domains. The two arrays must
> have the same number of elements.
> 
> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
> ---
>  Documentation/devicetree/bindings/power/power-domain.yaml | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/power-domain.yaml b/Documentation/devicetree/bindings/power/power-domain.yaml
> index b1147dbf2e73..a3d2af124d37 100644
> --- a/Documentation/devicetree/bindings/power/power-domain.yaml
> +++ b/Documentation/devicetree/bindings/power/power-domain.yaml
> @@ -68,6 +68,21 @@ properties:
>        by the given provider should be subdomains of the domain specified
>        by this binding.
>  
> +  power-domains-child-ids:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      An array of child domain IDs that correspond to the power-domains
> +      property. This property is only applicable to power domain providers
> +      with "#power-domain-cells" > 0 (i.e., providers that supply multiple
> +      power domains). It specifies which of the provider's child domains
> +      should be associated with each parent domain listed in the power-domains
> +      property. The number of elements in this array must match the number of
> +      phandles in the power-domains property. Each element specifies the child
> +      domain ID (index) that should be made a child domain of the corresponding
> +      parent domain. This enables hierarchical power domain structures where
> +      different child domains from the same provider can have different
> +      parent domains.

Okay, I guess we stick with this. Sorry for the detour.

With the example fixed,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Rob
