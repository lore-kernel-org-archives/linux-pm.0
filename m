Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1453F7AB7;
	Fri, 28 Aug 2026 09:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787910998; cv=none; b=cQWZgSSMAqF22RAsUh7DY7MDZ/15CRd3XHlzIe+FSM7NXzmp2Co9Cvy3gBN9bytmQG9yHygYlUNiKJciepBDhWmpUCQtqBesI9+F5lze1SYW22D/D5WjMyDM5oQH/CfHMFP9qK4QGm1RzQAIOLQP7OxbGBbZ9j8o1uFVIsS0f1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787910998; c=relaxed/simple;
	bh=lXETUQg915sztNxwiHH1Fjms2j4DOHmuRNr3d+j19+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tl/azddtLHENf0tMuREMwA0Byty264QqelOcxFQNvAI95YqmT596AdBBM/Dcorvu33RHU5BZLCBg85XxNRPFpKnPoFWZGWID8+bMjbTdpT2dPCUfu1LUaHGXmJVyXG4DY+/k7A/5arwz9UNAaHFK62kSy65uJvjCvSuLLRw9Uz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyHpHyTW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyHpHyTW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8A41F00A3A;
	Fri, 28 Aug 2026 09:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787910993;
	bh=HleWmOudSXdQ5Id/XLyTjYYYma/Xr4bAKsDrP2oCuYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lyHpHyTWKzzuVKi5W+RuZq6xLiX1JXFAmsHlAe33/VhcAj/GuE078k8ZBD+r9oves
	 CDinIFeKc0Q/PZZ4tadN57nZu2heXw48mwPWQZOEBKFPhCsKw/gTxx/c7eWt8K61et
	 r0M6mbObNgJeOJuQ/vu3Y4TqjPq299lvoKdLnGZYZGs3EpI2MXkH+6sa+OE6a69afQ
	 PKeTFL4gfBsK0N4QC1+xKnMvM/NG9MHK0FzSWkZ2XJzDeYvJ4TTsKrpq6vXwE0PnDF
	 WBnpz2g6GoxzF0rIUKDa36yb/gkMFLfY4z/9rf/229Y7E0HLUKD2S9MECQGt27reOh
	 74mr7/IvMYYuA==
Date: Fri, 28 Aug 2026 11:56:30 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sreeshankar K <sreeshankar0910@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, rafael@kernel.org, 
	viresh.kumar@linaro.org, konradybcio@kernel.org, tglx@kernel.org, ulfh@kernel.org, 
	bmasney@redhat.com, radu@rendec.net, abel.vesa@oss.qualcomm.com, 
	lpieralisi@kernel.org, taniya.das@oss.qualcomm.com, danila@mainlining.org, 
	davidwronek@gmail.com, mani@kernel.org, robimarko@gmail.com, linux@gurudas.dev, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 00/13] Add initial support for Qualcomm SM7250 SoC
Message-ID: <20260828-liberal-jumping-quokka-cff4da@quoll>
References: <20260824150156.1310-1-sreeshankar0910@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260824150156.1310-1-sreeshankar0910@gmail.com>

On Mon, Aug 24, 2026 at 03:01:43PM +0000, Sreeshankar K wrote:
> This patchset introduces foundational upstream support for the Qualcomm SM7250
> SoC (internally codenamed Lito).
> 
> SM7250 is an ARMv8.2-A platform manufactured on a 7nm process, featuring an
> octa-core Kryo 475 CPU configuration (1x Prime Cortex-A76, 1x Gold Cortex-A76,
> and 6x Silver Cortex-A55) and Adreno 620 GPU.
> 
> This patchset is organized as follows:
> > Document relevant device tree bindings (SoC ID, Kryo 475 CPUs, SCM, PDC,
> RPMh clocks/power domains, GCC and cpufreq hardware).
> > Add driver support for SM7250 in socinfo, rpmh-clk, rpmhpd, and GCC.
> > Add the base SoC DTSI (sm7250.dtsi) defining the cpus, PSCI,
> interrupt controllers, clock providers, power domains, and reserved memory.
> 
> Dependencies:
> This patchset depends on the following patch:
> > [PATCH] dt-bindings: clock: qcom,sm6375-gcc: Merge SM7150 into SM6375
> Link: https://lore.kernel.org/linux-arm-msm/20260817082457.64797-2-krzysztof.kozlowski@oss.qualcomm.com/T/#t
> 
> [PATCH v5] Link: https://lore.kernel.org/linux-arm-msm/20260824130437.2771-1-sreeshankar0910@gmail.com/T/#t

Please keep the previous changelogs and links.

Best regards,
Krzysztof

