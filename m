Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B3120C029;
	Thu, 26 Mar 2026 15:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774540064; cv=none; b=dYnmNJCQ81kQnR7SXlFPi7q/ukuzNjQaddT3YCr1dENQDsfGtKnB4jXLlqRLHV+OIgq/d7nHxHzMwVsk1yEYXAEeHxgOF68mKS8TLtnUll/jFsuastfAMpuY4uklMZWQdgSwgGznSE496ZxidcPdZWeV1hwF33d6SspumbjiqU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774540064; c=relaxed/simple;
	bh=7hZqaL4ZV9G0GsFJ4XspY2AfsRdOOg/Kciwg94rdwXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGZNTHajIxqYuAF6SdtsyY8O7R81mHicTUgcqLOOFYUmt2l8tXvlGkLBMnigBVIPIygZG0Z5R3SF6e+O+t7XJ4rUyqjJX3iHtt3iCl9t5VbXTNJpkD66iLvE1N1DZRK4mjD+fYaEgMEDdtmJgrZ5/JjlNkBhkhlJIq+l/D/sipQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lAnyAkMV; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lAnyAkMV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774540062; x=1806076062;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7hZqaL4ZV9G0GsFJ4XspY2AfsRdOOg/Kciwg94rdwXY=;
  b=lAnyAkMVGXA4O+n0otSg5cQuSmagXA9kCB1XgcdSPEW+2p/8NtZjx3Uq
   jdRO7U2Z0MsOCspW7PSxH7CqidQcLNxTnjrgX9zb4O2JsyJ71KcU0Q5Ox
   9cloH84n/owzCF1rConUsj4WGmT7KBEGIgmAOCOGDWrMfXCFjIecK+UE2
   /+BP8p8fG/MJ5KNQErNdvm+EmahSrnaQKiIV47ietqBqpnHFbKvWPOfsN
   ZLkU8YTTniue9jHpbuPEEENoSOPrgKVh6NlE8GzVnZiRyUbujSJjYt2OF
   wQzBre3yKxna61vmXnDAvrdrf25c+VBszlYGlrZ8AH3ue//jtaxecisKG
   Q==;
X-CSE-ConnectionGUID: rwubD9idQ2GxE/OP3HqlSA==
X-CSE-MsgGUID: 3sC0YFP4SUmhIvVU5W/4mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75670670"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="75670670"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 08:47:41 -0700
X-CSE-ConnectionGUID: 6t72dBeoQm+q0gEY3psBdg==
X-CSE-MsgGUID: aMaov3SwQs+WRdLtBOsT9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="224965421"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 26 Mar 2026 08:47:37 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w5mvl-000000008yP-35cp;
	Thu, 26 Mar 2026 15:47:33 +0000
Date: Thu, 26 Mar 2026 23:47:27 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Loehle <christian.loehle@arm.com>, arighi@nvidia.com
Cc: oe-kbuild-all@lists.linux.dev, peterz@infradead.org,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	valentin.schneider@arm.com, mingo@redhat.com, rostedt@goodmis.org,
	segall@google.com, mgorman@suse.de, catalin.marinas@arm.com,
	will@kernel.org, sudeep.holla@arm.com, rafael@kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	juri.lelli@redhat.com, kobak@nvidia.com, fabecassis@nvidia.com,
	Christian Loehle <christian.loehle@arm.com>
Subject: Re: [PATCH 3/3] arm64/sched: Enable CPPC-based asympacking
Message-ID: <202603262311.bSaX71dF-lkp@intel.com>
References: <20260325181314.3875909-4-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325181314.3875909-4-christian.loehle@arm.com>

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on arm64/for-next/core driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus peterz-queue/sched/core linus/master v7.0-rc5 next-20260325]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Loehle/sched-topology-Introduce-arch-hooks-for-asympacking/20260326-145644
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20260325181314.3875909-4-christian.loehle%40arm.com
patch subject: [PATCH 3/3] arm64/sched: Enable CPPC-based asympacking
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20260326/202603262311.bSaX71dF-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260326/202603262311.bSaX71dF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603262311.bSaX71dF-lkp@intel.com/

All errors (new ones prefixed by >>):

   or1k-linux-ld: kernel/sched/build_utility.o: in function `sd_init.constprop.0':
   build_utility.c:(.text+0x1840): undefined reference to `arch_sched_asym_flags'
>> build_utility.c:(.text+0x1840): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `arch_sched_asym_flags'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
