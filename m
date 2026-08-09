Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6FA22B8DF;
	Sun,  9 Aug 2026 01:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786239941; cv=none; b=GlqW/v2DsWRQxCuygthNoacdbEJqtXEEHBIsgV6UlbqUHS3clY2ARKGfZpAt1TYP/imnUUxeXuLcMC6UCjdcdZ/kN6z66UbrRhWchF7P2YQ2ujcW1VszklnjWer6iAAHvR8WD9Q0tuBVM/N1EushUEzJRK652lFn7UXeghzuz00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786239941; c=relaxed/simple;
	bh=lJFUiFz9Tg/81GF4Re7Nl98AENohZfxRJD2CQffKlxk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qYhsTUY1eepJvWofBNKipWBWZ6+XuGWpdRidxWGHyClb3Z5R5zcX7OVw0EEdoq5CpEAkl9OVgvkI6TTqGz42HLHm+fXZ1rTmJHITiUt15eC5q52QFTGr+j7e//v+aG9dxjHszd5tpU5q2N9ntpkCAw9elwccPxKD4OVcb/O80ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aejGRsPW; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aejGRsPW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786239939; x=1817775939;
  h=date:from:to:cc:subject:message-id;
  bh=lJFUiFz9Tg/81GF4Re7Nl98AENohZfxRJD2CQffKlxk=;
  b=aejGRsPWiEqgD2cSY/rh1bBA3e2tw7zY+b3hQKCxrSnsBpYluSSQ+xz4
   MWnBck8UPVpYKOQtorL7WD3gag3YpuqylBo5KoqtV+XbgAPP2VoT7AOzc
   CpRJ2Zc5nekSIpHMD4ps61+/lEh0T6aMqhh5EeI/mmMb1osiqso1GBQLP
   n4M9S4zZb8gLEOZIVklWurkZyp5DLGXNtmJaP3UVJHZYRsTQIEEjyCv7a
   ZZGTk0bB6HrvM8GeS9BPpWVih77bKjQQuWiQk6X0DnWM4IkLOvyDeyN+L
   fQuY+LO1jc+eZ20bdSJ6drb7stq5LbzhzouboYeEnKegpaaMT2xVrDhlD
   g==;
X-CSE-ConnectionGUID: vc9+KMoUTACiOPM9Nz6IUw==
X-CSE-MsgGUID: A9elZI1mTge9EOmPV/LKnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11869"; a="109589865"
X-IronPort-AV: E=Sophos;i="6.25,213,1779174000"; 
   d="scan'208";a="109589865"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 18:45:38 -0700
X-CSE-ConnectionGUID: 31IXYjFzTgKhQcAuYZNeEw==
X-CSE-MsgGUID: ycXMe8TlSYCpkAoVdqSh+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,213,1779174000"; 
   d="scan'208";a="264706584"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 08 Aug 2026 18:45:36 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wssbV-00000000LIC-3lMH;
	Sun, 09 Aug 2026 01:45:33 +0000
Date: Sun, 09 Aug 2026 09:45:08 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 ad0487e3f7c2ce63f9e74dbaf139671c04c5874e
Message-ID: <202608090952.k7rsEj7b-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: ad0487e3f7c2ce63f9e74dbaf139671c04c5874e  Merge branch 'acpi-apei' into bleeding-edge

elapsed time: 1907m

