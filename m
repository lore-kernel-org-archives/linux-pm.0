Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C4519E7F7;
	Thu, 21 May 2026 11:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779362947; cv=none; b=qYryNqq83hL1YqxY0N6T8vnkA1y34tuaJQyGvzgFMUQWphNx02pUCigbeK27DkWaaFHcaT4ZXvhZnK3bEs4bl1tcopZAozDVfRaneyDj+yH8BwNSmd+YB3+0VLNXfPGX4yZEm0/JIoJaMREJrNKZgorCU1VcXVTxaYTxmK8pDLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779362947; c=relaxed/simple;
	bh=r2VbEkG2P6wCDPABwQmhLXjFxp+Dar+DSHzQ4UznYGQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=vGU0yhvv2hnYT1Ht5J7ivcotvANYzCHEXdbTut4gINQB+0l35C1t9P7FEbk79IiS4RuOBnjdGzbItk+3BdLG73U6qPdmqNtNEXnp72ASJU0lBQPKCib+0cOTCcHFz0DlODR7TlQRfsKXaewbHY6LmmfpdS7ZuewOCcJCnhqhVHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DXp0gLsJ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DXp0gLsJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779362946; x=1810898946;
  h=date:from:to:cc:subject:message-id;
  bh=r2VbEkG2P6wCDPABwQmhLXjFxp+Dar+DSHzQ4UznYGQ=;
  b=DXp0gLsJWBpshRRA0EFjZz2wCUNTesqNP9pXaQMdZbdgLKMHUvI1qTJi
   fEM8RsYHiz2joT9GDLn16By8JfZZm0oqT5N2WTe6bQUVrb4XiYLwg6yVy
   /qTgB1KeaZ6IvD2tSaig4ViXlxO5P3Za46m70cbANfXgu28v88QW0Jc3n
   79ygXPvRLCYHwqHJymeDUIjTq0w1xhUTN2pskK3bxzs/XYgtEfNCGsUrv
   IZrurrD14kJv2/Yn0a8Tac6jVSF0/5UPvwe56ThQU+FV0AG0pOnUjgJoZ
   Fc4P4nu3ZCChmT1A1wBpJXY/L3L4xd6njJA9oR/u8fNvZT+A7STTgZc3i
   A==;
X-CSE-ConnectionGUID: nlmmMdBsTNqsP7o6UL3enQ==
X-CSE-MsgGUID: 9QNuSGHlRSic0ag642ntvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80334416"
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="80334416"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 04:29:05 -0700
X-CSE-ConnectionGUID: UuZaFRumSQC2SWzakXY9pA==
X-CSE-MsgGUID: dkqufxtiQ7ikLDYzfMOk2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="239492391"
Received: from lkp-server01.sh.intel.com (HELO fdb68b0ce653) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 21 May 2026 04:29:04 -0700
Received: from kbuild by fdb68b0ce653 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wQ1aH-000000000Cf-1hQ3;
	Thu, 21 May 2026 11:29:01 +0000
Date: Thu, 21 May 2026 19:28:57 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 5a12f05e047646e7c25c73482cd4d21fe297903b
Message-ID: <202605211949.RW6CM6Jm-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 5a12f05e047646e7c25c73482cd4d21fe297903b  Merge branch 'pm-cpuidle' into bleeding-edge

elapsed time: 876m

configs tested: 147
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                   randconfig-001-20260521    gcc-13.4.0
arc                   randconfig-002-20260521    gcc-12.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                   randconfig-001-20260521    clang-23
arm                   randconfig-002-20260521    gcc-12.5.0
arm                   randconfig-003-20260521    gcc-13.4.0
arm                   randconfig-004-20260521    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                          randconfig-001    gcc-8.5.0
arm64                 randconfig-001-20260521    clang-23
arm64                          randconfig-002    gcc-14.3.0
arm64                 randconfig-002-20260521    gcc-8.5.0
arm64                          randconfig-003    clang-23
arm64                 randconfig-003-20260521    gcc-8.5.0
arm64                          randconfig-004    clang-23
arm64                 randconfig-004-20260521    gcc-8.5.0
csky                              allnoconfig    gcc-15.2.0
csky                           randconfig-001    gcc-10.5.0
csky                  randconfig-001-20260521    gcc-15.2.0
csky                           randconfig-002    gcc-10.5.0
csky                  randconfig-002-20260521    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon               randconfig-001-20260521    clang-23
hexagon               randconfig-002-20260521    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386                  randconfig-011-20260521    gcc-14
i386                  randconfig-012-20260521    clang-20
i386                  randconfig-013-20260521    gcc-13
i386                  randconfig-014-20260521    gcc-14
i386                  randconfig-015-20260521    gcc-14
i386                  randconfig-016-20260521    clang-20
i386                  randconfig-017-20260521    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260521    gcc-12.5.0
loongarch             randconfig-002-20260521    gcc-15.2.0
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
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260521    gcc-11.5.0
nios2                 randconfig-002-20260521    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                         randconfig-001    gcc-13.4.0
parisc                randconfig-001-20260521    gcc-12.5.0
parisc                         randconfig-002    gcc-8.5.0
parisc                randconfig-002-20260521    gcc-15.2.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc                        randconfig-001    gcc-13.4.0
powerpc               randconfig-001-20260521    clang-23
powerpc                        randconfig-002    gcc-10.5.0
powerpc               randconfig-002-20260521    clang-17
powerpc64                      randconfig-001    clang-17
powerpc64             randconfig-001-20260521    clang-23
powerpc64                      randconfig-002    clang-23
powerpc64             randconfig-002-20260521    gcc-12.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260521    clang-23
riscv                 randconfig-002-20260521    gcc-13.4.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-001-20260521    gcc-8.5.0
s390                  randconfig-002-20260521    clang-17
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260521    gcc-15.2.0
sh                    randconfig-002-20260521    gcc-12.5.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260521    gcc-8.5.0
sparc                 randconfig-002-20260521    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260521    gcc-8.5.0
sparc64               randconfig-002-20260521    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260521    gcc-14
um                    randconfig-002-20260521    gcc-14
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260521    gcc-12
x86_64      buildonly-randconfig-002-20260521    gcc-14
x86_64      buildonly-randconfig-003-20260521    clang-20
x86_64      buildonly-randconfig-004-20260521    gcc-14
x86_64      buildonly-randconfig-005-20260521    clang-20
x86_64      buildonly-randconfig-006-20260521    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260521    clang-20
x86_64                randconfig-002-20260521    clang-20
x86_64                randconfig-003-20260521    gcc-14
x86_64                randconfig-004-20260521    clang-20
x86_64                randconfig-005-20260521    clang-20
x86_64                randconfig-006-20260521    clang-20
x86_64                         randconfig-011    gcc-14
x86_64                         randconfig-015    gcc-14
x86_64                randconfig-071-20260521    clang-20
x86_64                randconfig-072-20260521    clang-20
x86_64                randconfig-073-20260521    clang-20
x86_64                randconfig-074-20260521    gcc-14
x86_64                randconfig-075-20260521    clang-20
x86_64                randconfig-076-20260521    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260521    gcc-8.5.0
xtensa                randconfig-002-20260521    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
