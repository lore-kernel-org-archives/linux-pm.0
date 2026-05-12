Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B8D38E8B8;
	Tue, 12 May 2026 11:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778584004; cv=none; b=iC9FVEKRXoyWjIgvcjzTvFCvx39Ag65sptifm+7SiTrDW8JfQNLBc7s/0yVGbx7pXIY9iqwk7P7UQGjRxCeFu8Xu++BCjFO+Q3wybVpHXOqWq1xwdj7zBlQsncPZHeN7daUTNshrxFKb7yfkGxmP/Sazz04fyUgsgp9AxDbytXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778584004; c=relaxed/simple;
	bh=qYr/6pjpus8lyhH/rNzqHOuVzfYPuqh9/a8TiTdPI7Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qD9Qd6rL7OokEF9MaJvut54dbDVb0F5mYIqYhEYLoxkXyLoBaJDsSdfuI9ktwASzOEqrvy69RuwP/0JJfBAkUFmsHJruS9un/H2ASU5PHiwmh6QYLFpcBtBvghRC1MvbkRgifnbTRG+T5wcIe0pZKaYoGopbOuf2WmiyRQEa3Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DCq0E42D; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DCq0E42D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778584001; x=1810120001;
  h=date:from:to:cc:subject:message-id;
  bh=qYr/6pjpus8lyhH/rNzqHOuVzfYPuqh9/a8TiTdPI7Q=;
  b=DCq0E42DH11zu1U9IepTZFb3WlhTMKp6NoXHFJoqVoK5t4fgRijpJCvS
   qwiWfU/Ijho60FG62eFJGXJQsYPy8S0nLoOEwU7NmBL4k9GbW3NewxwTI
   4fG/O43CmNFgkKPbqpMVmuKawu23Q+Nyyi/eJZnJ+ltvAjBtbzhyRDMwe
   5XIcBSOxCPAZOcvpzlAK/ULe3400Be+jBbNAf/+k0/pG6+HUcPSu09zfj
   l1LS2GPq233742W0WKvbfin5yyuhqQZHQmohjHFVLNmzsytzd/l2oFEj2
   KDx3qCqGSc3/IFd4Y/Vt4pRL5SfaeA6CDKWLpS3ufq2AcwyWmT0FaAnbQ
   w==;
X-CSE-ConnectionGUID: zEOQOqibRwSPcS84JetyqA==
X-CSE-MsgGUID: NmyscVKaS5iE8WlvkQZVug==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="83361653"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="83361653"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 04:06:36 -0700
X-CSE-ConnectionGUID: Vpn0CW/yTd2uw1A5tqx6Zw==
X-CSE-MsgGUID: bxhglnruS7qLjxS2QU+K1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="261490080"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 12 May 2026 04:06:35 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wMkwa-0000000021X-26EE;
	Tue, 12 May 2026 11:06:32 +0000
Date: Tue, 12 May 2026 19:05:46 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 d80c76e2edbe499ba5466e023945ae3f5bb00df2
Message-ID: <202605121937.i3dk4d0o-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: d80c76e2edbe499ba5466e023945ae3f5bb00df2  Merge branch 'acpi-driver' into fixes

elapsed time: 1082m

