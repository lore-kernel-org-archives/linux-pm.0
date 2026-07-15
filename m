Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C4A2C326D;
	Wed, 15 Jul 2026 14:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784124922; cv=none; b=W+SzSxq6+QIr7RNlLGlPDpCtLXus/ryMzPf+WFrULiVbbkI3l6UYSH01rRgzjr5gZKf+0FnFBycMTYgk0FaMrJYk6UDjyCnHxc4Ab+lQJCH5wzakOnGM9yAuefUGfvIA9t7+rRfrsSmNpht9nCoHY+QOcit897rDbNCUGSNRMX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784124922; c=relaxed/simple;
	bh=Omn96KtVTQGN5NBKZ6895SxXS9/bHuU2PTNIqlUhggM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=N8/S16J4KN/nkTze3UZxYNTn6lQwZ7ZpFzEZFHGOBPQDPlqL6m+U5RlF/ZVR8+k1rOcA9zSRza7tPuI3Hi7yMTOESuyTlPP1roOaxfT+kmeJt7ggRqLe6Ln7WQtT9GDLyBqD0giMiZPH9slf5z4xjA2uGlGquYFUtFlKYRSrNLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YEM1XSD5; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YEM1XSD5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784124920; x=1815660920;
  h=date:from:to:cc:subject:message-id;
  bh=Omn96KtVTQGN5NBKZ6895SxXS9/bHuU2PTNIqlUhggM=;
  b=YEM1XSD5/NFLM6lG9r67U50mXPJ2e7B8lH0OIz6Aqe+uHLvw/bKIPnG2
   Pcvw1U7Y4MvkA6ja+IDwv4+4KvA7uktxCqp89HUZu4mzGqpZAb3WGzIjm
   A3H/Zeow+S/Qv+MvcOgCepXMwvRS6Dg5SaZPF581nmFhi+Dqow3JiEq5E
   e6bLXqhICrQWc4HmOQeek5Ep4eQBxViBFUDrZ6Hj1k/EoAKIZosBmUcDp
   HdbdI1GmscOxEIIompAK4paZxDzYUmwYHfzhBcvu2LuchGvwYSqHmSAE/
   OfPCMIxWQmFlXD78+/hthE9etTnXx7ivgROpGhvWuMHaxCUBsfywPRHi9
   g==;
X-CSE-ConnectionGUID: 41p7RLH8RzGvdl4ytPzf/w==
X-CSE-MsgGUID: SQMDRHrXSqetUY6n8env3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="110310398"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="110310398"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 07:15:20 -0700
X-CSE-ConnectionGUID: oWuPvmt/S7CTavq7+xS+8g==
X-CSE-MsgGUID: gsvXb19lQ96niLsevtWVBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="260008761"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 15 Jul 2026 07:15:18 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wk0OJ-00000000Nhf-2IIb;
	Wed, 15 Jul 2026 14:15:15 +0000
Date: Wed, 15 Jul 2026 22:14:48 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 0e4eef86f0f4df58cb7526fdb968bb779fe66d81
Message-ID: <202607152236.xtEgWitX-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 0e4eef86f0f4df58cb7526fdb968bb779fe66d81  Merge branch 'thermal-intel' into bleeding-edge

elapsed time: 1113m

