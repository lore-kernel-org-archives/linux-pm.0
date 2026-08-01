Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E6421ABD7;
	Sat,  1 Aug 2026 22:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785622103; cv=none; b=bi7W8bfbEftnV3hLSU22G8nb972O9OIe2Z2cRcjJXnZjczLe5fZR3UWW7PAGJ+RkTf3yPQd1gDaT2fZqva2/wOPxj1zdm2g8eV1CA7uTakk5Jf0Yf5pFv7TTlXCujRd5qodQNCri3WbenttkLplR22Fc+BV/mw0z3loQYPw2fNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785622103; c=relaxed/simple;
	bh=ZGiKvcRZWRe7rMBdJPn5kUxr85WfEInBUjgDzUecS+w=;
	h=Date:From:To:Cc:Subject:Message-ID; b=UvWjLVd/QwEXQstQBG3LechLArEdlis+YGG26zbNYKI4v0eNy6Moy+ak6eeuVfgbnv2I7KJXgS/71DQJ7I7UxYUI2mWokgANKcTRN/MZuveMUvCmpogpGb27ZLDBlSxJNaLdmxFZ+cXlWUtD7ZIndSBZGWHOphN6DSn/jR7qQiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mu9hrr4T; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mu9hrr4T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785622101; x=1817158101;
  h=date:from:to:cc:subject:message-id;
  bh=ZGiKvcRZWRe7rMBdJPn5kUxr85WfEInBUjgDzUecS+w=;
  b=Mu9hrr4TZnGn/7tZWfwx3zBhsDIBvTJvztuyPxbsGyWI8RxHPm5x4KPh
   4cr/9M4nkrfzlRqYQJBxhY/dDky384Ea7+6/+zJoMfTA8D6HFDPPSj1cL
   eT2apI2vyzba1KswwCAJqa2TdDRrcyGcUdkaHiZiXu3Bs176LvYs+BDKE
   vKHVCuaK066Yg4oJz4dVGfV+EHgL3LdT3pphjB99bmBTilZkvvUC47SuM
   j1Zg99Q/q4K/LNWL3C397DWTYlENvTG5EtZqKYZT5PJfOsk3FIiosPmmG
   MUmognoZZrDD0VGn9uhBlN2yrdLTPijGrrlHxwIQeM/k/dniR6zya1kbn
   g==;
X-CSE-ConnectionGUID: 6tPzZkbnT8GDnG79+NVwmg==
X-CSE-MsgGUID: XrNlqfIcQk2lo+Q5P4YprQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11862"; a="96801821"
X-IronPort-AV: E=Sophos;i="6.25,199,1779174000"; 
   d="scan'208";a="96801821"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2026 15:08:20 -0700
X-CSE-ConnectionGUID: eiIZuk2hQsaBrVarzCPRBw==
X-CSE-MsgGUID: ytYvCus9QjSoUL8dekx60w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,199,1779174000"; 
   d="scan'208";a="262844763"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 01 Aug 2026 15:08:19 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wqHsO-000000003xb-3yl6;
	Sat, 01 Aug 2026 22:08:16 +0000
Date: Sun, 02 Aug 2026 06:07:18 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 059e58cc96bf030ae366ef40bdcf611aa7ff9b3c
Message-ID: <202608020606.uM7Ci6M6-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 059e58cc96bf030ae366ef40bdcf611aa7ff9b3c  Merge branch 'acpi-processor' into bleeding-edge

elapsed time: 753m

