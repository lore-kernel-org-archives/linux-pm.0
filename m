Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DDD34AB01;
	Tue, 23 Jun 2026 02:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782183554; cv=none; b=HX7SulbFWbfn/oPSxPHTlDrZ+KaoOfIOddpEUN55jOX5nOwugHXhOBaqdcUCuMghybS6kpmC+MMLzPcp7qsd0fw6DTgLs8p7e7YUxc6xy08lN+ocF3QV5t3mgybLYYlRnjxttadYND861vBXWzN1tQgDkPimwdG1N/q+8gsIjZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782183554; c=relaxed/simple;
	bh=NNPMyuJUEU3eGm1aqq1fozhL8f0daY6CybNfh06DuNQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hC6HiQlw7bICWVupHV93h2f+fHYcKzKisjTKSJ4lvZS6h8IURADIBuHCev/BY46sPafqxGQtsqy3nOQy4AVJj+Eoz/St7bhJpUyKh6P5/xe6fZGQ9Iw4ZgvC5ZhJ24KQSWTFRrqcFZMMxjlRDLbbRvBn1hckv4Fo1/LpMl5H8m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LkIhNyC1; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LkIhNyC1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782183551; x=1813719551;
  h=date:from:to:cc:subject:message-id;
  bh=NNPMyuJUEU3eGm1aqq1fozhL8f0daY6CybNfh06DuNQ=;
  b=LkIhNyC1m06cGQcUXe2ByTUMY0rgs+AIUCrpbXdMb/6CZcnooBsAWmX3
   uwNLLerp9l2jls49nabOCMtZk+MwgPs7sauivnO44tqalfIsUWv/7/OBQ
   eDdAmV3eAiRYq1a78vs0RGNsfR63gpdXAxCL/m+TZCRWEXfcM/2GQcGOk
   fIHolU/LJhZNi9olZ+JMQdRoDaCNiDjAXSNB0T0V3UAkeoJAzEM1gf9ld
   Lueh7kxkG/aaAlJQSeugO5Uudo5MELx5OyQeLD+ZNLxI3xssaE0BDQ6fO
   QvymMeBQ3O/XZGwwA3OxWWYJj++qNWFGBiPEIFsjTkeKBeiUNJqosXmxi
   w==;
X-CSE-ConnectionGUID: JHYAAs0cQlqmjQZL6EbFow==
X-CSE-MsgGUID: Sdjbgh3sSGWxxxXYsplxFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="93510602"
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="93510602"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 19:59:11 -0700
X-CSE-ConnectionGUID: 2A7nVeufSiGXXpHrrnIvXw==
X-CSE-MsgGUID: Tned0mAvTcWzZ/ZZwJb+GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="243031629"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 22 Jun 2026 19:59:09 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wbrLs-000000002Bh-2q5C;
	Tue, 23 Jun 2026 02:59:05 +0000
Date: Tue, 23 Jun 2026 10:58:09 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 79e641eccecb1955cba74766fee8dad64d9d5574
Message-ID: <202606231058.evfgPfWF-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 79e641eccecb1955cba74766fee8dad64d9d5574  Merge branch 'experimental/acpi-driver-work' into bleeding-edge

elapsed time: 1398m