configs tested: 271
configs skipped: 37

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
arc                            randconfig-001    gcc-8.5.0
arc                   randconfig-001-20260512    gcc-11.5.0
arc                   randconfig-001-20260512    gcc-8.5.0
arc                            randconfig-002    gcc-8.5.0
arc                   randconfig-002-20260512    gcc-11.5.0
arc                   randconfig-002-20260512    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                          pxa3xx_defconfig    clang-23
arm                            randconfig-001    gcc-8.5.0
arm                   randconfig-001-20260512    gcc-11.5.0
arm                   randconfig-001-20260512    gcc-8.5.0
arm                            randconfig-002    gcc-8.5.0
arm                   randconfig-002-20260512    gcc-11.5.0
arm                   randconfig-002-20260512    gcc-8.5.0
arm                            randconfig-003    gcc-8.5.0
arm                   randconfig-003-20260512    gcc-11.5.0
arm                   randconfig-003-20260512    gcc-8.5.0
arm                            randconfig-004    gcc-8.5.0
arm                   randconfig-004-20260512    gcc-11.5.0
arm                   randconfig-004-20260512    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                          randconfig-001    clang-23
arm64                 randconfig-001-20260512    clang-23
arm64                 randconfig-001-20260512    gcc-14.3.0
arm64                          randconfig-002    clang-23
arm64                 randconfig-002-20260512    clang-23
arm64                 randconfig-002-20260512    gcc-14.3.0
arm64                          randconfig-003    clang-23
arm64                 randconfig-003-20260512    clang-23
arm64                 randconfig-003-20260512    gcc-14.3.0
arm64                          randconfig-004    clang-23
arm64                 randconfig-004-20260512    clang-23
arm64                 randconfig-004-20260512    gcc-14.3.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                           randconfig-001    clang-23
csky                  randconfig-001-20260512    clang-23
csky                  randconfig-001-20260512    gcc-14.3.0
csky                           randconfig-002    clang-23
csky                  randconfig-002-20260512    clang-23
csky                  randconfig-002-20260512    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260512    gcc-10.5.0
hexagon               randconfig-002-20260512    gcc-10.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                 buildonly-randconfig-001    gcc-14
i386        buildonly-randconfig-001-20260512    gcc-14
i386                 buildonly-randconfig-002    gcc-14
i386        buildonly-randconfig-002-20260512    gcc-14
i386                 buildonly-randconfig-003    gcc-14
i386        buildonly-randconfig-003-20260512    gcc-14
i386                 buildonly-randconfig-004    gcc-14
i386        buildonly-randconfig-004-20260512    gcc-14
i386                 buildonly-randconfig-005    gcc-14
i386        buildonly-randconfig-005-20260512    gcc-14
i386                 buildonly-randconfig-006    gcc-14
i386        buildonly-randconfig-006-20260512    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260512    gcc-14
i386                  randconfig-002-20260512    gcc-14
i386                  randconfig-003-20260512    gcc-14
i386                  randconfig-004-20260512    gcc-14
i386                  randconfig-005-20260512    gcc-14
i386                  randconfig-006-20260512    gcc-14
i386                  randconfig-007-20260512    gcc-14
i386                  randconfig-011-20260512    clang-20
i386                  randconfig-011-20260512    gcc-14
i386                  randconfig-012-20260512    clang-20
i386                  randconfig-013-20260512    clang-20
i386                  randconfig-014-20260512    clang-20
i386                  randconfig-015-20260512    clang-20
i386                  randconfig-015-20260512    gcc-14
i386                  randconfig-016-20260512    clang-20
i386                  randconfig-016-20260512    gcc-14
i386                  randconfig-017-20260512    clang-20
i386                  randconfig-017-20260512    gcc-14
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260512    gcc-10.5.0
loongarch             randconfig-002-20260512    gcc-10.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                          amiga_defconfig    gcc-15.2.0
m68k                          atari_defconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
m68k                        m5272c3_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                           jazz_defconfig    clang-17
mips                   sb1250_swarm_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-15.2.0
nios2                 randconfig-001-20260512    gcc-10.5.0
nios2                 randconfig-002-20260512    gcc-10.5.0
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                         randconfig-001    gcc-12.5.0
parisc                randconfig-001-20260512    gcc-12.5.0
parisc                         randconfig-002    gcc-12.5.0
parisc                randconfig-002-20260512    gcc-12.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                       holly_defconfig    clang-23
powerpc                        randconfig-001    gcc-12.5.0
powerpc               randconfig-001-20260512    gcc-12.5.0
powerpc                        randconfig-002    gcc-12.5.0
powerpc               randconfig-002-20260512    gcc-12.5.0
powerpc64                      randconfig-001    gcc-12.5.0
powerpc64             randconfig-001-20260512    gcc-12.5.0
powerpc64                      randconfig-002    gcc-12.5.0
powerpc64             randconfig-002-20260512    gcc-12.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                          randconfig-001    gcc-15.2.0
riscv                 randconfig-001-20260512    gcc-15.2.0
riscv                          randconfig-002    gcc-15.2.0
riscv                 randconfig-002-20260512    gcc-15.2.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                           randconfig-001    gcc-15.2.0
s390                  randconfig-001-20260512    gcc-15.2.0
s390                           randconfig-002    gcc-15.2.0
s390                  randconfig-002-20260512    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                             randconfig-001    gcc-15.2.0
sh                    randconfig-001-20260512    gcc-15.2.0
sh                             randconfig-002    gcc-15.2.0
sh                    randconfig-002-20260512    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                          randconfig-001    gcc-13.4.0
sparc                 randconfig-001-20260512    gcc-13.4.0
sparc                          randconfig-002    gcc-13.4.0
sparc                 randconfig-002-20260512    gcc-13.4.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-13.4.0
sparc64               randconfig-001-20260512    gcc-13.4.0
sparc64                        randconfig-002    gcc-13.4.0
sparc64               randconfig-002-20260512    gcc-13.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    gcc-13.4.0
um                    randconfig-001-20260512    gcc-13.4.0
um                             randconfig-002    gcc-13.4.0
um                    randconfig-002-20260512    gcc-13.4.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64               buildonly-randconfig-001    gcc-14
x86_64      buildonly-randconfig-001-20260512    gcc-14
x86_64               buildonly-randconfig-002    gcc-14
x86_64      buildonly-randconfig-002-20260512    gcc-14
x86_64               buildonly-randconfig-003    gcc-14
x86_64      buildonly-randconfig-003-20260512    gcc-14
x86_64               buildonly-randconfig-004    gcc-14
x86_64      buildonly-randconfig-004-20260512    gcc-14
x86_64               buildonly-randconfig-005    gcc-14
x86_64      buildonly-randconfig-005-20260512    gcc-14
x86_64               buildonly-randconfig-006    gcc-14
x86_64      buildonly-randconfig-006-20260512    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260512    gcc-14
x86_64                randconfig-002-20260512    gcc-14
x86_64                randconfig-003-20260512    gcc-14
x86_64                randconfig-004-20260512    gcc-14
x86_64                randconfig-005-20260512    gcc-14
x86_64                randconfig-006-20260512    gcc-14
x86_64                         randconfig-011    clang-20
x86_64                randconfig-011-20260512    clang-20
x86_64                         randconfig-012    clang-20
x86_64                randconfig-012-20260512    clang-20
x86_64                         randconfig-013    clang-20
x86_64                randconfig-013-20260512    clang-20
x86_64                         randconfig-014    clang-20
x86_64                randconfig-014-20260512    clang-20
x86_64                         randconfig-015    clang-20
x86_64                randconfig-015-20260512    clang-20
x86_64                randconfig-015-20260512    gcc-14
x86_64                         randconfig-016    clang-20
x86_64                randconfig-016-20260512    clang-20
x86_64                randconfig-071-20260512    clang-20
x86_64                randconfig-071-20260512    gcc-14
x86_64                randconfig-072-20260512    clang-20
x86_64                randconfig-073-20260512    clang-20
x86_64                randconfig-074-20260512    clang-20
x86_64                randconfig-074-20260512    gcc-14
x86_64                randconfig-075-20260512    clang-20
x86_64                randconfig-076-20260512    clang-20
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
xtensa                         randconfig-001    gcc-13.4.0
xtensa                randconfig-001-20260512    gcc-13.4.0
xtensa                         randconfig-002    gcc-13.4.0
xtensa                randconfig-002-20260512    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
