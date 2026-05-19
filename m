Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D4A3BE162;
	Tue, 19 May 2026 07:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779176597; cv=none; b=Zhf9tbf/iZyVvLKKjO1ZqOg1cDT2p6r3JXWO1wSzfBfhEktT+iws8W+Q+pmcPPNBWOpEQzsUaipylXCNitcsQI9buZ5jUrITK+JsTUXI+LSeBjaS3oB/HAsLWuY9UIftLtVGXfAasRIKNtGfym/CHTupg/8sPLX7Zcin7a2Bzt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779176597; c=relaxed/simple;
	bh=qjfdIAybQb1PWIapjs7Rgooq1eX6gqjmlEcma4hSmdA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Lb/vXHOyTW8GNwsTBEwuLR/gIV+iuwj6Xx4QtI+9KkukirWCNLRQI2/0hc1ORanfgXrYfJuAyVU/2md9nnHfbQkwb9YS4saVUjNFD0d32l0DzKAw+91JQdSj2BvFTuiCCo1FL6X1DGvaN+DQQ+Hxk5o33KLksrtJV/IYMsCaR7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m7a1UX5A; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m7a1UX5A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779176596; x=1810712596;
  h=date:from:to:cc:subject:message-id;
  bh=qjfdIAybQb1PWIapjs7Rgooq1eX6gqjmlEcma4hSmdA=;
  b=m7a1UX5AFWDvbXwiuE+1i438/iGdw0h4cgB7vHXLCmg0R9VxQuztejtQ
   QNkllOB4vqZTinsSur71xYlKZKcK8M9pG61EknbI7ZTbgesXTgh4C0HuT
   Z6jW+ac1Cez9Ifke0Ob7SU22RfhuBTTpOnT4juYxaLyOV2DMKwMY4hvsd
   cDJPjES7qnqPJYeSdnrr1e51q0Mcm15rz7z5MVk5kMQc+YwWRN8zmSR5B
   EtDoTv2pTeYEGGKJovI64ypuTRyWEHF8wHGfJAehzHJJMhFjOEhg7kdIp
   P+kRN5ktCRAEOabmNQwVxM5z1f8pdemtJkpYPeon53a+F/+voAubyqpFJ
   A==;
X-CSE-ConnectionGUID: T0ZM9/VnRbC6Hx3V6Gu8xQ==
X-CSE-MsgGUID: HcajCcMlQrS2RDFe7/QgKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="91510459"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="91510459"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 00:43:16 -0700
X-CSE-ConnectionGUID: nD2/IP9dSnWmvBhy8hvGWg==
X-CSE-MsgGUID: Ilw4xfFWRAWHLh8AT8/zGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="239938022"
Received: from lkp-server02.sh.intel.com (HELO 30e86e9c1927) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 19 May 2026 00:43:13 -0700
Received: from kbuild by 30e86e9c1927 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wPF6D-000000000fH-3tBM;
	Tue, 19 May 2026 07:42:56 +0000
Date: Tue, 19 May 2026 15:40:29 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 e76f50cb8598cc3294012686a9174d3b10b30dc4
Message-ID: <202605191519.NcSfxrft-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: e76f50cb8598cc3294012686a9174d3b10b30dc4  Merge branch 'experimental/acpi-driver-work' into bleeding-edge

elapsed time: 735m

