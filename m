Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9609610785;
	Tue,  7 Jul 2026 20:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783456679; cv=none; b=diRMhO99GL2BBp9avb+72Rzxxg9ElmaRafmfDgPCrTdmiDod6gMkkuLXVT5wmDWryT8M7YGwSbe4po+WCq5O4JjRLW285wfZ/2Hd6HBPdnQAJ1JOWx1U8XkIR5e5a54JepYLmi8S4wAXur6GmxXsefKzVqzjc/skYlQ5gpcFTdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783456679; c=relaxed/simple;
	bh=O4i4a7vvGfqImDsBR26ib/uiMaRy6/PECP+w4Sbfmjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EfngKwvljweCbAwVEcgTpJAGsWiEBp+TayxrHvDsS7TfCWUz2tOm24pqXZ4V3Xt5LkXt5fmLI+m1vGXDAGFHQSz94Rg5rtkVtuM6eTgq8bTBR4PnXLkpJrDZrJVhWgGOuOtazA9zNhwCzg7ShNIrPG5boDhOQkIyBNRUNwffq14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dzmSjqV9; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dzmSjqV9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783456677; x=1814992677;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O4i4a7vvGfqImDsBR26ib/uiMaRy6/PECP+w4Sbfmjs=;
  b=dzmSjqV97ZZIdtbxS/WSVS01W70Nr//2rfv/pT34XLqnmwG5pKFy6Q5Y
   XmfPJ+qVDjAdFJLY0wESHuaePqo/ZAe/pYkBV2TYGkYdP+9ac8Zj6N9S/
   HOZakHdanDqOSkQlNcppbRNUTzllfhjmhqZodmtdwfAyyG0yPhC5VSvzL
   LQ9pYBkMXDZI1lB7hJM5TdpqMt0LRJZP6c8h2NIlFkx+dTnF+meKK7ncX
   70oSir/LhiNtNk5NJpQK+eFBMNczbB/VZB2DpP9Gjxw1AvBohvKliKGe2
   QZal8XCOzNJ+B1wb+Qb3XKKX+XowESbUibUc8BVjJmITrDTUAetlF3Jmm
   w==;
X-CSE-ConnectionGUID: Jn3f5iFmQLSqFcdTem795w==
X-CSE-MsgGUID: T2MB7P2hThmn7xFVVPDX8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="101662951"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="101662951"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 13:37:56 -0700
X-CSE-ConnectionGUID: kDOJ+C5dQZe6/LMrC3XEDQ==
X-CSE-MsgGUID: zC9++rhWSX2z/8weKiGw3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="256013455"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 13:37:56 -0700
Date: Tue, 7 Jul 2026 13:47:11 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v1] cpufreq: intel_pstate: Set non-turbo capacity to
 HWP_GUARANTEED_PERF()
Message-ID: <20260707204711.GA1255@ranerica-svr.sc.intel.com>
References: <12928972.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12928972.O9o76ZdvQC@rafael.j.wysocki>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Tue, Jul 07, 2026 at 07:19:55PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Setting cpu->capacity_perf to cpu->pstate.max_pstate_physical in the
> "no turbo" case is inconsistent with what happens elsewhere in the
> driver and causes arch_scale_cpu_capacity() to be incorrect.  It also
> skews arch_scale_freq_capacity() which ends up differing from 1024 for
> the guaranteed P-state.
> 
> Address that by setting capacity_perf to HWP_GUARANTEED_PERF() in the
> "no turbo" case.

Indeed, using cpu->pstate.max_pstate_physical does not make sense. It only
reflects what PLATFORM_INFO[15:8] says for _all_ CPUs, regardless of type,
resized by cpu->pstate.scaling/cpu->pstate.perf_ctl_scaling. No relation
to any property of the CPU.

Now arch_scale_freq_capacity() looks correct.

> 
> Fixes: 929ebc93ccaa ("cpufreq: intel_pstate: Set asymmetric CPU capacity on hybrid systems")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Tested-by Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
