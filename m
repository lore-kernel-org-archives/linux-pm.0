Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794935941;
	b=mLc06ntr2E1fqcfZDpyjNWG9Uio9sH5ea5M5vFMKpLJ6Jp49pQ9X9+gCcFU7rHtqisWI
	 TdxEjQkqltpkb7HvmtoRw2uPB5FHQTjYtdcEuEkF84F4cvWbQcKZPKottDL4TQUaSNO9s
	 S+zewczMDWZP4vJTIBYrx8kU2CyAT46VDJ1JeLvNPJDUa2kGoabgxme31Md0aLXuGi0+I
	 5Fp8xCH9XvTuwOfa+RnRf50sh9cmrjBltjh3FUYDssiso5IFEKRFKkGHkIkAVKYKrUUxC
	 ih/KTt/25XAhPPC+agtrVgXsxdPxLjZQJgtNBHyJVlSFyYTEzOa7Pr+jNVjY7T3GQuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794935941;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=NlZVWqmvZWHITNYiqbgfMr5wxDub7pUxLf4YfFXgD68=;
	b=wIwh/7kK2alGyllNcu6uwkBiWljG1BYyNL37mLj97LOcNvcUyxocHR5QKZiKUpkqjiaW
	 b/d1Nx95qhvTkJRQkNupS17l7DorLpwHf/QRBPCjjJGtZ/tpBWaPVF/iYE3T6uxkHs/XO
	 oIFAf6Z457HFsubRNIS6bXFJjuBFoWWSffW76IKH4Ql23wnf8KeoYgjyTgG67rVyAz8U2
	 pQw/F97l3GFauGuFR6vOS5+4SxtwPzlp/JrVbs0lPxCx5u0pVoI0nbXXaVC0/RgSVYUVk
	 OFWN85bpW7LAx+tXSJfZYALRoW+5Kdg6ciCiSHfCYZlTp9FZQ7utulnbW2SwO0DudhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KJWQxbbH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB379606A31C;
	Tue, 17 Nov 2026 17:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KJWQxbbH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43AA41F000C5;
	Tue, 17 Nov 2026 17:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794935941;
	bh=NlZVWqmvZWHITNYiqbgfMr5wxDub7pUxLf4YfFXgD68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KJWQxbbHQtVsO3ajxbSUqzgVmUczjQSHPjQfsKb+nWioITz4tpc8zjQMlCKp3PzR8
	 mJ9mcVHOTUHScyns9PW7aH7odcC1IHCExeMfF6pohSiOggohnsRQcJFeiQGULO/sxM
	 HQji3sGd6R0LJaveZry307kFNc4gHAwLTPt8E5CcTNqLGv5yURwmzONp76lHY5Wc31
	 v+oxNicTiVCQWzBitxEcKFFKQsJxip6/1i9gXQnl5yqD54IE1Fw7xkFq8vj/HQW7oW
	 P6kZW1YjAq/O41nKIW5kXvATbAizBFO47secTMpGlmvvnGkdf/xkYhf3kSRJmLt+LK
	 Rox9DhfKXD+BA==
Date: Tue, 17 Nov 2026 11:18:59 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Lee Jones <lee@kernel.org>, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Guenter Roeck <linux@roeck-us.net>,
	William Zhang <william.zhang@broadcom.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	linux-hwmon@vger.kernel.org, Kursad Oney <kursad.oney@broadcom.com>,
	mfd@lists.linux.dev, Stephen Boyd <sboyd@kernel.org>,
	linux-pm@vger.kernel.org, Brian Masney <bmasney+clk@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Anand Gore <anand.gore@broadcom.com>
Subject: Re: [PATCH v5 1/6] dt-bindings: mfd: Describe the BCM6846 PMC complex
Message-ID: <179493593878.2709317.8975088229427570809.robh@kernel.org>
References: <20261117-xg6846b-bcmbca-xrdp-reset-v5-0-f584e8b8e696@kernel.org>
 <20261117-xg6846b-bcmbca-xrdp-reset-v5-1-f584e8b8e696@kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117-xg6846b-bcmbca-xrdp-reset-v5-1-f584e8b8e696@kernel.org>


On Tue, 17 Nov 2026 00:47:53 +0100, Linus Walleij wrote:
> Describe the BCM6846 Power Management Controller complex and its Power
> Management Bus, including the power-domain, clock, reset and PVTMON
> providers. Define the clock, reset and power-domain IDs used by consumers.
> 
> Keep the complete hierarchy in one schema so each child is validated
> once through the PMC binding. Include the combined XRDP, Runner and WAN
> power domain and the zero-cell PVTMON thermal sensor.
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  .../devicetree/bindings/mfd/brcm,bcm6846-pmc.yaml  | 238 +++++++++++++++++++++
>  MAINTAINERS                                        |   8 +
>  include/dt-bindings/clock/brcm,bcm6846-pmb.h       |  42 ++++
>  include/dt-bindings/power/brcm,bcm6846-pmb.h       |  12 ++
>  include/dt-bindings/reset/brcm,bcm6846-pmb.h       |  11 +
>  5 files changed, 311 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

