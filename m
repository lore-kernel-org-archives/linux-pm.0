Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C167C3A7838;
	Mon, 30 Mar 2026 20:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774903188; cv=none; b=IJQKI0KWRHA0TLvZ/IOVNrXQAfSIF7qBnxuGJ0HGhrl6Q2IEx17pc8mD9jGh5ey78PL0PwEvUKCrxtYzLBLtNF2tugJsdgVUE2RjB4oXkbNhZ/l88gr9tH1u1GSBgdPV5sJiePwjs6EN+M96lpnl6n25ndRBEiPGmviR40hTKbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774903188; c=relaxed/simple;
	bh=+3xE28sy8+DvCRKnhtXiv96e0ooraKfxcivtSIDaxlA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fEkaY+qdsS/s6xxZoM2x1ekb8HRWE69qfVHDw5Z1Bfh7i2QIpg737c02BSx5NqF6U0pzUj6y9E0pNR06jFqLqDFagsNku7TL8Z1TSs2HZNKXFNKNmxdYWSvCuOpBg/Y68kqT8hK4D+a8Px4hIsvHcCS9XNd85tjH+kJIh5kRevM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iQwmuLrU; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iQwmuLrU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774903185; x=1806439185;
  h=date:from:to:cc:subject:message-id;
  bh=+3xE28sy8+DvCRKnhtXiv96e0ooraKfxcivtSIDaxlA=;
  b=iQwmuLrUxT89qP17nStSKeZZBQdg+Tof3l4PucZyCPhspXLc5WJ/XQl3
   N96S8ADJQ7fFOoUZ0W9Qfo2rBlzHI+k8Q1VpUqxaK0xF4AR8zez3cPvY3
   nrAvOm+aqiLEKMLvJ5H9HWX5I+S00UbZkc4fmav3NEhgsDN6bAeA/P9yF
   TNkxc/IEx0glffS0qK9SkjVs89K28+dkbHOQrX4ClK73kDLA4rN8CG//r
   Qb02lkBCxU5LmZLi43HAdPG1BEoYXSpc/nn8ki+EjA7ldTpJ+Q7Zr6RvI
   mEDdKJGwsDWTAIKyyg8CiZ8Rg+V0pH4R1NLrEknxl+aK/LnSTCqIxVwtq
   A==;
X-CSE-ConnectionGUID: 6JHLmHvhQVm17SZqlI2LKg==
X-CSE-MsgGUID: vsfnylKKSMuSI9EYF+9+Gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="75923612"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="75923612"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 13:39:44 -0700
X-CSE-ConnectionGUID: vGroEUayRVOvp3tpbgHZfA==
X-CSE-MsgGUID: clD4RMfjRk69p2FE+//6Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="225329132"
Received: from lkp-server01.sh.intel.com (HELO 283bf2e1b94a) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 30 Mar 2026 13:39:42 -0700
Received: from kbuild by 283bf2e1b94a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w7JOd-000000001g9-2v3d;
	Mon, 30 Mar 2026 20:39:39 +0000
Date: Tue, 31 Mar 2026 04:38:41 +0800
From: kernel test robot <lkp@intel.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [rafael-pm:testing 161/166]
 drivers/powercap/intel_rapl_common.c:1143:32: error:
 'IOSF_CPU_POWER_BUDGET_CTL_BYT' undeclared here (not in a function)
Message-ID: <202603310439.J9wmW1hQ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

Hi Kuppuswamy,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git testing
head:   42d55832a5e041da2575cf582669755d6d0f9a45
commit: 6cec0a0079bc188fbb9f0363c11973a81f8fbf9c [161/166] powercap: intel_rapl: Remove unused macro definitions
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260331/202603310439.J9wmW1hQ-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260331/202603310439.J9wmW1hQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603310439.J9wmW1hQ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/powercap/intel_rapl_common.c:1143:32: error: 'IOSF_CPU_POWER_BUDGET_CTL_BYT' undeclared here (not in a function)
    1143 |         .floor_freq_reg_addr = IOSF_CPU_POWER_BUDGET_CTL_BYT,
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/powercap/intel_rapl_common.c:1150:32: error: 'IOSF_CPU_POWER_BUDGET_CTL_TNG' undeclared here (not in a function)
    1150 |         .floor_freq_reg_addr = IOSF_CPU_POWER_BUDGET_CTL_TNG,
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/IOSF_CPU_POWER_BUDGET_CTL_BYT +1143 drivers/powercap/intel_rapl_common.c

2d798d9f5967a3 drivers/powercap/intel_rapl_common.c Zhang Rui   2020-06-29  1141  
51b63409b75980 drivers/powercap/intel_rapl.c        Ajay Thomas 2015-04-30  1142  static const struct rapl_defaults rapl_defaults_byt = {
51b63409b75980 drivers/powercap/intel_rapl.c        Ajay Thomas 2015-04-30 @1143  	.floor_freq_reg_addr = IOSF_CPU_POWER_BUDGET_CTL_BYT,
51b63409b75980 drivers/powercap/intel_rapl.c        Ajay Thomas 2015-04-30  1144  	.check_unit = rapl_check_unit_atom,
51b63409b75980 drivers/powercap/intel_rapl.c        Ajay Thomas 2015-04-30  1145  	.set_floor_freq = set_floor_freq_atom,
51b63409b75980 drivers/powercap/intel_rapl.c        Ajay Thomas 2015-04-30  1146  	.compute_time_window = rapl_compute_time_window_atom,
51b63409b75980 drivers/powercap/intel_rapl.c        Ajay Thomas 2015-04-30  1147  };
51b63409b75980 drivers/powercap/intel_rapl.c        Ajay Thomas 2015-04-30  1148  
51b63409b75980 drivers/powercap/intel_rapl.c        Ajay Thomas 2015-04-30  1149  static const struct rapl_defaults rapl_defaults_tng = {
51b63409b75980 drivers/powercap/intel_rapl.c        Ajay Thomas 2015-04-30 @1150  	.floor_freq_reg_addr = IOSF_CPU_POWER_BUDGET_CTL_TNG,
3c2c08454ce9ca drivers/powercap/intel_rapl.c        Jacob Pan   2014-11-07  1151  	.check_unit = rapl_check_unit_atom,
3c2c08454ce9ca drivers/powercap/intel_rapl.c        Jacob Pan   2014-11-07  1152  	.set_floor_freq = set_floor_freq_atom,
3c2c08454ce9ca drivers/powercap/intel_rapl.c        Jacob Pan   2014-11-07  1153  	.compute_time_window = rapl_compute_time_window_atom,
087e9cbab5022f drivers/powercap/intel_rapl.c        Jacob Pan   2014-11-07  1154  };
087e9cbab5022f drivers/powercap/intel_rapl.c        Jacob Pan   2014-11-07  1155  

:::::: The code at line 1143 was first introduced by commit
:::::: 51b63409b75980753f52edb45da7d1b3e2b9405d powercap / RAPL: Floor frequency setting in Atom SoC

:::::: TO: Ajay Thomas <ajay.thomas.david.rajamanickam@intel.com>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
