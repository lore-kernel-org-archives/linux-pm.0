Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8993E5EE3;
	Wed, 10 Jun 2026 10:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781086295; cv=none; b=DWdVzcbXP0bbYtgRRR/9HAy7VVxtYpUCtq8WjMt74vvkPVsYi/nf5xg/jLIT+G/UJCzCCUv7SGyOrLvNN6Ov95H/t+RT9CxiIzNIruoiP6+eXLioaUK/0YB0RWSdnFuCCTuEbw+MKlZafGWPKC6IX18iutlR1QPclrsrCrXjbbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781086295; c=relaxed/simple;
	bh=jk+5CodvWS8vMKEk4hr1Gpd+jUeusCfMoA/WEoiopmY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WFHioKG9iqUN9cm1lZaz4s1zHtyUO6u8XVQ6ZqtbcOQS0ziPAdGK69m5Bsts8nm2bZHF8QmrA89B/6gdZ8z5t+RmDSJOHOTJNGEkvmhWarKBaoO9HbPbQblf75uiVRAP4daE4ih24pXNhnZCMy4UssRX7IRERZD46iDzowXHBxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y5YB7xXo; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y5YB7xXo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781086293; x=1812622293;
  h=date:from:to:cc:subject:message-id;
  bh=jk+5CodvWS8vMKEk4hr1Gpd+jUeusCfMoA/WEoiopmY=;
  b=Y5YB7xXoIZPJ7/edFgdCew98g5uqSGY94g7u6GbbAA7+6NMzw3e1Y+Q5
   eTk8XDpvIFB22t1nm6/ZsZ4q9iiFd0edY1ZcrFUEiSo9/yL4X7uRibE/v
   o9/fTFqBjTdrIUpVNWvqnC4GcG62zYRahZ/hl3J/R9dZeJ2/rAEV37lN9
   mvPlzeaYHoKDJbEBgO+72fGFpl+GquZnCJfCfwQN8VPc4ZetqDoJJoC/v
   l+NFHwkpuCT0tClzL9dX1toeX1b+jugYJCYsLjqYg8x7sznB0Xfs3LIxm
   8LELTpB39CAkvqf7PClFi+LFVA90yqZJTgshcg2mukFH+/fHK7pprUTwx
   w==;
X-CSE-ConnectionGUID: gYW3U3bXQoyYfLAKEh04gA==
X-CSE-MsgGUID: pOJdz+JlQFS1jTNQ0dvZGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81878187"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="81878187"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 03:11:33 -0700
X-CSE-ConnectionGUID: DzRi2LABTvqXcMJvJqhtOg==
X-CSE-MsgGUID: bYvVWRcNQ0GBbu9QsbiJbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="241995185"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 10 Jun 2026 03:11:31 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wXFuC-00000000LH0-41dD;
	Wed, 10 Jun 2026 10:11:28 +0000
Date: Wed, 10 Jun 2026 18:10:41 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 92610ce13187e9289ab0f7ca7366e68c717a02a9
Message-ID: <202606101832.1ojrbJQN-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 92610ce13187e9289ab0f7ca7366e68c717a02a9  Merge branches 'pm-sleep' and 'pm-qos' into bleeding-edge

elapsed time: 958m

configs tested: 103
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    gcc-16.1.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                 randconfig-002-20260610    gcc-9.5.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                        randconfig-001    clang-23
hexagon               randconfig-001-20260610    clang-23
hexagon                        randconfig-002    clang-23
hexagon               randconfig-002-20260610    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-004-20260610    gcc-14
loongarch                         allnoconfig    clang-20
loongarch                      randconfig-001    clang-23
loongarch             randconfig-001-20260610    gcc-16.1.0
loongarch                      randconfig-002    gcc-16.1.0
loongarch             randconfig-002-20260610    gcc-16.1.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260610    gcc-11.5.0
nios2                          randconfig-002    gcc-8.5.0
nios2                 randconfig-002-20260610    gcc-11.5.0
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260610    gcc-8.5.0
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    gcc-16.1.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                 randconfig-001-20260610    gcc-15.2.0
riscv                 randconfig-002-20260610    gcc-8.5.0
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                  randconfig-001-20260610    clang-23
s390                  randconfig-002-20260610    clang-23
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    gcc-16.1.0
sh                    randconfig-001-20260610    gcc-16.1.0
sh                    randconfig-002-20260610    gcc-16.1.0
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                          randconfig-001    gcc-16.1.0
sparc                 randconfig-001-20260610    gcc-8.5.0
sparc                          randconfig-002    gcc-11.5.0
sparc                 randconfig-002-20260610    gcc-14.3.0
sparc64                          allmodconfig    clang-20
sparc64                        randconfig-001    gcc-12.5.0
sparc64               randconfig-001-20260610    gcc-12.5.0
sparc64                        randconfig-002    clang-20
sparc64               randconfig-002-20260610    clang-23
um                               allmodconfig    clang-23
um                                allnoconfig    clang-16
um                               allyesconfig    gcc-14
um                             randconfig-002    clang-23
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-22
x86_64               buildonly-randconfig-001    gcc-12
x86_64      buildonly-randconfig-001-20260610    clang-22
x86_64               buildonly-randconfig-002    clang-22
x86_64      buildonly-randconfig-002-20260610    gcc-14
x86_64               buildonly-randconfig-003    gcc-14
x86_64      buildonly-randconfig-003-20260610    clang-22
x86_64               buildonly-randconfig-004    gcc-14
x86_64      buildonly-randconfig-004-20260610    clang-22
x86_64               buildonly-randconfig-005    gcc-14
x86_64      buildonly-randconfig-005-20260610    gcc-14
x86_64               buildonly-randconfig-006    clang-22
x86_64      buildonly-randconfig-006-20260610    gcc-14
x86_64                randconfig-001-20260610    clang-22
x86_64                randconfig-002-20260610    clang-22
x86_64                randconfig-003-20260610    gcc-13
x86_64                randconfig-004-20260610    clang-22
x86_64                randconfig-005-20260610    clang-22
x86_64                randconfig-006-20260610    gcc-13
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    gcc-16.1.0
xtensa                         randconfig-001    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
