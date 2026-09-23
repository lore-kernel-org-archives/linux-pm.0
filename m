Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DE7538D8D;
	Wed, 23 Sep 2026 14:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790174558; cv=none; b=UCgNRTHQO1YJH7ZVYM+3sITWlQZAvhZnthKqNTka3nRbU+UJ+b2G5/5rqGw8lESLih6L0JCSuoohTFecdAH0in40INbCffrac3fSUSVtluZoUz6rqlhJVwt8Qst1bOsKlL7xuc+SsSvxUkUldJmhEZLTc4YyR0AzsaDZauOmxus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790174558; c=relaxed/simple;
	bh=N2IScWfV2B5Ujuu0bl7n4/GW/ItJpVMyniZBvPEai6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Am3Buxw1ohG3xGqy800FCUWeL2ge12yfhLc41nw8UuGQeagCvp8kphznbNIuxZ85ss/wp1M1Oc9qEqwJsfQ5H824GbfXpO/3gkjWAJUttDqMjqh1lg70V8hJq/Gr1o2/zarqBbuWqkgz14Q5eIZoLV8lJG1pQRnjxV4y6Nlzd38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CEQ3m3ET; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CEQ3m3ET"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790174556; x=1821710556;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N2IScWfV2B5Ujuu0bl7n4/GW/ItJpVMyniZBvPEai6s=;
  b=CEQ3m3ETt4nOKKN12tHFbEG8UsWS/KqKSMUSN008X8X66brF/dwm878g
   +Kq5BaUQZ4+gL/ynyoTfeMKSTM+Q4YzSEcN1FiDkT2XeyoX6NALaNPccZ
   l6NIxznlBTVdh3i3mFkFNGeBLLrhWX50Rhrqgx82B+c9f5TeBNDMW/BUA
   U/MW2FcI90M4p9UHXcnlGxr+89PoUexmN20/euN1HeARjau4S02gIPyUU
   pJn5ZhlAKCvdP37hsFIU45wz/VninConQTxijnE5c6N99KwS0Y/3hjFFM
   Z+Vcr8ssFO3B1v5VsFvo3RshMz8OjF0cfIUKGmgAL4jLzgrOSxydohYhQ
   Q==;
X-CSE-ConnectionGUID: CnB2/w5IQoqjwSvRu+c30A==
X-CSE-MsgGUID: 7H0H/uSGSzmqksVcFx4WQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="89795069"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="89795069"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 07:42:35 -0700
X-CSE-ConnectionGUID: D5tdkV4RSwaqqNQ2BjTcJA==
X-CSE-MsgGUID: kYWqNHP/Q/2vnjjX51+uVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="301578537"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 07:42:35 -0700
Date: Wed, 23 Sep 2026 07:51:11 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Jianyong Wu <wujianyong@hygon.cn>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] cpufreq: intel_pstate: Fix max_freq fallback in
 cpufreq_update_pressure()
Message-ID: <20260923145111.GA24137@ranerica-svr.sc.intel.com>
References: <12975163.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12975163.O9o76ZdvQC@rafael.j.wysocki>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Mon, Sep 21, 2026 at 09:12:00PM +0200, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> After commit d2d5c129d07e ("cpufreq: Make cpufreq_update_pressure() fall
> back to cpuinfo.max_freq"), cpufreq pressure appears in the CPU load
> balancer unexpectedly in some cases in which it was not present before,
> leading to confusion and uncertainty.
> 
> Clearly, the scheduler assumes that cpufreq pressure will not be set
> unless the capacity reference frequency of the CPU is known, and the
> commit mentioned above violates that assumption.
> 
> However, in some cases the capacity reference frequency of the CPU is
> in fact known even though arch_scale_freq_ref() returns 0 and in those
> cases it should be possible to set cpufreq pressure as appropriate.
> 
> For this purpose, introduce a new cpufreq driver callback returning
> the CPU capacity reference frequency, .scale_freq_ref(), and make
> cpufreq_update_pressure() invoke it, if present, instead of falling
> back to cpuinfo.max_freq unconditionally.
> 
> Add that callback to the intel_pstate driver and make it return 0 unless
> the scale-invariant capacity of the given CPU has been explicitly set,
> in which cases its reference frequency is always cpuinfo.max_freq.
> 
> Fixes: d2d5c129d07e ("cpufreq: Make cpufreq_update_pressure() fall back to cpuinfo.max_freq")
> Reported-by: Jianyong Wu <wujianyong@hygon.cn>
> Closes: https://lore.kernel.org/linux-pm/20260915065747.1671965-1-wujianyong@hygon.cn/
> Tested-by: Jianyong Wu <wujianyong@hygon.cn>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

This patch did not break anything for me. I tested this in several Intel
processors with asymmetric capacity capacity enabled. Tasks spread as
expected when no cpufreq pressure is applied. Tasks duly migrate away when
this pressure is applied to a subset of CPUs. They come back when the
pressure is removed.

Tested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com> # Intel hybrid parts
