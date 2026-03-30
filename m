Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E83136404D;
	Mon, 30 Mar 2026 21:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774905890; cv=none; b=j5wlbxT4TSh9NxZwUQNIPsjIUS+inQei2AR26T5IniPA+z9H8ZJVN+Wjtl16jKrY3l0Rj5nvcWsxdziaQiiS8T3EvWNuE1+R+AO0imB0050DUZALj6mfC6C7NVjQmneeW8uhnI/G5ifhK4gn3/yKErc88hQzTFChVWNgQ3g5oXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774905890; c=relaxed/simple;
	bh=9dDXrDB+eX/zMrgci8Jy2eu2dL5dSEgo3U0NBB95YJk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mz8fbpQL5wijrTDbeflW6hI27lQ88wk7xxjTElKg5tbr5dTebPSWYYP1ndwkQeot5HN1rgwvz0szGEhNC0NNPbUaDDgelLTdkcJ8mNxTFGLmhI68aSb95Q42hvTZ2cAIsUCST/hZ086MYDiLE6GbGbs2ih0mKkhHn7jHtFjN/iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MTsefXfG; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MTsefXfG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774905889; x=1806441889;
  h=date:from:to:cc:subject:message-id;
  bh=9dDXrDB+eX/zMrgci8Jy2eu2dL5dSEgo3U0NBB95YJk=;
  b=MTsefXfGmjdUBDI5x/Z2en9ndSdIadGz1URF7NCrKccbk3X8irCgglf+
   7cx1U3VbYBN89d8k5Uzj/N5qzLKaHmH0h6j89GpIUhCP1MLA/flCx3dxL
   //zKQ3wxPaYQPNBdlj3C++oEBWZDKQiLUouD594h20ow1jxqYUsyGdcR9
   Mtx2LDRUEHN3bj5vsPsdWEI3HQei5SyDjoA6BXrKtmbCovYKSKgs/2Itg
   LTqU4ZgGC0Y73TulVKwHQoOtzn2NQQrft8ini7UGnEZ24cGAtPyMr1BDY
   wBLHqztj75vELgDRdt3TLRlMA0/KRFxc5M21/HVAjKpngnjgWLmzJgA3G
   g==;
X-CSE-ConnectionGUID: HtRL9a8hS/miEPIutGw/wg==
X-CSE-MsgGUID: uT75lM0zT0qRkp2m7iyFeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="75876641"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="75876641"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 14:24:49 -0700
X-CSE-ConnectionGUID: nbyZNWE+SFmVgL4Ladt8xQ==
X-CSE-MsgGUID: advd3DTzR/+fHDnaKKNF3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="221302154"
Received: from lkp-server01.sh.intel.com (HELO 283bf2e1b94a) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 30 Mar 2026 14:24:46 -0700
Received: from kbuild by 283bf2e1b94a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w7K6F-000000001jV-1VIl;
	Mon, 30 Mar 2026 21:24:43 +0000
Date: Tue, 31 Mar 2026 05:24:08 +0800
From: kernel test robot <lkp@intel.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [rafael-pm:bleeding-edge 175/181]
 drivers/powercap/intel_rapl_common.c:1143:25: error: use of undeclared
 identifier 'IOSF_CPU_POWER_BUDGET_CTL_BYT'
Message-ID: <202603310544.0WC7CT1o-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

Hi Kuppuswamy,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   a4b9106c1c54a3f214009aa006cf31f9329b6b27
commit: 6cec0a0079bc188fbb9f0363c11973a81f8fbf9c [175/181] powercap: intel_rapl: Remove unused macro definitions
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20260331/202603310544.0WC7CT1o-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260331/202603310544.0WC7CT1o-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603310544.0WC7CT1o-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/powercap/intel_rapl_common.c:1143:25: error: use of undeclared identifier 'IOSF_CPU_POWER_BUDGET_CTL_BYT'
    1143 |         .floor_freq_reg_addr = IOSF_CPU_POWER_BUDGET_CTL_BYT,
         |                                ^
>> drivers/powercap/intel_rapl_common.c:1150:25: error: use of undeclared identifier 'IOSF_CPU_POWER_BUDGET_CTL_TNG'
    1150 |         .floor_freq_reg_addr = IOSF_CPU_POWER_BUDGET_CTL_TNG,
         |                                ^
   2 errors generated.


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
