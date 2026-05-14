Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3364C390CA9;
	Thu, 14 May 2026 18:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778784922; cv=none; b=Iy5HtWILgtrDIeKILMr6NmCIjSNz5FllWKfemygY2Uic1G4kksNhio8ejpFZIXD29FN2L0QYFG7RJ6kMlNlS7/I9732O9NSz5JX/L0i2y9ScXZBSyZDfgD1qOayOGZWHQkQ+Nle7u/+n5n6TqrvjMQTj57umaJc/T2DXIAyc6Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778784922; c=relaxed/simple;
	bh=Thj4MArQuLgmsOFPjuS8omfnE/hGlvE1bsT1WApSSyU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=iSvZABLyB8RHxNEkc/u1j3K5TdsGobT1dGeJSHHj8lEsgiSgmGqliMVjzz2UBCsQ2CdyIS98X3yezAnAOzOQJpK82Sz95hQoxYLBn1HjfH9CZWNVLKaxa6wdO1UwcVyYnFmMTmANB+ccunruBn09sKgPB1WyY8Kwm9PteivN1Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FcdY+LHf; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FcdY+LHf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778784921; x=1810320921;
  h=date:from:to:cc:subject:message-id;
  bh=Thj4MArQuLgmsOFPjuS8omfnE/hGlvE1bsT1WApSSyU=;
  b=FcdY+LHf1hMDAqu8zWkmKPowATyQjL0LWLRtSNgNYlteM6le9A+RkKUD
   otgFCn96rvRtl7AF1ihUbCSN+Zl6BwedZTkTq/WqXJkUGvurohfapkDkf
   Nq1mP70VuWInIBDlD49FjoT7a3R3s+gcmJNR49nehx7QEjGoBv5ogp5js
   hvYDd3H1n+Z2l3c7NJg8GCEDlzD2T9HnOPckBoXkxoFXwvToE+I162qxz
   EPl5jFTTqn5+eRw/3UvErmxEk5O/eR3EH2W9lIMQ3CDwvk9icEslDczAt
   T56hZCq+6tI4R/Pn34/tWt2eIhzEXg9eDlmQV0Uo/mr3STVyLQ0MmC4ER
   Q==;
X-CSE-ConnectionGUID: fl/Jssw9TL+BCylovK51Og==
X-CSE-MsgGUID: l4iKQ44AQi+aGleZrM92gA==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="83349084"
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="83349084"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 11:55:21 -0700
X-CSE-ConnectionGUID: 3DpZH+njRuCXSB0Nnh+EAA==
X-CSE-MsgGUID: qHVB56OPT6KV059bvqGwEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="238569235"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 14 May 2026 11:55:19 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wNbDJ-000000006x3-05KT;
	Thu, 14 May 2026 18:55:17 +0000
Date: Fri, 15 May 2026 02:54:31 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 a213d823ffa634d2aec36c58969da0417de65508
Message-ID: <202605150224.7W9kcI6d-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: a213d823ffa634d2aec36c58969da0417de65508  Merge branch 'pm-cpufreq-fixes' into bleeding-edge

elapsed time: 729m

