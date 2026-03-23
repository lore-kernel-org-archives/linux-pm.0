Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1A340DFB7;
	Mon, 23 Mar 2026 04:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774239248; cv=none; b=h2Qh81CU9Jy2CQgYmpYb2+xRNnHSIUBw3Et8AQ6COcH27qV08zysPY9qanwjfM7QZhe2qqiLRPazS0tEiylBnxpNWTRCX5ldZMgB4mfRhDs9KhSNfTSPNJrZeA33mMNvKSeXDaP/sCOEG/FL09T0zj+llwEtrnHQVzZcZutIyr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774239248; c=relaxed/simple;
	bh=D6pA8MunkA3Wrq8YZFZzzO8WrJn99+IQHm+pMxzkIHI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SZ1DWPw24pGLESUPa0f4Q1cHgefaANT3Aei4Xbxn0zajTmh3CoK9vLo0Z+q04j4X5/0FHL5F/vPovb7gilo+ETKFf7fkb6pVCLXwxXasUXUMVXiauSGYgYRbF55F96Y0Lr536HQD8bt1VqUOVM8cfUQwGdYe4BcoYBMT/GafHFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P149346p; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P149346p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774239246; x=1805775246;
  h=date:from:to:cc:subject:message-id;
  bh=D6pA8MunkA3Wrq8YZFZzzO8WrJn99+IQHm+pMxzkIHI=;
  b=P149346pFnFfI0sBkk40gigm7s7p3ZH8fagchyOGu0/jI7d3c9jmitd2
   DdeYO/Q4uwjD790jKdMBpDQwmvTr0R2p0fu8zxP8r8swovMMIWFhcI3Kw
   8JQyCgIBWZB5R0T9pIC/xClhG4XHOJNwUBHGflq9mVagh3PJp/DwHT5r7
   LhT9/JPfBUSOgJY8hjhBvE+8zYu8J8qzU/N4BRYG3+wK8FyXJgg1xDmTJ
   nH+z2Rh5GbwWWY4zBnPTfPJlFpcNFF91UMRg7VcXQCqtwQP9JJkFh9444
   ghdL1Ratnif5thUy0jNN7vVsE2G7zKqvUYpHPrGvA3+vp6WICGHjei2w8
   A==;
X-CSE-ConnectionGUID: JbGXo7hSR+y+ZqnjEhtcjg==
X-CSE-MsgGUID: xZp3ukdTT9ui4k/xC/R98g==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="77844201"
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; 
   d="scan'208";a="77844201"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2026 21:14:05 -0700
X-CSE-ConnectionGUID: XivdVWfJSvyT1Xlhc12PmA==
X-CSE-MsgGUID: 9EXetnWKQyKuSh1Vor0BYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; 
   d="scan'208";a="228623116"
Received: from lkp-server01.sh.intel.com (HELO 7ce7cd20ec32) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 22 Mar 2026 21:14:04 -0700
Received: from kbuild by 7ce7cd20ec32 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w4Wfx-0000000003Z-3NNx;
	Mon, 23 Mar 2026 04:14:01 +0000
Date: Mon, 23 Mar 2026 12:13:59 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 e9d8abf829f59947b749a761a62b7146acee31e8
Message-ID: <202603231251.UXaw9aNk-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: e9d8abf829f59947b749a761a62b7146acee31e8  Merge branch 'acpi-cmos-rtc' into bleeding-edge

elapsed time: 757m

configs tested: 152
configs skipped: 3

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
arc                   randconfig-001-20260323    gcc-8.5.0
arc                   randconfig-002-20260323    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                   randconfig-001-20260323    clang-23
arm                   randconfig-002-20260323    clang-23
arm                   randconfig-003-20260323    gcc-14.3.0
arm                   randconfig-004-20260323    gcc-10.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260323    gcc-10.5.0
arm64                 randconfig-002-20260323    gcc-11.5.0
arm64                 randconfig-003-20260323    clang-23
arm64                 randconfig-004-20260323    gcc-12.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260323    gcc-11.5.0
csky                  randconfig-002-20260323    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260323    clang-23
hexagon               randconfig-002-20260323    clang-17
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260323    clang-20
i386        buildonly-randconfig-002-20260323    gcc-14
i386        buildonly-randconfig-003-20260323    clang-20
i386        buildonly-randconfig-004-20260323    clang-20
i386        buildonly-randconfig-005-20260323    clang-20
i386                                defconfig    clang-20
i386                  randconfig-011-20260323    clang-20
i386                  randconfig-012-20260323    clang-20
i386                  randconfig-013-20260323    clang-20
i386                  randconfig-014-20260323    gcc-14
i386                  randconfig-015-20260323    clang-20
i386                  randconfig-016-20260323    clang-20
i386                  randconfig-017-20260323    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260323    clang-18
loongarch             randconfig-002-20260323    clang-23
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
nios2                 randconfig-001-20260323    gcc-8.5.0
nios2                 randconfig-002-20260323    gcc-8.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260323    gcc-8.5.0
parisc                randconfig-002-20260323    gcc-13.4.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260323    clang-19
powerpc               randconfig-002-20260323    gcc-13.4.0
powerpc64             randconfig-001-20260323    clang-23
powerpc64             randconfig-002-20260323    gcc-10.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260323    gcc-14.3.0
riscv                 randconfig-002-20260323    clang-23
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-001-20260323    gcc-8.5.0
s390                  randconfig-002-20260323    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260323    gcc-15.2.0
sh                    randconfig-002-20260323    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260323    gcc-8.5.0
sparc                 randconfig-002-20260323    gcc-13.4.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260323    gcc-8.5.0
sparc64               randconfig-002-20260323    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260323    clang-23
um                    randconfig-002-20260323    clang-23
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260323    clang-20
x86_64      buildonly-randconfig-002-20260323    clang-20
x86_64      buildonly-randconfig-003-20260323    gcc-14
x86_64      buildonly-randconfig-004-20260323    clang-20
x86_64      buildonly-randconfig-005-20260323    clang-20
x86_64      buildonly-randconfig-006-20260323    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260323    clang-20
x86_64                randconfig-002-20260323    gcc-14
x86_64                randconfig-003-20260323    gcc-14
x86_64                randconfig-004-20260323    clang-20
x86_64                randconfig-005-20260323    gcc-14
x86_64                randconfig-006-20260323    clang-20
x86_64                randconfig-011-20260323    gcc-13
x86_64                randconfig-012-20260323    gcc-14
x86_64                randconfig-013-20260323    gcc-14
x86_64                randconfig-014-20260323    clang-20
x86_64                randconfig-015-20260323    clang-20
x86_64                randconfig-016-20260323    clang-20
x86_64                randconfig-071-20260323    clang-20
x86_64                randconfig-072-20260323    clang-20
x86_64                randconfig-073-20260323    clang-20
x86_64                randconfig-074-20260323    gcc-13
x86_64                randconfig-075-20260323    clang-20
x86_64                randconfig-076-20260323    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260323    gcc-13.4.0
xtensa                randconfig-002-20260323    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
