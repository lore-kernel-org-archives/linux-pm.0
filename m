Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A06E2C3768;
	Thu,  6 Aug 2026 14:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786026984; cv=none; b=SJ0jrHfJ7CJ3V2c9RI23IMW8MBq9F7V8Nt2iRxAfXA83tWsXdAYO4jME/VyZ3ZbO8ViP7d81v3+3bVPv/NwW3kXsqx/uj9ImJfHbYm+WbcH33n1Ivjh7BC/Zy0re4/dMIJNfGzxF8U+naFmZxiMDYGYzR7DdR5DFy3rgmj8s5iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786026984; c=relaxed/simple;
	bh=I5U/3QMOREYQLQtBCGPZb8D/ULcgP7XxXdTi6Mn1G7U=;
	h=Date:From:To:Cc:Subject:Message-ID; b=g1paaad15cd7Zb3n5pXBmQxhYi6NR1HRtYr/yoQyYC4lSDvM4JkrVg7Y7eCdPxfaOkjucUlJT4KTwpIDXEi231Tn/WodbckNVLneffJRkK2EZt0+20/UezRlZokH8Toj0oyuJV0TAU4kjdNK2E8EdLd8MJJkypQwO16KHK4jeAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zv4woaL6; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zv4woaL6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786026981; x=1817562981;
  h=date:from:to:cc:subject:message-id;
  bh=I5U/3QMOREYQLQtBCGPZb8D/ULcgP7XxXdTi6Mn1G7U=;
  b=Zv4woaL6qDQSyWcgqAVKNcjpOLr0JleiwBlnjxczsq5NUEEWbFx5dHrD
   LdyXqbmUPap9qEHYN1kW4z03Jcpmsy7JXx5iCqVbN/l0hguYaG+LwrdWF
   W4Qo/x8PsHD9IHG6jq8DFAfMSa5HAAKQkaAuE3zumQ/k+oYfSVMGb1Ewv
   lRMcIfYMy56F2+DY7dLsqd88KdmybNxDhae+KURhWVInOfLiTwNhXoYly
   CuQQZuCrdbDLUWxseSZ7gZBp+UQaE47ZrzV+7l2O7hsJ4/NevyNkrgm6r
   xclAS450dw0+ZeczYVjB6Ai4hfrgu8lMIggWtlFUcyejdX37PDUH8jxNu
   w==;
X-CSE-ConnectionGUID: +h7t3DzHR9mWpoc+uDfb3A==
X-CSE-MsgGUID: Jm/VOtFSRQ+zWtKoqOxY8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="90502547"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="90502547"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 07:36:19 -0700
X-CSE-ConnectionGUID: i6Glns09Q3a/E0KIi1fO6g==
X-CSE-MsgGUID: Fyeu2qmcS0m3iQzsUk4rgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="259500577"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 06 Aug 2026 07:36:17 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wrzCg-00000000FMl-3g8m;
	Thu, 06 Aug 2026 14:36:14 +0000
Date: Thu, 06 Aug 2026 22:35:24 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 39cd7b5ec8fe62bb4ac533f629819a2203828db5
Message-ID: <202608062212.Mt42KW53-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: 39cd7b5ec8fe62bb4ac533f629819a2203828db5  Merge branch 'thermal-hwmon' into fixes

elapsed time: 1576m