configs tested: 258
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-16.1.0
arc                            randconfig-001    gcc-10.5.0
arc                   randconfig-001-20260715    gcc-10.5.0
arc                            randconfig-002    gcc-10.5.0
arc                   randconfig-002-20260715    gcc-10.5.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                         bcm2835_defconfig    clang-17
arm                                 defconfig    gcc-16.1.0
arm                             pxa_defconfig    gcc-16.1.0
arm                            randconfig-001    gcc-10.5.0
arm                   randconfig-001-20260715    gcc-10.5.0
arm                            randconfig-002    gcc-10.5.0
arm                   randconfig-002-20260715    gcc-10.5.0
arm                            randconfig-003    gcc-10.5.0
arm                   randconfig-003-20260715    gcc-10.5.0
arm                            randconfig-004    gcc-10.5.0
arm                   randconfig-004-20260715    gcc-10.5.0
arm                         socfpga_defconfig    gcc-16.1.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                          randconfig-001    clang-23
arm64                 randconfig-001-20260715    clang-23
arm64                 randconfig-001-20260715    gcc-16.1.0
arm64                          randconfig-002    clang-23
arm64                 randconfig-002-20260715    clang-23
arm64                 randconfig-002-20260715    gcc-16.1.0
arm64                          randconfig-003    clang-23
arm64                 randconfig-003-20260715    gcc-16.1.0
arm64                          randconfig-004    clang-23
arm64                 randconfig-004-20260715    clang-23
arm64                 randconfig-004-20260715    gcc-16.1.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                           randconfig-001    clang-23
csky                  randconfig-001-20260715    clang-23
csky                  randconfig-001-20260715    gcc-16.1.0
csky                           randconfig-002    clang-23
csky                  randconfig-002-20260715    clang-23
csky                  randconfig-002-20260715    gcc-16.1.0
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260715    gcc-11.5.0
hexagon               randconfig-001-20260715    gcc-16.1.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260715    gcc-11.5.0
hexagon               randconfig-002-20260715    gcc-16.1.0
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                             allyesconfig    gcc-14
i386                 buildonly-randconfig-001    clang-22
i386        buildonly-randconfig-001-20260715    clang-22
i386                 buildonly-randconfig-002    clang-22
i386        buildonly-randconfig-002-20260715    clang-22
i386                 buildonly-randconfig-003    clang-22
i386        buildonly-randconfig-003-20260715    clang-22
i386                 buildonly-randconfig-004    clang-22
i386        buildonly-randconfig-004-20260715    clang-22
i386                 buildonly-randconfig-005    clang-22
i386        buildonly-randconfig-005-20260715    clang-22
i386                 buildonly-randconfig-006    clang-22
i386        buildonly-randconfig-006-20260715    clang-22
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260715    clang-22
i386                  randconfig-002-20260715    clang-22
i386                  randconfig-003-20260715    clang-22
i386                  randconfig-004-20260715    clang-22
i386                  randconfig-005-20260715    clang-22
i386                  randconfig-006-20260715    clang-22
i386                  randconfig-007-20260715    clang-22
i386                           randconfig-011    gcc-14
i386                  randconfig-011-20260715    gcc-14
i386                           randconfig-012    gcc-14
i386                  randconfig-012-20260715    gcc-14
i386                           randconfig-013    gcc-14
i386                  randconfig-013-20260715    gcc-14
i386                           randconfig-014    gcc-14
i386                  randconfig-014-20260715    gcc-14
i386                           randconfig-015    gcc-14
i386                  randconfig-015-20260715    gcc-14
i386                           randconfig-016    gcc-14
i386                  randconfig-016-20260715    gcc-14
i386                           randconfig-017    gcc-14
i386                  randconfig-017-20260715    gcc-14
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260715    gcc-11.5.0
loongarch             randconfig-001-20260715    gcc-16.1.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260715    gcc-11.5.0
loongarch             randconfig-002-20260715    gcc-16.1.0
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
mips                      maltaaprp_defconfig    clang-17
nios2                            allmodconfig    clang-20
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260715    gcc-11.5.0
nios2                 randconfig-001-20260715    gcc-16.1.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260715    gcc-11.5.0
nios2                 randconfig-002-20260715    gcc-16.1.0
openrisc                         allmodconfig    clang-20
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    clang-17
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260715    clang-23
parisc                randconfig-002-20260715    clang-23
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc                 linkstation_defconfig    clang-23
powerpc               randconfig-001-20260715    clang-23
powerpc               randconfig-002-20260715    clang-23
powerpc64             randconfig-001-20260715    clang-23
powerpc64             randconfig-002-20260715    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                 randconfig-001-20260715    gcc-15.2.0
riscv                 randconfig-002-20260715    gcc-15.2.0
s390                             allmodconfig    clang-17
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260715    gcc-15.2.0
s390                  randconfig-002-20260715    gcc-15.2.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260715    gcc-15.2.0
sh                    randconfig-002-20260715    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                          randconfig-001    gcc-16.1.0
sparc                 randconfig-001-20260715    gcc-16.1.0
sparc                          randconfig-002    gcc-16.1.0
sparc                 randconfig-002-20260715    gcc-16.1.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-16.1.0
sparc64               randconfig-001-20260715    gcc-16.1.0
sparc64                        randconfig-002    gcc-16.1.0
sparc64               randconfig-002-20260715    gcc-16.1.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    gcc-16.1.0
um                    randconfig-001-20260715    gcc-16.1.0
um                             randconfig-002    gcc-16.1.0
um                    randconfig-002-20260715    gcc-16.1.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64               buildonly-randconfig-001    gcc-14
x86_64      buildonly-randconfig-001-20260715    gcc-14
x86_64               buildonly-randconfig-002    gcc-14
x86_64      buildonly-randconfig-002-20260715    gcc-14
x86_64               buildonly-randconfig-003    gcc-14
x86_64      buildonly-randconfig-003-20260715    gcc-14
x86_64               buildonly-randconfig-004    gcc-14
x86_64      buildonly-randconfig-004-20260715    gcc-14
x86_64               buildonly-randconfig-005    gcc-14
x86_64      buildonly-randconfig-005-20260715    gcc-14
x86_64               buildonly-randconfig-006    gcc-14
x86_64      buildonly-randconfig-006-20260715    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260715    clang-22
x86_64                randconfig-002-20260715    clang-22
x86_64                randconfig-003-20260715    clang-22
x86_64                randconfig-004-20260715    clang-22
x86_64                randconfig-005-20260715    clang-22
x86_64                randconfig-006-20260715    clang-22
x86_64                         randconfig-011    clang-22
x86_64                randconfig-011-20260715    clang-22
x86_64                         randconfig-012    clang-22
x86_64                randconfig-012-20260715    clang-22
x86_64                         randconfig-013    clang-22
x86_64                randconfig-013-20260715    clang-22
x86_64                         randconfig-014    clang-22
x86_64                randconfig-014-20260715    clang-22
x86_64                         randconfig-015    clang-22
x86_64                randconfig-015-20260715    clang-22
x86_64                         randconfig-016    clang-22
x86_64                randconfig-016-20260715    clang-22
x86_64                randconfig-071-20260715    gcc-14
x86_64                randconfig-072-20260715    gcc-14
x86_64                randconfig-073-20260715    gcc-14
x86_64                randconfig-074-20260715    gcc-14
x86_64                randconfig-075-20260715    gcc-14
x86_64                randconfig-076-20260715    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                               rhel-9.4    gcc-14
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                          rhel-9.4-func    gcc-14
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                    rhel-9.4-kselftests    gcc-14
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    clang-20
xtensa                           allyesconfig    gcc-16.1.0
xtensa                generic_kc705_defconfig    gcc-16.1.0
xtensa                          iss_defconfig    gcc-16.1.0
xtensa                         randconfig-001    gcc-16.1.0
xtensa                randconfig-001-20260715    gcc-16.1.0
xtensa                         randconfig-002    gcc-16.1.0
xtensa                randconfig-002-20260715    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
