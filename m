Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDE813A3ED;
	Fri, 27 Mar 2026 15:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774626893; cv=none; b=Z1Inr8O/ERvVt2lOnC6Na8XRDIzsACg5JX1Didh+XMAYXxiYH6Qcw6849z8rrkKtzVoUh0DsJVdjwNhaoeG2W+vvPfN72DWYaLl2dSeZkxj0nS/EP1RnVlTsCvuEet1Uqjmiu+oEPogZSoiHtfRzNLBANlTiEmPCW7cqAiY6rro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774626893; c=relaxed/simple;
	bh=UiroqzcbHytgjtA58hXE+zHBvav7jviIRMDQGrky9X0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WJ1ckY7ge6zBfRywuwHg5Cr6tcT2In74Y5WylPJyrRSbC/dCJtsATCrEsv7Yn9XVLTP/3zJ17AZKDVFshczv+lBgt7G7KzlM7Jj35i1QPcXm9xXA0lAc9BEGu/0U6RIrqZp3ND6F1MR7Pu67duPf4mDhqEWkfO4NuyxfzOPENJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VJy67JCb; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VJy67JCb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774626893; x=1806162893;
  h=date:from:to:cc:subject:message-id;
  bh=UiroqzcbHytgjtA58hXE+zHBvav7jviIRMDQGrky9X0=;
  b=VJy67JCbBZfoFTVjqmduK08VHdMaj1gm1HK70ZK78jJAI4X+hsgXb1vW
   0bYXPes0B5Z9gUtYVB2BmUFQ8QMhsvmTsgYgsaWm9vHEZUcILFTzs6Q4c
   EwTLXsrsdIOIajRkkN/Nfyw/50c5FFAb/HfKuuyFjuMtkG3d0VZOYe/Y7
   98mIr9CyXU7s1xMSsEReNJJxbz1bi6wulwECH9CWW/L2pfbl4iArZNjUq
   sPH2zucANaBrYjp+anKH75pLWKi33e/0gi83W18g6ep63LDtOP4o2M8h3
   wwwuk6SVX60eLh+5Zh5ngUf8ZxPptMpLxRf0Cg5FF26KJ77as7IzbX4Vn
   Q==;
X-CSE-ConnectionGUID: Ooi/cFztSsubDKVqP9hMJA==
X-CSE-MsgGUID: t4TBZOkHSD2j1ihaiTU7+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="86778908"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="86778908"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 08:54:45 -0700
X-CSE-ConnectionGUID: Ytm1kzJmR/GMISPF76iz1g==
X-CSE-MsgGUID: BvhzUfYeRtypGKOpHt0U4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="222025994"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 27 Mar 2026 08:54:43 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w69WD-00000000AQP-10ay;
	Fri, 27 Mar 2026 15:54:41 +0000
Date: Fri, 27 Mar 2026 23:54:18 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 ccbc696f9e4ceb00bd007184c84bf8e08344da99
Message-ID: <202603272309.J7BA0Kyj-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: ccbc696f9e4ceb00bd007184c84bf8e08344da99  Merge branch 'acpi-tables' into bleeding-edge

elapsed time: 1201m

configs tested: 153
configs skipped: 4

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
arc                   randconfig-001-20260327    gcc-11.5.0
arc                   randconfig-002-20260327    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                   randconfig-001-20260327    gcc-8.5.0
arm                   randconfig-002-20260327    clang-23
arm                   randconfig-003-20260327    clang-18
arm                   randconfig-004-20260327    gcc-11.5.0
arm                           tegra_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260327    clang-23
arm64                 randconfig-002-20260327    clang-18
arm64                 randconfig-003-20260327    gcc-9.5.0
arm64                 randconfig-004-20260327    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260327    gcc-15.2.0
csky                  randconfig-002-20260327    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260327    clang-23
hexagon               randconfig-002-20260327    clang-19
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260327    clang-20
i386        buildonly-randconfig-002-20260327    clang-20
i386        buildonly-randconfig-003-20260327    gcc-14
i386        buildonly-randconfig-004-20260327    clang-20
i386        buildonly-randconfig-005-20260327    clang-20
i386        buildonly-randconfig-006-20260327    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20260327    clang-20
i386                  randconfig-002-20260327    clang-20
i386                  randconfig-003-20260327    gcc-14
i386                  randconfig-004-20260327    clang-20
i386                  randconfig-005-20260327    clang-20
i386                  randconfig-006-20260327    clang-20
i386                  randconfig-007-20260327    gcc-14
i386                  randconfig-011-20260327    clang-20
i386                  randconfig-012-20260327    gcc-14
i386                  randconfig-013-20260327    gcc-12
i386                  randconfig-014-20260327    gcc-12
i386                  randconfig-015-20260327    clang-20
i386                  randconfig-016-20260327    gcc-14
i386                  randconfig-017-20260327    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260327    gcc-15.2.0
loongarch             randconfig-002-20260327    clang-23
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
nios2                 randconfig-001-20260327    gcc-9.5.0
nios2                 randconfig-002-20260327    gcc-8.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260327    gcc-8.5.0
parisc                randconfig-002-20260327    gcc-8.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260327    gcc-8.5.0
powerpc               randconfig-002-20260327    clang-18
powerpc64             randconfig-001-20260327    clang-23
powerpc64             randconfig-002-20260327    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260327    clang-23
riscv                 randconfig-002-20260327    clang-23
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-001-20260327    clang-23
s390                  randconfig-002-20260327    gcc-12.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260327    gcc-14.3.0
sh                    randconfig-002-20260327    gcc-13.4.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260327    gcc-14.3.0
sparc                 randconfig-002-20260327    gcc-13.4.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260327    clang-23
sparc64               randconfig-002-20260327    clang-23
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260327    gcc-14
um                    randconfig-002-20260327    clang-23
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260327    clang-20
x86_64      buildonly-randconfig-002-20260327    clang-20
x86_64      buildonly-randconfig-003-20260327    gcc-14
x86_64      buildonly-randconfig-004-20260327    clang-20
x86_64      buildonly-randconfig-005-20260327    gcc-14
x86_64      buildonly-randconfig-006-20260327    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260327    clang-20
x86_64                randconfig-002-20260327    clang-20
x86_64                randconfig-003-20260327    gcc-14
x86_64                randconfig-004-20260327    clang-20
x86_64                randconfig-005-20260327    gcc-14
x86_64                randconfig-006-20260327    gcc-14
x86_64                randconfig-071-20260327    clang-20
x86_64                randconfig-072-20260327    clang-20
x86_64                randconfig-073-20260327    clang-20
x86_64                randconfig-074-20260327    gcc-13
x86_64                randconfig-075-20260327    clang-20
x86_64                randconfig-076-20260327    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-001-20260327    gcc-14.3.0
xtensa                randconfig-002-20260327    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
