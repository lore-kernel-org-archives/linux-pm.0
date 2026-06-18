Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955A2306B11;
	Thu, 18 Jun 2026 06:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781765754; cv=none; b=OpK9kTqHJ4knaNiIE5NIYGZaf4IUc5v+vDflFQ3ib1IzjSvI2tv33qQM8b0TiGv6E6JbIGqNXCRGjZHyZMv2ROHSuLrHw7dBwAW7wW1Vzipi/Posk0f5rDUOsGnR8yjqIWSS7EPC5V4TDySnmSqgAS6UvBt/r1/qiZ16SFT3gDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781765754; c=relaxed/simple;
	bh=p5nV9poVxruHhafFedkFUFsqrjf6sPqsR/GmCjP8Hlw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=YPKr6eZke9PFjqhNr8OXecYZ+WCiCclMDYN0NHGjdvZ0nIs0vihz/IIL4yJgHFyiKJpAn7ciT4kF6vb5+HILeRQF4Ly9iE0Cy6eqtvoE7ZKXB/fUqLTuqa2aBhj9GCyuEcctivIAXMuNulXLisw5bItoCsOlrd8eVjZj7SGSMp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dNmteuhs; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dNmteuhs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781765751; x=1813301751;
  h=date:from:to:cc:subject:message-id;
  bh=p5nV9poVxruHhafFedkFUFsqrjf6sPqsR/GmCjP8Hlw=;
  b=dNmteuhsEq/IHoWwtaSJolgLssKPay+Kb/rORPicflgksWKKkxVfbweT
   97P5Lh6Bx2Ou7tFVhRa0VhFgm7OdiNS+H6MHBpQ+cpoi/m8wjPrnuqZPg
   MfqwyWZkGrXUlxNP/9p4k6G2b3UIovQasvu1NneoCRj0u406SZctQSck9
   KXdZQDUThrKwnq7WGyEgCA+7CEquaLksuS5a3MPmtAiE/2GOh748Cnk9U
   77CO0QRIUc8vBOgy8QIdPNCWY9xX50QmLqLa1aPvwjyT7vr/hnt1cXV8l
   a8Cf3IGmCzcogBxF1Ns1vWkPsPE+1PkyH4Q8sMoeNrctiD1rWgyAVtcDZ
   Q==;
X-CSE-ConnectionGUID: u+efo8M+RJu7O4iky+w6Kg==
X-CSE-MsgGUID: 7+mNI+qZRKyU5H6z9y6msw==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="82593941"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="82593941"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 23:55:50 -0700
X-CSE-ConnectionGUID: 7IIey/MbTTSi5eqpZgg5kw==
X-CSE-MsgGUID: WPhnrN9IT2OsNII/6CVxvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="245916313"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 17 Jun 2026 23:55:48 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wa6fC-00000000VKE-0KLy;
	Thu, 18 Jun 2026 06:55:46 +0000
Date: Thu, 18 Jun 2026 14:55:12 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 06d09020d6d8326233327e7565e774d6a90fa3b4
Message-ID: <202606181400.FGQAQK6m-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: 06d09020d6d8326233327e7565e774d6a90fa3b4  Merge branch 'acpica' into fixes

elapsed time: 727m