configs tested: 225
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
arc                              alldefconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                   randconfig-001-20260519    clang-23
arc                   randconfig-001-20260519    gcc-9.5.0
arc                   randconfig-002-20260519    clang-23
arc                   randconfig-002-20260519    gcc-10.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                   randconfig-001-20260519    clang-23
arm                   randconfig-002-20260519    clang-23
arm                   randconfig-003-20260519    clang-23
arm                   randconfig-004-20260519    clang-23
arm                   randconfig-004-20260519    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                 randconfig-001-20260519    gcc-8.5.0
arm64                 randconfig-002-20260519    gcc-8.5.0
arm64                 randconfig-003-20260519    gcc-8.5.0
arm64                 randconfig-004-20260519    gcc-8.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                  randconfig-001-20260519    gcc-8.5.0
csky                  randconfig-002-20260519    gcc-8.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon               randconfig-001-20260519    clang-23
hexagon               randconfig-001-20260519    gcc-10.5.0
hexagon               randconfig-002-20260519    clang-23
hexagon               randconfig-002-20260519    gcc-10.5.0
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    gcc-14
i386                 buildonly-randconfig-001    gcc-12
i386        buildonly-randconfig-001-20260519    gcc-12
i386                 buildonly-randconfig-002    gcc-12
i386        buildonly-randconfig-002-20260519    gcc-12
i386        buildonly-randconfig-002-20260519    gcc-14
i386                 buildonly-randconfig-003    gcc-12
i386        buildonly-randconfig-003-20260519    clang-20
i386        buildonly-randconfig-003-20260519    gcc-12
i386                 buildonly-randconfig-004    gcc-12
i386        buildonly-randconfig-004-20260519    gcc-12
i386        buildonly-randconfig-004-20260519    gcc-14
i386                 buildonly-randconfig-005    gcc-12
i386        buildonly-randconfig-005-20260519    gcc-12
i386        buildonly-randconfig-005-20260519    gcc-14
i386                 buildonly-randconfig-006    gcc-12
i386        buildonly-randconfig-006-20260519    clang-20
i386        buildonly-randconfig-006-20260519    gcc-12
i386                  randconfig-001-20260519    gcc-14
i386                  randconfig-002-20260519    gcc-14
i386                  randconfig-003-20260519    gcc-14
i386                  randconfig-004-20260519    gcc-14
i386                  randconfig-005-20260519    gcc-14
i386                  randconfig-006-20260519    gcc-14
i386                  randconfig-007-20260519    gcc-14
i386                  randconfig-011-20260519    gcc-14
i386                  randconfig-012-20260519    gcc-14
i386                  randconfig-013-20260519    gcc-14
i386                  randconfig-014-20260519    gcc-14
i386                  randconfig-015-20260519    gcc-14
i386                  randconfig-016-20260519    gcc-14
i386                  randconfig-017-20260519    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260519    clang-18
loongarch             randconfig-001-20260519    gcc-10.5.0
loongarch             randconfig-002-20260519    gcc-10.5.0
loongarch             randconfig-002-20260519    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                         10m50_defconfig    gcc-11.5.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260519    gcc-10.5.0
nios2                 randconfig-001-20260519    gcc-11.5.0
nios2                 randconfig-002-20260519    gcc-10.5.0
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
parisc                randconfig-001-20260519    gcc-8.5.0
parisc                randconfig-002-20260519    gcc-8.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260519    gcc-8.5.0
powerpc               randconfig-002-20260519    gcc-8.5.0
powerpc64             randconfig-001-20260519    gcc-8.5.0
powerpc64             randconfig-002-20260519    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260519    gcc-13.4.0
riscv                 randconfig-001-20260519    gcc-8.5.0
riscv                 randconfig-002-20260519    clang-17
riscv                 randconfig-002-20260519    gcc-13.4.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260519    clang-23
s390                  randconfig-001-20260519    gcc-13.4.0
s390                  randconfig-002-20260519    clang-18
s390                  randconfig-002-20260519    gcc-13.4.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                          landisk_defconfig    gcc-15.2.0
sh                    randconfig-001-20260519    gcc-13.4.0
sh                    randconfig-001-20260519    gcc-15.2.0
sh                    randconfig-002-20260519    gcc-13.4.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260519    gcc-14.3.0
sparc                 randconfig-002-20260519    gcc-11.5.0
sparc                 randconfig-002-20260519    gcc-14.3.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260519    gcc-14.3.0
sparc64               randconfig-001-20260519    gcc-8.5.0
sparc64               randconfig-002-20260519    gcc-14.3.0
sparc64               randconfig-002-20260519    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-23
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260519    clang-23
um                    randconfig-001-20260519    gcc-14.3.0
um                    randconfig-002-20260519    clang-23
um                    randconfig-002-20260519    gcc-14.3.0
um                           x86_64_defconfig    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260519    gcc-14
x86_64      buildonly-randconfig-002-20260519    gcc-14
x86_64      buildonly-randconfig-003-20260519    gcc-14
x86_64      buildonly-randconfig-004-20260519    gcc-14
x86_64      buildonly-randconfig-005-20260519    gcc-14
x86_64      buildonly-randconfig-006-20260519    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260519    gcc-14
x86_64                randconfig-002-20260519    gcc-13
x86_64                randconfig-003-20260519    clang-20
x86_64                randconfig-004-20260519    clang-20
x86_64                randconfig-005-20260519    clang-20
x86_64                randconfig-006-20260519    clang-20
x86_64                randconfig-011-20260519    clang-20
x86_64                randconfig-012-20260519    clang-20
x86_64                randconfig-013-20260519    clang-20
x86_64                randconfig-014-20260519    clang-20
x86_64                randconfig-015-20260519    clang-20
x86_64                randconfig-016-20260519    clang-20
x86_64                randconfig-071-20260519    gcc-14
x86_64                randconfig-072-20260519    gcc-14
x86_64                randconfig-073-20260519    gcc-14
x86_64                randconfig-074-20260519    gcc-14
x86_64                randconfig-075-20260519    gcc-14
x86_64                randconfig-076-20260519    gcc-14
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260519    gcc-10.5.0
xtensa                randconfig-001-20260519    gcc-14.3.0
xtensa                randconfig-002-20260519    gcc-10.5.0
xtensa                randconfig-002-20260519    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
