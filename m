Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA32B1CEAC2;
	Fri,  5 Jun 2026 12:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780662745; cv=none; b=WtHyfdY8oaB91r8aoYYMt2M4p9hY7TBVDCsYrbmpqCfU4lsivv4W+Xho2T7XTzoUofabFjEqB7p+a1B3x8/hZ7bCydD5HjIhEvgMPFN3J1HyGD6bDDACN1Wy6U2Xmt1Au9iKOcqu27R0w9wUpq83bgoWMpk2SvfvdHP3RNhJlDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780662745; c=relaxed/simple;
	bh=k6oYQJNcr5f0Jhbt+inmWKxBi0O2ofPEgmENnOmypZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYzvTeILWUNvf9n6tCzZSyEcAYLmFgDcyW9DqgpgJjYUx4Wpe5DnBoWoAXlMHynPUv9uyyfVPjcVaNDP4VGhG9/XxFpz7HRb0ghosSEoUqKNI4vpT4YiAG+Sm2kk6WXTB+qJptfVNoOqQ4+DPwUPg+/JvKKQNZf5lGF6zqXNPHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTMV+dUb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTMV+dUb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED761F00893;
	Fri,  5 Jun 2026 12:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780662744;
	bh=QJZWeu/CAsNhvLdYQ0LGuGabFiBbIMVq8mhdqfQ3070=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iTMV+dUbbExPGYpaEujb3KyB0c0qB+x6soIcWNyWkpbjzBKGhPmBfjKe3QY0TvIvP
	 AdRJXsw+6LZbh8Ri6ZINPmZM+e8AW7fWakBWIbeW2Aux4A+5cKxhi1FDu4vmGN0w+K
	 Hr+RuePhQUOTtWgnUbHlBaeU2B2leRAzUUf1GkXx0zA0l72vBnjI2i579Tbl8TT+Gw
	 DQYwvGFbJPQIQx6eThLpY4/lTf2yIAUiP8m3jl7M7ErFl2QQAynMaaI0EbgN4nRO9F
	 UqXH1bSfsELY1umLX5vQ/GdWtW1sEhGoT+OW/23CLO+MC/h1JKnjDF4dAZf2d5bKXO
	 YX+m4M1sB3VKg==
Date: Fri, 5 Jun 2026 14:32:20 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sibi Sankar <sibi.sankar@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: interconnect: qcom,osm-l3: Add EPSS
 L3 DT binding for Qualcomm Shikra SoC
Message-ID: <20260605-imaginary-essential-kestrel-0bf265@quoll>
References: <20260603-shikra_epss_l3-v3-0-3c2e0b796e78@oss.qualcomm.com>
 <20260603-shikra_epss_l3-v3-1-3c2e0b796e78@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260603-shikra_epss_l3-v3-1-3c2e0b796e78@oss.qualcomm.com>

On Wed, Jun 03, 2026 at 11:26:12AM +0000, Raviteja Laggyshetty wrote:
> Document the EPSS L3 interconnect provider binding for Qualcomm
> Shikra SoC.
> 
> The Shikra EPSS L3 block is similar to existing Qualcomm EPSS/OSM L3
> providers, but supports only up to 12 frequency lookup table entries.
> 
> Co-developed-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

