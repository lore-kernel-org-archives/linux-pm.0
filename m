Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B401A9FA4;
	Tue, 16 Jun 2026 07:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781593502; cv=none; b=NnEjBxONP0s49WC/3fZn4sf6zS+KIZpBUQ7TSgLIdAzL88fdGF635DWPcPFqaL3DPQTusLILaqKxbWKXzuaGdP3j+kqCvTw8fR+NY+Z1vX/7e+HIKivPoKcY2MhcezF+q+4zSf2J2oAMS7eExxrdkwwHlgPsNmIdVLDjjSmLg1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781593502; c=relaxed/simple;
	bh=B+RREB8xUmn4Z7NWHXvsQdPtCdQ6z4NNrhyvNixU+Vs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Hcxzvvdd4d9BvxDVj2KJ+DpMEaHdsairvfggEhWuo9MYQWrMHj+jd0WYg+UD/EmGPVCBYxrzkOHJdA4A4HHPCeHqcKg8h9S3VPJncdtAPEEeXsqe6NLcyi3bW26LM+uGwwa1to1TwUxkRHjecXAc7drr1rqizOs8XCkjdzaov0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PWx0s10c; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PWx0s10c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781593501; x=1813129501;
  h=date:from:to:cc:subject:message-id;
  bh=B+RREB8xUmn4Z7NWHXvsQdPtCdQ6z4NNrhyvNixU+Vs=;
  b=PWx0s10cZwVlsb+yEQjB2VV+x/XQdNJwNjTYJZ7FXvNUK81i2lhxdfXQ
   CWOD8jwLvllDXelEcaPUw0yq94a/KRYjdUiEwP/c4rVwcGorqunAB0zjT
   lQc3iX8VfN4dpl7Ks5Ogm1zOnE7eIVdegE8lvGIg/qD/rKHF0rSRjJZ+H
   neY8Arn4xsVv20Qf43Gb4KWe6DfgweHfyOddV5EUzBw5LyTFds6ilJHlK
   a1KVf/qDg157rBvXfBWgkc2H23s2fRYMtS3+AZYTXXX06zWHZCB2Jx6rW
   iFY5qGIEjiX2DfO9weDEeMIaQKcsXbM/HZgHbLqAkp4q+U9RLk7uvva4k
   w==;
X-CSE-ConnectionGUID: sVecZZhvROaadafIFpIijQ==
X-CSE-MsgGUID: kEX0bbnZRyuVSU/Q1wRirw==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="82454238"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="82454238"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 00:04:47 -0700
X-CSE-ConnectionGUID: 3Bv0EGx4Smayqhflz0qQ2A==
X-CSE-MsgGUID: wAUmmsPlSjyrZ1iBCxJ6YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="246797902"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 16 Jun 2026 00:04:45 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wZNqk-00000000Spa-0XOp;
	Tue, 16 Jun 2026 07:04:42 +0000
Date: Tue, 16 Jun 2026 15:04:28 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 57b611bacc6831fff044e4a384afa11076cf4d27
Message-ID: <202606161519.MuezJPZi-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 57b611bacc6831fff044e4a384afa11076cf4d27  Merge branch 'experimental/acpi-driver-work' into bleeding-edge

elapsed time: 891m

