Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BBD23A562;
	Fri, 28 Aug 2026 12:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787919568; cv=none; b=opt7qgyVEzFg/8kn6pN1wACXkWiWC52JYvTm4yED40hEi7rMDN8ROaAfcGja8Gc2mhlLXlRBjJUS4ut0kWR1lHu9cc7TWlLwd39DTXHpYQ/U3iGYSXtZP0a6RqtHKe9IXLnUqj9Z/gk6gE+B2eITkm0ChpknYrcIh3zhqZv4zz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787919568; c=relaxed/simple;
	bh=GwaUhHUaP1zXuY5u+UJ6JZonlBEJUtdkqPQvNpwHWVo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pYrMdXyv3vsxCS107TYgikjHEK4RilDKCe97D5fgvZ3NTxuGrc9kcx24+/EhWil4YMTQhvvoUHrcdndXhO/bsf9frMK4g4+sM/6U9jeYie5HEuwPfU7x1JLM/LhvONU8NCeC0JXPtzFazau6S2o8a0KTn39WIM8CgWazssu++XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mhVTaZ0g; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mhVTaZ0g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787919560; x=1819455560;
  h=date:from:to:cc:subject:message-id;
  bh=GwaUhHUaP1zXuY5u+UJ6JZonlBEJUtdkqPQvNpwHWVo=;
  b=mhVTaZ0gFkXtm9m+gkSuh8m9yP3/2rqoAKvBBCvW4hcvFD54iQRUbY9S
   /4PEDLFc6ndCoJSeOb5/f+Fs0TSdAu0Qjx+2LYmpgOGThIWwfks120o0r
   xLnuwgVAsHvN9DquO5Qi5XJpirGZ736RVzDN8VFYgdi7lvH+hWn/YNtwa
   LGvK6M+ikiOF5EqgFR/wfr3VhjWTBFeRWgLcKGPMutKukOQiqKsu2FkpG
   P3FRsJ6Kv7gm2LOt58vz6yShV1BBnarh6g6pQOpN/cVUFBT98o5J5Zkw/
   NIL91UziFvUw/LWp3uJhyeXKP7mV24z5uDBn4quGZ1EHAu4mr+DAwfXXS
   g==;
X-CSE-ConnectionGUID: 553dhDOdSbWzBHUPGNcdXg==
X-CSE-MsgGUID: n+z1siWwTEmSYau20oIbDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="92239152"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="92239152"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 05:19:15 -0700
X-CSE-ConnectionGUID: sNtZJcFzTLu8vx5/KACDeA==
X-CSE-MsgGUID: Xs0kAgvPTiqc9XVk3RKHdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="266827817"
Received: from lkp-server01.sh.intel.com (HELO 3532383e6126) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 28 Aug 2026 05:19:14 -0700
Received: from kbuild by 3532383e6126 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wzvY8-00000000B5J-0FaB;
	Fri, 28 Aug 2026 12:19:12 +0000
Date: Fri, 28 Aug 2026 20:18:58 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 4ac6d00b8b6f382b963b6ec52ed5450763bdd452
Message-ID: <202608282036.gPiUYPjY-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 4ac6d00b8b6f382b963b6ec52ed5450763bdd452  Merge branch 'testing' into bleeding-edge

elapsed time: 2942m

