Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C0C397E81;
	Wed, 24 Jun 2026 07:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782285804; cv=none; b=ULo55SuJefhtnGJ2E1jAUPBASWqJEvKOQ/xmo3dUy+KKcXHw/B8KX0swPdUyvqLC5QWILatsafNKYyYG9ICues115ts11NLm3N0HkZIp+pAsW/ChpMYhgPL0LYIEPYO/MTO08V98L1NvHEPEkg4iFXfZF8+TlSXFmaF5GC7IHlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782285804; c=relaxed/simple;
	bh=xLxwgvoXGRC3iTr0jRuckGQyYFRwBYzzErgK26oOaKQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZAsZrW3aekebjKSl8ZS733z/cHpXc+sDcuvUCzXabaGPBJp9IVDDOKu0i2hUwK/vXI9pZkk60hPaVRssZQ2JswF+vpJ0bDKl/P5QLRbV7GPWU8VFtQQ98Ubb6yIF7psyNqw6g1DwoheM8rf+J3IdSrX5HhH7fO2c8OzjzGzD+Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ly+37W75; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ly+37W75"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782285801; x=1813821801;
  h=date:from:to:cc:subject:message-id;
  bh=xLxwgvoXGRC3iTr0jRuckGQyYFRwBYzzErgK26oOaKQ=;
  b=Ly+37W75gMWZXAhUBplZxjZ4g0N9SCPkpkM6rOEk3GtQhMEmDdWB2a4H
   JNTq0nMIiIrd9G9L2mCRxJzBu6URBUvBQH9RDpO0jnfgzEDq0wovMTBwi
   e0l2MjNRdpQhOxwG+R4l0sUZxEncVo3v5WQ4837D7Y0f2uqAqhBq8bpzE
   hhZrE6zEBWz1cNG05+N6tCH6z9WZchQZ4LQUDP/RJDInz9uFrDPag4mOa
   gwEn6a9sOaTNZSKnICCPRUPAQSoUpom96JnN7+TEI+W6ikEiFSEOQlsfg
   U3V7XcgAgMjacuiNuAC3E16D3iZCx9pa200GKOhMYypqAaYOGPyYk1pHa
   Q==;
X-CSE-ConnectionGUID: t4ziph32QG6GFgG0y92LAQ==
X-CSE-MsgGUID: tUK5UbbqSAKV9+J3NfvDEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="86943292"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="86943292"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 00:23:03 -0700
X-CSE-ConnectionGUID: 9hNHnwIpRSKxJZIUUwdyow==
X-CSE-MsgGUID: mz3IZqGgTCGTLRd+OR/6+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="273452402"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 24 Jun 2026 00:23:02 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wcHwm-000000003CL-3FmC;
	Wed, 24 Jun 2026 07:22:57 +0000
Date: Wed, 24 Jun 2026 15:22:14 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 ee41842fdfd5e0869c3be2637461b2d47775e9e6
Message-ID: <202606241503.6TDDFpar-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: ee41842fdfd5e0869c3be2637461b2d47775e9e6  Merge branch 'experimental/acpi-driver-work' into bleeding-edge

elapsed time: 837m

