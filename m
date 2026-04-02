Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619C137CD2F;
	Thu,  2 Apr 2026 06:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775112984; cv=none; b=Gw4Ee7bz/v9/VkFzVERYDJc6uotYNsWeOEuH9Pa5HO7w+qgecE6l+Ho+ZhO8/Ei4HiB8jXaGyuqSbB3Z3uk01/lLrtRWKH+aBsDnGorJWH9zg/iD/e+HS0WeQDld6ZJwjUchKgEuPGzvEB0/kI10GIk46l9pECy/C/9RZidp+6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775112984; c=relaxed/simple;
	bh=aMKqR50zQTRJBJX7s/KFRRtW1Khnt4kEY+t80pULROo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LvCqtDN5RdMW3eWh3hASv/IaJ/l0tgyhcEMvKuak/KY/Hf/vwPn+tnZUGBqVj+6nhzXh8EKfnZc6u0LSrlwXvJLoPh35kewTpDnI9kVhxzmnNCPeOZR80skFEDebFCewu6OxAEM2auffm3N6cD89wpmJCRsYW5Iyec1Eo+l7JU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FEQT76Md; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FEQT76Md"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775112980; x=1806648980;
  h=date:from:to:cc:subject:message-id;
  bh=aMKqR50zQTRJBJX7s/KFRRtW1Khnt4kEY+t80pULROo=;
  b=FEQT76MdHrJagMmRZEqBkYe1i9KMgtGCXLzQoaB+9T0FFufBj59BHDLa
   jR2Kh1ay1ySYJJerUwtW1804GEgvk7/G6kZScSWFRRczaph0myoaIa5hN
   hg178fLgqqEzJzkN+MZbDjg3AT2KVifLZ1X/ArDFvLPkcPcE0YQMXbfaT
   jhdzWLOCki8hYN81fmxfJk1d/lTQXrsvo8osG8ehQKtX1esbWs2O/mp3L
   uAwq4pz9JqIL4outFEK3i4JCDWVE9zALPWKwfIl0FEMvUoLzh5jilvR0a
   OrR/hnkDhLBq8a74Bp3Wu/lFPUBdAHGLKaTy1RDzlbw8sEMCxI1xxfq5A
   g==;
X-CSE-ConnectionGUID: twIlXikfTVSJCIykY1RgDA==
X-CSE-MsgGUID: L8zUKKz5TBa5YnM2Q/+6jQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="80053907"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="80053907"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 23:56:19 -0700
X-CSE-ConnectionGUID: feJY7eiURzycfJpXGnRmeA==
X-CSE-MsgGUID: VBxEWiqJTrqZup+S4ordwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="250106081"
Received: from lkp-server02.sh.intel.com (HELO cedfeeed6c12) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 01 Apr 2026 23:56:18 -0700
Received: from kbuild by cedfeeed6c12 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w8ByM-000000000L7-1y6i;
	Thu, 02 Apr 2026 06:56:11 +0000
Date: Thu, 02 Apr 2026 10:01:26 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 baf86598b2220d2710045bb15efadba7af276049
Message-ID: <202604021020.FhNvdJhh-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: baf86598b2220d2710045bb15efadba7af276049  Merge branch 'experimental/acpi-driver-conversion' into bleeding-edge

elapsed time: 2266m

configs tested: 154
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
arc                   randconfig-001-20260401    gcc-8.5.0
arc                   randconfig-002-20260401    gcc-11.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                   randconfig-001-20260401    clang-23
arm                   randconfig-002-20260401    clang-23
arm                   randconfig-003-20260401    clang-23
arm                   randconfig-004-20260401    gcc-12.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260401    clang-18
arm64                 randconfig-002-20260401    gcc-8.5.0
arm64                 randconfig-003-20260401    gcc-8.5.0
arm64                 randconfig-004-20260401    gcc-11.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260401    gcc-13.4.0
csky                  randconfig-002-20260401    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260401    clang-23
hexagon               randconfig-002-20260401    clang-17
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260401    gcc-14
i386        buildonly-randconfig-002-20260401    clang-20
i386        buildonly-randconfig-003-20260401    gcc-14
i386        buildonly-randconfig-004-20260401    gcc-14
i386        buildonly-randconfig-005-20260401    gcc-14
i386        buildonly-randconfig-006-20260401    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20260401    gcc-14
i386                  randconfig-002-20260401    clang-20
i386                  randconfig-003-20260401    clang-20
i386                  randconfig-004-20260401    gcc-12
i386                  randconfig-005-20260401    gcc-14
i386                  randconfig-006-20260401    gcc-14
i386                  randconfig-007-20260401    gcc-14
i386                  randconfig-011-20260401    clang-20
i386                  randconfig-012-20260401    clang-20
i386                  randconfig-013-20260401    clang-20
i386                  randconfig-014-20260401    clang-20
i386                  randconfig-015-20260401    clang-20
i386                  randconfig-016-20260401    gcc-14
i386                  randconfig-017-20260401    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260401    gcc-15.2.0
loongarch             randconfig-002-20260401    clang-23
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
nios2                 randconfig-001-20260401    gcc-8.5.0
nios2                 randconfig-002-20260401    gcc-9.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260401    gcc-8.5.0
parisc                randconfig-002-20260401    gcc-8.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260401    gcc-8.5.0
powerpc               randconfig-002-20260401    clang-18
powerpc64             randconfig-001-20260401    gcc-14.3.0
powerpc64             randconfig-002-20260401    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260401    gcc-8.5.0
riscv                 randconfig-002-20260401    gcc-11.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-001-20260401    gcc-9.5.0
s390                  randconfig-002-20260401    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                    randconfig-001-20260401    gcc-10.5.0
sh                    randconfig-002-20260401    gcc-15.2.0
sh                            shmin_defconfig    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260401    gcc-8.5.0
sparc                 randconfig-002-20260401    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64               randconfig-001-20260401    clang-23
sparc64               randconfig-002-20260401    clang-23
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                    randconfig-001-20260401    clang-16
um                    randconfig-002-20260401    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260401    gcc-14
x86_64      buildonly-randconfig-002-20260401    gcc-14
x86_64      buildonly-randconfig-003-20260401    gcc-12
x86_64      buildonly-randconfig-004-20260401    gcc-12
x86_64      buildonly-randconfig-005-20260401    clang-20
x86_64      buildonly-randconfig-006-20260401    gcc-14
x86_64                randconfig-001-20260401    gcc-14
x86_64                randconfig-002-20260401    clang-20
x86_64                randconfig-003-20260401    gcc-14
x86_64                randconfig-004-20260401    gcc-14
x86_64                randconfig-005-20260401    clang-20
x86_64                randconfig-006-20260401    clang-20
x86_64                randconfig-011-20260401    gcc-14
x86_64                randconfig-012-20260401    gcc-14
x86_64                randconfig-013-20260401    gcc-14
x86_64                randconfig-014-20260401    clang-20
x86_64                randconfig-015-20260401    clang-20
x86_64                randconfig-016-20260401    gcc-14
x86_64                randconfig-071-20260401    gcc-14
x86_64                randconfig-072-20260401    clang-20
x86_64                randconfig-073-20260401    gcc-14
x86_64                randconfig-074-20260401    gcc-14
x86_64                randconfig-075-20260401    clang-20
x86_64                randconfig-076-20260401    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-001-20260401    gcc-9.5.0
xtensa                randconfig-002-20260401    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