configs tested: 185
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260801    gcc-12.5.0
arc                  randconfig-001-20260802    gcc-15.2.0
arc                  randconfig-002-20260801    gcc-12.5.0
arc                  randconfig-002-20260802    gcc-15.2.0
arm                       keystone_defconfig    gcc-16.1.0
arm                         pxa910_defconfig    gcc-16.1.0
arm                  randconfig-001-20260801    gcc-12.5.0
arm                  randconfig-001-20260802    gcc-15.2.0
arm                  randconfig-002-20260801    gcc-12.5.0
arm                  randconfig-002-20260802    gcc-15.2.0
arm                  randconfig-003-20260801    gcc-12.5.0
arm                  randconfig-003-20260802    gcc-15.2.0
arm                  randconfig-004-20260801    gcc-12.5.0
arm                  randconfig-004-20260802    gcc-15.2.0
arm64                         randconfig-001    gcc-10.5.0
arm64                randconfig-001-20260801    gcc-10.5.0
arm64                randconfig-001-20260802    gcc-9.5.0
arm64                randconfig-002-20260801    gcc-10.5.0
arm64                randconfig-002-20260802    gcc-9.5.0
arm64                randconfig-003-20260801    gcc-10.5.0
arm64                randconfig-003-20260802    gcc-9.5.0
arm64                randconfig-004-20260801    gcc-10.5.0
arm64                randconfig-004-20260802    gcc-9.5.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260801    gcc-10.5.0
csky                 randconfig-001-20260802    gcc-9.5.0
csky                 randconfig-002-20260801    gcc-10.5.0
csky                 randconfig-002-20260802    gcc-9.5.0
hexagon              randconfig-001-20260801    clang-24
hexagon              randconfig-001-20260801    gcc-16.1.0
hexagon              randconfig-001-20260802    clang-24
hexagon              randconfig-002-20260801    clang-17
hexagon              randconfig-002-20260801    gcc-16.1.0
hexagon              randconfig-002-20260802    clang-24
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260801    gcc-14
i386       buildonly-randconfig-001-20260802    gcc-14
i386       buildonly-randconfig-002-20260801    gcc-14
i386       buildonly-randconfig-002-20260802    gcc-14
i386       buildonly-randconfig-003-20260801    gcc-14
i386       buildonly-randconfig-003-20260802    gcc-14
i386       buildonly-randconfig-004-20260801    gcc-14
i386       buildonly-randconfig-004-20260802    gcc-14
i386       buildonly-randconfig-005-20260801    gcc-14
i386       buildonly-randconfig-005-20260802    gcc-14
i386       buildonly-randconfig-006-20260801    gcc-14
i386       buildonly-randconfig-006-20260802    gcc-14
i386                 randconfig-001-20260801    clang-22
i386                 randconfig-002-20260801    clang-22
i386                 randconfig-002-20260801    gcc-14
i386                 randconfig-003-20260801    clang-22
i386                 randconfig-004-20260801    clang-22
i386                 randconfig-005-20260801    clang-22
i386                 randconfig-006-20260801    clang-22
i386                 randconfig-007-20260801    clang-22
i386                 randconfig-011-20260801    gcc-14
i386                 randconfig-012-20260801    gcc-14
i386                 randconfig-013-20260801    gcc-14
i386                 randconfig-014-20260801    gcc-14
i386                 randconfig-015-20260801    gcc-14
i386                 randconfig-016-20260801    gcc-14
i386                 randconfig-017-20260801    gcc-14
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260801    clang-18
loongarch            randconfig-001-20260801    gcc-16.1.0
loongarch            randconfig-001-20260802    clang-24
loongarch            randconfig-002-20260801    gcc-16.1.0
loongarch            randconfig-002-20260802    clang-24
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260801    gcc-16.1.0
nios2                randconfig-001-20260801    gcc-8.5.0
nios2                randconfig-001-20260802    clang-24
nios2                randconfig-002-20260801    gcc-11.5.0
nios2                randconfig-002-20260801    gcc-16.1.0
nios2                randconfig-002-20260802    clang-24
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc                        randconfig-001    gcc-8.5.0
parisc                        randconfig-001    gcc-9.5.0
parisc               randconfig-001-20260801    gcc-11.5.0
parisc               randconfig-001-20260801    gcc-9.5.0
parisc               randconfig-001-20260802    gcc-14.3.0
parisc               randconfig-002-20260801    gcc-9.5.0
parisc               randconfig-002-20260802    gcc-14.3.0
powerpc                  bluestone_defconfig    clang-24
powerpc                  lite5200b_defconfig    clang-24
powerpc              randconfig-001-20260801    clang-20
powerpc              randconfig-001-20260801    gcc-9.5.0
powerpc              randconfig-001-20260802    gcc-14.3.0
powerpc              randconfig-002-20260801    gcc-10.5.0
powerpc              randconfig-002-20260801    gcc-9.5.0
powerpc              randconfig-002-20260802    gcc-14.3.0
powerpc                    tqm8541_defconfig    clang-24
powerpc64            randconfig-001-20260801    clang-24
powerpc64            randconfig-001-20260801    gcc-9.5.0
powerpc64            randconfig-001-20260802    gcc-14.3.0
powerpc64            randconfig-002-20260801    clang-24
powerpc64            randconfig-002-20260801    gcc-9.5.0
powerpc64            randconfig-002-20260802    gcc-14.3.0
riscv                         randconfig-001    gcc-14.3.0
riscv                randconfig-001-20260801    gcc-14.3.0
riscv                randconfig-001-20260802    gcc-13.4.0
riscv                randconfig-002-20260801    gcc-14.3.0
riscv                randconfig-002-20260802    gcc-13.4.0
s390                 randconfig-001-20260801    gcc-14.3.0
s390                 randconfig-001-20260802    gcc-13.4.0
s390                 randconfig-002-20260801    gcc-14.3.0
s390                 randconfig-002-20260802    gcc-13.4.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260801    gcc-14.3.0
sh                   randconfig-001-20260802    gcc-13.4.0
sh                   randconfig-002-20260801    gcc-14.3.0
sh                   randconfig-002-20260802    gcc-13.4.0
sparc                randconfig-001-20260801    gcc-11.5.0
sparc                randconfig-001-20260802    gcc-12.5.0
sparc                randconfig-002-20260801    gcc-11.5.0
sparc                randconfig-002-20260802    gcc-12.5.0
sparc64              randconfig-001-20260801    gcc-11.5.0
sparc64              randconfig-001-20260802    gcc-12.5.0
sparc64              randconfig-002-20260801    gcc-11.5.0
sparc64              randconfig-002-20260802    gcc-12.5.0
um                   randconfig-001-20260801    gcc-11.5.0
um                   randconfig-001-20260802    gcc-12.5.0
um                   randconfig-002-20260801    gcc-11.5.0
um                   randconfig-002-20260802    gcc-12.5.0
x86_64              buildonly-randconfig-001    clang-22
x86_64              buildonly-randconfig-001    gcc-12
x86_64     buildonly-randconfig-001-20260801    clang-22
x86_64     buildonly-randconfig-001-20260802    gcc-12
x86_64     buildonly-randconfig-002-20260801    clang-22
x86_64     buildonly-randconfig-002-20260802    gcc-12
x86_64     buildonly-randconfig-003-20260801    clang-22
x86_64     buildonly-randconfig-003-20260801    gcc-13
x86_64     buildonly-randconfig-003-20260802    gcc-12
x86_64     buildonly-randconfig-004-20260801    clang-22
x86_64     buildonly-randconfig-004-20260802    gcc-12
x86_64     buildonly-randconfig-005-20260801    clang-22
x86_64     buildonly-randconfig-005-20260802    gcc-12
x86_64     buildonly-randconfig-006-20260801    clang-22
x86_64     buildonly-randconfig-006-20260802    gcc-12
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260801    gcc-14
x86_64               randconfig-001-20260802    clang-22
x86_64               randconfig-002-20260801    gcc-14
x86_64               randconfig-002-20260802    clang-22
x86_64               randconfig-003-20260801    gcc-14
x86_64               randconfig-003-20260802    clang-22
x86_64               randconfig-004-20260801    gcc-14
x86_64               randconfig-004-20260802    clang-22
x86_64               randconfig-005-20260801    gcc-14
x86_64               randconfig-005-20260802    clang-22
x86_64               randconfig-006-20260801    gcc-14
x86_64               randconfig-006-20260802    clang-22
x86_64                        randconfig-011    clang-22
x86_64               randconfig-011-20260801    clang-22
x86_64               randconfig-012-20260801    clang-22
x86_64               randconfig-013-20260801    clang-22
x86_64               randconfig-014-20260801    clang-22
x86_64               randconfig-015-20260801    clang-22
x86_64               randconfig-016-20260801    clang-22
x86_64                        randconfig-071    clang-22
x86_64               randconfig-071-20260801    clang-22
x86_64               randconfig-071-20260802    gcc-12
x86_64               randconfig-072-20260801    clang-22
x86_64               randconfig-072-20260802    gcc-12
x86_64               randconfig-073-20260801    clang-22
x86_64               randconfig-073-20260802    gcc-12
x86_64               randconfig-074-20260801    clang-22
x86_64               randconfig-074-20260802    gcc-12
x86_64               randconfig-075-20260801    clang-22
x86_64               randconfig-075-20260802    gcc-12
x86_64               randconfig-076-20260801    clang-22
x86_64               randconfig-076-20260802    gcc-12
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260801    gcc-11.5.0
xtensa               randconfig-001-20260802    gcc-12.5.0
xtensa               randconfig-002-20260801    gcc-11.5.0
xtensa               randconfig-002-20260802    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
