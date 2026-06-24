Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3312609EE;
	Wed, 24 Jun 2026 04:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782276185; cv=none; b=Ecqc+p5qberwR0M7b+MJRG300HHzxgEkXflbv2NyII5D5z74igsLi0JRmadbkPaFPZ6xMNTo1eqjc3vucr9AOIRyBXDek6EYn36N/PBwxzbz3I/CYCz6Hc796d1GWYHIgYdPw7eEbAkj1lh0q/qreFTlvHzm79ijrbvkCqQfhlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782276185; c=relaxed/simple;
	bh=sA0+jK0A3os0ZEQkT5Rw7Su3yVpJpq6OhTlKIeMBPM4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=sAzDwdQ5mq0387vZ/r1SXU5HBUyIBR1IDPGc4AJ67mh+91TnYauBvulh4y1XGw5J6ia1FCXQIo/iMx7on9m3M7GKARMyGs6Y7FOTsL67NSBtU4n7Ch5cL3TrdWJIf5FuS02av0Lo86zl3C7QZaWl88OTRLUuhmRdfEbCoYfPeX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lMw3rFp5; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lMw3rFp5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782276184; x=1813812184;
  h=date:from:to:cc:subject:message-id;
  bh=sA0+jK0A3os0ZEQkT5Rw7Su3yVpJpq6OhTlKIeMBPM4=;
  b=lMw3rFp5UohxnH0vDwvB1+HNmngv0zB60e2an5891hlytR/W5ZIJn52y
   lrQ69i5rpmbRdynxQIOkr0l7ABaYfDX9ccp9hjKEwuaf+Uqy0kBmnj0t6
   vtUO4DadNlex248k/W3i13Yg3PX0FOGcYHwapPJ5cmD3m828W2GIdoJwC
   D581PZMrLr36MFx7AHZ8PtRVx93eqSKC2R8ZGuD6uCUHVvS4lKZ44Bt6W
   1AqhAnSNtJFpLK4QE800p8rF3JrnsVh/pSgjx4bf8ynxZOth0XnYeMVz4
   V7Vy+a6ZGmc2m+zT8HcGmOJSVcTTg05mQu+YW6itocuN7gvMXYYq1uTsn
   A==;
X-CSE-ConnectionGUID: tvklyBzCSeWXBEHSZBnMRw==
X-CSE-MsgGUID: gyrFEDDUStKtXtSsI8wcwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="83123449"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="83123449"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 21:43:03 -0700
X-CSE-ConnectionGUID: hr1RYzKFQ1il0FOF3kcyYg==
X-CSE-MsgGUID: RCu3rdQgSJKIskx+O01TFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="254818747"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 23 Jun 2026 21:43:00 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wcFRl-0000000037X-0lZC;
	Wed, 24 Jun 2026 04:42:48 +0000
Date: Wed, 24 Jun 2026 12:41:32 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 7b8d80921156c54cf7fcc35a830342686958aeea
Message-ID: <202606241222.xRZ1XtZZ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: 7b8d80921156c54cf7fcc35a830342686958aeea  Merge branch 'pnp' into fixes

elapsed time: 724m

