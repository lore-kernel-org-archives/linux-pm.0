Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FDC343D8A;
	Fri, 14 Aug 2026 17:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786729577; cv=none; b=mJu4+VDtEjNhiHy5L3VB486PXRXXOFbV0T9sqOoPEi5XU7G2xGCSt0vN7RhUC+pLdqmRNhwY3hmbwdjrbwhMZcGVbRAk+4RYoE9a04x6bl2YtXgeLlFw/NkedkrznqSjn+VmiOwHr6AsmcNIAF0L6WlVd4bjKafJeV8AecYE/N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786729577; c=relaxed/simple;
	bh=Ee4H6aA3UPq3aIZ17njPtE2HirVtx8v4BgvF47lBwlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RxB00oZ18lwz1Wkcc7oRzF3IN8qbHtkgtiZgYWSAxr+8on0vrcvDHqpwWRpohY/YOQdxxSAVjNoamnAUStx3Pv1A1FjIXnAEU7Rw1Mxkj/x6rswhbs4moGc/7KTVGx8rstd/TfrpR0Mi+qScws6pmr+MOEykOkz+JPQ3X7LPlj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TtrdKZTE; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TtrdKZTE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786729575; x=1818265575;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ee4H6aA3UPq3aIZ17njPtE2HirVtx8v4BgvF47lBwlo=;
  b=TtrdKZTEWPlkQlVxv0Dm0/jLuFfMg9HCZkn+I9eOjPBQOYAVTzxa538J
   7Ko0VCrnoackPsWR3LxkP4HTr/HI1DVt5br8UJBmbVPVytyAuP+mnqbwB
   ZT3PQDT4gWgkhGLQhCOSOrqXrtzAvVU+xc5k8DrCnyzNLhd0jwU+HUFF0
   WSoUZiB+qIXfxNDTBOvFD2W7nlrqFXCmbc3ZcQxG9tCrABtJUf9VlEbQR
   izAfJp4TUne2fHNsYsjn3z09u2Us+ak6mFIUlQXvrAoLpUPxQIuwjGw7e
   KS7662YtVZcX5z/rvIrOI9tAO4WCWN25Fu7cJVwULoL4hSWv2gfDR2WPM
   A==;
X-CSE-ConnectionGUID: l+JiAicNScWim3bXGb6EHA==
X-CSE-MsgGUID: uBjMRon5Q9q9eZNiVnDk0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="97975389"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="97975389"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 10:46:14 -0700
X-CSE-ConnectionGUID: iNs7rcNsT6+GByw8u0JwJg==
X-CSE-MsgGUID: VL3TNn+4S/izTZzgVIpuAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="261015355"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 10:46:14 -0700
Message-ID: <1a967189-2195-4e66-9656-deb61589e5fc@linux.intel.com>
Date: Fri, 14 Aug 2026 10:46:13 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powercap: intel_rapl: Sign-extend the PMU delta on
 counter wraparound
To: Li Yifan <yifan2.li@intel.com>, rafael@kernel.org, rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 srinivas.pandruvada@linux.intel.com, jianfeng.gao@intel.com,
 anand.b.jyoti@intel.com, lili.li@intel.com
