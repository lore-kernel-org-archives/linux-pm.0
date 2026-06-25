Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C412DD5E2;
	Thu, 25 Jun 2026 05:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782364547; cv=none; b=n+QNmZK7PhFiutP6yrE6zyf0As8AxfkbhyGmuQQUYO0yOHa/qo/TkzkfLVEiaXYTRO5wHw7T8peSLUxU4qnKKYptRtSPG/j2VvEcDIHvXW2f6Zmlmved/MY6yjQJXySjv3K+iP2zzXlQGMdzgkd7uOkCfnxgC3msi8xaSq/xQ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782364547; c=relaxed/simple;
	bh=W/d6NSaB7zsvk6F/lzRlZ4KlHU7TruBjplRzddu1YVw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=iMvwlKEnWKDQtNumeNK9hWKzHJ8yKoV2mmNJhKPNoRIoHDtxTNmVV7ivaR9vLd4OPBhwD6IrhgY3+GsXvPG0KU6SJ1KqGoESQvzcaL84hGDGIbw4bl5bc+Rry3mhMklsMi53tEQxHc/R8uvZZHUT5VgysMVqIHFK7bba2AvdRMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZgPbdBv5; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZgPbdBv5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782364545; x=1813900545;
  h=date:from:to:cc:subject:message-id;
  bh=W/d6NSaB7zsvk6F/lzRlZ4KlHU7TruBjplRzddu1YVw=;
  b=ZgPbdBv5MwB6PHQ/g4ndQ4DoG4TkyWhqAkWfkDBkGXfW9sbT1rhtJJTX
   KcA6o9gGqWw7gT9WAWHRofpOdt215qbgXNgiTUa+Ji24HBNjyvtFaCclO
   YC8JcH1eGeod49frWzBwyl2jpwsG7oJPEs6SuTv6LbNa+LzjiSHsWsPrd
   fcNVsC6uY9aBd0JpUvL54IqeATco60gomqpHXPGbqz/295b6kr3N58aYG
   XGT3zELkBxPsUXdjHPsGtVAvfXOADrNvlkM0P7DKpkqxIJRROdkxpwp25
   8qDI/Qqo1jorocU+doRQWugDGwUkMZ9PGV2Mj30uw/txWdnlff++VryEM
   A==;
X-CSE-ConnectionGUID: u2idl03hQbmxAF4q44fHLw==
X-CSE-MsgGUID: GExPLKGWRxK6c+ZU5RgHpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="86978610"
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="86978610"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 22:15:44 -0700
X-CSE-ConnectionGUID: pgOpDHJ+RvKPAt0hnVzTQw==
X-CSE-MsgGUID: rUOawxRCStmMCGZEJ7/scQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="243949794"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 24 Jun 2026 22:15:43 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wccRA-000000003u5-1YQh;
	Thu, 25 Jun 2026 05:15:40 +0000
Date: Thu, 25 Jun 2026 13:15:04 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 d0eb7b5a43418506edc4f42ad4f73a5548a23267
Message-ID: <202606251354.wXAD0KSF-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: d0eb7b5a43418506edc4f42ad4f73a5548a23267  Merge branch 'pm-cpuidle' into fixes

elapsed time: 726m

