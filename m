Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685D028CF5D;
	Thu, 26 Mar 2026 13:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774531487; cv=none; b=c5CyIBw3kXgpsRt0jdJeSGwyUZ/aSqFvXyZvykASd6o1mjmcnm4IZfDHoEb8cUvWmm1P7bs4Sx0URU+0be6AhTK9BmIvZjY3YyK6ugeUxm5DcZUAsRgNxizRUgcfmzMIaC/fskv9M+wKvFoHte8z+/ZCZzp/QqhH0ZtvCePIixU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774531487; c=relaxed/simple;
	bh=lqKWc/FFQwxIVGjVfqveY33E7rzJ71mAfK6dsqpxj4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SePVgxtqhxs+8TzmlpY1M6v9H+uIzjs2xruU3MCjUHMjKs3S7JP8PqVrGFUXVMGqY6DljOECGr9LgznaLfqY84YEbglaa9qhrUD+1ZWeT7KhoKdoQztxmtc2j8ciTVEkCTxFv7fnk0HPKLMePlt22CAkGcpMNEFe0I4Csm3csPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jQ+fq1Oe; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jQ+fq1Oe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774531486; x=1806067486;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lqKWc/FFQwxIVGjVfqveY33E7rzJ71mAfK6dsqpxj4M=;
  b=jQ+fq1OeW90Dvoc25Gcgg+hO1ajW8iLTWL8QWTWA0vj02QNV10qIvkuN
   R88IO8IS3OIcZaCjHsNMi6rP0yX9FYxn8MTaGmcrX0YN1ewgLjkRho8qC
   aG+O2wFJhBTBpzkFUrLPkOpcWy0DBtMRN1bV0e7u6y7xIg/l8HB54BOVh
   aS0HsAh3pLJCI/xF9aZFMVkM4GvbgDb/d5I5PsXjtKvuXiBgVRPZG33+S
   5aYgv5vrmgQKSVGmpSB7zMB8Mua4wslFCnM0Bt06eiGJYBCmrLEAbi8Ed
   6XmVFRO6ldIoK1z71pnAPJIjCdXfJE1A+qS/Yi7mfJvVjQ0JE4Ao1VMCK
   A==;
X-CSE-ConnectionGUID: 03Mi0jajTRi0/JmI50wJ+Q==
X-CSE-MsgGUID: loLr2BEMQLG59g2BuQenfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="74616470"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="74616470"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 06:24:45 -0700
X-CSE-ConnectionGUID: gPfRzRU+STGC9PQzUDHfbw==
X-CSE-MsgGUID: pHkplRBlQXabR9TB5h7Bhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="220592210"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by fmviesa010.fm.intel.com with ESMTP; 26 Mar 2026 06:24:41 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w5khT-000000007HZ-2dON;
	Thu, 26 Mar 2026 13:24:39 +0000
Date: Thu, 26 Mar 2026 14:23:51 +0100
From: kernel test robot <lkp@intel.com>
To: Christian Loehle <christian.loehle@arm.com>, arighi@nvidia.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	peterz@infradead.org, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, valentin.schneider@arm.com,
	mingo@redhat.com, rostedt@goodmis.org, segall@google.com,
	mgorman@suse.de, catalin.marinas@arm.com, will@kernel.org,
	sudeep.holla@arm.com, rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
	kobak@nvidia.com, fabecassis@nvidia.com,
	Christian Loehle <christian.loehle@arm.com>
Subject: Re: [PATCH 1/3] sched/topology: Introduce arch hooks for asympacking
Message-ID: <202603261419.mAKkKckS-lkp@intel.com>
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
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260326/202603261419.mAKkKckS-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260326/202603261419.mAKkKckS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603261419.mAKkKckS-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/x86/kernel/itmt.c:168:5: error: redefinition of 'topology_arch_asym_cpu_priority'
     168 | int arch_asym_cpu_priority(int cpu)
         |     ^
   include/linux/arch_topology.h:131:32: note: expanded from macro 'arch_asym_cpu_priority'
     131 | #define arch_asym_cpu_priority topology_arch_asym_cpu_priority
         |                                ^
   include/linux/arch_topology.h:132:19: note: previous definition is here
     132 | static inline int topology_arch_asym_cpu_priority(int cpu)
         |                   ^
   1 error generated.


vim +/topology_arch_asym_cpu_priority +168 arch/x86/kernel/itmt.c

5e76b2ab36b40c Tim Chen 2016-11-22  167  
5e76b2ab36b40c Tim Chen 2016-11-22 @168  int arch_asym_cpu_priority(int cpu)
5e76b2ab36b40c Tim Chen 2016-11-22  169  {
5e76b2ab36b40c Tim Chen 2016-11-22  170  	return per_cpu(sched_core_priority, cpu);
5e76b2ab36b40c Tim Chen 2016-11-22  171  }
5e76b2ab36b40c Tim Chen 2016-11-22  172  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
