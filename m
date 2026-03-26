Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2855B35DA7B;
	Thu, 26 Mar 2026 15:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774538814; cv=none; b=oi9JRT/Nymj/Jj+69gjqFYvtMUEjrIYZFesTf9HO7y/lqnAV6vnU10M12+XqQEC8v3mRLsdfRW5Vq8X0VAVai8Gj4vXXcgjR6katvQdhMlWZrguzWBUykRb8EkplLcr0NKjpPNmB55X+v1GgJp9zJI7cRrREMBQwZZt+ip+CdCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774538814; c=relaxed/simple;
	bh=vrxSfkQYTfwx+AnpYheSvatnv7lcbjLvz4Ct2Qyi/pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsFf0zxmFtGWgO2yGZqAmLO+zxc9ryq+t75XV0qinh7sF28IUyQ7STIHmet04gx+iRqNR2osNuKQjoP263Wd4LJ2FqkPQ+DqTGxjH0fAjzby3sMqGc0TXSxozyecX3N/dn2H0k+Myoc1Z1WGKf7FI9/SrojbWCzASuQMgftSmmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A+ZEzQO0; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A+ZEzQO0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774538812; x=1806074812;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vrxSfkQYTfwx+AnpYheSvatnv7lcbjLvz4Ct2Qyi/pg=;
  b=A+ZEzQO0KW49ncGo2S1C4DWekKrsPQP8CDS9ZafW1SWU6o9HvA2eELif
   Bwcwx2pUZBUJd/lqvw9EQWDBtXMMZwbiVwlAWg1vVBaq2H0RfLId5390K
   44bCyRz0AFeKce8ERf2/S7ZprMNHJ6eEM6c7t2QXXOZE0Cf5aaG2GGsLZ
   9nJn8e22P3i9CGtF49A7khfk9a33ic92GT+mS45irtkH48vwpsJRko24w
   4jH9b6p8ZSn5+b93ux1nACm9UqWqrzlH5KaN6RZloPBi1hs6wLQ2aUurx
   OEh1qyrc9zAUpEj6TVgm3RQoSmJYiaYrZit6Po3cHRgPzGnHNPvzY1GLt
   Q==;
X-CSE-ConnectionGUID: qJfNT1wRQHqT0hWRdUBGtw==
X-CSE-MsgGUID: 6lmXsbtQRRiCe1+g0KZuhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75668923"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="75668923"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 08:26:48 -0700
X-CSE-ConnectionGUID: CAcWgENtR1ORa6Hew/zH8w==
X-CSE-MsgGUID: DauhxJP0RGGTPPPbbSZcOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="224105462"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by orviesa006.jf.intel.com with ESMTP; 26 Mar 2026 08:26:44 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w5mbZ-000000007JR-0kBX;
	Thu, 26 Mar 2026 15:26:41 +0000
Date: Thu, 26 Mar 2026 16:26:05 +0100
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
Message-ID: <202603261609.fazAo3mx-lkp@intel.com>
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
[also build test ERROR on arm64/for-next/core driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus peterz-queue/sched/core next-20260325]
[cannot apply to linus/master v6.16-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Loehle/sched-topology-Introduce-arch-hooks-for-asympacking/20260326-145644
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20260325181314.3875909-2-christian.loehle%40arm.com
patch subject: [PATCH 1/3] sched/topology: Introduce arch hooks for asympacking
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260326/202603261609.fazAo3mx-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260326/202603261609.fazAo3mx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603261609.fazAo3mx-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/topology.h:30,
                    from include/linux/sched/topology.h:5,
                    from include/linux/cpuset.h:13,
                    from arch/x86/kernel/itmt.c:21:
>> include/linux/arch_topology.h:131:32: error: redefinition of 'topology_arch_asym_cpu_priority'
     131 | #define arch_asym_cpu_priority topology_arch_asym_cpu_priority
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/itmt.c:168:5: note: in expansion of macro 'arch_asym_cpu_priority'
     168 | int arch_asym_cpu_priority(int cpu)
         |     ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/arch_topology.h:132:19: note: previous definition of 'topology_arch_asym_cpu_priority' with type 'int(int)'
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
