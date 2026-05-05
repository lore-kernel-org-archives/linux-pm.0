Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5991D9A5F;
	Tue,  5 May 2026 00:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777942124; cv=none; b=H+JJjZkwl7hxcH4Auy6Hmv+njHo9YQUNeh7pI6rj/UNL+comye7Q3u0etTenfS3iwTotq3cJtYUvoPPr+G1ODZLkXgwZ8v1eggEBN24UfUNoYTEmkZIAPWdLPTo4VWrqUg0TZqqiO66fcjyTxnby43NX4Wm/kY4RwmlfKqdZMCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777942124; c=relaxed/simple;
	bh=k7cy5mGHa03H7XnxeOPHve2rRZ6QU07GVDxeqEQYyx4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ARA44eFjNP9lwBdNK0tmKoMQOxjEuxytmTWcbcpx5aZUSUAsbfp2XXW1Kx4QvSA/6Lv+fEwVUh+fBGxsvZcufqsplZ7gtGrR8TTXZ54cGpKXtbZUsOYJfhcbTfbwMWlySYzma0aW8x4ShJ5/sac/7ADOOpi4zDxKc1OZMh077Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O1iw23lT; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O1iw23lT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777942122; x=1809478122;
  h=date:from:to:cc:subject:message-id;
  bh=k7cy5mGHa03H7XnxeOPHve2rRZ6QU07GVDxeqEQYyx4=;
  b=O1iw23lTzvxSyUJStexSh060DC35tfcyhIjCi5kAlnWiiea23TGRH2yI
   60VfQ8xEdLNH3MBqZE7ObHZsVMmsDuEgHCUfm/oPcrpxw3j2aXpdPXG2e
   mgerNyTkVGOOkh5yoUznZbJeJ50L48RmsVM8cVWneBY/ocz7AhnOz3vPv
   +vn9/V7UJ16APWTM1HNWIZQfRgpA0MabHWzqse3M6v2S1iKlPlMW9YqRs
   2CVWykrQeU1wR5s/EVOaGjKB3GNAlR/gXcEhHEo5MDlJW09Lp1RFc6CBT
   RMYc9Te6tv9R6Pn2YxYa+aLHewHOkMxnFD7JaRt1iZLLR9ZFimRnehUR8
   A==;
X-CSE-ConnectionGUID: lvex3scbRQ6ojwYQbzPtlQ==
X-CSE-MsgGUID: Yrzp9E7FQMy5EtZykkCCsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="96233805"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="96233805"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 17:48:41 -0700
X-CSE-ConnectionGUID: dF1S6PqcSjCMp2WQ25FDgQ==
X-CSE-MsgGUID: erlkgm1RRveOxv1cAjU/JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="231068842"
Received: from lkp-server01.sh.intel.com (HELO 781826d00641) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 04 May 2026 17:48:39 -0700
Received: from kbuild by 781826d00641 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wK3xg-0000000046T-0g90;
	Tue, 05 May 2026 00:48:33 +0000
Date: Tue, 05 May 2026 08:47:57 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 0ddd887759cc3a114e211fc6c2e5dcf1f6d2c21a
Message-ID: <202605050849.YpShg53z-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 0ddd887759cc3a114e211fc6c2e5dcf1f6d2c21a  Merge branch 'experimental/acpi-driver-conversion' into bleeding-edge

elapsed time: 769m

