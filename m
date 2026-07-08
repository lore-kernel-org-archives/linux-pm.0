Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A346837E2E2;
	Wed,  8 Jul 2026 17:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783530233; cv=none; b=g5HzcMN5pBiolg9N1S0xpQnV0/l+p5tPOut3XDbh9yGPsZzvuAAvhW/tk1z5QWaC5q5OM339O9jw952cVaaa66AB/R4781rTFlb4q4GVYZfvi+WyKjje3I5yWb2fdkMSSTo+a4YpIHA196RCRZgpsicZxJsUUSni02LPuXDDB+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783530233; c=relaxed/simple;
	bh=Br4TdDbW3DFRl/q2q9kYjobNPC2cSctBctZ48N9DXR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/uxVfcR90+WGqIX+6+nMSqCBnaGt5Lag60fjK8a3yGtU2tFBmP84fj43+j5ZP392uEPCL52hEPV6yZhDkwJfy7uoaslwaUPRu5t+S84313fB0idg400A8ST8XKxOcPAo2ltyS2YRvHkTZ32jw0m+695vwnG0vaG8ktA+r2ssxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RPCnNaJ/; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RPCnNaJ/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783530231; x=1815066231;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Br4TdDbW3DFRl/q2q9kYjobNPC2cSctBctZ48N9DXR8=;
  b=RPCnNaJ/5VwiOObaOrvAF/wiYyCVANIF3ZO7hsoTiTf9kvL0J+B5DJlS
   1NB5tSHRB9QDZDUlGkNx7sTDalv5Yh9Af+p1FIIutHJyO183pXlaF5s9Z
   SGSaoucACWWc/WmaF2S+XmVt8hTKgNujS5MM2b507E8jIkmX3LTm2b61D
   QFeZZkz1F4Fv3OelDVTb0HUJj+7uaVyK+Q1kMwNr9JPTaMHbIFOUvYmnz
   EpphZIwuzRrn1Bx9WqA/sDs35arz/VlN/2cjdzhZbFrttMWejLBCsG7Ry
   3DbLvoEJ5vw2/XvI82xS7pZUaRkyIL7aToP305Xs/pS7MRmK3fU+kqhyH
   Q==;
X-CSE-ConnectionGUID: L/9G97JFTjaf4Z6y8zHtuQ==
X-CSE-MsgGUID: y0oLPuFfSgyZdZbEDM2frA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="94807894"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="94807894"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 10:03:49 -0700
X-CSE-ConnectionGUID: VBMZxHScQGGj3ihdTnLh2Q==
X-CSE-MsgGUID: apEs3FumQ2yqMs5AHHvv8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="258639064"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 10:03:49 -0700
Date: Wed, 8 Jul 2026 10:13:03 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Viresh Kumar <viresh.kumar@linaro.org>, Dhruva Gole <d-gole@ti.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v1] cpufreq: Make cpufreq_update_pressure() fall back to
 cpuinfo.max_freq
Message-ID: <20260708171303.GA2705@ranerica-svr.sc.intel.com>
References: <5086499.GXAFRqVoOG@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5086499.GXAFRqVoOG@rafael.j.wysocki>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Tue, Jul 07, 2026 at 07:25:39PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If arch_scale_freq_ref() is not defined for a given arch (like x86, for
> example), cpufreq_update_pressure() will always set cpufreq_pressure to
> zero for all CPUs in the system, which is generally problematic on
> systems with asymmetric capacity [1].
> 
> However, in the absence of arch_scale_freq_ref(), it is reasonable
> to assume that cpuinfo.max_freq is the maximum sustainable frequency
> for the given cpufreq policy.  Moreover, there are cases in which
> arch_scale_freq_ref() would need to be defined to return essentially
> the cpuinfo.max_freq value anyway (for example, intel_pstate on
> hybrid platforms).
> 
> For the above reasons, update cpufreq_update_pressure() to fall back to
> using cpuinfo.max_freq as the reference frequency if zero is returned by
> arch_scale_freq_ref().
> 
> Fixes: 75d659317bb1 ("cpufreq: Add a cpufreq pressure feedback for the scheduler")
> Link: https://lore.kernel.org/lkml/CAKfTPtBuRLfYNnR4w--cFZYZy-R8gaPEgVwCcaMmbCcJ2H-muQ@mail.gmail.com/ [1]

This patch achieves the desired behavior for cluster scheduling discussed
in [1]: tasks duly migrate from CPUs of which frequency has been capped.
Tasks spread once the frequency cap is removed.

Tested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com> # cluster scheduling
