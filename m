Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D86E37474B
	for <linux-pm@vger.kernel.org>; Tue,  7 Apr 2026 03:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775533944; cv=none; b=KUUaeAu4Er+n5YSF3eF50BXZKsVnzvc1mqGwcUUwQGIz9Pph/Q6snpTRl4dZjaf+FCeNesfzSV+yP567Dnin92owAhkY8Lcdc5oMkTzYQJKEOwDvCTuL6jILqlZYaMptvdj6k+FW4zgo2WVVpt/2sABK+Me8TRw8C6bEp+w//qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775533944; c=relaxed/simple;
	bh=2cFqyz5C6rJgd4peP6Nc5WsW7lZSzq16/K+Ou1GTFFQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KBzyhDNCW7QVOp2RiKjuens8zq6QNARPwEOB4k+q/Lkjz8+uBJ1OuuEKUWOyudyFuBzX3mi0064g9YHTts5YNDuhKK/xwgGZaA1bGToi4X+HLVqd8raXPzNSR8Jk6ExlVHfTjOBbwPpiM7Lt2Z+11aosu3iTDEZmbemISKiT4yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EPgitkqF; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EPgitkqF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775533943; x=1807069943;
  h=date:from:to:cc:subject:message-id;
  bh=2cFqyz5C6rJgd4peP6Nc5WsW7lZSzq16/K+Ou1GTFFQ=;
  b=EPgitkqFXrUpd0PeAldBMV860dOgwuBYNpOSdPWT19RZT8fBp53nyJq6
   f2MR8fBJX/QVPbhKdbN8/aHBLVGnoKOLPxtSYxxJQavgzJUX8TtI0p7ii
   n9VpWNz4d+w7GZVF40mlmck2ec04QZRPUitJgfJpXNrVvicNnj7x+8mF1
   rTmCApNkyYkZHYx1PYi7iZIdBLNGIPdx+0r5otuqGxKyJPVdgHN/kd82z
   sfeXbMiuBpdWtxa9XU2xZICjygZmEicIU14CQPoFFicmi8dbJeztbzPeC
   pf2xFxVtUa8GSiwumJLq+hPCekShouO4slPCxKdDe8g1GDHXXGXkU0wpY
   g==;
X-CSE-ConnectionGUID: HSm/sCYNQ3Of8qH0/4Kslw==
X-CSE-MsgGUID: hFhiMn1+RMml4nlr/17qag==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="86781489"
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="86781489"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 20:52:23 -0700
X-CSE-ConnectionGUID: yV0PezZ9Q5qSviH6SN0n+g==
X-CSE-MsgGUID: m0iCFp6DSmeOCZfOh/YMGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="224842923"
Received: from lkp-server01.sh.intel.com (HELO d00eb8a6782a) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 06 Apr 2026 20:52:21 -0700
Received: from kbuild by d00eb8a6782a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w9xUA-0000000002h-3L6a;
	Tue, 07 Apr 2026 03:52:18 +0000
Date: Tue, 07 Apr 2026 11:51:35 +0800
From: kernel test robot <lkp@intel.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Subject: [amd-pstate:linux-next 15/22] ld.lld: error: undefined
 symbol: power_supply_reg_notifier
Message-ID: <202604040742.ySEdkuAa-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git linux-next
head:   9487e2a00e7b3c6f258c5c99953f470eba6fb61d
commit: e30ca6dd5345c5b8ba05f346a8e81105352fe571 [15/22] cpufreq/amd-pstate: Add dynamic energy performance preference
config: x86_64-randconfig-121-20260403 (https://download.01.org/0day-ci/archive/20260404/202604040742.ySEdkuAa-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260404/202604040742.ySEdkuAa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604040742.ySEdkuAa-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: power_supply_reg_notifier
   >>> referenced by amd-pstate.c:1216 (drivers/cpufreq/amd-pstate.c:1216)
   >>>               vmlinux.o:(amd_pstate_epp_cpu_init)
--
>> ld.lld: error: undefined symbol: power_supply_unreg_notifier
   >>> referenced by amd-pstate.c:1198 (drivers/cpufreq/amd-pstate.c:1198)
   >>>               vmlinux.o:(amd_pstate_epp_cpu_init)
   >>> referenced by amd-pstate.c:1198 (drivers/cpufreq/amd-pstate.c:1198)
   >>>               vmlinux.o:(amd_pstate_epp_cpu_exit)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