configs tested: 304
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-14
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-14
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                        nsim_700_defconfig    gcc-16.1.0
arc                   randconfig-001-20260827    gcc-15.2.0
arc                   randconfig-002-20260827    gcc-15.2.0
arm                              alldefconfig    clang-14
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-14
arm                              allyesconfig    gcc-16.1.0
arm                         assabet_defconfig    clang-22
arm                                 defconfig    gcc-16.1.0
arm                            mmp2_defconfig    gcc-16.1.0
arm                        neponset_defconfig    gcc-16.1.0
arm                             pxa_defconfig    clang-19
arm                   randconfig-001-20260827    gcc-15.2.0
arm                   randconfig-002-20260827    gcc-15.2.0
arm                   randconfig-003-20260827    gcc-15.2.0
arm                   randconfig-004-20260827    gcc-15.2.0
arm                         socfpga_defconfig    gcc-16.1.0
arm                           stm32_defconfig    gcc-16.1.0
arm64                            alldefconfig    clang-19
arm64                            allmodconfig    clang-14
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                          randconfig-001    clang-14
arm64                 randconfig-001-20260827    clang-14
arm64                 randconfig-001-20260827    clang-21
arm64                 randconfig-001-20260827    gcc-8.5.0
arm64                          randconfig-002    clang-14
arm64                 randconfig-002-20260827    clang-14
arm64                 randconfig-002-20260827    clang-21
arm64                 randconfig-002-20260827    gcc-8.5.0
arm64                          randconfig-003    clang-14
arm64                 randconfig-003-20260827    clang-14
arm64                 randconfig-003-20260827    clang-21
arm64                          randconfig-004    clang-14
arm64                 randconfig-004-20260827    clang-14
arm64                 randconfig-004-20260827    clang-21
arm64                 randconfig-004-20260827    gcc-8.5.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                           randconfig-001    clang-14
csky                  randconfig-001-20260827    clang-14
csky                  randconfig-001-20260827    clang-21
csky                  randconfig-001-20260827    gcc-8.5.0
csky                           randconfig-002    clang-14
csky                  randconfig-002-20260827    clang-14
csky                  randconfig-002-20260827    clang-21
csky                  randconfig-002-20260827    gcc-8.5.0
hexagon                          allmodconfig    clang-14
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-14
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260827    gcc-16.1.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260827    gcc-16.1.0
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260827    clang-22
i386        buildonly-randconfig-002-20260827    clang-22
i386        buildonly-randconfig-003-20260827    clang-22
i386        buildonly-randconfig-004-20260827    clang-22
i386        buildonly-randconfig-005-20260827    clang-22
i386        buildonly-randconfig-006-20260827    clang-22
i386                                defconfig    gcc-16.1.0
i386                           randconfig-001    gcc-14
i386                  randconfig-001-20260827    gcc-14
i386                           randconfig-002    gcc-14
i386                  randconfig-002-20260827    gcc-14
i386                           randconfig-003    gcc-14
i386                  randconfig-003-20260827    gcc-14
i386                           randconfig-004    gcc-14
i386                  randconfig-004-20260827    gcc-14
i386                           randconfig-005    gcc-14
i386                  randconfig-005-20260827    gcc-14
i386                           randconfig-006    gcc-14
i386                  randconfig-006-20260827    gcc-14
i386                           randconfig-007    gcc-14
i386                  randconfig-007-20260827    gcc-14
i386                           randconfig-011    gcc-13
i386                  randconfig-011-20260827    gcc-13
i386                           randconfig-012    gcc-13
i386                  randconfig-012-20260827    gcc-13
i386                           randconfig-013    gcc-13
i386                  randconfig-013-20260827    gcc-13
i386                           randconfig-014    gcc-13
i386                  randconfig-014-20260827    gcc-13
i386                           randconfig-015    gcc-13
i386                  randconfig-015-20260827    gcc-13
i386                           randconfig-016    gcc-13
i386                  randconfig-016-20260827    gcc-13
i386                           randconfig-017    gcc-13
i386                  randconfig-017-20260827    gcc-13
loongarch                        allmodconfig    clang-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-14
loongarch                           defconfig    clang-24
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260827    gcc-16.1.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260827    gcc-16.1.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-14
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    clang-14
m68k                            q40_defconfig    clang-19
microblaze                       alldefconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-14
microblaze                      mmu_defconfig    gcc-16.1.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                       bmips_be_defconfig    gcc-16.1.0
mips                           gcw0_defconfig    clang-19
mips                          rb532_defconfig    clang-14
mips                          rm200_defconfig    clang-14
nios2                            allmodconfig    clang-20
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-14
nios2                             allnoconfig    clang-24
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-14
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260827    gcc-16.1.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260827    gcc-16.1.0
openrisc                         allmodconfig    clang-20
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    clang-14
openrisc                          allnoconfig    clang-24
openrisc                          allnoconfig    gcc-16.1.0
openrisc         de0_nano_multicore_defconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-14
parisc                            allnoconfig    clang-24
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    clang-17
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                generic-32bit_defconfig    clang-19
parisc                         randconfig-001    gcc-14.3.0
parisc                randconfig-001-20260827    gcc-14.3.0
parisc                         randconfig-002    gcc-14.3.0
parisc                randconfig-002-20260827    gcc-14.3.0
parisc64                            defconfig    clang-14
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-14
powerpc                           allnoconfig    clang-24
powerpc                           allnoconfig    gcc-16.1.0
powerpc                    amigaone_defconfig    gcc-16.1.0
powerpc                     ep8248e_defconfig    clang-14
powerpc                    gamecube_defconfig    clang-19
powerpc                     kmeter1_defconfig    clang-14
powerpc               mpc834x_itxgp_defconfig    gcc-16.1.0
powerpc                        randconfig-001    gcc-14.3.0
powerpc               randconfig-001-20260827    gcc-14.3.0
powerpc                        randconfig-002    gcc-14.3.0
powerpc               randconfig-002-20260827    gcc-14.3.0
powerpc                     tqm5200_defconfig    clang-19
powerpc                     tqm8540_defconfig    gcc-16.1.0
powerpc                     tqm8541_defconfig    gcc-16.1.0
powerpc                     tqm8555_defconfig    clang-14
powerpc                         wii_defconfig    clang-14
powerpc64                      randconfig-001    gcc-14.3.0
powerpc64             randconfig-001-20260827    gcc-14.3.0
powerpc64                      randconfig-002    gcc-14.3.0
powerpc64             randconfig-002-20260827    gcc-14.3.0
riscv                            allmodconfig    clang-14
riscv                             allnoconfig    clang-14
riscv                             allnoconfig    clang-24
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-14
riscv                            allyesconfig    clang-24
riscv                               defconfig    gcc-16.1.0
riscv             nommu_k210_sdcard_defconfig    gcc-16.1.0
riscv                          randconfig-001    clang-14
riscv                 randconfig-001-20260827    clang-14
riscv                          randconfig-002    clang-14
riscv                 randconfig-002-20260827    clang-14
s390                             allmodconfig    clang-14
s390                             allmodconfig    clang-17
s390                              allnoconfig    clang-14
s390                              allnoconfig    clang-24
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                           randconfig-001    clang-14
s390                  randconfig-001-20260827    clang-14
s390                           randconfig-002    clang-14
s390                  randconfig-002-20260827    clang-14
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-14
sh                                allnoconfig    clang-24
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                               allyesconfig    gcc-16.1.0
sh                        apsh4ad0a_defconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-16.1.0
sh                             randconfig-001    clang-14
sh                    randconfig-001-20260827    clang-14
sh                             randconfig-002    clang-14
sh                    randconfig-002-20260827    clang-14
sh                          rsk7264_defconfig    clang-14
sh                     sh7710voipgw_defconfig    gcc-16.1.0
sh                            shmin_defconfig    clang-19
sparc                             allnoconfig    clang-14
sparc                             allnoconfig    clang-24
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260827    gcc-10.5.0
sparc                 randconfig-002-20260827    gcc-10.5.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260827    gcc-10.5.0
sparc64               randconfig-002-20260827    gcc-10.5.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-14
um                                allnoconfig    clang-17
um                                allnoconfig    clang-24
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260827    gcc-10.5.0
um                    randconfig-002-20260827    gcc-10.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-14
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-24
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260827    clang-22
x86_64      buildonly-randconfig-002-20260827    clang-22
x86_64      buildonly-randconfig-003-20260827    clang-22
x86_64      buildonly-randconfig-004-20260827    clang-22
x86_64      buildonly-randconfig-005-20260827    clang-22
x86_64      buildonly-randconfig-006-20260827    clang-22
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260827    clang-22
x86_64                randconfig-001-20260828    gcc-14
x86_64                randconfig-002-20260827    clang-22
x86_64                randconfig-002-20260828    gcc-14
x86_64                randconfig-003-20260827    clang-22
x86_64                randconfig-003-20260828    gcc-14
x86_64                randconfig-004-20260827    clang-22
x86_64                randconfig-004-20260828    gcc-14
x86_64                randconfig-005-20260827    clang-22
x86_64                randconfig-005-20260828    gcc-14
x86_64                randconfig-006-20260827    clang-22
x86_64                randconfig-006-20260828    gcc-14
x86_64                         randconfig-011    clang-22
x86_64                randconfig-011-20260827    clang-22
x86_64                         randconfig-012    clang-22
x86_64                randconfig-012-20260827    clang-22
x86_64                         randconfig-013    clang-22
x86_64                randconfig-013-20260827    clang-22
x86_64                         randconfig-014    clang-22
x86_64                randconfig-014-20260827    clang-22
x86_64                         randconfig-015    clang-22
x86_64                randconfig-015-20260827    clang-22
x86_64                         randconfig-016    clang-22
x86_64                randconfig-016-20260827    clang-22
x86_64                randconfig-071-20260827    gcc-14
x86_64                randconfig-072-20260827    gcc-14
x86_64                randconfig-073-20260827    gcc-14
x86_64                randconfig-074-20260827    gcc-14
x86_64                randconfig-075-20260827    gcc-14
x86_64                randconfig-076-20260827    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-14
xtensa                            allnoconfig    clang-24
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    clang-20
xtensa                           allyesconfig    gcc-16.1.0
xtensa                randconfig-001-20260827    gcc-10.5.0
xtensa                randconfig-002-20260827    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
