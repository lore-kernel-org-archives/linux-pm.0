Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B4B36AB4B;
	Fri, 12 Jun 2026 17:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781286911; cv=none; b=FwEYsR5lyE8/2kyoHONeEs+GKi8YBabYbSXSKWgyPE7FdTd2FFwpGtNE9clEtH0XZfS99eFJqO038UdO3ill+BjZJoChqD5DojT0rKA9rA0b+jHbQFlH5BIhcXePPF0feI+tky9Y4Ts8E+zCGT2HdlibF40Ts9h2kEUtXjNapuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781286911; c=relaxed/simple;
	bh=wXtD1O2QRhqtuZVuhb41OrsA3ailylCWjE3VxsJztzg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Uc0pwSh11iTM+zoruIwrN8HZBDXPc5dNAhzfs85Y05x7XrVlPGBbBjprmH3MRi2itrHM3oEMSHf9T8ReAiCcKAP3T7kGtSenUmeyWubVFcCpcwjk92qwuSkv/Wjthd/mkB+UByPMtY0CiX38sTiiMint0RQjIObaadYLcZuhw5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XCX/3M+x; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XCX/3M+x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781286910; x=1812822910;
  h=date:from:to:cc:subject:message-id;
  bh=wXtD1O2QRhqtuZVuhb41OrsA3ailylCWjE3VxsJztzg=;
  b=XCX/3M+xK1RhmTDBU0Lc7KvD9B/T8u5C02YfKQOaez7+rwfc2aiJqyxf
   F6nepsj04n3CotFsifrFZSiTfmT0JyrlVvBOHZm3FadY0dhQm+q4j4V9O
   jihsM+ZA80xiXuQx5WL/f8NQC7eRhzIl/xV8zfAyzUBBTOX0GHNU1Y0gL
   F1DHoGRKcdSxmn7xpupeq3+IYhFUvqDjN+thy6rbvICLsq+1jPF0Ew/EH
   Jpe7iSvWZj9jqUO01ZK7l//AyuqbD6V2QYR3SMXXNhjXmFCEqplOYLi7z
   QJxjPSNNJgpIIObSwexgitoHQLZsoIVui1ME0d5tbPkIKHx0ERyqNbSG4
   Q==;
X-CSE-ConnectionGUID: SKu03FU/RVSpQ+NmD4ujoA==
X-CSE-MsgGUID: yIVLX/CHR0S+OidDSx0THw==
X-IronPort-AV: E=McAfee;i="6800,10657,11815"; a="107557108"
X-IronPort-AV: E=Sophos;i="6.24,201,1774335600"; 
   d="scan'208";a="107557108"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 10:55:10 -0700
X-CSE-ConnectionGUID: PeSWqG3OQfSXkJipZ8mLzg==
X-CSE-MsgGUID: YwV44SXWTqqFj2RCrK1ALg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,201,1774335600"; 
   d="scan'208";a="242503415"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 12 Jun 2026 10:55:08 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wY65y-00000000P9t-1L3b;
	Fri, 12 Jun 2026 17:55:06 +0000
Date: Sat, 13 Jun 2026 01:55:02 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 058cd2920302bb1478643b44f9dcc9d6d8e542b9
Message-ID: <202606130153.HYbUWhS3-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 058cd2920302bb1478643b44f9dcc9d6d8e542b9  Merge branch 'experimental/acpi-driver-work' into bleeding-edge

elapsed time: 966m