configs tested: 188
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260622    gcc-8.5.0
arc                   randconfig-002-20260622    gcc-8.5.0
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                                 defconfig    gcc-16.1.0
arm                   randconfig-001-20260622    gcc-8.5.0
arm                   randconfig-002-20260622    gcc-8.5.0
arm                   randconfig-003-20260622    gcc-8.5.0
arm                   randconfig-004-20260622    gcc-8.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260622    gcc-8.5.0
arm64                 randconfig-002-20260622    gcc-8.5.0
arm64                 randconfig-003-20260622    gcc-8.5.0
arm64                 randconfig-004-20260622    gcc-8.5.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260622    gcc-8.5.0
csky                  randconfig-002-20260622    gcc-8.5.0
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260622    gcc-11.5.0
hexagon               randconfig-001-20260622    gcc-8.5.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260622    gcc-11.5.0
hexagon               randconfig-002-20260622    gcc-8.5.0
i386                             allmodconfig    clang-22
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386        buildonly-randconfig-001-20260622    gcc-14
i386        buildonly-randconfig-002-20260622    gcc-14
i386        buildonly-randconfig-003-20260622    gcc-14
i386        buildonly-randconfig-004-20260622    gcc-14
i386        buildonly-randconfig-005-20260622    gcc-14
i386        buildonly-randconfig-006-20260622    gcc-14
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260622    clang-22
i386                  randconfig-002-20260622    clang-22
i386                  randconfig-003-20260622    clang-22
i386                  randconfig-004-20260622    clang-22
i386                  randconfig-005-20260622    clang-22
i386                  randconfig-006-20260622    clang-22
i386                  randconfig-007-20260622    clang-22
i386                  randconfig-011-20260622    gcc-14
i386                  randconfig-012-20260622    gcc-14
i386                  randconfig-013-20260622    gcc-14
i386                  randconfig-014-20260622    gcc-14
i386                  randconfig-015-20260622    gcc-14
i386                  randconfig-016-20260622    gcc-14
i386                  randconfig-017-20260622    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260622    gcc-11.5.0
loongarch             randconfig-001-20260622    gcc-8.5.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260622    gcc-11.5.0
loongarch             randconfig-002-20260622    gcc-8.5.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                                defconfig    clang-23
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                        qi_lb60_defconfig    clang-17
nios2                            allmodconfig    clang-20
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-23
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260622    gcc-11.5.0
nios2                 randconfig-001-20260622    gcc-8.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260622    gcc-11.5.0
nios2                 randconfig-002-20260622    gcc-8.5.0
openrisc                         allmodconfig    clang-20
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-17
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260622    gcc-14.3.0
parisc                randconfig-002-20260622    gcc-14.3.0
parisc64                            defconfig    clang-23
powerpc                     akebono_defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc               randconfig-001-20260622    gcc-14.3.0
powerpc               randconfig-002-20260622    gcc-14.3.0
powerpc64             randconfig-001-20260622    gcc-14.3.0
powerpc64             randconfig-002-20260622    gcc-14.3.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                 randconfig-001-20260622    clang-17
s390                             allmodconfig    clang-17
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260622    clang-17
s390                  randconfig-002-20260622    clang-17
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-17
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260622    clang-17
sh                    randconfig-002-20260622    clang-17
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260622    gcc-16.1.0
sparc                 randconfig-002-20260622    gcc-16.1.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260622    gcc-16.1.0
sparc64               randconfig-002-20260622    gcc-16.1.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260622    gcc-16.1.0
um                    randconfig-002-20260622    gcc-16.1.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64               buildonly-randconfig-001    clang-22
x86_64      buildonly-randconfig-001-20260622    clang-22
x86_64               buildonly-randconfig-002    clang-22
x86_64      buildonly-randconfig-002-20260622    clang-22
x86_64               buildonly-randconfig-003    clang-22
x86_64      buildonly-randconfig-003-20260622    clang-22
x86_64               buildonly-randconfig-004    clang-22
x86_64      buildonly-randconfig-004-20260622    clang-22
x86_64               buildonly-randconfig-005    clang-22
x86_64      buildonly-randconfig-005-20260622    clang-22
x86_64               buildonly-randconfig-006    clang-22
x86_64      buildonly-randconfig-006-20260622    clang-22
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260622    clang-22
x86_64                randconfig-002-20260622    clang-22
x86_64                randconfig-003-20260622    clang-22
x86_64                randconfig-004-20260622    clang-22
x86_64                randconfig-005-20260622    clang-22
x86_64                randconfig-006-20260622    clang-22
x86_64                randconfig-011-20260622    clang-22
x86_64                randconfig-012-20260622    clang-22
x86_64                randconfig-013-20260622    clang-22
x86_64                randconfig-014-20260622    clang-22
x86_64                randconfig-015-20260622    clang-22
x86_64                randconfig-016-20260622    clang-22
x86_64                randconfig-071-20260622    gcc-14
x86_64                randconfig-072-20260622    gcc-14
x86_64                randconfig-073-20260622    gcc-14
x86_64                randconfig-074-20260622    gcc-14
x86_64                randconfig-075-20260622    gcc-14
x86_64                randconfig-076-20260622    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-20
xtensa                randconfig-001-20260622    gcc-16.1.0
xtensa                randconfig-002-20260622    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
