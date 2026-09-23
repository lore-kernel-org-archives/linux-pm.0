Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8999A51CF76;
	Wed, 23 Sep 2026 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790174861; cv=none; b=ApcdWt3uD6dkE73E4XKlp8o7IckmaSu1LMr5ZURfRq6iXeYG68XLSZpLvI08YWe1k2UBVyfF/G4az897H3wTHvSvwmLBdcTbpC8vmxTUA7MzgCrdK5Vc1K5zz1ItHUfFbUK2RQ5cVKAs905t3U3XcNIARkOTK69oWc5lHTIqvwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790174861; c=relaxed/simple;
	bh=MwZgnHPFFGSL49mOgaoJtNsPPKvCGM4K3GZNXUY+5xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXFbWVddrpnolNmm5v0q7Tt9JMZ1jymix80vDDFsMqaxw8Qgok4KL6wIzw4WFCQqp0kKUo97MpaHiOqNDD7jekHE01c+3o1XYPtSA8Vo9zyfl35pTa4V/HXSUolbOY98DIbNGlTIV8Hxl1D9rJlsOrwQgIwwRRvKrxCec/AruK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DiitupBx; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DiitupBx"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 453C9152B;
	Wed, 23 Sep 2026 07:47:35 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7B9E3F86C;
	Wed, 23 Sep 2026 07:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790174858; bh=MwZgnHPFFGSL49mOgaoJtNsPPKvCGM4K3GZNXUY+5xg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DiitupBxbjkThSFpOSKScvVyDKIYwZVZU+IsbhFP/W6+udcJWW9cCrEzhu6dvx6EN
	 p3L9MfIbHQOPCEuSWLgvC3bHkfURsw+BrWtEUB9/1+QHUCVAkYMcMINcaJlsfBSEro
	 2aMOQW8rfqkvqYa2+YZnMF8jexjIVFnZ9e/NewoQ=
Date: Wed, 23 Sep 2026 15:47:34 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Oleg Keri <okerixx@gmail.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
	Beata Michalska <beata.michalska@arm.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Ananthu C V <ananthu.cv@oss.qualcomm.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v6] arm64: topology: fix arch_freq_get_on_cpu() overflow
 above 4.19 GHz
Message-ID: <arPmhnU-pkGpaD4-@arm.com>
References: <20260923125604.2482-1-okerixx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923125604.2482-1-okerixx@gmail.com>

On Wed, Sep 23, 2026 at 02:56:04PM +0200, Oleg Keri wrote:
> arch_freq_get_on_cpu() computes the product of the frequency scale and
> the reference frequency as a u64, but assigns it to an unsigned int
> before shifting it back down:
> 
> 	freq = scale * arch_scale_freq_ref(cpu);
> 	freq >>= SCHED_CAPACITY_SHIFT;
> 
> The product is truncated to 32 bits before the shift, so the result
> wraps once arch_scale_freq_ref() exceeds 2^32 / SCHED_CAPACITY_SCALE,
> i.e. 4194304 kHz.
> 
> On a Snapdragon X2 Elite (Glymur) laptop, whose boost OPP is 4723200
> kHz, cpuinfo_avg_freq reports 524283 kHz instead of ~4723200 kHz while
> the CPU demonstrably runs at the boost frequency: a fixed workload
> completes in 1.72 s at the 4723200 kHz OPP versus 2.01 s at 4032000
> kHz, matching the 1.171 frequency ratio.
> 
> Shift the u64 product and narrow only at the return.
> 
> Fixes: 16d1e27475f6 ("arm64: Provide an AMU-based version of arch_freq_get_on_cpu")
> Signed-off-by: Oleg Keri <okerixx@gmail.com>
> ---
> Changes in v6:
> - Drop the cap_scale() change. As a u64 static inline in a shared
>   header it would cost future 32-bit callers a 64-bit multiply that the
>   macro did not (Will); the truncation is the unsigned int temporary, so
>   drop that and leave kernel/sched untouched. Will's Ack on v5 not
>   carried since the arm64 hunk changed.
> - v5: https://lore.kernel.org/all/20260917182059.2851-1-okerixx@gmail.com/

I assume Dietmar and Will's acks still stand. I can add them from v5
(let me know if you disagree).

-- 
Catalin
