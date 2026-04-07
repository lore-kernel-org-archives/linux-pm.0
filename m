Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EB82C326D;
	Tue,  7 Apr 2026 19:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775588409; cv=none; b=epa2ZWp/ohBukM5Rd4XpI49QoOzJl7Ty1cTd9Ah8n3YJeKE6rZvVQOTcDDSj8ACsk0xJuyF3WiaBaLBU5mbmHQtUnl1/MubqKkPPPDtCZ+4eL8aJhXibV29/XlUn2YutjuI69Q576j2sjmoJhw1cHby+jk8bq/FDladwo/1iXss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775588409; c=relaxed/simple;
	bh=55gfgfhdrLtTEC8pAEXIj2w50uQlUoe7K/F59JnwjVA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=E0ke86uj07KQl+kxLQb27ruwzyUxnGUehf+vxX1j3sJnXO3OAjxm9MaatTf6mFioEAyiR3fn8XU74DljlinVClY1ew/qKDYLe2XliF/ZWLDsMWUD4OUSOUsmjwt1WHh1qX256pab6vl2m0EafhinY6Ha4We0tmenMFH6OouwDe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YQOO00Cr; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YQOO00Cr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775588408; x=1807124408;
  h=date:from:to:cc:subject:message-id;
  bh=55gfgfhdrLtTEC8pAEXIj2w50uQlUoe7K/F59JnwjVA=;
  b=YQOO00CrU6IYELtJ0OQwCh7o72sXqYaFppmf5tTFO7nUR2uODtnPYvPS
   SEkcBsteEdy72yoCdCWvGT0X93f+ms0Y2adiwNY/Qd8LOeldJmDuEaeSU
   bpO2Y1OMyyD8kSLh3FWgoIlJfCF18Sxxbb2MYsT2MwXMFbwuIkM7VrVF6
   fLdPmniytxcEyFp6+neNKJFEDjQPMTgCXJ5DgWXB0Ymqmk1C5w3PmGb6a
   yykYIG5lCPVnPP5oevqHzN2qAQb6NDH5gUvALfsOsYH/umyoeoiPVPIut
   UJuD5CfqfBTb2Gy/Jr6ufJ+y4Y4rhAlog9qIgHswhGBKFwEPOQtc7oNXB
   A==;
X-CSE-ConnectionGUID: ItTOsb6hQby9KBPnyn2i3g==
X-CSE-MsgGUID: vNKP0b9SRCupz4NUO6db/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="87262791"
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="87262791"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 12:00:07 -0700
X-CSE-ConnectionGUID: BrKzTxpmQCCUaejVsWV1hA==
X-CSE-MsgGUID: z1sL31IDQoCIwJo31fWwKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="228157540"
Received: from lkp-server01.sh.intel.com (HELO d00eb8a6782a) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 07 Apr 2026 12:00:05 -0700
Received: from kbuild by d00eb8a6782a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wABec-000000000wP-3El7;
	Tue, 07 Apr 2026 19:00:02 +0000
Date: Wed, 08 Apr 2026 02:59:24 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 7bbddc5f2768eb97b02e81babd9f8ee0c502dd76
Message-ID: <202604080215.WFfPI8lp-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 7bbddc5f2768eb97b02e81babd9f8ee0c502dd76  Merge branch 'acpi-cpu-uid' into bleeding-edge

elapsed time: 1231m

configs tested: 153
configs skipped: 10

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
arc                   randconfig-001-20260407    gcc-11.5.0
arc                   randconfig-002-20260407    gcc-9.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                   randconfig-001-20260407    gcc-12.5.0
arm                   randconfig-003-20260407    gcc-10.5.0
arm                   randconfig-004-20260407    clang-20
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260407    clang-16
arm64                 randconfig-002-20260407    gcc-13.4.0
arm64                 randconfig-003-20260407    gcc-8.5.0
arm64                 randconfig-004-20260407    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260407    gcc-13.4.0
csky                  randconfig-002-20260407    gcc-9.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260407    clang-19
hexagon               randconfig-002-20260407    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20260407    gcc-14
i386        buildonly-randconfig-002-20260407    gcc-14
i386        buildonly-randconfig-003-20260407    clang-20
i386        buildonly-randconfig-004-20260407    clang-20
i386        buildonly-randconfig-005-20260407    gcc-14
i386        buildonly-randconfig-006-20260407    clang-20
i386                                defconfig    clang-20
i386                  randconfig-002-20260407    gcc-14
i386                  randconfig-004-20260407    gcc-14
i386                  randconfig-005-20260407    clang-20
i386                  randconfig-006-20260407    gcc-14
i386                  randconfig-007-20260407    gcc-14
i386                  randconfig-011-20260407    gcc-14
i386                  randconfig-012-20260407    clang-20
i386                  randconfig-013-20260407    clang-20
i386                  randconfig-014-20260407    clang-20
i386                  randconfig-015-20260407    gcc-14
i386                  randconfig-016-20260407    clang-20
i386                  randconfig-017-20260407    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch             randconfig-001-20260407    clang-23
loongarch             randconfig-002-20260407    gcc-15.2.0
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
nios2                 randconfig-001-20260407    gcc-11.5.0
nios2                 randconfig-002-20260407    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260407    gcc-8.5.0
parisc                randconfig-002-20260407    gcc-8.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260407    gcc-13.4.0
powerpc               randconfig-002-20260407    gcc-8.5.0
powerpc                     tqm5200_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260407    gcc-12.5.0
powerpc64             randconfig-002-20260407    gcc-10.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260407    clang-23
riscv                 randconfig-002-20260407    gcc-12.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-001-20260407    gcc-14.3.0
s390                  randconfig-002-20260407    clang-20
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260407    gcc-13.4.0
sh                    randconfig-002-20260407    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260407    gcc-15.2.0
sparc                 randconfig-002-20260407    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260407    clang-23
sparc64               randconfig-002-20260407    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260407    gcc-12
um                    randconfig-002-20260407    gcc-14
um                           x86_64_defconfig    clang-23
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20260407    gcc-14
x86_64      buildonly-randconfig-002-20260407    gcc-14
x86_64      buildonly-randconfig-003-20260407    gcc-14
x86_64      buildonly-randconfig-004-20260407    clang-20
x86_64      buildonly-randconfig-005-20260407    gcc-14
x86_64      buildonly-randconfig-006-20260407    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260407    clang-20
x86_64                randconfig-002-20260407    clang-20
x86_64                randconfig-003-20260407    clang-20
x86_64                randconfig-004-20260407    gcc-14
x86_64                randconfig-005-20260407    gcc-14
x86_64                randconfig-006-20260407    gcc-14
x86_64                randconfig-011-20260407    gcc-14
x86_64                randconfig-012-20260407    clang-20
x86_64                randconfig-013-20260407    clang-20
x86_64                randconfig-014-20260407    clang-20
x86_64                randconfig-015-20260407    gcc-14
x86_64                randconfig-016-20260407    gcc-14
x86_64                randconfig-071-20260407    clang-20
x86_64                randconfig-072-20260407    clang-20
x86_64                randconfig-073-20260407    clang-20
x86_64                randconfig-074-20260407    clang-20
x86_64                randconfig-075-20260407    clang-20
x86_64                randconfig-076-20260407    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-001-20260407    gcc-12.5.0
xtensa                randconfig-002-20260407    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