configs tested: 247
configs skipped: 3

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
arc                            randconfig-001    gcc-8.5.0
arc                   randconfig-001-20260624    gcc-15.2.0
arc                   randconfig-001-20260624    gcc-9.5.0
arc                            randconfig-002    gcc-8.5.0
arc                   randconfig-002-20260624    gcc-15.2.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    gcc-16.1.0
arm                            randconfig-001    gcc-16.1.0
arm                   randconfig-001-20260624    clang-19
arm                   randconfig-001-20260624    gcc-15.2.0
arm                            randconfig-002    gcc-15.2.0
arm                   randconfig-002-20260624    gcc-15.2.0
arm                   randconfig-002-20260624    gcc-8.5.0
arm                            randconfig-003    clang-23
arm                   randconfig-003-20260624    gcc-15.2.0
arm                            randconfig-004    gcc-13.4.0
arm                   randconfig-004-20260624    clang-17
arm                   randconfig-004-20260624    gcc-15.2.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260624    clang-21
arm64                 randconfig-002-20260624    clang-21
arm64                 randconfig-002-20260624    gcc-15.2.0
arm64                 randconfig-003-20260624    clang-21
arm64                 randconfig-003-20260624    clang-23
arm64                 randconfig-004-20260624    clang-21
arm64                 randconfig-004-20260624    clang-23
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260624    clang-21
csky                  randconfig-001-20260624    gcc-16.1.0
csky                  randconfig-002-20260624    clang-21
csky                  randconfig-002-20260624    gcc-9.5.0
hexagon                          allmodconfig    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260624    gcc-9.5.0
hexagon               randconfig-002-20260624    gcc-9.5.0
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    gcc-14
i386                 buildonly-randconfig-001    gcc-12
i386        buildonly-randconfig-001-20260624    gcc-12
i386        buildonly-randconfig-001-20260624    gcc-14
i386                 buildonly-randconfig-002    gcc-12
i386        buildonly-randconfig-002-20260624    gcc-12
i386        buildonly-randconfig-002-20260624    gcc-14
i386                 buildonly-randconfig-003    gcc-12
i386        buildonly-randconfig-003-20260624    gcc-12
i386                 buildonly-randconfig-004    gcc-12
i386        buildonly-randconfig-004-20260624    gcc-12
i386        buildonly-randconfig-004-20260624    gcc-14
i386                 buildonly-randconfig-005    gcc-12
i386        buildonly-randconfig-005-20260624    gcc-12
i386        buildonly-randconfig-005-20260624    gcc-14
i386                 buildonly-randconfig-006    gcc-12
i386        buildonly-randconfig-006-20260624    gcc-12
i386        buildonly-randconfig-006-20260624    gcc-14
i386                                defconfig    gcc-16.1.0
i386                           randconfig-001    clang-22
i386                  randconfig-001-20260624    clang-22
i386                           randconfig-002    clang-22
i386                  randconfig-002-20260624    clang-22
i386                           randconfig-003    clang-22
i386                  randconfig-003-20260624    clang-22
i386                           randconfig-004    clang-22
i386                  randconfig-004-20260624    clang-22
i386                           randconfig-005    clang-22
i386                  randconfig-005-20260624    clang-22
i386                           randconfig-006    clang-22
i386                  randconfig-006-20260624    clang-22
i386                           randconfig-007    clang-22
i386                  randconfig-007-20260624    clang-22
i386                  randconfig-011-20260624    clang-22
i386                  randconfig-012-20260624    clang-22
i386                  randconfig-013-20260624    clang-22
i386                  randconfig-014-20260624    clang-22
i386                  randconfig-015-20260624    clang-22
i386                  randconfig-016-20260624    clang-22
i386                  randconfig-017-20260624    clang-22
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260624    gcc-9.5.0
loongarch             randconfig-002-20260624    gcc-9.5.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    clang-23
m68k                                defconfig    gcc-16.1.0
m68k                        stmark2_defconfig    gcc-16.1.0
m68k                          sun3x_defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
microblaze                          defconfig    gcc-16.1.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260624    gcc-9.5.0
nios2                 randconfig-002-20260624    gcc-9.5.0
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
parisc                randconfig-001-20260624    gcc-16.1.0
parisc                randconfig-002-20260624    gcc-16.1.0
parisc64                            defconfig    clang-23
parisc64                            defconfig    gcc-16.1.0
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc                     asp8347_defconfig    clang-23
powerpc                        fsp2_defconfig    gcc-16.1.0
powerpc               randconfig-001-20260624    gcc-16.1.0
powerpc               randconfig-002-20260624    gcc-16.1.0
powerpc64             randconfig-001-20260624    gcc-16.1.0
powerpc64             randconfig-002-20260624    gcc-16.1.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                 randconfig-001-20260624    clang-18
riscv                 randconfig-002-20260624    clang-18
s390                             allmodconfig    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    clang-18
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260624    clang-18
s390                  randconfig-002-20260624    clang-18
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-16.1.0
sh                    randconfig-001-20260624    clang-18
sh                    randconfig-002-20260624    clang-18
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260624    gcc-14.3.0
sparc                 randconfig-002-20260624    gcc-14.3.0
sparc                       sparc32_defconfig    gcc-16.1.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260624    gcc-14.3.0
sparc64               randconfig-002-20260624    gcc-14.3.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    clang-23
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260624    gcc-14.3.0
um                    randconfig-002-20260624    gcc-14.3.0
um                           x86_64_defconfig    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260624    clang-22
x86_64      buildonly-randconfig-002-20260624    clang-22
x86_64      buildonly-randconfig-003-20260624    clang-22
x86_64      buildonly-randconfig-004-20260624    clang-22
x86_64      buildonly-randconfig-005-20260624    clang-22
x86_64      buildonly-randconfig-006-20260624    clang-22
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260624    clang-22
x86_64                randconfig-002-20260624    clang-22
x86_64                randconfig-003-20260624    clang-22
x86_64                randconfig-004-20260624    clang-22
x86_64                randconfig-004-20260624    gcc-14
x86_64                randconfig-005-20260624    clang-22
x86_64                randconfig-006-20260624    clang-22
x86_64                randconfig-006-20260624    gcc-14
x86_64                randconfig-011-20260624    gcc-14
x86_64                randconfig-012-20260624    gcc-14
x86_64                randconfig-013-20260624    gcc-14
x86_64                randconfig-014-20260624    gcc-14
x86_64                randconfig-015-20260624    gcc-14
x86_64                randconfig-016-20260624    gcc-14
x86_64                randconfig-071-20260624    gcc-14
x86_64                randconfig-072-20260624    clang-22
x86_64                randconfig-072-20260624    gcc-14
x86_64                randconfig-073-20260624    gcc-14
x86_64                randconfig-074-20260624    clang-22
x86_64                randconfig-074-20260624    gcc-14
x86_64                randconfig-075-20260624    gcc-14
x86_64                randconfig-076-20260624    clang-22
x86_64                randconfig-076-20260624    gcc-14
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
xtensa                           allyesconfig    gcc-16.1.0
xtensa                randconfig-001-20260624    gcc-14.3.0
xtensa                randconfig-002-20260624    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
