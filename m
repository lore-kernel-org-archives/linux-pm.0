Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C44390222;
	Wed, 11 Mar 2026 23:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773273450; cv=none; b=QfXw8opxUjXRpoI+I4bmnnv15t/LS/wbOBzx+q3UjnJ2UAKezaA9rkr5Fu1g2FNbUxJjZwxB4akvoz1aI9ruBXTryUcE6Fk7KGapK6FdQaBYvb5eYb+pEDd8bz1rtiVGly2lDQ9wAy3AX2aJz5KAJGc6APORr386M3Uy6l8oEO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773273450; c=relaxed/simple;
	bh=f1D4knyjoZVv14taE0mjW/o2w1dewn138ZI26G8cPTs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=udlQRcLE1HmzINeNc/DbEHyrkilo0yS3SCqnGxQXeaqVISJLhrm9VNlPNZDvBxv2NGD7tneWAP5QLS+Mdjfb8iAElymsMc0v9auvvVRaJqX1/qr4ZX3b4QlvwYdPtApWnKnXAd8gax2SR9UX46eJU+4d8/808lFmha/w/PwmF4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vu350LE2; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vu350LE2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773273448; x=1804809448;
  h=date:from:to:cc:subject:message-id;
  bh=f1D4knyjoZVv14taE0mjW/o2w1dewn138ZI26G8cPTs=;
  b=Vu350LE2BIKKWhlwPQTQuq1aTam4AeZxh3zoQEiMp+SxtG9NKFzxsevX
   GBKGtw0kiPzVHcxrNcJNnk3jyiD3KD36VgLikysYfw24tKEBGMq14hgW7
   qGaZ70a6YDPMcn9tNyyIPW9QOrpX2HM8TEDNnIanLTYPXE5D9HGS6fwkd
   gpiKMhqyMiS79HfOEGN54636VeEuenQytfbMm9DGPTztd80/Cclobf2qJ
   aLAPFtN59+Nlg2G2oIq6HoQMKzp0NAwXK0NpQbfz/i5nD7rooLXJLhza6
   NMS/FKB9kfcgIDuyRN/diYAxu8b0sdnRt7mMD/02akmxv5HBRHPlNcm+F
   A==;
X-CSE-ConnectionGUID: HX3Tag4FSIaniAL9+gKD0A==
X-CSE-MsgGUID: USZOJcNqQEWRxKfWip8GuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="73549696"
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="73549696"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 16:57:27 -0700
X-CSE-ConnectionGUID: oNGGZrdJTTCzXHMpjjt0eg==
X-CSE-MsgGUID: NmzWJmBGSzuFn9DtRyDobg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="217241681"
Received: from lkp-server01.sh.intel.com (HELO 418530b1a366) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 11 Mar 2026 16:57:26 -0700
Received: from kbuild by 418530b1a366 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w0TQZ-000000001qT-3VkA;
	Wed, 11 Mar 2026 23:57:23 +0000
Date: Thu, 12 Mar 2026 07:56:47 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 1ab2a7e1fcc8b8cd1118fd6a839600f95089a8d2
Message-ID: <202603120740.CiJeQ08y-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: 1ab2a7e1fcc8b8cd1118fd6a839600f95089a8d2  Merge branch 'acpi-osl-fixes' into fixes

elapsed time: 733m

configs tested: 181
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260311    gcc-8.5.0
arc                   randconfig-002-20260311    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260311    gcc-8.5.0
arm                   randconfig-002-20260311    gcc-8.5.0
arm                   randconfig-003-20260311    gcc-8.5.0
arm                   randconfig-004-20260311    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260312    clang-18
arm64                 randconfig-002-20260312    clang-18
arm64                 randconfig-003-20260312    clang-18
arm64                 randconfig-004-20260312    clang-18
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260312    clang-18
csky                  randconfig-002-20260312    clang-18
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260311    gcc-8.5.0
hexagon               randconfig-002-20260311    gcc-8.5.0
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260311    clang-20
i386        buildonly-randconfig-002-20260311    clang-20
i386        buildonly-randconfig-003-20260311    clang-20
i386        buildonly-randconfig-004-20260311    clang-20
i386        buildonly-randconfig-005-20260311    clang-20
i386        buildonly-randconfig-006-20260311    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260311    gcc-14
i386                  randconfig-002-20260311    gcc-14
i386                  randconfig-003-20260311    gcc-14
i386                  randconfig-004-20260311    gcc-14
i386                  randconfig-005-20260311    gcc-14
i386                  randconfig-006-20260311    gcc-14
i386                  randconfig-007-20260311    gcc-14
i386                  randconfig-011-20260312    clang-20
i386                  randconfig-012-20260312    clang-20
i386                  randconfig-013-20260312    clang-20
i386                  randconfig-014-20260312    clang-20
i386                  randconfig-015-20260312    clang-20
i386                  randconfig-016-20260312    clang-20
i386                  randconfig-017-20260312    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260311    gcc-8.5.0
loongarch             randconfig-002-20260311    gcc-8.5.0
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
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260311    gcc-8.5.0
nios2                 randconfig-002-20260311    gcc-8.5.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260311    clang-23
parisc                randconfig-002-20260311    clang-23
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260311    clang-23
powerpc               randconfig-002-20260311    clang-23
powerpc64             randconfig-001-20260311    clang-23
powerpc64             randconfig-002-20260311    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260311    gcc-15.2.0
riscv                 randconfig-002-20260311    gcc-15.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260311    gcc-15.2.0
s390                  randconfig-002-20260311    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                          landisk_defconfig    gcc-15.2.0
sh                    randconfig-001-20260311    gcc-15.2.0
sh                    randconfig-002-20260311    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260312    gcc-15.2.0
sparc                 randconfig-002-20260312    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260312    gcc-15.2.0
sparc64               randconfig-002-20260312    gcc-15.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260312    gcc-15.2.0
um                    randconfig-002-20260312    gcc-15.2.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260312    gcc-14
x86_64      buildonly-randconfig-002-20260312    gcc-14
x86_64      buildonly-randconfig-003-20260312    gcc-14
x86_64      buildonly-randconfig-004-20260312    gcc-14
x86_64      buildonly-randconfig-005-20260312    gcc-14
x86_64      buildonly-randconfig-006-20260312    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-011-20260311    gcc-13
x86_64                randconfig-012-20260311    gcc-13
x86_64                randconfig-013-20260311    gcc-13
x86_64                randconfig-014-20260311    gcc-13
x86_64                randconfig-015-20260311    gcc-13
x86_64                randconfig-016-20260311    gcc-13
x86_64                randconfig-071-20260311    gcc-14
x86_64                randconfig-072-20260311    gcc-14
x86_64                randconfig-073-20260311    gcc-14
x86_64                randconfig-074-20260311    gcc-14
x86_64                randconfig-075-20260311    gcc-14
x86_64                randconfig-076-20260311    gcc-14
x86_64                               rhel-9.4    gcc-14
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    gcc-14
x86_64                    rhel-9.4-kselftests    gcc-14
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260312    gcc-15.2.0
xtensa                randconfig-002-20260312    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