References: <20260814031008.750911-1-yifan2.li@intel.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20260814031008.750911-1-yifan2.li@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/13/2026 8:10 PM, Li Yifan wrote:
> From: "Li, Yifan" <yifan2.li@intel.com>
> 
> The RAPL PMU misreports energy when the hardware energy counter
> overflows and wraps back to zero.  perf event counts are defined to
> increase monotonically, but a single wraparound makes the PMU event
> count jump backwards by nearly the full counter range, and consumers
> that take the difference of two reads in unsigned arithmetic then
> underflow and report an absurd value.
> 
> On a Panther Lake system (energy unit 61.035 uJ, counter range
> 262144 J) the package counter wraps every ~2.9 hours at 25 W, and
> turbostat prints one bogus sample per wraparound, per domain:
> 
>   PkgTmp  PkgWatt         CorWatt GFXWatt RAMWatt SysWatt
>   44      24.97           16.30   3.90    1.87    2145386370.35
>   43      2145240612.10   16.13   4.02    1.91    40.46
> 
> The RAPL energy counters are 32-bit wide on every register interface:
> MSR, MMIO and TPMI all describe ENERGY_COUNTER with a GENMASK(31, 0)
> mask.  rapl_read_data_raw() applies that mask, so event_read_counter()
> returns the counter zero-extended in a u64.
> 
> rapl_event_update() then computes
> 
> 	delta = new_raw_count - prev_raw_count;
> 
> without reducing the result modulo 2^32.  While the counter does not
> wrap this is correct, but once the hardware counter wraps,
> new_raw_count < prev_raw_count and delta becomes (true_delta - 2^32),
> a large negative value.  Declaring delta as s64 only makes that value
> representable; it does not correct it.  That bogus delta is scaled and
> added to event->count, which is where the backwards jump comes from.
> 
> Fix it the way arch/x86/events/rapl.c has done since the RAPL PMU was
> first introduced: shift both values up so that the 64-bit subtraction
> reduces modulo 2^32, then shift the difference back down with an
> arithmetic shift to sign-extend it.
> 
> This is correct as long as at most one wraparound happens between two
> updates, which the existing overflow hrtimer already guarantees: its
> period is half of the counter range at the 200 W reference used in
> rapl_package_add_pmu_locked().
> 
> The problem has been present since the powercap RAPL PMU was added, but
> only affected TPMI RAPL until commit 748d6ba43afd ("powercap:
> intel_rapl: Enable MSR-based RAPL PMU support") routed MSR RAPL through
> the same PMU, which exposed it on client platforms such as Panther Lake.
> 
> Fixes: 575024a8aa7c ("powercap: intel_rapl: Introduce APIs for PMU support")
> Reported-by: Jyoti, Anand B <anand.b.jyoti@intel.com>
> Signed-off-by: Li, Yifan <yifan2.li@intel.com>
> Signed-off-by: Gao Jianfeng <jianfeng.gao@intel.com>
> Tested-by: Jyoti, Anand B <anand.b.jyoti@intel.com>
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  drivers/powercap/intel_rapl_common.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
> index 1006d183d508..6b7d11a0abc5 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -32,6 +32,9 @@
>  
>  #define ENERGY_STATUS_MASK		GENMASK(31, 0)
>  
> +/* Width of the RAPL energy counters, see the *_ENERGY_STATUS_MASK defines */
> +#define RAPL_CNTR_WIDTH			32
> +
>  #define POWER_UNIT_OFFSET		0x00
>  #define POWER_UNIT_MASK			GENMASK(3, 0)
>  
> @@ -1227,6 +1230,7 @@ static u64 rapl_event_update(struct perf_event *event)
>  	struct rapl_package_pmu_data *data = event_to_pmu_data(event);
>  	u64 prev_raw_count, new_raw_count;
>  	s64 delta, sdelta;
> +	int shift = 64 - RAPL_CNTR_WIDTH;
>  
>  	/*
>  	 * Follow the generic code to drain hwc->prev_count.
> @@ -1243,8 +1247,13 @@ static u64 rapl_event_update(struct perf_event *event)
>  	 * Now we have the new raw value and have updated the prev
>  	 * timestamp already. We can now calculate the elapsed delta
>  	 * (event-)time and add that to the generic event.
> +	 *
> +	 * Careful, the counter is narrower than u64 and is not
> +	 * sign-extended above its physical width.  Shift both values up
> +	 * so that the subtraction wraps, then shift the result back down.
>  	 */
> -	delta = new_raw_count - prev_raw_count;
> +	delta = (new_raw_count << shift) - (prev_raw_count << shift);
> +	delta >>= shift;
>  
>  	/*
>  	 * Scale delta to smallest unit (2^-32)
> 
> base-commit: f5bbbfec59b4e2fb7520a91de3df8a6174325d6a

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