configs tested: 166
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             alldefconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260806    gcc-11.5.0
arc                  randconfig-002-20260806    gcc-11.5.0
arm                  randconfig-001-20260806    gcc-11.5.0
arm                  randconfig-002-20260806    gcc-11.5.0
arm                  randconfig-003-20260806    gcc-11.5.0
arm                  randconfig-004-20260806    gcc-11.5.0
arm64                randconfig-001-20260805    clang-24
arm64                randconfig-001-20260806    gcc-13.4.0
arm64                randconfig-002-20260805    gcc-8.5.0
arm64                randconfig-002-20260806    gcc-13.4.0
arm64                randconfig-003-20260805    clang-24
arm64                randconfig-003-20260806    gcc-13.4.0
arm64                randconfig-004-20260805    clang-24
arm64                randconfig-004-20260806    gcc-13.4.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260805    gcc-16.1.0
csky                 randconfig-001-20260806    gcc-13.4.0
csky                 randconfig-002-20260805    gcc-10.5.0
csky                 randconfig-002-20260806    gcc-13.4.0
hexagon              randconfig-001-20260805    clang-17
hexagon              randconfig-001-20260806    clang-24
hexagon              randconfig-002-20260805    clang-19
hexagon              randconfig-002-20260806    clang-24
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260806    gcc-14
i386       buildonly-randconfig-002-20260806    gcc-14
i386       buildonly-randconfig-003-20260806    gcc-14
i386       buildonly-randconfig-004-20260806    gcc-14
i386       buildonly-randconfig-005-20260806    gcc-14
i386       buildonly-randconfig-006-20260806    gcc-14
i386                          randconfig-001    clang-22
i386                 randconfig-001-20260805    clang-22
i386                 randconfig-001-20260806    clang-22
i386                 randconfig-002-20260805    clang-22
i386                 randconfig-002-20260806    clang-22
i386                 randconfig-003-20260805    gcc-14
i386                 randconfig-003-20260806    clang-22
i386                 randconfig-004-20260805    clang-22
i386                 randconfig-004-20260806    clang-22
i386                 randconfig-005-20260805    gcc-14
i386                 randconfig-005-20260806    clang-22
i386                 randconfig-006-20260805    gcc-13
i386                 randconfig-006-20260806    clang-22
i386                 randconfig-007-20260805    gcc-14
i386                 randconfig-007-20260806    clang-22
i386                 randconfig-011-20260805    gcc-14
i386                 randconfig-011-20260806    clang-22
i386                 randconfig-012-20260805    gcc-14
i386                 randconfig-012-20260806    clang-22
i386                 randconfig-013-20260805    clang-22
i386                 randconfig-013-20260806    clang-22
i386                 randconfig-014-20260805    clang-22
i386                 randconfig-014-20260806    clang-22
i386                 randconfig-015-20260805    gcc-14
i386                 randconfig-015-20260806    clang-22
i386                 randconfig-016-20260805    gcc-14
i386                 randconfig-016-20260806    clang-22
i386                 randconfig-017-20260805    gcc-14
i386                 randconfig-017-20260806    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260805    clang-18
loongarch            randconfig-001-20260806    clang-24
loongarch            randconfig-002-20260805    clang-18
loongarch            randconfig-002-20260806    clang-24
m68k                      m5208evb_defconfig    gcc-16.1.0
mips                          xway_defconfig    clang-19
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260805    gcc-10.5.0
nios2                randconfig-001-20260806    clang-24
nios2                randconfig-002-20260805    gcc-11.5.0
nios2                randconfig-002-20260806    clang-24
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260806    gcc-8.5.0
parisc               randconfig-002-20260806    gcc-8.5.0
powerpc              randconfig-001-20260806    gcc-8.5.0
powerpc              randconfig-002-20260806    gcc-8.5.0
powerpc64            randconfig-001-20260806    gcc-8.5.0
powerpc64            randconfig-002-20260806    gcc-8.5.0
riscv                         randconfig-001    gcc-13.4.0
riscv                randconfig-001-20260806    gcc-13.4.0
riscv                randconfig-002-20260806    gcc-13.4.0
s390                 randconfig-001-20260806    gcc-13.4.0
s390                 randconfig-002-20260806    gcc-13.4.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260806    gcc-13.4.0
sh                   randconfig-002-20260806    gcc-13.4.0
sparc                         randconfig-001    gcc-8.5.0
sparc                randconfig-001-20260805    gcc-16.1.0
sparc                randconfig-001-20260806    gcc-8.5.0
sparc                randconfig-002-20260805    gcc-11.5.0
sparc                randconfig-002-20260806    gcc-8.5.0
sparc64              randconfig-001-20260805    gcc-9.5.0
sparc64              randconfig-001-20260806    gcc-8.5.0
sparc64              randconfig-002-20260805    gcc-8.5.0
sparc64              randconfig-002-20260806    gcc-8.5.0
um                   randconfig-001-20260805    gcc-14
um                   randconfig-001-20260806    gcc-8.5.0
um                   randconfig-002-20260805    gcc-14
um                   randconfig-002-20260806    gcc-8.5.0
x86_64              buildonly-randconfig-001    clang-22
x86_64     buildonly-randconfig-001-20260805    gcc-14
x86_64     buildonly-randconfig-001-20260806    clang-22
x86_64     buildonly-randconfig-002-20260805    clang-22
x86_64     buildonly-randconfig-002-20260806    clang-22
x86_64     buildonly-randconfig-003-20260805    clang-22
x86_64     buildonly-randconfig-003-20260806    clang-22
x86_64     buildonly-randconfig-004-20260805    gcc-13
x86_64     buildonly-randconfig-004-20260806    clang-22
x86_64     buildonly-randconfig-005-20260805    gcc-14
x86_64     buildonly-randconfig-005-20260806    clang-22
x86_64     buildonly-randconfig-006-20260805    clang-22
x86_64     buildonly-randconfig-006-20260806    clang-22
x86_64                                 kexec    clang-22
x86_64                        randconfig-001    gcc-14
x86_64               randconfig-001-20260805    gcc-14
x86_64               randconfig-001-20260806    clang-22
x86_64               randconfig-002-20260805    gcc-14
x86_64               randconfig-002-20260806    clang-22
x86_64               randconfig-003-20260805    clang-22
x86_64               randconfig-003-20260806    clang-22
x86_64               randconfig-004-20260805    gcc-14
x86_64               randconfig-004-20260806    clang-22
x86_64               randconfig-005-20260805    gcc-14
x86_64               randconfig-005-20260806    clang-22
x86_64               randconfig-006-20260805    gcc-14
x86_64               randconfig-006-20260806    clang-22
x86_64                        randconfig-011    clang-22
x86_64                        randconfig-011    gcc-14
x86_64               randconfig-011-20260805    gcc-14
x86_64               randconfig-011-20260806    clang-22
x86_64               randconfig-012-20260805    gcc-14
x86_64               randconfig-012-20260806    clang-22
x86_64               randconfig-013-20260805    gcc-14
x86_64               randconfig-013-20260806    clang-22
x86_64               randconfig-014-20260805    clang-22
x86_64               randconfig-014-20260806    clang-22
x86_64               randconfig-015-20260805    clang-22
x86_64               randconfig-015-20260806    clang-22
x86_64               randconfig-016-20260805    clang-22
x86_64               randconfig-016-20260806    clang-22
x86_64                        randconfig-071    gcc-14
x86_64               randconfig-071-20260805    clang-22
x86_64               randconfig-071-20260806    gcc-14
x86_64               randconfig-072-20260805    gcc-14
x86_64               randconfig-072-20260806    gcc-14
x86_64               randconfig-073-20260805    gcc-13
x86_64               randconfig-073-20260806    gcc-14
x86_64               randconfig-074-20260805    clang-22
x86_64               randconfig-074-20260806    gcc-14
x86_64               randconfig-075-20260805    clang-22
x86_64               randconfig-075-20260806    gcc-14
x86_64               randconfig-076-20260805    clang-22
x86_64               randconfig-076-20260806    gcc-14
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260805    gcc-13.4.0
xtensa               randconfig-001-20260806    gcc-8.5.0
xtensa               randconfig-002-20260806    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
