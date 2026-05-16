Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81CF1DF27F;
	Sat, 16 May 2026 13:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778938187; cv=none; b=jmZVE6BVjcD82xHVgw5BjsBi8JKxbz062sb359VvmdtO4f/RC1zhYU0smGpL5fmUYxXGE7KlDSd0rl8ZNYB+6AO2cusN50tDZVzYHJiqk7f+DJUUTxbebPBokqKDfHJqaPEempqllbEVltlnNsQuseQWT0DsuMDaV5p0LInNXE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778938187; c=relaxed/simple;
	bh=33mFgPXgSwBZsv1E1PeDptu3b9d/ODBi0XMrAxnG5rI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HornzW7Jm5HlM674hjtHXJzOaUxbADMSLh3CEhUMoIJfPU8JEfwBjx/3aP6yDWcOTq0UsyjZthrGYWNkLhZN7SjxDMsF07ahl/eW/l4sD8uFkR1QGo5kHJgA5NMru6UShFDtgaaNCYmDo+tLqTh+m1id/omKDJjO9bzUNIUV6ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MCTaa/wW; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MCTaa/wW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778938185; x=1810474185;
  h=date:from:to:cc:subject:message-id;
  bh=33mFgPXgSwBZsv1E1PeDptu3b9d/ODBi0XMrAxnG5rI=;
  b=MCTaa/wWxgmv7qiPH3onCNbAG1uD2Pw/TzqI0aQKwqTxcapvnB0pdrkH
   ui+x2392WhSGlT1KzR2H8v5vrRnN8EBOzOmL5mr5hEF3t+bHxO6s2Yf9q
   fdoNML1VZQj1O05bckj0CK4jBkpVKTkdYlZkivbZZqEP5UPiR2Lg8aaQW
   UNg/ydomZA3/WlaVtP1HOnKUXeP44i6M7kGPUz94HVt3ODbiJwf+fUAFD
   5vVEIFZMeOJ/XK4h6N6O2w6z2JrP7ZpvZR8oExCdh6KFNp+TSpVitjdsn
   p0BoBVMjV+Um/x1Bs5WC8L8NNCIK8Y63t19bN/wsTYFkej3lGG7AMACQF
   w==;
X-CSE-ConnectionGUID: 9tIWDj9bRZCyu2fRXa/vmQ==
X-CSE-MsgGUID: wUvFWUrWQxC5YqLyDbThWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="79835189"
X-IronPort-AV: E=Sophos;i="6.23,238,1770624000"; 
   d="scan'208";a="79835189"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2026 06:29:45 -0700
X-CSE-ConnectionGUID: W4htnYGQS9uCuR3QfSkMhw==
X-CSE-MsgGUID: yQt5usDPS+q6/D7Gh7SRwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,238,1770624000"; 
   d="scan'208";a="277073227"
Received: from lkp-server01.sh.intel.com (HELO d94e5e629b2d) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 16 May 2026 06:29:42 -0700
Received: from kbuild by d94e5e629b2d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wOF5H-000000000qw-0Lbf;
	Sat, 16 May 2026 13:29:39 +0000
Date: Sat, 16 May 2026 21:29:02 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 5e01adb0fe2c47e8506ad1c46c6ed385f45c7f6e
Message-ID: <202605162152.QF8ZL8qN-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 5e01adb0fe2c47e8506ad1c46c6ed385f45c7f6e  Merge branch 'experimental/acpi-driver-work' into bleeding-edge

elapsed time: 974m

configs tested: 168
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                        nsimosci_defconfig    gcc-15.2.0
arc                            randconfig-001    gcc-8.5.0
arc                   randconfig-001-20260516    gcc-14.3.0
arc                            randconfig-002    gcc-8.5.0
arc                   randconfig-002-20260516    gcc-13.4.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                            randconfig-001    gcc-8.5.0
arm                   randconfig-001-20260516    gcc-13.4.0
arm                            randconfig-002    gcc-11.5.0
arm                   randconfig-002-20260516    gcc-8.5.0
arm                            randconfig-003    clang-20
arm                   randconfig-003-20260516    clang-19
arm                            randconfig-004    gcc-14.3.0
arm                   randconfig-004-20260516    clang-23
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260516    gcc-13.4.0
arm64                 randconfig-002-20260516    clang-23
arm64                 randconfig-003-20260516    gcc-9.5.0
arm64                 randconfig-004-20260516    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260516    gcc-15.2.0
csky                  randconfig-002-20260516    gcc-10.5.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260516    clang-23
hexagon               randconfig-002-20260516    clang-16
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260516    clang-20
i386        buildonly-randconfig-002-20260516    clang-20
i386        buildonly-randconfig-003-20260516    clang-20
i386        buildonly-randconfig-004-20260516    gcc-14
i386        buildonly-randconfig-005-20260516    clang-20
i386        buildonly-randconfig-006-20260516    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260516    gcc-15.2.0
loongarch             randconfig-002-20260516    clang-18
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260516    gcc-10.5.0
nios2                 randconfig-002-20260516    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                         randconfig-001    gcc-13.4.0
parisc                randconfig-001-20260516    gcc-10.5.0
parisc                         randconfig-002    gcc-8.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                        randconfig-001    gcc-13.4.0
powerpc                        randconfig-002    gcc-10.5.0
powerpc64                      randconfig-001    clang-17
powerpc64             randconfig-001-20260516    clang-17
powerpc64                      randconfig-002    clang-23
powerpc64             randconfig-002-20260516    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260516    gcc-8.5.0
riscv                 randconfig-002-20260516    clang-16
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-001-20260516    clang-23
s390                  randconfig-002-20260516    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                    randconfig-001-20260516    gcc-12.5.0
sh                    randconfig-002-20260516    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260516    gcc-8.5.0
sparc                 randconfig-002-20260516    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64               randconfig-001-20260516    gcc-10.5.0
sparc64               randconfig-002-20260516    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260516    clang-16
um                    randconfig-002-20260516    clang-18
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260516    clang-20
x86_64      buildonly-randconfig-002-20260516    gcc-14
x86_64      buildonly-randconfig-003-20260516    gcc-13
x86_64      buildonly-randconfig-004-20260516    gcc-14
x86_64      buildonly-randconfig-005-20260516    gcc-14
x86_64      buildonly-randconfig-006-20260516    gcc-14
x86_64                         randconfig-001    gcc-14
x86_64                         randconfig-002    gcc-14
x86_64                         randconfig-003    clang-20
x86_64                randconfig-003-20260516    gcc-14
x86_64                randconfig-005-20260516    gcc-14
x86_64                randconfig-006-20260516    gcc-14
x86_64                         randconfig-011    gcc-14
x86_64                randconfig-011-20260516    gcc-14
x86_64                         randconfig-012    gcc-14
x86_64                randconfig-012-20260516    clang-20
x86_64                         randconfig-013    clang-20
x86_64                randconfig-013-20260516    clang-20
x86_64                         randconfig-014    gcc-14
x86_64                randconfig-014-20260516    gcc-14
x86_64                         randconfig-015    gcc-14
x86_64                randconfig-015-20260516    clang-20
x86_64                         randconfig-016    clang-20
x86_64                randconfig-016-20260516    gcc-14
x86_64                randconfig-071-20260516    gcc-14
x86_64                randconfig-072-20260516    gcc-14
x86_64                randconfig-073-20260516    clang-20
x86_64                randconfig-074-20260516    clang-20
x86_64                randconfig-075-20260516    gcc-14
x86_64                randconfig-076-20260516    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-001-20260516    gcc-13.4.0
xtensa                randconfig-002-20260516    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