configs tested: 302
configs skipped: 45

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260504    gcc-13.4.0
arc                   randconfig-001-20260505    gcc-8.5.0
arc                   randconfig-002-20260504    gcc-13.4.0
arc                   randconfig-002-20260505    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                       aspeed_g4_defconfig    clang-23
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260504    gcc-13.4.0
arm                   randconfig-001-20260505    gcc-8.5.0
arm                   randconfig-002-20260504    gcc-13.4.0
arm                   randconfig-002-20260505    gcc-8.5.0
arm                   randconfig-003-20260504    gcc-13.4.0
arm                   randconfig-003-20260505    gcc-8.5.0
arm                   randconfig-004-20260504    gcc-13.4.0
arm                   randconfig-004-20260505    gcc-8.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260504    gcc-15.2.0
arm64                 randconfig-001-20260505    gcc-14.3.0
arm64                 randconfig-002-20260504    gcc-15.2.0
arm64                 randconfig-002-20260505    gcc-14.3.0
arm64                 randconfig-003-20260504    gcc-15.2.0
arm64                 randconfig-003-20260505    gcc-14.3.0
arm64                 randconfig-004-20260504    gcc-15.2.0
arm64                 randconfig-004-20260505    gcc-14.3.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260504    gcc-15.2.0
csky                  randconfig-001-20260505    gcc-14.3.0
csky                  randconfig-002-20260504    gcc-15.2.0
csky                  randconfig-002-20260505    gcc-14.3.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260504    clang-23
hexagon               randconfig-001-20260505    clang-23
hexagon               randconfig-001-20260505    gcc-11.5.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260504    clang-23
hexagon               randconfig-002-20260505    clang-23
hexagon               randconfig-002-20260505    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386                 buildonly-randconfig-001    gcc-14
i386        buildonly-randconfig-001-20260504    gcc-14
i386        buildonly-randconfig-001-20260505    gcc-14
i386                 buildonly-randconfig-002    gcc-14
i386        buildonly-randconfig-002-20260504    gcc-14
i386        buildonly-randconfig-002-20260505    gcc-14
i386                 buildonly-randconfig-003    gcc-14
i386        buildonly-randconfig-003-20260504    gcc-14
i386        buildonly-randconfig-003-20260505    gcc-14
i386                 buildonly-randconfig-004    gcc-14
i386        buildonly-randconfig-004-20260504    gcc-14
i386        buildonly-randconfig-004-20260505    gcc-14
i386                 buildonly-randconfig-005    gcc-14
i386        buildonly-randconfig-005-20260504    gcc-14
i386        buildonly-randconfig-005-20260505    gcc-14
i386                 buildonly-randconfig-006    gcc-14
i386        buildonly-randconfig-006-20260504    gcc-14
i386        buildonly-randconfig-006-20260505    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260504    clang-20
i386                  randconfig-001-20260505    clang-20
i386                           randconfig-002    gcc-14
i386                  randconfig-002-20260504    clang-20
i386                  randconfig-002-20260504    gcc-14
i386                  randconfig-002-20260505    clang-20
i386                           randconfig-003    gcc-14
i386                  randconfig-003-20260504    clang-20
i386                  randconfig-003-20260504    gcc-14
i386                  randconfig-003-20260505    clang-20
i386                  randconfig-004-20260504    clang-20
i386                  randconfig-004-20260504    gcc-14
i386                  randconfig-004-20260505    clang-20
i386                           randconfig-005    gcc-14
i386                  randconfig-005-20260504    clang-20
i386                  randconfig-005-20260504    gcc-14
i386                  randconfig-005-20260505    clang-20
i386                           randconfig-006    gcc-14
i386                  randconfig-006-20260504    clang-20
i386                  randconfig-006-20260505    clang-20
i386                           randconfig-007    gcc-14
i386                  randconfig-007-20260504    clang-20
i386                  randconfig-007-20260505    clang-20
i386                  randconfig-011-20260504    clang-20
i386                  randconfig-011-20260505    clang-20
i386                  randconfig-011-20260505    gcc-14
i386                  randconfig-012-20260504    clang-20
i386                  randconfig-012-20260505    clang-20
i386                  randconfig-013-20260504    clang-20
i386                  randconfig-013-20260505    clang-20
i386                  randconfig-014-20260504    clang-20
i386                  randconfig-014-20260505    clang-20
i386                  randconfig-015-20260504    clang-20
i386                  randconfig-015-20260505    clang-20
i386                  randconfig-015-20260505    gcc-14
i386                  randconfig-016-20260504    clang-20
i386                  randconfig-016-20260505    clang-20
i386                  randconfig-017-20260504    clang-20
i386                  randconfig-017-20260505    clang-20
i386                  randconfig-017-20260505    gcc-14
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260504    clang-23
loongarch             randconfig-001-20260505    clang-23
loongarch             randconfig-001-20260505    gcc-11.5.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260504    clang-23
loongarch             randconfig-002-20260505    clang-23
loongarch             randconfig-002-20260505    gcc-11.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
m68k                       m5249evb_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                  decstation_64_defconfig    gcc-15.2.0
mips                           rs90_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-15.2.0
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260504    clang-23
nios2                 randconfig-001-20260505    clang-23
nios2                 randconfig-001-20260505    gcc-11.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260504    clang-23
nios2                 randconfig-002-20260505    clang-23
nios2                 randconfig-002-20260505    gcc-11.5.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260504    gcc-13.4.0
parisc                randconfig-001-20260505    gcc-14.3.0
parisc                randconfig-002-20260504    gcc-13.4.0
parisc                randconfig-002-20260505    gcc-14.3.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260504    gcc-13.4.0
powerpc               randconfig-001-20260505    gcc-14.3.0
powerpc               randconfig-002-20260504    gcc-13.4.0
powerpc               randconfig-002-20260505    gcc-14.3.0
powerpc                     tqm8560_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260504    gcc-13.4.0
powerpc64             randconfig-001-20260505    gcc-14.3.0
powerpc64             randconfig-002-20260504    gcc-13.4.0
powerpc64             randconfig-002-20260505    gcc-14.3.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260504    gcc-8.5.0
riscv                 randconfig-001-20260505    gcc-10.5.0
riscv                 randconfig-002-20260504    gcc-8.5.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260504    gcc-8.5.0
s390                  randconfig-002-20260504    gcc-8.5.0
s390                  randconfig-002-20260505    gcc-10.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260504    gcc-8.5.0
sh                    randconfig-001-20260505    gcc-10.5.0
sh                    randconfig-002-20260504    gcc-8.5.0
sh                    randconfig-002-20260505    gcc-10.5.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260504    gcc-8.5.0
sparc                 randconfig-001-20260505    gcc-15.2.0
sparc                 randconfig-002-20260504    gcc-8.5.0
sparc                 randconfig-002-20260505    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260504    gcc-8.5.0
sparc64               randconfig-001-20260505    gcc-15.2.0
sparc64               randconfig-002-20260504    gcc-8.5.0
sparc64               randconfig-002-20260505    gcc-15.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-23
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260504    gcc-8.5.0
um                    randconfig-001-20260505    gcc-15.2.0
um                    randconfig-002-20260504    gcc-8.5.0
um                    randconfig-002-20260505    gcc-15.2.0
um                           x86_64_defconfig    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260504    gcc-12
x86_64      buildonly-randconfig-001-20260505    clang-20
x86_64      buildonly-randconfig-002-20260504    gcc-12
x86_64      buildonly-randconfig-002-20260505    clang-20
x86_64      buildonly-randconfig-003-20260504    gcc-12
x86_64      buildonly-randconfig-003-20260505    clang-20
x86_64      buildonly-randconfig-004-20260504    gcc-12
x86_64      buildonly-randconfig-004-20260505    clang-20
x86_64      buildonly-randconfig-005-20260504    gcc-12
x86_64      buildonly-randconfig-005-20260505    clang-20
x86_64      buildonly-randconfig-006-20260504    gcc-12
x86_64      buildonly-randconfig-006-20260505    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260505    clang-20
x86_64                randconfig-002-20260505    clang-20
x86_64                randconfig-003-20260504    gcc-14
x86_64                randconfig-003-20260505    clang-20
x86_64                randconfig-004-20260505    clang-20
x86_64                randconfig-005-20260505    clang-20
x86_64                randconfig-006-20260505    clang-20
x86_64                randconfig-011-20260504    gcc-14
x86_64                randconfig-011-20260505    clang-20
x86_64                randconfig-012-20260504    gcc-14
x86_64                randconfig-012-20260505    clang-20
x86_64                randconfig-013-20260504    gcc-14
x86_64                randconfig-013-20260505    clang-20
x86_64                randconfig-014-20260504    gcc-14
x86_64                randconfig-014-20260505    clang-20
x86_64                randconfig-015-20260505    clang-20
x86_64                randconfig-016-20260505    clang-20
x86_64                randconfig-071-20260504    clang-20
x86_64                randconfig-071-20260505    clang-20
x86_64                randconfig-072-20260504    clang-20
x86_64                randconfig-072-20260505    clang-20
x86_64                randconfig-073-20260504    clang-20
x86_64                randconfig-073-20260505    clang-20
x86_64                randconfig-074-20260504    clang-20
x86_64                randconfig-074-20260505    clang-20
x86_64                randconfig-075-20260504    clang-20
x86_64                randconfig-075-20260505    clang-20
x86_64                randconfig-076-20260504    clang-20
x86_64                randconfig-076-20260505    clang-20
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
xtensa                           allyesconfig    gcc-11.5.0
xtensa                randconfig-001-20260504    gcc-8.5.0
xtensa                randconfig-001-20260505    gcc-15.2.0
xtensa                randconfig-002-20260504    gcc-8.5.0
xtensa                randconfig-002-20260505    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
