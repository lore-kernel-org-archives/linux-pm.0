Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2603E3264FC;
	Wed,  1 Apr 2026 05:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775022836; cv=none; b=I7F6iaIB8qbhkkV4Btsn2fHDrITdkAEUlnknXrYlKRV2QegmIxUZifoUPQMB7Oa/O1811jS5mhE8k5qrRVjUI1u+7dqqeQ9ngvHBJO4Tvt+jcS8DRpKnRU5zhuYVxy9LIhx3G9OdA6aLJuXAqnj9h/GNuKeRMQklHSuCaPasKH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775022836; c=relaxed/simple;
	bh=R5jpdXNLat5hLTJYAS61jR1uavKCKK//8pACycNjRME=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PkWNRsFknV0NvojhPNQrwI6p8w5T+Xwu8gbP2ptbRxeSdwVzcsCGe2ywq40wEHkyoblN5lA8of31oPZIjMAw7FOIKQvyVeEcRtSVdCK9InjrGReoXIvw40PLqyUfRIhHYfO3tolweOC8GRkaHuAcKVRLVqePoE+LGQyiknQeiog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lDBry0zP; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lDBry0zP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775022834; x=1806558834;
  h=date:from:to:cc:subject:message-id;
  bh=R5jpdXNLat5hLTJYAS61jR1uavKCKK//8pACycNjRME=;
  b=lDBry0zPxt52BOsY0Uf8rRFS6YhCiVpHqPEDFdMOBmFkMBPg4EQquMAd
   GVuGQCj7NtiyZjNvAzzsPGyIbR8tevvBN1R5DCru4YMQsDDK0BKSrJnsy
   hUF1DBNFPX6a/clnNJi+vesQ1p1sPp6zk44NRaOxd2n1T8rN9rLcvu4z3
   nxB8IGHsaqf+CuEEFajTT0TqI41NhPvT5ksCkLN006i5NatwdKLoTTdFL
   MN1H7POwqBLr8y2153M7H8RnoTtSQonj3SoaRhPbbvlsPDNfZ6ROcBoKn
   tEY0ceKU7zn77n5iCAeO31cBDND/eC6Qkr5tvCNH7RoeGioGu2Bl53bG4
   w==;
X-CSE-ConnectionGUID: giRgyn+qTu+kH0DH23o3og==
X-CSE-MsgGUID: qqFmIXBMRVK1AqRg/oghtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="76164997"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="76164997"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 22:53:54 -0700
X-CSE-ConnectionGUID: 4f5LaNmKQ6GvCFbCcBwsdw==
X-CSE-MsgGUID: ODUucB34ROeYLeji6WL6Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="231513537"
Received: from lkp-server01.sh.intel.com (HELO beaa6a812b8c) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 31 Mar 2026 22:53:52 -0700
Received: from kbuild by beaa6a812b8c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w7oWS-0000000002z-2Gtm;
	Wed, 01 Apr 2026 05:53:48 +0000
Date: Wed, 01 Apr 2026 13:53:21 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 6a7d7bac274585a9bb18b4d61cb59718334f4a39
Message-ID: <202604011311.pdVtLvCU-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: 6a7d7bac274585a9bb18b4d61cb59718334f4a39  Merge branch 'thermal-core-fixes' into fixes

elapsed time: 1058m

configs tested: 197
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260401    clang-23
arc                   randconfig-002-20260401    clang-23
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                            mmp2_defconfig    gcc-15.2.0
arm                   randconfig-001-20260401    clang-23
arm                   randconfig-002-20260401    clang-23
arm                   randconfig-003-20260401    clang-23
arm                   randconfig-004-20260401    clang-23
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260401    gcc-15.2.0
arm64                 randconfig-002-20260401    gcc-15.2.0
arm64                 randconfig-003-20260401    gcc-15.2.0
arm64                 randconfig-004-20260401    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260401    gcc-15.2.0
csky                  randconfig-002-20260401    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260401    gcc-15.2.0
hexagon               randconfig-002-20260401    gcc-15.2.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260401    gcc-14
i386        buildonly-randconfig-002-20260401    gcc-14
i386        buildonly-randconfig-003-20260401    gcc-14
i386        buildonly-randconfig-004-20260401    gcc-14
i386        buildonly-randconfig-005-20260401    gcc-14
i386        buildonly-randconfig-006-20260401    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260401    gcc-14
i386                  randconfig-002-20260401    gcc-14
i386                  randconfig-003-20260401    gcc-14
i386                  randconfig-004-20260401    gcc-14
i386                  randconfig-005-20260401    gcc-14
i386                  randconfig-006-20260401    gcc-14
i386                  randconfig-007-20260401    gcc-14
i386                  randconfig-011-20260401    clang-20
i386                  randconfig-012-20260401    clang-20
i386                  randconfig-013-20260401    clang-20
i386                  randconfig-014-20260401    clang-20
i386                  randconfig-015-20260401    clang-20
i386                  randconfig-016-20260401    clang-20
i386                  randconfig-017-20260401    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch                loongson64_defconfig    clang-23
loongarch             randconfig-001-20260401    gcc-15.2.0
loongarch             randconfig-002-20260401    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260401    gcc-15.2.0
nios2                 randconfig-002-20260401    gcc-15.2.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260401    gcc-8.5.0
parisc                randconfig-002-20260401    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                       holly_defconfig    clang-23
powerpc               randconfig-001-20260401    gcc-8.5.0
powerpc               randconfig-002-20260401    gcc-8.5.0
powerpc64             randconfig-001-20260401    gcc-8.5.0
powerpc64             randconfig-002-20260401    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260401    gcc-9.5.0
riscv                 randconfig-002-20260401    gcc-9.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260401    gcc-9.5.0
s390                  randconfig-002-20260401    gcc-9.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260401    gcc-9.5.0
sh                    randconfig-002-20260401    gcc-9.5.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260401    clang-16
sparc                 randconfig-002-20260401    clang-16
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260401    clang-16
sparc64               randconfig-002-20260401    clang-16
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260401    clang-16
um                    randconfig-002-20260401    clang-16
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260401    gcc-12
x86_64      buildonly-randconfig-002-20260401    gcc-12
x86_64      buildonly-randconfig-003-20260401    gcc-12
x86_64      buildonly-randconfig-004-20260401    gcc-12
x86_64      buildonly-randconfig-005-20260401    gcc-12
x86_64      buildonly-randconfig-006-20260401    gcc-12
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260401    clang-20
x86_64                randconfig-002-20260401    clang-20
x86_64                randconfig-003-20260401    clang-20
x86_64                randconfig-004-20260401    clang-20
x86_64                randconfig-005-20260401    clang-20
x86_64                randconfig-006-20260401    clang-20
x86_64                randconfig-011-20260401    gcc-14
x86_64                randconfig-012-20260401    gcc-14
x86_64                randconfig-013-20260401    gcc-14
x86_64                randconfig-014-20260401    gcc-14
x86_64                randconfig-015-20260401    gcc-14
x86_64                randconfig-016-20260401    gcc-14
x86_64                randconfig-071-20260401    gcc-14
x86_64                randconfig-072-20260401    gcc-14
x86_64                randconfig-073-20260401    gcc-14
x86_64                randconfig-074-20260401    gcc-14
x86_64                randconfig-075-20260401    gcc-14
x86_64                randconfig-076-20260401    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260401    clang-16
xtensa                randconfig-002-20260401    clang-16

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