configs tested: 211
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
arc                   randconfig-001-20260618    gcc-15.2.0
arc                   randconfig-002-20260618    gcc-15.2.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    gcc-16.1.0
arm                   randconfig-001-20260618    gcc-15.2.0
arm                   randconfig-002-20260618    gcc-15.2.0
arm                   randconfig-003-20260618    gcc-15.2.0
arm                   randconfig-004-20260618    gcc-15.2.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260618    gcc-15.2.0
arm64                 randconfig-002-20260618    gcc-15.2.0
arm64                 randconfig-003-20260618    gcc-15.2.0
arm64                 randconfig-004-20260618    gcc-15.2.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260618    gcc-15.2.0
csky                  randconfig-002-20260618    gcc-15.2.0
hexagon                          allmodconfig    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260618    clang-23
hexagon               randconfig-002-20260618    clang-23
i386                             allmodconfig    clang-22
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386        buildonly-randconfig-001-20260618    gcc-14
i386        buildonly-randconfig-002-20260618    gcc-14
i386        buildonly-randconfig-003-20260618    gcc-14
i386        buildonly-randconfig-004-20260618    gcc-14
i386        buildonly-randconfig-005-20260618    gcc-14
i386        buildonly-randconfig-006-20260618    gcc-14
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260618    clang-22
i386                  randconfig-002-20260618    clang-22
i386                  randconfig-003-20260618    clang-22
i386                  randconfig-004-20260618    clang-22
i386                  randconfig-005-20260618    clang-22
i386                  randconfig-006-20260618    clang-22
i386                  randconfig-007-20260618    clang-22
i386                  randconfig-011-20260618    clang-22
i386                  randconfig-012-20260618    clang-22
i386                  randconfig-013-20260618    clang-22
i386                  randconfig-014-20260618    clang-22
i386                  randconfig-015-20260618    clang-22
i386                  randconfig-016-20260618    clang-22
i386                  randconfig-017-20260618    clang-22
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260618    clang-23
loongarch             randconfig-002-20260618    clang-23
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
nios2                            allmodconfig    clang-20
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                 randconfig-001-20260618    clang-23
nios2                 randconfig-002-20260618    clang-23
openrisc                         allmodconfig    clang-20
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
parisc                randconfig-001-20260618    gcc-14.3.0
parisc                randconfig-001-20260618    gcc-16.1.0
parisc                randconfig-002-20260618    gcc-16.1.0
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc               randconfig-001-20260618    gcc-16.1.0
powerpc               randconfig-001-20260618    gcc-8.5.0
powerpc               randconfig-002-20260618    gcc-11.5.0
powerpc               randconfig-002-20260618    gcc-16.1.0
powerpc64             randconfig-001-20260618    gcc-16.1.0
powerpc64             randconfig-001-20260618    gcc-8.5.0
powerpc64             randconfig-002-20260618    clang-17
powerpc64             randconfig-002-20260618    gcc-16.1.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                          randconfig-001    gcc-13.4.0
riscv                 randconfig-001-20260618    gcc-11.5.0
riscv                 randconfig-001-20260618    gcc-13.4.0
riscv                          randconfig-002    clang-17
riscv                 randconfig-002-20260618    clang-20
riscv                 randconfig-002-20260618    gcc-13.4.0
s390                             allmodconfig    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                           randconfig-001    gcc-15.2.0
s390                  randconfig-001-20260618    clang-23
s390                  randconfig-001-20260618    gcc-13.4.0
s390                           randconfig-002    clang-18
s390                  randconfig-002-20260618    clang-23
s390                  randconfig-002-20260618    gcc-13.4.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                               allyesconfig    gcc-16.1.0
sh                         ap325rxa_defconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                             randconfig-001    gcc-14.3.0
sh                    randconfig-001-20260618    gcc-13.4.0
sh                             randconfig-002    gcc-9.5.0
sh                    randconfig-002-20260618    gcc-13.4.0
sh                    randconfig-002-20260618    gcc-16.1.0
sh                           se7619_defconfig    gcc-16.1.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260618    gcc-14.3.0
sparc                 randconfig-002-20260618    gcc-14.3.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260618    gcc-14.3.0
sparc64               randconfig-002-20260618    gcc-14.3.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260618    gcc-14.3.0
um                    randconfig-002-20260618    gcc-14.3.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260618    clang-22
x86_64      buildonly-randconfig-002-20260618    clang-22
x86_64      buildonly-randconfig-003-20260618    clang-22
x86_64      buildonly-randconfig-004-20260618    clang-22
x86_64      buildonly-randconfig-005-20260618    clang-22
x86_64      buildonly-randconfig-006-20260618    clang-22
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260618    clang-22
x86_64                randconfig-002-20260618    clang-22
x86_64                randconfig-003-20260618    clang-22
x86_64                randconfig-004-20260618    clang-22
x86_64                randconfig-005-20260618    clang-22
x86_64                randconfig-006-20260618    clang-22
x86_64                randconfig-011-20260618    gcc-14
x86_64                randconfig-012-20260618    gcc-14
x86_64                randconfig-013-20260618    gcc-14
x86_64                randconfig-014-20260618    gcc-14
x86_64                randconfig-015-20260618    gcc-14
x86_64                randconfig-016-20260618    gcc-14
x86_64                randconfig-071-20260618    clang-22
x86_64                randconfig-072-20260618    clang-22
x86_64                randconfig-073-20260618    clang-22
x86_64                randconfig-074-20260618    clang-22
x86_64                randconfig-075-20260618    clang-22
x86_64                randconfig-076-20260618    clang-22
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
xtensa                randconfig-001-20260618    gcc-14.3.0
xtensa                randconfig-002-20260618    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
