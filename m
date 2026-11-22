Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795366415;
	b=yPOpkmKZsF8T1oMagEod0un3vtokdMjj8P57ELyXD+U0yYsJCZHCu0uwJLPSqO9ggpGB
	 EES8fAW/No8IrD3ckvu5RPuPGebgNtVWfXPauTBzWhuqAu1Y9dmWLqeW2c2lOca6kR8KC
	 REHjiyeyE5ulO3fhg3hZ3SMg3gA0l+oxvXB0UvOyM63qV4djeCHjy2iNdyLLMNQ9DOug2
	 RMqeFIlU/oF3fW8mVb+VeRQ/vXofJqAWmi6Jq8/3EOyRO8gwZSINhPFkE7jJ9d1C6ZONI
	 KAPT+dvtRB1DkkjJHCH5DLK16ot9YO+36sTZe982ObizV4EgUnWrIU0FUb+N0gwVPWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795366415;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/15f6ZjHF8yYj2UrtTX7/aYIK6eHyTuu6zxtnLvBfIc=;
	b=KGiojQBHYgIvpQw2o+N6C8oG1bPs2ukkTJK+o6EmR0eBCVqbSwuzF1HJkpXuZgZwvvIi
	 a29UVql6NHfmyvXglH3JLUtlRPOM0EmWJGz2NbU0uXwQsJkm7ZPQX8NcFu3Bn8TEm0Ts0
	 JpJJPrKL0pxB2pan445M++ImGZsY2Q9KA7PgCWt+WzWqfcV2vpPdrlnFgAWjsC7pzRO1+
	 oRJj9DPd3pprBwX6gKH39jTcmqhQISGAHDTHA6lqFxYay4P/eyg5cFFGzWFyvvl22yXVT
	 B9a96vqf8ov6tC7B4s57wgZelaA/G/zxdXMBLqV3fnuQ70mSNC6X3CKLPJLYtVebARg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WIeLH4Tz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41347606A320;
	Sun, 22 Nov 2026 16:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WIeLH4Tz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2491F000C4;
	Sun, 22 Nov 2026 16:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795366414;
	bh=/15f6ZjHF8yYj2UrtTX7/aYIK6eHyTuu6zxtnLvBfIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WIeLH4TzFoWaI01pl7wgjBHBkB4uyIz/V+xYss1hYNEQdHzpI3E3i3hi9OVmN9idL
	 bDHkcaoss5HmKfI/t8JNXmj6gOafoauIlCr26vmDVlCX/PdsN6bVtEayE37cTBtiDT
	 4FByEoIFx7CnKsyBxlmvQkLhwrUQlE3ereYLyfx/VD/XFnPk+woMMGig+UzVg5VIrf
	 QWbipiwaqUJC2ImbRPxoRHAtLcel0Jz7WtkZTDeU0wkl1qvQBIKWl/vJUY4DP6hZ/1
	 oAdN77hqnqsjdAgT5qXKckrf+SXULNENsEIhQGNv7Kaf3dYaC81DqQ2hSuQWfLDGMf
	 2FnYu84SbQXLg==
Date: Sun, 22 Nov 2026 17:53:30 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org, 
	viresh.kumar@linaro.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	treding@nvidia.com, jonathanh@nvidia.com, linux-pm@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	bbasu@nvidia.com
Subject: Re: [PATCH v3 0/9] cpufreq: tegra194: add Tegra264 support
Message-ID: <20261122-elfish-amusing-muskox-d6cdef@quoll>
References: <20261119111217.902071-1-sumitg@nvidia.com>
 <2698e091-17e9-4a1d-acf1-19981ee604da@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2698e091-17e9-4a1d-acf1-19981ee604da@oss.qualcomm.com>

On Thu, Nov 19, 2026 at 07:41:34PM +0800, Zhongqiu Han wrote:
> On 11/19/2026 7:12 PM, Sumit Gupta wrote:
> > This series adds cpufreq support for Tegra264, which joins the SoCs
> > already supported by the tegra194-cpufreq driver.
> > 
> > Tegra264 keeps the existing model, where BPMP provides the NDIV limits.
> > The driver derives the current frequency from the core clock and
> > reference counters.
> > 
> > The main differences are:
> >   - Frequency read: through system registers, as on Tegra194, but from
> >     the 64-bit architected AMU counters. The reference counter ticks at
> >     the system counter rate (CNTFRQ).
> > 
> >   - Frequency request: through MMIO, as on Tegra234. The driver writes
> >     NDIV to a core_freq_req register in the CCPLEX register space. Each
> >     register controls a clock shared by two single-CPU clusters, so both
> >     CPUs form one cpufreq policy.
> > 
> > The patches fall into four groups:
> >   - Fix (patch 1): read each CPU's MPIDR from a CPU hotplug callback
> >     instead of at probe. A CPU that is offline at probe then also gets
> >     valid cluster and core IDs.
> > 
> >   - Preparation (patches 2 to 5): cleanups, mostly of the counter code,
> >     to make room for a 64-bit counter and for an MMIO mapping without
> >     ACTMON counters.
> > 
> >   - Improvement (patches 6 and 7): group CPUs by the generic
> >     "performance-domains" property, which cluster-based grouping cannot
> >     express on Tegra264. Device trees without it keep the existing
> >     grouping.
> > 
> >   - Tegra264 support (patches 8 and 9): the driver support, followed by
> >     the device tree changes it relies on.
> > 
> > v2[2] -> v3:
> >   - Patch 8: read the AMU counters with interrupts disabled (Zhongqiu).
> >   - Add Reviewed-by from Zhongqiu to patches 1-7 and 9.
> 
> For patch 8/9:
> 
> Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>

Why you cannot respond to specific patch? Tags applied to cover letter
work completely different!

Best regards,
Krzysztof

