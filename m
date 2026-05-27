Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ED4381AFC
	for <linux-pm@vger.kernel.org>; Wed, 27 May 2026 18:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779907121; cv=none; b=EW60MiotjkAUom3VZjw7BZ8blVo4NtJczyExW8gCw6ob9BH+bTQ78k5LwoaiOSTG+nDJ1LmCs+KsOSGBjwuyyKT/xF7qcCcKTArd0HHGWd+v70mIKITE1nhgogluctFygad4RRH4+Ffjb/C/GCID43JXx49usj2ZoNCBc8F1Pac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779907121; c=relaxed/simple;
	bh=4vWnplo4IC+VPtAwYTcVPR/kHDGv4sPF2TzcyZD/h/8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=N1vzAkXbR6ZL1bgACbncKmvd5ZvZaFRxZVacuQR83/nDgxQLj10YtWQGqW0k7vtCwNxBW7oo+bRq/sEsixDVkXngBBj7J+1qbCNOESyVBmFGWZHNT8G11p8jlLWDrWoROlKuL389oelE7PoTSrrBbETBQgjJC/j1Y2Ir8119DMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D2fXOnzT; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D2fXOnzT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779907120; x=1811443120;
  h=date:from:to:cc:subject:message-id;
  bh=4vWnplo4IC+VPtAwYTcVPR/kHDGv4sPF2TzcyZD/h/8=;
  b=D2fXOnzTO2iyDROXGO76isNJ+kFOSHX68kbsYWd5EDWDO6XHZEXsnq0i
   Pozk2I4hr1CbEEO9c7aazy5be5BRmQTwgltXA0R1jJ3FfZgngK7dvsyKK
   yXpLpTmAgPFA0BkHNrNzAjZL53IYJBoh5L7FYvQvEAuEdw93Q4HS8zktL
   Fm/clZULteSzGo7KPeYXryO/y3dWhxBGWyQUFWo3+dTpDLH3OEVwgG/+Z
   tt+atUhtUr2axS82k8E5JUM+cM1qyz5taQaOJF5EmtNVlXM5ShPdX3rmZ
   MA5lBWyvg6CE77UnNClj1qb2yhQcyu4AISbUXkAhU4WYi1OECRrIWK886
   g==;
X-CSE-ConnectionGUID: GnWnOA3vSEirslfB+O0RaQ==
X-CSE-MsgGUID: iOyAqkZXQS2+WzH+EmSMYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="84373542"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="84373542"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 11:38:40 -0700
X-CSE-ConnectionGUID: Kz4Xhs/+Q866UW3hR58c1Q==
X-CSE-MsgGUID: Q8GGMwSlQVapNyVBhCW1mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="241280264"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 27 May 2026 11:38:39 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wSJ9I-000000004KI-1AGG;
	Wed, 27 May 2026 18:38:36 +0000
Date: Thu, 28 May 2026 02:38:05 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: linux-pm@vger.kernel.org
Subject: [amd-pstate:amd-pstate-fixes] BUILD SUCCESS
 3cd07ee35a66038fd1a643632bfc057645e07c9a
Message-ID: <202605280256.ucYR7ID0-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git amd-pstate-fixes
branch HEAD: 3cd07ee35a66038fd1a643632bfc057645e07c9a  cpufreq/amd-pstate: drop stale @epp_cached kdoc

elapsed time: 1592m

configs tested: 54
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-15.2.0
alpha        allyesconfig    gcc-15.2.0
arc          allmodconfig    gcc-15.2.0
arc           allnoconfig    gcc-15.2.0
arc          allyesconfig    gcc-15.2.0
arm           allnoconfig    clang-23
arm          allyesconfig    gcc-15.2.0
arm64        allmodconfig    clang-19
arm64         allnoconfig    gcc-15.2.0
csky         allmodconfig    gcc-15.2.0
csky          allnoconfig    gcc-15.2.0
hexagon      allmodconfig    clang-17
hexagon       allnoconfig    clang-23
i386         allmodconfig    gcc-14
i386          allnoconfig    gcc-14
i386         allyesconfig    gcc-14
loongarch    allmodconfig    clang-19
loongarch     allnoconfig    clang-23
m68k         allmodconfig    gcc-15.2.0
m68k          allnoconfig    gcc-15.2.0
m68k         allyesconfig    gcc-15.2.0
microblaze    allnoconfig    gcc-15.2.0
microblaze   allyesconfig    gcc-15.2.0
mips         allmodconfig    gcc-15.2.0
mips          allnoconfig    gcc-15.2.0
mips         allyesconfig    gcc-15.2.0
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    gcc-15.2.0
openrisc      allnoconfig    gcc-15.2.0
parisc       allmodconfig    gcc-15.2.0
parisc        allnoconfig    gcc-15.2.0
parisc       allyesconfig    gcc-15.2.0
powerpc      allmodconfig    gcc-15.2.0
powerpc       allnoconfig    gcc-15.2.0
riscv        allmodconfig    clang-23
riscv         allnoconfig    gcc-15.2.0
riscv        allyesconfig    clang-16
s390         allmodconfig    clang-18
s390          allnoconfig    clang-23
s390         allyesconfig    gcc-15.2.0
sh           allmodconfig    gcc-15.2.0
sh            allnoconfig    gcc-15.2.0
sh           allyesconfig    gcc-15.2.0
sparc         allnoconfig    gcc-15.2.0
sparc64      allmodconfig    clang-23
um           allmodconfig    clang-19
um            allnoconfig    clang-23
um           allyesconfig    gcc-14
x86_64       allmodconfig    clang-20
x86_64        allnoconfig    clang-20
x86_64       allyesconfig    clang-20
x86_64      rhel-9.4-rust    clang-20
xtensa        allnoconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
