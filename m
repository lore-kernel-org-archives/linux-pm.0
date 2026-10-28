Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197411;
	b=YcJ/hCSsVkkRjtNUwnMtStN9rrjJHVj8DcSUK0WRtMmoDPe9oBlZSEua69mN+1M4fQBT
	 dE+nt4rWDSGIFmGl4TmMBNWMHg5RBUoUMdWv4xQ7Bri+vxSkzuHOxAIQDUpYqkhIDnbFC
	 2QHtsVBSYPVd5wF84rU0xhZCB+Ufp+BNIZdFVzVVOMonnSHP3nedqQv32L/UhgDyXboh3
	 n8INUuvQvaYqjMVnqa2ynSZizd106EUi8kUXY0hP8XlGFGyWjIZeVibkpyf7KbQsq8SOx
	 6UAtiftmcb8L4QOhC9ejY18zeQJNAHzZgdKpLY7MVTa7RDskNPRgTpBAy/qrrTDI4wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197411;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=2NdrZAkAz7heaa42OfUL91fExS8Tds1gie9XHu1AeFI=;
	b=ri17XsTUE3/ElmSEwYaiSPQT1Ni0pz8qcS9CnfKo/MdBh8l43wejEqqZJ9Lk85RHyY9x
	 QB9vjn2ZqKlQB221X/hOo/WsT62OO8iUaj+UIXcO8GUdiHWffTo6wArcyg7abK9Qzk1Q8
	 ulFQgFu88qolOIR/xEnxOi+gxng+U7SWgLX0egfdlOiyNwIPbTg8nBzQPjYVLme04+uFL
	 S9oB8lwqpWbBuR+fxUbZygLlvGTU7wCTWtMMqUIlJmMfosnn5qvC4k91WAq5rxOwJzzAW
	 pJtE82+xp3wkbjIpJoEFCTby5VVYfQXENuTIGpjtawSQuP/jzCBAN+YuKnwzck9M3wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kkB8J+Ly;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECC360A263D
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 14:23:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5ECC360A263D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kkB8J+Ly
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793197410; x=1824733410;
  h=date:from:to:cc:subject:message-id;
  bh=n/azdzmJ94M4g+CyGtjLKBZf2SVDWtbyTXshttQ7Qe0=;
  b=kkB8J+LyoO3nPQThoouqYPN4mX7VHWigw2N3hdYBxN7LMy2QVMlmDX65
   Djq6FdGGQEYGsNTi7MRJ4LgHztd1g8WPo/uNDOx5bJCEh9Ar4XHghdc9Y
   SmyFGWn/bnOes5MdwUKUFt7G5TkKZhAbWodblNltHhFEpsQRFCL7cHvtY
   3tSdUeF1tner+RdQkknXlAOiYJv9y8lUkKyEXXjJ+7fOQ+z8NJbHoRXR0
   Q+0pjdXsYe0l2BOkSsBP9s2U/EFuyMOqUBNmxLDIkvVqHaY8L3W59CbOO
   V5Sk0QctlAv2UhOwwu6ciPAZ7+H3eGbCT3U/ntzUwmHzMld23e3SxA5fp
   g==;
X-CSE-ConnectionGUID: JBPb9PCBT2iNi8Y+ugAFtg==
X-CSE-MsgGUID: rccZ9/tXS0i8DRjE5IwZjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1799541"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1799541"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 07:23:30 -0700
X-CSE-ConnectionGUID: R/tn64d4QWidz3UVmQPuug==
X-CSE-MsgGUID: uaJzQ5kATOOvAxLEKvge5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="5174543"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 28 Oct 2026 07:23:27 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xM4Ym-00000000YqO-3dbR;
	Wed, 28 Oct 2026 14:23:24 +0000
Date: Wed, 28 Oct 2026 22:22:38 +0800
From: kernel test robot <lkp@intel.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-pm@vger.kernel.org
Subject: [amd-pstate:superm1/lockdown-iommu 3/3]
 security/lockdown/lockdown.c:217:8: error: call to undeclared function
 'iommu_is_available'; ISO C99 and later do not support implicit function
 declarations
Message-ID: <202610282110.ZVggpdqM-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git superm1/lockdown-iommu
head:   74b0183524154e17897a7789da06a937eaf8b2b7
commit: 74b0183524154e17897a7789da06a937eaf8b2b7 [3/3] security: lockdown: Prevent boot with lockdown but no IOMMU
config: arm64-randconfig-1003-20261028 (https://download.01.org/0day-ci/archive/20261028/202610282110.ZVggpdqM-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 1da436a23e613c425fc9b868fc8deb979ede47a4)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261028/202610282110.ZVggpdqM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610282110.ZVggpdqM-lkp@intel.com/

All errors (new ones prefixed by >>):

>> security/lockdown/lockdown.c:217:8: error: call to undeclared function 'iommu_is_available'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     217 |                 if (!iommu_is_available()) {
         |                      ^
   security/lockdown/lockdown.c:217:8: note: did you mean 'slab_is_available'?
   include/linux/slab.h:283:6: note: 'slab_is_available' declared here
     283 | bool slab_is_available(void);
         |      ^
   1 error generated.


vim +/iommu_is_available +217 security/lockdown/lockdown.c

   197	
   198	/*
   199	 * Late init call to verify IOMMU availability when lockdown is active.
   200	 * This catches cases where:
   201	 *  - IOMMU hardware is absent on the platform
   202	 *  - IOMMU was disabled by driver initialization failure
   203	 *  - IOMMU was not detected (e.g. broken firmware, missing ACPI tables)
   204	 *
   205	 * On x86, we also check no_iommu here as a double-check. The early check
   206	 * in lockdown_lsm_init() catches 'iommu=off' from the cmdline before
   207	 * lockdown_lsm_init() runs, but this late check covers any missed cases.
   208	 */
   209	static int __init lockdown_check_iommu(void)
   210	{
   211		if (kernel_locked_down > LOCKDOWN_NONE) {
   212			/*
   213			 * Check generic IOMMU availability (all architectures).
   214			 * iommu_is_available() returns true if any IOMMU driver
   215			 * registered successfully.
   216			 */
 > 217			if (!iommu_is_available()) {

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
