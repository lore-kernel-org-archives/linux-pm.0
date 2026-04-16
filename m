Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562D834D3BE;
	Thu, 16 Apr 2026 12:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776341037; cv=none; b=TUokRRB2Jii7GArO5tbruFzLNFZjfHDBA9G8lKm5XOo5H1N/GbWLg5u4b5HrLVPh/WyzaxwMN1PA2iYf1XtPoLTdtgvV2tSg4opHU4ASZ3antbC7pnhTVbsVR1wAj7Dk2dfk4pDoG0lXSut9KlZobrZJD5IbO+KpiDl5D4L80/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776341037; c=relaxed/simple;
	bh=RV/pVm8MsCdGAJco1670hjDP15pZoTBL/ZV1sRrirzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBncq/KPCabNqB4ual4TyiC5nd3sKzhHk+O0NJxPGboGdXX+wRaSPUnH2mQbms4ddc5tmJs4k7chwxDgSH63o2+OJw78cd+1qgbZDz56Ytl7xQ2gjwNoHIVZhaDFnWnCfqdlvR5zGKa2lj/lBywSc8+Vg7D0vg5STljU5ff1hes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9QIbwsP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9QIbwsP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B20C2BCB3;
	Thu, 16 Apr 2026 12:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776341037;
	bh=RV/pVm8MsCdGAJco1670hjDP15pZoTBL/ZV1sRrirzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R9QIbwsPOe2YCFQmPMnCippjkeP6Qa8MUXuAuHnnykuDdh5djsmYku/XiSm3Y1tyM
	 dqk+v36Fo2mWS8tUD+QFV2NQ3scIPDihA67UqQEnpiYzW4PK1PdHbf0nlHMzcXPQtO
	 rayiv8icPm/+SCIC/pF8p5IM8MzYMSkR1pK1dxS+niYSdHx47yCzxWGH4lDOQe71aA
	 3oANnkpcSaIOdS+DHmOtyc8YS2x3FoDNod0Uurs0Nay6qQRaaL43zshyIplICVSXVC
	 NrKsslIZPaMKN5LJLbyGHp9tryjiqe/E+PPQW1b8FBmH3VNSLn8fHxnXtpb39wDTDU
	 Q9E1BDptW8yWA==
Date: Thu, 16 Apr 2026 07:03:55 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Kevin Hilman (TI)" <khilman@baylibre.com>
Cc: devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: power: Add power-domains-child-ids
 property
Message-ID: <177634103449.2736751.6317268015188601498.robh@kernel.org>
References: <20260410-topic-lpm-pmdomain-child-ids-v2-0-83396e4b5f8b@baylibre.com>
 <20260410-topic-lpm-pmdomain-child-ids-v2-1-83396e4b5f8b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-topic-lpm-pmdomain-child-ids-v2-1-83396e4b5f8b@baylibre.com>


On Fri, 10 Apr 2026 16:44:36 -0700, Kevin Hilman (TI) wrote:
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
>  Documentation/devicetree/bindings/power/power-domain.yaml | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