configs tested: 222
configs skipped: 2

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
arc                   randconfig-001-20260624    gcc-15.2.0
arc                   randconfig-002-20260624    gcc-15.2.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    gcc-16.1.0
arm                   randconfig-001-20260624    gcc-15.2.0
arm                   randconfig-002-20260624    gcc-15.2.0
arm                   randconfig-003-20260624    gcc-15.2.0
arm                   randconfig-004-20260624    gcc-15.2.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260624    clang-21
arm64                 randconfig-002-20260624    clang-21
arm64                 randconfig-003-20260624    clang-21
arm64                 randconfig-004-20260624    clang-21
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260624    clang-21
csky                  randconfig-002-20260624    clang-21
hexagon                          allmodconfig    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260624    gcc-11.5.0
hexagon               randconfig-001-20260624    gcc-9.5.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260624    gcc-11.5.0
hexagon               randconfig-002-20260624    gcc-9.5.0
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260624    gcc-12
i386        buildonly-randconfig-002-20260624    gcc-12
i386        buildonly-randconfig-003-20260624    gcc-12
i386        buildonly-randconfig-004-20260624    gcc-12
i386        buildonly-randconfig-005-20260624    gcc-12
i386        buildonly-randconfig-006-20260624    gcc-12
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260624    clang-22
i386                  randconfig-002-20260624    clang-22
i386                  randconfig-003-20260624    clang-22
i386                  randconfig-004-20260624    clang-22
i386                  randconfig-005-20260624    clang-22
i386                  randconfig-006-20260624    clang-22
i386                  randconfig-007-20260624    clang-22
i386                  randconfig-011-20260624    clang-22
i386                  randconfig-012-20260624    clang-22
i386                  randconfig-013-20260624    clang-22
i386                  randconfig-014-20260624    clang-22
i386                  randconfig-015-20260624    clang-22
i386                  randconfig-016-20260624    clang-22
i386                  randconfig-017-20260624    clang-22
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260624    gcc-11.5.0
loongarch             randconfig-001-20260624    gcc-9.5.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260624    gcc-11.5.0
loongarch             randconfig-002-20260624    gcc-9.5.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    clang-23
m68k                        stmark2_defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260624    gcc-11.5.0
nios2                 randconfig-001-20260624    gcc-9.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260624    gcc-11.5.0
nios2                 randconfig-002-20260624    gcc-9.5.0
openrisc                         allmodconfig    clang-20
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    clang-17
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260624    gcc-16.1.0
parisc                randconfig-002-20260624    gcc-16.1.0
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc                     asp8347_defconfig    clang-23
powerpc                        fsp2_defconfig    gcc-16.1.0
powerpc               randconfig-001-20260624    gcc-16.1.0
powerpc               randconfig-002-20260624    gcc-16.1.0
powerpc64             randconfig-001-20260624    gcc-16.1.0
powerpc64             randconfig-002-20260624    gcc-16.1.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                          randconfig-001    clang-18
riscv                 randconfig-001-20260624    clang-18
riscv                          randconfig-002    clang-18
riscv                 randconfig-002-20260624    clang-18
s390                             allmodconfig    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    clang-18
s390                                defconfig    gcc-16.1.0
s390                           randconfig-001    clang-18
s390                  randconfig-001-20260624    clang-18
s390                           randconfig-002    clang-18
s390                  randconfig-002-20260624    clang-18
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                             randconfig-001    clang-18
sh                    randconfig-001-20260624    clang-18
sh                             randconfig-002    clang-18
sh                    randconfig-002-20260624    clang-18
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260624    gcc-14.3.0
sparc                 randconfig-002-20260624    gcc-14.3.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260624    gcc-14.3.0
sparc64               randconfig-002-20260624    gcc-14.3.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260624    gcc-14.3.0
um                    randconfig-002-20260624    gcc-14.3.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260624    clang-22
x86_64      buildonly-randconfig-002-20260624    clang-22
x86_64      buildonly-randconfig-003-20260624    clang-22
x86_64      buildonly-randconfig-004-20260624    clang-22
x86_64      buildonly-randconfig-005-20260624    clang-22
x86_64      buildonly-randconfig-006-20260624    clang-22
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                         randconfig-001    clang-22
x86_64                randconfig-001-20260624    clang-22
x86_64                         randconfig-002    clang-22
x86_64                randconfig-002-20260624    clang-22
x86_64                         randconfig-003    clang-22
x86_64                randconfig-003-20260624    clang-22
x86_64                         randconfig-004    clang-22
x86_64                randconfig-004-20260624    clang-22
x86_64                         randconfig-005    clang-22
x86_64                randconfig-005-20260624    clang-22
x86_64                         randconfig-006    clang-22
x86_64                randconfig-006-20260624    clang-22
x86_64                randconfig-006-20260624    gcc-14
x86_64                randconfig-011-20260624    gcc-14
x86_64                randconfig-012-20260624    gcc-14
x86_64                randconfig-013-20260624    gcc-14
x86_64                randconfig-014-20260624    gcc-14
x86_64                randconfig-015-20260624    gcc-14
x86_64                randconfig-016-20260624    gcc-14
x86_64                randconfig-071-20260624    gcc-14
x86_64                randconfig-072-20260624    gcc-14
x86_64                randconfig-073-20260624    gcc-14
x86_64                randconfig-074-20260624    gcc-14
x86_64                randconfig-075-20260624    gcc-14
x86_64                randconfig-076-20260624    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    clang-20
xtensa                randconfig-001-20260624    gcc-14.3.0
xtensa                randconfig-002-20260624    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
