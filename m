Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA18F3A9DA9;
	Wed,  3 Jun 2026 10:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484092; cv=none; b=B1iGxtzvxMznfXfgFUxVGxb4ipIWZqFOBvxvwKqqT4654PFkmexjXrt8t/mqzZ1dyd75GHD+9vRazFQe4950dRMz9uagK5ElfQxdiSEZj1lKzIHf68DkPU6o4mBpfxc2WOUmL0Gq8Bfca3YgvqOtfBHRe66zJbcukr2SZET4tls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484092; c=relaxed/simple;
	bh=Cb/2f3IOVyjVG3HvO/oBo2cGvY8f9XM8YOxOFI7ov18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FD6KRQDTm+oDPurAQKYKqFrTzaqVS5eptmgVyY6NSFKdJ43rYwA0f21CxiB88rgHU5FOZFdWxdQWhCj6ozS/wu2+WspsDX1d3JikSQ76XBA4joL+jyganrbJUDOpV2/RvHqeF84oMLfI0oNeH0fadpJ+JYq4lCc8NsOsRr9oMyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=mZSPLpmf; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="mZSPLpmf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=09IF4r2GPP51QC7fgR7GmCwwxB+trhrkzGHUOHz7fIk=; b=mZSPLpmfYTDC2FNPWZyT7nCDWB
	XOJF+q295bze2DseYwmiUqORfac0Vff6GMAnYtP7jCubT53kvQ1FoFI+JDp9R0Zn2wxzXDbXksp21
	pU9jVCXJB0PKUywhsa0+lPRZeM8L+hKO6uEShUwY5gCHOcHOIl3GqGcgJWK12Szx0USiwDrB3wM1f
	3SDW0rmNaoHNbOwBuGVgVZIPB+bSYTRjZCOscOl575usT9W91OjJhM1vBldFEfB4OuXuUNNkwsb1A
	/m+e+95LNYxFSknS5rwHJAw6W1ukLEOhgVCPegIrqWc06/Z1/XbGHheoBux2e7jcPxmlDoNynBQkg
	kzrWLY3w==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wUjFC-003gKG-2H;
	Wed, 03 Jun 2026 10:54:43 +0000
Date: Wed, 3 Jun 2026 03:54:37 -0700
From: Breno Leitao <leitao@debian.org>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-pm@vger.kernel.org, sumitg@nvidia.com, pierre.gondois@arm.com, 
	zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, viresh.kumar@linaro.org, 
	rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: cppc: Reduce cppc delivered perf sampling jitter
Message-ID: <aiAGtKDKTVy2e4ds@gmail.com>
References: <20260602212052.1278365-1-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602212052.1278365-1-jeremy.linton@arm.com>
X-Debian-User: leitao

On Tue, Jun 02, 2026 at 04:20:52PM -0500, Jeremy Linton wrote:
> CPPC uses a pair of registers cycling at different frequencies to
> determine an accumulated performance level. For userspace reporting we
> want to convert this to an instantaneous CPU frequency, but over short
> time periods small errors caused by CPPC counter reads can cause
> fairly significant reported frequency variations even when the core
> CPU clock isn't changing.
> 
> Reduce this by keeping a start sample fixed and retrying the end
> sample until the counter deltas are large enough to reduce short
> window error, or until adjacent delivered performance estimates are
> within the CPU's observed CPPC read noise floor.
> 
> To begin, resample the initial pair a small fixed number of times
> looking for matching delivered performance deltas.  This reduces the
> chance that a disturbed start sample anchors the rest of the
> calculation.
> 
> Then look for an end sample while updating the noise floor from the
> best error seen between samples.  The floor remains zero on systems
> with stable feedback reads, but lets noisy systems stop early once
> another retry is unlikely to improve the result.  The retry loop is
> capped at 200 iterations, giving an ~20 usec explicit delay budget
> derived from ndelay(100).
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 68 ++++++++++++++++++++++++++++++----
>  1 file changed, 61 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 7e7f9dfb7a24..362c08def420 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -50,7 +50,7 @@ struct cppc_freq_invariance {
>  static DEFINE_PER_CPU(struct cppc_freq_invariance, cppc_freq_inv);
>  static struct kthread_worker *kworker_fie;
>  
> -static int cppc_perf_from_fbctrs(u64 reference_perf,
> +static u64 cppc_perf_from_fbctrs(u64 reference_perf,
>  				 struct cppc_perf_fb_ctrs *fb_ctrs_t0,
>  				 struct cppc_perf_fb_ctrs *fb_ctrs_t1);
>  
> @@ -750,7 +750,7 @@ static inline u64 get_delta(u64 t1, u64 t0)
>  	return (u32)t1 - (u32)t0;
>  }
>  
> -static int cppc_perf_from_fbctrs(u64 reference_perf,
> +static u64 cppc_perf_from_fbctrs(u64 reference_perf,
>  				 struct cppc_perf_fb_ctrs *fb_ctrs_t0,
>  				 struct cppc_perf_fb_ctrs *fb_ctrs_t1)
>  {
> @@ -771,19 +771,71 @@ static int cppc_perf_from_fbctrs(u64 reference_perf,
>  	return (reference_perf * delta_delivered) / delta_reference;
>  }
>  
> -static int cppc_get_perf_ctrs_sample(int cpu,
> +/* CPPC read noise floor for early retry exit. */
> +static DEFINE_PER_CPU(u64, err_floor);
> +
> +#define CPPC_SAMPLE_MAX_RETRIES	200

Could the remaining tuning literals get the same treatment?
Specifically:

- the 10 initial-resample iteration count
- the 2000 multiplier in ref * 2000
- the 100 ns in ndelay(100)

Thanks
--breno