configs tested: 220
configs skipped: 2

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
arc                   randconfig-001-20260514    clang-23
arc                   randconfig-002-20260514    clang-23
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260514    clang-23
arm                   randconfig-002-20260514    clang-23
arm                   randconfig-003-20260514    clang-23
arm                   randconfig-004-20260514    clang-23
arm                             rpc_defconfig    clang-18
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260514    clang-23
arm64                 randconfig-001-20260515    gcc-11.5.0
arm64                 randconfig-002-20260514    clang-23
arm64                 randconfig-002-20260515    gcc-11.5.0
arm64                 randconfig-003-20260514    clang-23
arm64                 randconfig-003-20260515    gcc-11.5.0
arm64                 randconfig-004-20260514    clang-23
arm64                 randconfig-004-20260515    gcc-11.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260514    clang-23
csky                  randconfig-001-20260515    gcc-11.5.0
csky                  randconfig-002-20260514    clang-23
csky                  randconfig-002-20260515    gcc-11.5.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260514    gcc-10.5.0
hexagon               randconfig-002-20260514    gcc-10.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                 buildonly-randconfig-001    gcc-14
i386        buildonly-randconfig-001-20260514    gcc-14
i386                 buildonly-randconfig-002    gcc-14
i386        buildonly-randconfig-002-20260514    gcc-14
i386                 buildonly-randconfig-003    gcc-14
i386        buildonly-randconfig-003-20260514    gcc-14
i386                 buildonly-randconfig-004    gcc-14
i386        buildonly-randconfig-004-20260514    gcc-14
i386                 buildonly-randconfig-005    gcc-14
i386        buildonly-randconfig-005-20260514    gcc-14
i386                 buildonly-randconfig-006    gcc-14
i386        buildonly-randconfig-006-20260514    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260514    clang-20
i386                  randconfig-002-20260514    clang-20
i386                  randconfig-003-20260514    clang-20
i386                  randconfig-004-20260514    clang-20
i386                  randconfig-005-20260514    clang-20
i386                  randconfig-006-20260514    clang-20
i386                  randconfig-007-20260514    clang-20
i386                  randconfig-011-20260514    clang-20
i386                  randconfig-012-20260514    clang-20
i386                  randconfig-013-20260514    clang-20
i386                  randconfig-014-20260514    clang-20
i386                  randconfig-015-20260514    clang-20
i386                  randconfig-016-20260514    clang-20
i386                  randconfig-017-20260514    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260514    gcc-10.5.0
loongarch             randconfig-002-20260514    gcc-10.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260514    gcc-10.5.0
nios2                 randconfig-002-20260514    gcc-10.5.0
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                         randconfig-001    gcc-13.4.0
parisc                randconfig-001-20260514    gcc-13.4.0
parisc                         randconfig-002    gcc-13.4.0
parisc                randconfig-002-20260514    gcc-13.4.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                  mpc885_ads_defconfig    clang-23
powerpc                        randconfig-001    gcc-13.4.0
powerpc               randconfig-001-20260514    gcc-13.4.0
powerpc                        randconfig-002    gcc-13.4.0
powerpc               randconfig-002-20260514    gcc-13.4.0
powerpc                     tqm8541_defconfig    clang-23
powerpc64                      randconfig-001    gcc-13.4.0
powerpc64             randconfig-001-20260514    gcc-13.4.0
powerpc64                      randconfig-002    gcc-13.4.0
powerpc64             randconfig-002-20260514    gcc-13.4.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260514    gcc-14.3.0
riscv                 randconfig-002-20260514    gcc-14.3.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260514    gcc-14.3.0
s390                  randconfig-002-20260514    gcc-14.3.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260514    gcc-14.3.0
sh                    randconfig-002-20260514    gcc-14.3.0
sh                        sh7757lcr_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                          randconfig-001    gcc-15.2.0
sparc                 randconfig-001-20260514    gcc-15.2.0
sparc                          randconfig-002    gcc-15.2.0
sparc                 randconfig-002-20260514    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-15.2.0
sparc64               randconfig-001-20260514    gcc-15.2.0
sparc64                        randconfig-002    gcc-15.2.0
sparc64               randconfig-002-20260514    gcc-15.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    gcc-15.2.0
um                    randconfig-001-20260514    gcc-15.2.0
um                             randconfig-002    gcc-15.2.0
um                    randconfig-002-20260514    gcc-15.2.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64               buildonly-randconfig-001    clang-20
x86_64      buildonly-randconfig-001-20260514    clang-20
x86_64               buildonly-randconfig-002    clang-20
x86_64      buildonly-randconfig-002-20260514    clang-20
x86_64               buildonly-randconfig-003    clang-20
x86_64      buildonly-randconfig-003-20260514    clang-20
x86_64               buildonly-randconfig-004    clang-20
x86_64      buildonly-randconfig-004-20260514    clang-20
x86_64               buildonly-randconfig-005    clang-20
x86_64      buildonly-randconfig-005-20260514    clang-20
x86_64               buildonly-randconfig-006    clang-20
x86_64      buildonly-randconfig-006-20260514    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                         randconfig-001    gcc-14
x86_64                randconfig-001-20260514    gcc-14
x86_64                         randconfig-002    gcc-14
x86_64                randconfig-002-20260514    gcc-14
x86_64                         randconfig-003    gcc-14
x86_64                randconfig-003-20260514    gcc-14
x86_64                         randconfig-004    gcc-14
x86_64                randconfig-004-20260514    gcc-14
x86_64                         randconfig-005    gcc-14
x86_64                randconfig-005-20260514    gcc-14
x86_64                         randconfig-006    gcc-14
x86_64                randconfig-006-20260514    gcc-14
x86_64                         randconfig-011    clang-20
x86_64                randconfig-011-20260514    clang-20
x86_64                         randconfig-012    clang-20
x86_64                randconfig-012-20260514    clang-20
x86_64                         randconfig-013    clang-20
x86_64                randconfig-013-20260514    clang-20
x86_64                         randconfig-014    clang-20
x86_64                randconfig-014-20260514    clang-20
x86_64                         randconfig-015    clang-20
x86_64                randconfig-015-20260514    clang-20
x86_64                         randconfig-016    clang-20
x86_64                randconfig-016-20260514    clang-20
x86_64                randconfig-071-20260514    clang-20
x86_64                randconfig-072-20260514    clang-20
x86_64                randconfig-073-20260514    clang-20
x86_64                randconfig-074-20260514    clang-20
x86_64                randconfig-075-20260514    clang-20
x86_64                randconfig-076-20260514    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                         randconfig-001    gcc-15.2.0
xtensa                randconfig-001-20260514    gcc-15.2.0
xtensa                         randconfig-002    gcc-15.2.0
xtensa                randconfig-002-20260514    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