configs tested: 222
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260625    clang-23
arc                   randconfig-002-20260625    clang-23
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                                 defconfig    gcc-16.1.0
arm                   randconfig-001-20260625    clang-23
arm                   randconfig-002-20260625    clang-23
arm                   randconfig-003-20260625    clang-23
arm                   randconfig-004-20260625    clang-23
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260625    clang-23
arm64                 randconfig-002-20260625    clang-23
arm64                 randconfig-003-20260625    clang-23
arm64                 randconfig-004-20260625    clang-23
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260625    clang-23
csky                  randconfig-002-20260625    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260625    gcc-11.5.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260625    gcc-11.5.0
i386                             allmodconfig    clang-22
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                 buildonly-randconfig-001    gcc-14
i386        buildonly-randconfig-001-20260625    gcc-14
i386                 buildonly-randconfig-002    gcc-14
i386        buildonly-randconfig-002-20260625    gcc-14
i386                 buildonly-randconfig-003    gcc-14
i386        buildonly-randconfig-003-20260625    gcc-14
i386                 buildonly-randconfig-004    gcc-14
i386        buildonly-randconfig-004-20260625    gcc-14
i386                 buildonly-randconfig-005    gcc-14
i386        buildonly-randconfig-005-20260625    gcc-14
i386                 buildonly-randconfig-006    gcc-14
i386        buildonly-randconfig-006-20260625    gcc-14
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260625    clang-22
i386                  randconfig-002-20260625    clang-22
i386                  randconfig-003-20260625    clang-22
i386                  randconfig-004-20260625    clang-22
i386                  randconfig-005-20260625    clang-22
i386                  randconfig-006-20260625    clang-22
i386                  randconfig-007-20260625    clang-22
i386                  randconfig-011-20260625    clang-22
i386                  randconfig-012-20260625    clang-22
i386                  randconfig-013-20260625    clang-22
i386                  randconfig-014-20260625    clang-22
i386                  randconfig-015-20260625    clang-22
i386                  randconfig-016-20260625    clang-22
i386                  randconfig-017-20260625    clang-22
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260625    gcc-11.5.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260625    gcc-11.5.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                          atari_defconfig    gcc-16.1.0
m68k                                defconfig    clang-23
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                          ath25_defconfig    clang-23
nios2                            allmodconfig    clang-20
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260625    gcc-11.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260625    gcc-11.5.0
openrisc                         allmodconfig    clang-20
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    clang-17
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260625    gcc-13.4.0
parisc                randconfig-002-20260625    gcc-13.4.0
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc                     kmeter1_defconfig    gcc-16.1.0
powerpc               randconfig-001-20260625    gcc-13.4.0
powerpc               randconfig-002-20260625    gcc-13.4.0
powerpc                     tqm5200_defconfig    gcc-16.1.0
powerpc64             randconfig-001-20260625    gcc-13.4.0
powerpc64             randconfig-002-20260625    gcc-13.4.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                          randconfig-001    gcc-8.5.0
riscv                 randconfig-001-20260625    gcc-8.5.0
riscv                          randconfig-002    gcc-8.5.0
riscv                 randconfig-002-20260625    gcc-8.5.0
s390                             allmodconfig    clang-17
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                           randconfig-001    gcc-8.5.0
s390                  randconfig-001-20260625    gcc-8.5.0
s390                           randconfig-002    gcc-8.5.0
s390                  randconfig-002-20260625    gcc-8.5.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                                  defconfig    gcc-14
sh                             randconfig-001    gcc-8.5.0
sh                    randconfig-001-20260625    gcc-8.5.0
sh                             randconfig-002    gcc-8.5.0
sh                    randconfig-002-20260625    gcc-8.5.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                          randconfig-001    gcc-8.5.0
sparc                 randconfig-001-20260625    gcc-8.5.0
sparc                          randconfig-002    gcc-8.5.0
sparc                 randconfig-002-20260625    gcc-8.5.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-8.5.0
sparc64               randconfig-001-20260625    gcc-8.5.0
sparc64                        randconfig-002    gcc-8.5.0
sparc64               randconfig-002-20260625    gcc-8.5.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    gcc-8.5.0
um                    randconfig-001-20260625    gcc-8.5.0
um                             randconfig-002    gcc-8.5.0
um                    randconfig-002-20260625    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260625    clang-22
x86_64      buildonly-randconfig-002-20260625    clang-22
x86_64      buildonly-randconfig-003-20260625    clang-22
x86_64      buildonly-randconfig-004-20260625    clang-22
x86_64      buildonly-randconfig-005-20260625    clang-22
x86_64      buildonly-randconfig-006-20260625    clang-22
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260625    gcc-14
x86_64                randconfig-002-20260625    gcc-14
x86_64                randconfig-003-20260625    gcc-14
x86_64                randconfig-004-20260625    gcc-14
x86_64                randconfig-005-20260625    gcc-14
x86_64                randconfig-006-20260625    gcc-14
x86_64                         randconfig-011    clang-22
x86_64                randconfig-011-20260625    clang-22
x86_64                         randconfig-012    clang-22
x86_64                randconfig-012-20260625    clang-22
x86_64                         randconfig-013    clang-22
x86_64                randconfig-013-20260625    clang-22
x86_64                         randconfig-014    clang-22
x86_64                randconfig-014-20260625    clang-22
x86_64                         randconfig-015    clang-22
x86_64                randconfig-015-20260625    clang-22
x86_64                         randconfig-016    clang-22
x86_64                randconfig-016-20260625    clang-22
x86_64                         randconfig-071    clang-22
x86_64                randconfig-071-20260625    clang-22
x86_64                         randconfig-072    clang-22
x86_64                randconfig-072-20260625    clang-22
x86_64                         randconfig-073    clang-22
x86_64                randconfig-073-20260625    clang-22
x86_64                         randconfig-074    clang-22
x86_64                randconfig-074-20260625    clang-22
x86_64                         randconfig-075    clang-22
x86_64                randconfig-075-20260625    clang-22
x86_64                         randconfig-076    clang-22
x86_64                randconfig-076-20260625    clang-22
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
xtensa                         randconfig-001    gcc-8.5.0
xtensa                randconfig-001-20260625    gcc-8.5.0
xtensa                         randconfig-002    gcc-8.5.0
xtensa                randconfig-002-20260625    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
