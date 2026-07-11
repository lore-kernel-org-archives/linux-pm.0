Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913952264C0;
	Sat, 11 Jul 2026 03:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783741764; cv=none; b=ac/nZL7W5DFAAnajykPFyWp2E5LO8vCGodj0nJ2EBEF2sHA4p4TnEYEVCfDCf1mmxlIfKRmQa4dhkIQwGbNpt20sXkIZin9mexH/F+WeEBh3omhD3DCrg01Qeo1f/XHjhMMAWS2tt0VKN5vuGAdQMKgaHzDLarUMPljjYg7vemQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783741764; c=relaxed/simple;
	bh=4jQE6pbDV+FoYS5UvuW/QhoCXc0fTtiUbe+/dSRcrkk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=uyOCmE8zy/7kkJIs0hlzpNbnNFWkFYyZaMwETBzTaOoataQ8Zc/wnQGTe+0N3CS2vzWoWqjKqa2/8/pNtWmvUn1cngVQ3b9FhxsW/yZaOeWJedX0MMfCkv1zTWsL3wAVGmSQPMvqh62/adIqMJ1YE1IlC2YIuq/jMw9x/FXoYuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IN5qD7zH; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IN5qD7zH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783741762; x=1815277762;
  h=date:from:to:cc:subject:message-id;
  bh=4jQE6pbDV+FoYS5UvuW/QhoCXc0fTtiUbe+/dSRcrkk=;
  b=IN5qD7zHaC4K6OOGA4fcrha6JubOhqrqcmCYN3ujbl8CAUHCNinAELOM
   jnAQZBStPoz71J7Wi3pTngFPB25yaEnmqF7/qGPzRxX2/XXbz2JgSCNt3
   jErmR3rI6hhYwbVMP23snhgIK47H+BwN+/3e9/wGpGfrw+WxZimGpS4nI
   Iz6tJvHgBxzTLRUWghZYck0i/Udstyrl/0A3qDgJpmqVYtIr60vjgo2f2
   rNQXYw2jFcUmkkpnpCagSOt7L/n2YdKeD77Q+jojf3gDAgoXhUXVAdkvS
   Mfzf9Y20m5j3ZfDvATt9qie+t9nvwXMcKPgve0hllrmIYKubjjljkuWQ6
   w==;
X-CSE-ConnectionGUID: GZlS4p3fSBeLevN3r44B8Q==
X-CSE-MsgGUID: fcu64pt6TV2w93AsbATMqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84551875"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84551875"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 20:49:21 -0700
X-CSE-ConnectionGUID: 4sajkIqgRviJIFFUoYeseA==
X-CSE-MsgGUID: euXKCrMLQVOzXx+je9hLYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="278295068"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 10 Jul 2026 20:49:19 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wiOiK-00000000JhS-2vIf;
	Sat, 11 Jul 2026 03:49:16 +0000
Date: Sat, 11 Jul 2026 11:49:09 +0800
From: kernel test robot <lkp@intel.com>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [rafael-pm:bleeding-edge 56/59]
 drivers/thermal/intel/therm_throt.c:545:17: warning: 'msr_val' is used
 uninitialized
Message-ID: <202607111159.OKnM0OJu-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   29ef85e24c475132363ab956dea5db1b2600ef75
commit: 9d8ba97052b6d613819ae217cc406228a5799df1 [56/59] thermal: intel: Enable the Directed Package-level Thermal Interrupt
config: x86_64-buildonly-randconfig-002-20260711 (https://download.01.org/0day-ci/archive/20260711/202607111159.OKnM0OJu-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.4.0-5) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260711/202607111159.OKnM0OJu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607111159.OKnM0OJu-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/thermal/intel/therm_throt.c: In function 'check_directed_thermal_pkg_intr_ack':
   drivers/thermal/intel/therm_throt.c:545:17: error: implicit declaration of function 'rdmsrl'; did you mean 'rdmsrq'? [-Werror=implicit-function-declaration]
     545 |                 rdmsrl(MSR_IA32_PACKAGE_THERM_STATUS, msr_val);
         |                 ^~~~~~
         |                 rdmsrq
   drivers/thermal/intel/therm_throt.c: In function 'config_directed_thermal_pkg_intr':
   drivers/thermal/intel/therm_throt.c:570:9: error: implicit declaration of function 'wrmsrl'; did you mean 'wrmsrq'? [-Werror=implicit-function-declaration]
     570 |         wrmsrl(MSR_IA32_THERM_INTERRUPT, msr_val);
         |         ^~~~~~
         |         wrmsrq
   drivers/thermal/intel/therm_throt.c: In function 'check_directed_thermal_pkg_intr_ack':
>> drivers/thermal/intel/therm_throt.c:545:17: warning: 'msr_val' is used uninitialized [-Wuninitialized]
     545 |                 rdmsrl(MSR_IA32_PACKAGE_THERM_STATUS, msr_val);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/thermal/intel/therm_throt.c:538:13: note: 'msr_val' was declared here
     538 |         u64 msr_val;
         |             ^~~~~~~
   drivers/thermal/intel/therm_throt.c: In function 'config_directed_thermal_pkg_intr':
   drivers/thermal/intel/therm_throt.c:563:9: warning: 'msr_val' is used uninitialized [-Wuninitialized]
     563 |         rdmsrl(MSR_IA32_THERM_INTERRUPT, msr_val);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/thermal/intel/therm_throt.c:561:13: note: 'msr_val' was declared here
     561 |         u64 msr_val;
         |             ^~~~~~~
   cc1: some warnings being treated as errors


vim +/msr_val +545 drivers/thermal/intel/therm_throt.c

   534	
   535	static int check_directed_thermal_pkg_intr_ack(void)
   536	{
   537		unsigned int count = 15000;
   538		u64 msr_val;
   539	
   540		/*
   541		 * Hardware acknowledges the directed interrupt setup in 10ms or less.
   542		 * Wait 15ms to be safe.
   543		 */
   544		do {
 > 545			rdmsrl(MSR_IA32_PACKAGE_THERM_STATUS, msr_val);
   546			udelay(1);
   547		} while (!(msr_val & PACKAGE_THERM_STATUS_DPTI_ACK) && --count);
   548	
   549		if (!count)
   550			return -ETIMEDOUT;
   551	
   552		thermal_clear_package_intr_status(PACKAGE_LEVEL,
   553						  PACKAGE_THERM_STATUS_DPTI_ACK);
   554	
   555		return 0;
   556	}
   557	
   558	static void config_directed_thermal_pkg_intr(void *info)
   559	{
   560		bool enable = *((bool *)info);
   561		u64 msr_val;
   562	
   563		rdmsrl(MSR_IA32_THERM_INTERRUPT, msr_val);
   564	
   565		if (enable)
   566			msr_val |= THERM_INT_DPTI_ENABLE;
   567		else
   568			msr_val &= ~THERM_INT_DPTI_ENABLE;
   569	
 > 570		wrmsrl(MSR_IA32_THERM_INTERRUPT, msr_val);
   571	}
   572	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
