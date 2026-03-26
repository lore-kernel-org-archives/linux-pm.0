Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD80D39184C;
	Thu, 26 Mar 2026 16:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774543247; cv=none; b=MAP3Qm6ux5RUXTUk4w4fJvJhO61QzUbn0R5xtUSpCOMpLO80kqyXPkdeb6hXr5Y3t8xDknUxeMDOZ6E+Ntcv4sfCEA7JwBlq62H+GmvxXwIajgk3VabLnQ8pNxkI2+GTjS0C3V22yaTG+foR/0rryFc1zOoWvVzDNNKJyysKsho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774543247; c=relaxed/simple;
	bh=KjunGW45yXlRcSONfEmUcgQUekN6c9AihQS4z0wuD1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvbTrgbAAcEhBC/2btaJUYK1IWKY13ytFgD4Fd7roEYYwJqXtN+Jh0und1TaX07LkZ0dvTCMuyZyoxkqFYCLar8gPviqGgCuWKgEPP5m/hojs3gLXNQvqCM2CaBAxiNrDsyLJlyTBq5b2epNOYE/BS2/ZseiFsPwdoEXt+9+mQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mViR9v4J; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mViR9v4J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774543246; x=1806079246;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KjunGW45yXlRcSONfEmUcgQUekN6c9AihQS4z0wuD1g=;
  b=mViR9v4JqWMx90aqH/D84WgEVfktaesoA+2LFmzGssoy1alYhAJKR/GE
   KV9h4kM1R12mjfD6FInHGMyrLDrTGguRqupzQHWHUCwngnwGeo43Oe92I
   id3oliCpblnMK3xHHiVw0iAQY+R7ncOk8rZf+Z3tjmPG87dwkPbKBNhbD
   UDf4O1EaskARfIZZ18lopSuBDARhQnW2j1ip+WpnLPM1RYz83LPflJRdx
   LhoxoJARyZix8Oe5afWNrmTnxDNDBDhV8r+ed1AgAFCRXglFLHiGqlH55
   QGhFEvI6lODRJo+8EMcR3PIURRsB8J1aZEixYQhtxja2AQRbVfN9Gfm7j
   A==;
X-CSE-ConnectionGUID: orRhfbfETnuSbNo+TmKGog==
X-CSE-MsgGUID: 5cjAQCXASFyLWP8O4c57FA==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75805538"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="75805538"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 09:40:45 -0700
X-CSE-ConnectionGUID: oDmWARjMT6Kl993Qimv7GQ==
X-CSE-MsgGUID: +NXsbF0YTROfwytebaIDTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="255551568"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 26 Mar 2026 09:40:40 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w5nl7-00000000937-2vLG;
	Thu, 26 Mar 2026 16:40:37 +0000
Date: Fri, 27 Mar 2026 00:40:17 +0800
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
Subject: Re: [PATCH 1/3] sched/topology: Introduce arch hooks for asympacking
Message-ID: <202603270017.gHZBIwsQ-lkp@intel.com>
References: <20260325181314.3875909-2-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325181314.3875909-2-christian.loehle@arm.com>

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on arm64/for-next/core driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus peterz-queue/sched/core linus/master v7.0-rc5 next-20260325]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Loehle/sched-topology-Introduce-arch-hooks-for-asympacking/20260326-145644
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20260325181314.3875909-2-christian.loehle%40arm.com
patch subject: [PATCH 1/3] sched/topology: Introduce arch hooks for asympacking
config: powerpc-randconfig-001-20260326 (https://download.01.org/0day-ci/archive/20260327/202603270017.gHZBIwsQ-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260327/202603270017.gHZBIwsQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603270017.gHZBIwsQ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/topology.h:30,
                    from include/linux/gfp.h:8,
                    from include/linux/sched/mm.h:9,
                    from arch/powerpc/kernel/smp.c:18:
>> include/linux/arch_topology.h:131:32: error: redefinition of 'topology_arch_asym_cpu_priority'
     131 | #define arch_asym_cpu_priority topology_arch_asym_cpu_priority
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/kernel/smp.c:1767:5: note: in expansion of macro 'arch_asym_cpu_priority'
    1767 | int arch_asym_cpu_priority(int cpu)
         |     ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/arch_topology.h:132:19: note: previous definition of 'topology_arch_asym_cpu_priority' was here
     132 | static inline int topology_arch_asym_cpu_priority(int cpu)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/topology_arch_asym_cpu_priority +131 include/linux/arch_topology.h

   125	
   126	/*
   127	 * Architectures may override this to provide a custom CPU priority for
   128	 * asymmetric packing.
   129	 */
   130	#ifndef arch_asym_cpu_priority
 > 131	#define arch_asym_cpu_priority topology_arch_asym_cpu_priority
   132	static inline int topology_arch_asym_cpu_priority(int cpu)
   133	{
   134		return -cpu;
   135	}
   136	#endif
   137	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