configs tested: 162
configs skipped: 13

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260612    gcc-13.4.0
arc                   randconfig-002-20260612    gcc-15.2.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    clang-23
arm                   randconfig-001-20260612    gcc-11.5.0
arm                   randconfig-002-20260612    gcc-10.5.0
arm                   randconfig-003-20260612    gcc-11.5.0
arm                   randconfig-004-20260612    gcc-13.4.0
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260612    gcc-13.4.0
arm64                 randconfig-002-20260612    clang-23
arm64                 randconfig-003-20260612    gcc-9.5.0
arm64                 randconfig-004-20260612    gcc-11.5.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260612    gcc-11.5.0
csky                  randconfig-002-20260612    gcc-13.4.0
hexagon                          allmodconfig    clang-23
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260612    clang-23
hexagon               randconfig-002-20260612    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260612    clang-22
i386        buildonly-randconfig-002-20260612    gcc-14
i386        buildonly-randconfig-003-20260612    gcc-14
i386        buildonly-randconfig-004-20260612    gcc-14
i386        buildonly-randconfig-005-20260612    gcc-14
i386        buildonly-randconfig-006-20260612    clang-22
i386                                defconfig    clang-22
i386                  randconfig-001-20260612    gcc-14
i386                  randconfig-002-20260612    clang-22
i386                  randconfig-003-20260612    gcc-14
i386                  randconfig-004-20260612    gcc-14
i386                  randconfig-005-20260612    clang-22
i386                  randconfig-006-20260612    clang-22
i386                  randconfig-007-20260612    gcc-12
i386                  randconfig-011-20260612    clang-22
i386                  randconfig-012-20260612    clang-22
i386                  randconfig-013-20260612    clang-22
i386                  randconfig-014-20260612    clang-22
i386                  randconfig-015-20260612    gcc-14
i386                  randconfig-016-20260612    gcc-14
i386                  randconfig-017-20260612    clang-22
loongarch                         allnoconfig    clang-20
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260612    clang-23
loongarch             randconfig-002-20260612    gcc-16.1.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    gcc-16.1.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260612    gcc-11.5.0
nios2                 randconfig-002-20260612    gcc-11.5.0
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260612    gcc-12.5.0
parisc                randconfig-002-20260612    gcc-14.3.0
parisc64                            defconfig    gcc-16.1.0
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    gcc-16.1.0
powerpc                     mpc5200_defconfig    clang-23
powerpc64             randconfig-001-20260612    gcc-8.5.0
powerpc64             randconfig-002-20260612    gcc-11.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260612    gcc-13.4.0
riscv                 randconfig-002-20260612    clang-23
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    clang-18
s390                  randconfig-001-20260612    clang-23
s390                  randconfig-002-20260612    gcc-8.5.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-16.1.0
sh                    randconfig-001-20260612    gcc-11.5.0
sh                    randconfig-002-20260612    gcc-13.4.0
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260612    gcc-8.5.0
sparc                 randconfig-002-20260612    gcc-8.5.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    clang-23
sparc64               randconfig-001-20260612    clang-20
sparc64               randconfig-002-20260612    gcc-12.5.0
um                               allmodconfig    clang-23
um                                allnoconfig    clang-16
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260612    gcc-14
um                    randconfig-002-20260612    clang-23
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-22
x86_64               buildonly-randconfig-001    gcc-12
x86_64      buildonly-randconfig-001-20260612    clang-22
x86_64               buildonly-randconfig-002    clang-22
x86_64      buildonly-randconfig-002-20260612    gcc-14
x86_64               buildonly-randconfig-003    gcc-14
x86_64      buildonly-randconfig-003-20260612    clang-22
x86_64               buildonly-randconfig-004    gcc-14
x86_64      buildonly-randconfig-004-20260612    clang-22
x86_64               buildonly-randconfig-005    gcc-14
x86_64      buildonly-randconfig-005-20260612    clang-22
x86_64               buildonly-randconfig-006    clang-22
x86_64      buildonly-randconfig-006-20260612    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260612    clang-22
x86_64                randconfig-002-20260612    gcc-14
x86_64                randconfig-003-20260612    gcc-14
x86_64                randconfig-004-20260612    gcc-14
x86_64                randconfig-005-20260612    gcc-14
x86_64                randconfig-006-20260612    clang-22
x86_64                randconfig-011-20260612    gcc-14
x86_64                randconfig-012-20260612    clang-22
x86_64                randconfig-013-20260612    clang-22
x86_64                randconfig-014-20260612    gcc-14
x86_64                randconfig-015-20260612    gcc-14
x86_64                randconfig-016-20260612    gcc-14
x86_64                randconfig-071-20260612    gcc-14
x86_64                randconfig-072-20260612    gcc-12
x86_64                randconfig-073-20260612    clang-22
x86_64                randconfig-074-20260612    clang-22
x86_64                randconfig-075-20260612    clang-22
x86_64                randconfig-076-20260612    clang-22
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    gcc-16.1.0
xtensa                randconfig-001-20260612    gcc-10.5.0
xtensa                randconfig-002-20260612    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
