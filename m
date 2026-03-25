Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE3C3A1D05;
	Wed, 25 Mar 2026 10:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774433781; cv=none; b=py2hyeVSJAGCzjLI+dGGBQeE65JxGFoVqbtfZv2ovVqOYQ2jexulbIGs0D5aUzqqpO4nwVpOavqewRD0bvgnlMtJvyHRI0yK21Y1qsbs/NFThkSj1GZlK6/4ASUya6EooNOJygKKeoxsjzdz5ukRGNabEApelZyvX2bv2F0KhH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774433781; c=relaxed/simple;
	bh=J1W/W6dgugIFTw8lc+XnBxr8W9IvNju4+ItfTBX6Hyk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=EeaG7cETxd1Zq4w6jP9SgCVykXMDlwo0rqHvdRYH+JeMpcKw7DPiB+upWCabKfkZWBeyc4d7CPOuBO8DZdi5+Vzx5Chr9ePJ1AOUxoEl5VSb1iZ98eH4xR1aJ7AzLXUCYX+ibJHTx/dXoOu0yL/gwXj3GJQZcz2fFkizey9dT9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ntO5bAju; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ntO5bAju"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774433780; x=1805969780;
  h=date:from:to:cc:subject:message-id;
  bh=J1W/W6dgugIFTw8lc+XnBxr8W9IvNju4+ItfTBX6Hyk=;
  b=ntO5bAjuFuk6poymIvfAvpYfVcJv1P54+H8t28wEJv9qndF6e7rQgbXt
   NGYEFBAE0XPnvF6FHGkGYa6Lp57cHzijDbEEy+eKIsxAQZl3R05if/OfL
   8NGXXGJ5oFXpvqQUs6n6dr4QyGkn1A1zoExoq51fAETZ9mxPP5LKtYvgU
   qO98J4FRXQBEgy31Qh9iZBt8iveJ+U3yk4/k3ODCinpIHh6Mc8GgQ/xka
   BH2KTOF2lXjRqIALSJ5rnygT0Iuji+rKuFORnPWn+h6C8q4BJ/OBYo+N5
   BKc8vrk+7n8jcxeR24AXEsj2lO08MTKOoKvXYESH6wKxu7r1SWmdvBMqx
   A==;
X-CSE-ConnectionGUID: mnejOEFyRQqGD9fRjrLDDw==
X-CSE-MsgGUID: uSGXP/ugSKyJMWo6qsSLEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="75488606"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="75488606"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 03:16:20 -0700
X-CSE-ConnectionGUID: ShJuyI4OQGmEPQEFMN9r1Q==
X-CSE-MsgGUID: aJWeaUsuSoay1v/0XcKlcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="224894166"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 25 Mar 2026 03:16:18 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w5LHb-000000006cD-1yli;
	Wed, 25 Mar 2026 10:16:15 +0000
Date: Wed, 25 Mar 2026 18:15:25 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 4354f16141fb93bdea922285dfbdbe997cdfba15
Message-ID: <202603251817.F3wuNlcb-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: 4354f16141fb93bdea922285dfbdbe997cdfba15  Merge branch 'thermal-intel-fixes' into fixes

elapsed time: 939m

configs tested: 176
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
arc                   randconfig-001-20260325    gcc-8.5.0
arc                   randconfig-002-20260325    gcc-8.5.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                       netwinder_defconfig    gcc-15.2.0
arm                           omap1_defconfig    gcc-15.2.0
arm                   randconfig-001-20260325    gcc-8.5.0
arm                   randconfig-002-20260325    gcc-8.5.0
arm                   randconfig-003-20260325    gcc-8.5.0
arm                   randconfig-004-20260325    gcc-8.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260325    clang-23
arm64                 randconfig-002-20260325    clang-23
arm64                 randconfig-003-20260325    clang-23
arm64                 randconfig-004-20260325    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260325    clang-23
csky                  randconfig-002-20260325    clang-23
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260325    gcc-11.5.0
hexagon               randconfig-002-20260325    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260325    gcc-14
i386        buildonly-randconfig-002-20260325    gcc-14
i386        buildonly-randconfig-003-20260325    gcc-14
i386        buildonly-randconfig-004-20260325    gcc-14
i386        buildonly-randconfig-005-20260325    gcc-14
i386        buildonly-randconfig-006-20260325    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260325    clang-20
i386                  randconfig-002-20260325    clang-20
i386                  randconfig-003-20260325    clang-20
i386                  randconfig-004-20260325    clang-20
i386                  randconfig-005-20260325    clang-20
i386                  randconfig-006-20260325    clang-20
i386                  randconfig-007-20260325    clang-20
i386                  randconfig-011-20260325    clang-20
i386                  randconfig-012-20260325    clang-20
i386                  randconfig-013-20260325    clang-20
i386                  randconfig-014-20260325    clang-20
i386                  randconfig-015-20260325    clang-20
i386                  randconfig-016-20260325    clang-20
i386                  randconfig-017-20260325    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260325    gcc-11.5.0
loongarch             randconfig-002-20260325    gcc-11.5.0
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
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260325    gcc-11.5.0
nios2                 randconfig-002-20260325    gcc-11.5.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260325    clang-23
parisc                randconfig-002-20260325    clang-23
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc               randconfig-001-20260325    clang-23
powerpc               randconfig-002-20260325    clang-23
powerpc                     taishan_defconfig    clang-17
powerpc64             randconfig-001-20260325    clang-23
powerpc64             randconfig-002-20260325    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260325    gcc-8.5.0
riscv                 randconfig-002-20260325    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260325    gcc-8.5.0
s390                  randconfig-002-20260325    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260325    gcc-8.5.0
sh                    randconfig-002-20260325    gcc-8.5.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260325    gcc-13
sparc                 randconfig-002-20260325    gcc-13
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260325    gcc-13
sparc64               randconfig-002-20260325    gcc-13
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260325    gcc-13
um                    randconfig-002-20260325    gcc-13
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260325    gcc-14
x86_64      buildonly-randconfig-002-20260325    gcc-14
x86_64      buildonly-randconfig-003-20260325    gcc-14
x86_64      buildonly-randconfig-004-20260325    gcc-14
x86_64      buildonly-randconfig-005-20260325    gcc-14
x86_64      buildonly-randconfig-006-20260325    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260325    gcc-12
x86_64                randconfig-002-20260325    gcc-12
x86_64                randconfig-003-20260325    gcc-12
x86_64                randconfig-004-20260325    gcc-12
x86_64                randconfig-005-20260325    gcc-12
x86_64                randconfig-006-20260325    gcc-12
x86_64                randconfig-011-20260325    clang-20
x86_64                randconfig-012-20260325    clang-20
x86_64                randconfig-013-20260325    clang-20
x86_64                randconfig-014-20260325    clang-20
x86_64                randconfig-015-20260325    clang-20
x86_64                randconfig-016-20260325    clang-20
x86_64                randconfig-071-20260325    gcc-14
x86_64                randconfig-072-20260325    gcc-14
x86_64                randconfig-073-20260325    gcc-14
x86_64                randconfig-074-20260325    gcc-14
x86_64                randconfig-075-20260325    gcc-14
x86_64                randconfig-076-20260325    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260325    gcc-13
xtensa                randconfig-002-20260325    gcc-13

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