configs tested: 156
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260808    gcc-9.5.0
arc                  randconfig-001-20260809    gcc-12.5.0
arc                  randconfig-002-20260808    gcc-9.5.0
arc                  randconfig-002-20260809    gcc-12.5.0
arm                  randconfig-001-20260808    gcc-9.5.0
arm                  randconfig-001-20260809    gcc-12.5.0
arm                  randconfig-002-20260808    gcc-9.5.0
arm                  randconfig-002-20260809    gcc-12.5.0
arm                  randconfig-003-20260808    gcc-9.5.0
arm                  randconfig-003-20260809    gcc-12.5.0
arm                  randconfig-004-20260808    gcc-9.5.0
arm                  randconfig-004-20260809    gcc-12.5.0
arm64                         randconfig-001    gcc-11.5.0
arm64                randconfig-001-20260808    gcc-11.5.0
arm64                randconfig-002-20260808    gcc-11.5.0
arm64                randconfig-003-20260808    gcc-11.5.0
arm64                randconfig-004-20260808    gcc-11.5.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260808    gcc-11.5.0
csky                 randconfig-002-20260808    gcc-11.5.0
hexagon                       randconfig-001    gcc-12.5.0
hexagon              randconfig-001-20260808    gcc-16.1.0
hexagon              randconfig-001-20260809    gcc-12.5.0
hexagon              randconfig-002-20260808    gcc-16.1.0
hexagon              randconfig-002-20260809    gcc-12.5.0
i386                            allmodconfig    gcc-14
i386                buildonly-randconfig-001    clang-22
i386       buildonly-randconfig-001-20260808    clang-22
i386       buildonly-randconfig-001-20260809    clang-22
i386       buildonly-randconfig-002-20260808    clang-22
i386       buildonly-randconfig-002-20260809    clang-22
i386       buildonly-randconfig-003-20260808    clang-22
i386       buildonly-randconfig-003-20260809    clang-22
i386       buildonly-randconfig-004-20260808    clang-22
i386       buildonly-randconfig-004-20260809    clang-22
i386       buildonly-randconfig-005-20260808    clang-22
i386       buildonly-randconfig-005-20260809    clang-22
i386       buildonly-randconfig-006-20260808    clang-22
i386       buildonly-randconfig-006-20260809    clang-22
i386                 randconfig-001-20260808    clang-22
i386                 randconfig-002-20260808    clang-22
i386                 randconfig-003-20260808    clang-22
i386                 randconfig-004-20260808    clang-22
i386                 randconfig-005-20260808    clang-22
i386                 randconfig-006-20260808    clang-22
i386                 randconfig-007-20260808    clang-22
i386                 randconfig-011-20260808    clang-22
i386                 randconfig-012-20260808    clang-22
i386                 randconfig-013-20260808    clang-22
i386                 randconfig-014-20260808    clang-22
i386                 randconfig-015-20260808    clang-22
i386                 randconfig-016-20260808    clang-22
i386                 randconfig-017-20260808    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260808    gcc-16.1.0
loongarch            randconfig-001-20260809    gcc-12.5.0
loongarch            randconfig-002-20260808    gcc-16.1.0
loongarch            randconfig-002-20260809    gcc-12.5.0
m68k                         sun3x_defconfig    gcc-16.1.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260808    gcc-16.1.0
nios2                randconfig-001-20260809    gcc-12.5.0
nios2                randconfig-002-20260808    gcc-16.1.0
nios2                randconfig-002-20260809    gcc-12.5.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260808    gcc-8.5.0
parisc               randconfig-001-20260809    gcc-8.5.0
parisc               randconfig-002-20260808    gcc-8.5.0
parisc               randconfig-002-20260809    gcc-8.5.0
powerpc              randconfig-001-20260808    gcc-8.5.0
powerpc              randconfig-001-20260809    gcc-8.5.0
powerpc              randconfig-002-20260808    gcc-8.5.0
powerpc              randconfig-002-20260809    gcc-8.5.0
powerpc64            randconfig-001-20260808    gcc-8.5.0
powerpc64            randconfig-001-20260809    gcc-8.5.0
powerpc64            randconfig-002-20260808    gcc-8.5.0
powerpc64            randconfig-002-20260809    gcc-8.5.0
riscv                randconfig-001-20260808    clang-24
riscv                randconfig-001-20260809    clang-24
riscv                randconfig-002-20260808    clang-24
riscv                randconfig-002-20260809    clang-24
s390                 randconfig-001-20260808    clang-24
s390                 randconfig-001-20260809    clang-24
s390                 randconfig-002-20260808    clang-24
s390                 randconfig-002-20260809    clang-24
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260808    clang-24
sh                   randconfig-001-20260809    clang-24
sh                   randconfig-002-20260808    clang-24
sh                   randconfig-002-20260809    clang-24
sparc                         randconfig-001    gcc-11.5.0
sparc                randconfig-001-20260808    gcc-8.5.0
sparc                randconfig-001-20260809    gcc-11.5.0
sparc                randconfig-002-20260808    gcc-8.5.0
sparc                randconfig-002-20260809    gcc-11.5.0
sparc64              randconfig-001-20260808    gcc-8.5.0
sparc64              randconfig-001-20260809    gcc-11.5.0
sparc64              randconfig-002-20260808    gcc-8.5.0
sparc64              randconfig-002-20260809    gcc-11.5.0
um                   randconfig-001-20260808    gcc-8.5.0
um                   randconfig-001-20260809    gcc-11.5.0
um                   randconfig-002-20260808    gcc-8.5.0
um                   randconfig-002-20260809    gcc-11.5.0
x86_64     buildonly-randconfig-001-20260808    gcc-14
x86_64     buildonly-randconfig-001-20260809    clang-22
x86_64     buildonly-randconfig-002-20260808    gcc-14
x86_64     buildonly-randconfig-002-20260809    clang-22
x86_64     buildonly-randconfig-003-20260808    gcc-14
x86_64     buildonly-randconfig-003-20260809    clang-22
x86_64     buildonly-randconfig-004-20260808    gcc-14
x86_64     buildonly-randconfig-004-20260809    clang-22
x86_64     buildonly-randconfig-005-20260808    gcc-14
x86_64     buildonly-randconfig-005-20260809    clang-22
x86_64     buildonly-randconfig-006-20260808    gcc-14
x86_64     buildonly-randconfig-006-20260809    clang-22
x86_64                                 kexec    clang-22
x86_64                        randconfig-001    clang-22
x86_64               randconfig-001-20260808    clang-22
x86_64               randconfig-001-20260809    clang-22
x86_64               randconfig-002-20260808    clang-22
x86_64               randconfig-002-20260809    clang-22
x86_64               randconfig-003-20260808    clang-22
x86_64               randconfig-003-20260809    clang-22
x86_64               randconfig-004-20260808    clang-22
x86_64               randconfig-004-20260809    clang-22
x86_64               randconfig-005-20260808    clang-22
x86_64               randconfig-005-20260809    clang-22
x86_64               randconfig-006-20260808    clang-22
x86_64               randconfig-006-20260809    clang-22
x86_64               randconfig-011-20260808    clang-22
x86_64               randconfig-012-20260808    clang-22
x86_64               randconfig-013-20260808    clang-22
x86_64               randconfig-014-20260808    clang-22
x86_64               randconfig-015-20260808    clang-22
x86_64               randconfig-016-20260808    clang-22
x86_64                        randconfig-071    gcc-14
x86_64               randconfig-071-20260808    gcc-14
x86_64               randconfig-072-20260808    gcc-14
x86_64               randconfig-073-20260808    gcc-14
x86_64               randconfig-074-20260808    gcc-14
x86_64               randconfig-075-20260808    gcc-14
x86_64               randconfig-076-20260808    gcc-14
x86_64                          rhel-9.4-bpf    gcc-14
xtensa                 nommu_kc705_defconfig    gcc-16.1.0
xtensa               randconfig-001-20260808    gcc-8.5.0
xtensa               randconfig-001-20260809    gcc-11.5.0
xtensa               randconfig-002-20260808    gcc-8.5.0
xtensa               randconfig-002-20260809    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
