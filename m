Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040173019AA;
	Fri,  3 Jul 2026 06:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783059629; cv=none; b=Oauo0zqJnFvWuqbBo+4M3VtuP7nwRA4Nh/NTOBgi206LTITdUYB2oO7dPDoFy6JEnSulIgtue8LIogxAT1Aw9VDhcPnm5Guhjry7a8cs3Vf4tt0pilsomxC20k4npYn5IftmzzzTN0L/R4J61lcrFwmY73exr9NoSnaYZKndqdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783059629; c=relaxed/simple;
	bh=vjuDqyfxp0IWWyjc+HDhwkXzpy2rC9dZ3qsZEn3remU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHIf/JlXkLWkpkItGeNwWdqmHkSQ5h99JXPVmCkiE2dPaHvF2j/ABj962iO+CW44Uiyi/e3m6kaDeN31U+J36oUiQVLy4DgQl0kvcoJktx7jxaVKIQ4okVgTw8KzeVo37ED8w2soI5qLMMfBwXctEXAQ+rEX+qqw8S9ePx7r8fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZjVQ4k1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZjVQ4k1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F19E1F000E9;
	Fri,  3 Jul 2026 06:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783059627;
	bh=pm0t9ydFcpktLa35+YRQ3ivYFMa29UixUYCSb79e5D8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bZjVQ4k1ra3vF0HtF3nNyzma+8cJst63bGd3qSZv05vgRXmQ6HgYGgtlWuQaxzKdv
	 WMxVwoM1CzZ4je2Wdj3qTHgPkL1xphlqNmCZ6dSSsbLqNwdhgHWvWaidTFF9/WuB4Q
	 2REp+aPksQ/wVw09Zjh1DXLL4FmY3bySjRICl2/f9DNj/iEDNUXnnvw6Efru05dw3B
	 MQpdndhbVHZXlhTrZ6nnpj8qtFz1AZ7EtqnYa2z80gdOzTImPgF1ciyw9nTFzu3IkT
	 Oti/vNwmXdZ/bQz5St0kuy3K1J1fE29hs9Eqkd8UQoyfJK91I1B245EeYBAOCAm8Ks
	 QAeXrAdwTEVyA==
Date: Fri, 3 Jul 2026 08:20:23 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>, 
	Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: power: Add common power limit
 controller schema
Message-ID: <20260703-modern-indigo-wolverine-6b6eaa@quoll>
References: <20260702-qcom_spel_driver_upstream-v3-0-434d50f0c5b0@oss.qualcomm.com>
 <20260702-qcom_spel_driver_upstream-v3-1-434d50f0c5b0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260702-qcom_spel_driver_upstream-v3-1-434d50f0c5b0@oss.qualcomm.com>

On Thu, Jul 02, 2026 at 10:52:54PM +0530, Manaf Meethalavalappu Pallikunhi wrote:
> +title: Power Limit Controller
> +
> +maintainers:
> +  - Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
> +
> +description:

You should have | to preserve formatting,

> +  Power limit controllers are hardware blocks that enforce power consumption
> +  limits on SoC power domains to prevent thermal overload, maintain system
> +  stability, and comply with platform power budgets.
> +
> +  These controllers typically provide
> +    - Hardware-enforced power capping for one or more power domains
> +    - Configurable power limits (e.g., sustained, burst, peak)
> +    - Time window controls for power averaging
> +    - Energy or power monitoring and reporting capabilities
> +    - Power balancing algorithms across domains
> +
> +  This binding describes the common properties for power limit controller
> +  provider nodes. Individual controller bindings should reference this schema
> +  and add device-specific properties.

Where are the properties? I see nothing - empty list of properties.

> +
> +select: false
> +
> +properties:
> +  $nodename:
> +    pattern: "^power-limits(@.*)?$"
> +
> +additionalProperties: true
> 
> -- 
> 2.43.0
> 
