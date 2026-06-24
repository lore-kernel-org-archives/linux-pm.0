Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E473254AE;
	Wed, 24 Jun 2026 05:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782280290; cv=none; b=gHYjKKFnYE/h/E30L1OpspjbPRGF7Q7K2VMI00Hs2VDeXHzvbNlidq8sRHZRoxlC8wmA/2MxJk+k7LJ/iceGNkN3izFZhNKaSUSyyQeO3Nz+N+NfY9f01P5rc/KUKIa8wRGbHIudWYE3YUgurqVd7ApRH6gNsUMKSz59V6A9hH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782280290; c=relaxed/simple;
	bh=D9I/LTguC5OtyFwynVjoVCieJymaCyDcF7pGWxF94UM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=oib/92qNxVf3vW6zvXRRfXVOyiAi4XPSPefU5mGwwirjMM4TMKPOTc8lHUYagiRbIda8BZQb2mqdInCw3Zekd9n2DDogxHkL62B41LqjbW4mRkoIirMHgeq+X+WfiFyiPZDOrNDYdJADOgpJLbrvaXEjdXVwDHGTvsVs0o50Us8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jf/8LIOY; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jf/8LIOY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782280289; x=1813816289;
  h=date:from:to:cc:subject:message-id;
  bh=D9I/LTguC5OtyFwynVjoVCieJymaCyDcF7pGWxF94UM=;
  b=jf/8LIOYgT87AEnYgTHBY086ScEiaN/p8uimmYzB0hL5UkNC96yOkmKn
   0Dgig5yFRIBpvXfIerHGeUjMAfXCZ0r1bm0Ns/p/LPfNuuirQhOapwNQo
   Fk9MaciA+6fCyy9n3g2qQejf72bzJciWueConDWnjdWnOxh9SzLkIqNtx
   NQghbGlbb6zJhqvn92f1m9HE8D8/kl69MKX5awKNm6GVHN8+lxAV9Y8FK
   Ji/gqnPj/+w1zguOewrO3mCcklbxJzx5xvLPqZtrSEeBQNbJazfh45jzF
   MeevhC9Nkbbtrm9lzFgy3P5Xr0ZA3tiCubADnQVKYMkGY/7IOQmPTR1H0
   w==;
X-CSE-ConnectionGUID: 9e2l1lDVRYGObQRDb6MjYg==
X-CSE-MsgGUID: yugaFsLoQrCuNdJTMi2SGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="82147688"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="82147688"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 22:51:23 -0700
X-CSE-ConnectionGUID: TDaGHdk2TgGuFy2CTjR3sg==
X-CSE-MsgGUID: iv2UiRHLS5qIoLEZ8psrcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="249582966"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 23 Jun 2026 22:51:20 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wcGW5-0000000039L-2yei;
	Wed, 24 Jun 2026 05:51:17 +0000
Date: Wed, 24 Jun 2026 13:51:04 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:linux-next 11/16]
 drivers/thermal/testing/command.c:91:27: sparse: sparse: symbol 'd_command'
 was not declared. Should it be static?
Message-ID: <202606241309.I4xxswNB-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
head:   7b8d80921156c54cf7fcc35a830342686958aeea
commit: a36ab01e7cd43baf3150f4b3c68624c14ead27a8 [11/16] thermal: testing: zone: Flush work items during cleanup
config: powerpc-randconfig-r132-20260624 (https://download.01.org/0day-ci/archive/20260624/202606241309.I4xxswNB-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.5.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260624/202606241309.I4xxswNB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606241309.I4xxswNB-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/thermal/testing/command.c:91:27: sparse: sparse: symbol 'd_command' was not declared. Should it be static?

vim +/d_command +91 drivers/thermal/testing/command.c

    90	
  > 91	struct dentry *d_testing, *d_command __ro_after_init;
    92	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