configs tested: 191
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                 nsimosci_hs_smp_defconfig    gcc-16.1.0
arc                   randconfig-001-20260616    gcc-9.5.0
arc                   randconfig-002-20260616    gcc-9.5.0
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    gcc-16.1.0
arm                   randconfig-001-20260616    gcc-9.5.0
arm                   randconfig-002-20260616    gcc-9.5.0
arm                   randconfig-003-20260616    gcc-9.5.0
arm                   randconfig-004-20260616    gcc-9.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260616    gcc-13.4.0
arm64                 randconfig-002-20260616    gcc-13.4.0
arm64                 randconfig-003-20260616    gcc-13.4.0
arm64                 randconfig-004-20260616    gcc-13.4.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260616    gcc-13.4.0
csky                  randconfig-002-20260616    gcc-13.4.0
hexagon                          allmodconfig    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260616    clang-23
hexagon               randconfig-002-20260616    clang-23
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260616    clang-22
i386        buildonly-randconfig-002-20260616    clang-22
i386        buildonly-randconfig-003-20260616    clang-22
i386        buildonly-randconfig-004-20260616    clang-22
i386        buildonly-randconfig-005-20260616    clang-22
i386        buildonly-randconfig-006-20260616    clang-22
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260616    gcc-14
i386                  randconfig-002-20260616    gcc-14
i386                  randconfig-003-20260616    gcc-14
i386                  randconfig-004-20260616    gcc-14
i386                  randconfig-005-20260616    gcc-14
i386                  randconfig-006-20260616    gcc-14
i386                  randconfig-007-20260616    gcc-14
i386                  randconfig-011-20260616    clang-22
i386                  randconfig-012-20260616    clang-22
i386                  randconfig-013-20260616    clang-22
i386                  randconfig-014-20260616    clang-22
i386                  randconfig-015-20260616    clang-22
i386                  randconfig-016-20260616    clang-22
i386                  randconfig-017-20260616    clang-22
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260616    clang-23
loongarch             randconfig-002-20260616    clang-23
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    clang-23
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                 randconfig-001-20260616    clang-23
nios2                 randconfig-002-20260616    clang-23
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    clang-17
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260616    gcc-8.5.0
parisc                randconfig-002-20260616    gcc-8.5.0
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc                      pmac32_defconfig    clang-23
powerpc                      ppc64e_defconfig    gcc-16.1.0
powerpc               randconfig-001-20260616    gcc-8.5.0
powerpc               randconfig-002-20260616    gcc-8.5.0
powerpc64             randconfig-001-20260616    gcc-8.5.0
powerpc64             randconfig-002-20260616    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                 randconfig-001-20260616    gcc-16.1.0
riscv                 randconfig-002-20260616    gcc-16.1.0
s390                             allmodconfig    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260616    gcc-16.1.0
s390                  randconfig-002-20260616    gcc-16.1.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260616    gcc-16.1.0
sh                    randconfig-002-20260616    gcc-16.1.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260616    gcc-8.5.0
sparc                 randconfig-002-20260616    gcc-8.5.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260616    gcc-8.5.0
sparc64               randconfig-002-20260616    gcc-8.5.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260616    gcc-8.5.0
um                    randconfig-002-20260616    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260616    gcc-14
x86_64      buildonly-randconfig-002-20260616    gcc-14
x86_64      buildonly-randconfig-003-20260616    gcc-14
x86_64      buildonly-randconfig-004-20260616    gcc-14
x86_64      buildonly-randconfig-005-20260616    gcc-14
x86_64      buildonly-randconfig-006-20260616    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260616    clang-22
x86_64                randconfig-002-20260616    clang-22
x86_64                randconfig-003-20260616    clang-22
x86_64                randconfig-004-20260616    clang-22
x86_64                randconfig-005-20260616    clang-22
x86_64                randconfig-006-20260616    clang-22
x86_64                randconfig-011-20260616    clang-22
x86_64                randconfig-012-20260616    clang-22
x86_64                randconfig-013-20260616    clang-22
x86_64                randconfig-014-20260616    clang-22
x86_64                randconfig-015-20260616    clang-22
x86_64                randconfig-016-20260616    clang-22
x86_64                randconfig-071-20260616    gcc-14
x86_64                randconfig-072-20260616    gcc-14
x86_64                randconfig-073-20260616    gcc-14
x86_64                randconfig-074-20260616    gcc-14
x86_64                randconfig-075-20260616    gcc-14
x86_64                randconfig-076-20260616    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-16.1.0
xtensa                randconfig-001-20260616    gcc-8.5.0
xtensa                randconfig-002-20260616    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
