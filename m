Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865F9489894
	for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 20:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785355475; cv=none; b=qQwjJyhe4bAJu4wrAMlRM6mLnqukGcafEeWfbJtJYZlq2lJASOjYbETiLpyisHvAb9zeCiWUgTFhYAuA3m8Wky98O2sm+v7+yNNYWvXM32URUSM6e+tGjRy5a74PMjE53sSIOc8MTxwrP/o2CvKIT4gqpNd+dNotsDvcT09Dlfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785355475; c=relaxed/simple;
	bh=8/5LDJq0NceNietetvLSkZ9RTVxYQh1ayysQKG72oDQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hbwyQtos3nVMLOiwVACqXdPOlfR+78QS3fLJRcg7SGKQ2DMmumb2rq4ischkx149FQM2o1RfE+tm8yIaVL4dkDCGiFpzh3Y/gEbLebxN6hfxiFpx7ggfaGH0OWIXaZneH3AIeqRSZhDymbOzw7/vtHzHelEs/puVKK2mlRzwYOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WInDCSPY; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WInDCSPY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785355473; x=1816891473;
  h=date:from:to:cc:subject:message-id;
  bh=8/5LDJq0NceNietetvLSkZ9RTVxYQh1ayysQKG72oDQ=;
  b=WInDCSPYAPezAp698f93xRZu/F29a/X4T1gFy6udGMMs3/3TQ8sivJzM
   clVShKp9z3nuM1oqqe4D7R1s1MXEIPTgYfksN0+GiCIQWvD3BCQtHzDwD
   nl9k/zorEshdBnoaVCXw+yLLE7oH6w+o7QVup8MoZsYC2Vkv1PdNDjyV+
   bm+k+BeWx/OteXVRv1VBEbLQiv3ASfMMUZx63DRB4+BHuEolA7Tw9nWgP
   FLTvlT52W6NgUuGm3ZEqPwIfznl4yFbq3DSjftXK8Fmzr3WgOuFIKjRY3
   134S7Y5ozk71dPu4tzjlfF6Bm0jg+v7A2s2MLQuMl1N/lBcfYDI9Npz8d
   A==;
X-CSE-ConnectionGUID: wPeeOYDjTpiZIfLBmf31QQ==
X-CSE-MsgGUID: Js42l09vTZ2NmZ4qze98Ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="86091487"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="86091487"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 13:04:32 -0700
X-CSE-ConnectionGUID: zAS3Wt/0SBGRMh8ZkyMXjQ==
X-CSE-MsgGUID: LgTpeeb8TD6VvzOZL/GMgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="263594958"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 29 Jul 2026 13:04:30 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wpATK-00000000fdu-24T3;
	Wed, 29 Jul 2026 20:02:15 +0000
Date: Thu, 30 Jul 2026 03:55:52 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: linux-pm@vger.kernel.org
Subject: [amd-pstate:bleeding-edge] BUILD SUCCESS
 d06c75c22d5c95ee27e01fedcaa07231c9bd5c88
Message-ID: <202607300341.8OI5znWy-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git bleeding-edge
branch HEAD: d06c75c22d5c95ee27e01fedcaa07231c9bd5c88  cpufreq/amd-pstate: Document missing kernel-doc members

elapsed time: 1586m

configs tested: 148
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260729    gcc-8.5.0
arc                  randconfig-002-20260729    gcc-8.5.0
arm                  randconfig-001-20260729    gcc-8.5.0
arm                  randconfig-002-20260729    gcc-8.5.0
arm                  randconfig-003-20260729    gcc-8.5.0
arm                  randconfig-004-20260729    gcc-8.5.0
arm64                         randconfig-001    gcc-14.3.0
arm64                randconfig-001-20260729    clang-17
arm64                randconfig-001-20260729    gcc-14.3.0
arm64                randconfig-002-20260729    clang-17
arm64                randconfig-002-20260729    gcc-14.3.0
arm64                randconfig-003-20260729    clang-17
arm64                randconfig-003-20260729    gcc-14.3.0
arm64                randconfig-004-20260729    clang-17
arm64                randconfig-004-20260729    gcc-14.3.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260729    clang-17
csky                 randconfig-001-20260729    gcc-14.3.0
csky                 randconfig-002-20260729    clang-17
csky                 randconfig-002-20260729    gcc-14.3.0
hexagon                       randconfig-001    gcc-9.5.0
hexagon              randconfig-001-20260729    gcc-9.5.0
hexagon              randconfig-001-20260730    clang-24
hexagon              randconfig-002-20260729    gcc-9.5.0
hexagon              randconfig-002-20260730    clang-24
i386                            allmodconfig    gcc-14
i386                buildonly-randconfig-001    gcc-14
i386       buildonly-randconfig-001-20260729    gcc-14
i386       buildonly-randconfig-002-20260729    gcc-14
i386       buildonly-randconfig-003-20260729    gcc-14
i386       buildonly-randconfig-004-20260729    gcc-14
i386       buildonly-randconfig-005-20260729    gcc-14
i386       buildonly-randconfig-006-20260729    gcc-14
i386                          randconfig-001    clang-22
i386                 randconfig-001-20260729    clang-22
i386                 randconfig-002-20260729    clang-22
i386                 randconfig-003-20260729    clang-22
i386                 randconfig-004-20260729    clang-22
i386                 randconfig-005-20260729    clang-22
i386                 randconfig-006-20260729    clang-22
i386                 randconfig-007-20260729    clang-22
i386                          randconfig-011    gcc-14
i386                 randconfig-011-20260729    gcc-14
i386                 randconfig-012-20260729    gcc-14
i386                 randconfig-013-20260729    gcc-14
i386                 randconfig-014-20260729    gcc-14
i386                 randconfig-015-20260729    gcc-14
i386                 randconfig-016-20260729    gcc-14
i386                 randconfig-017-20260729    gcc-14
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260729    gcc-9.5.0
loongarch            randconfig-001-20260730    clang-24
loongarch            randconfig-002-20260729    gcc-9.5.0
loongarch            randconfig-002-20260730    clang-24
m68k                       m5272c3_defconfig    gcc-16.1.0
mips                       bcm63xx_defconfig    clang-24
mips                     maltaaprp_defconfig    clang-17
mips                       maltaup_defconfig    clang-17
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260729    gcc-9.5.0
nios2                randconfig-001-20260730    clang-24
nios2                randconfig-002-20260729    gcc-9.5.0
nios2                randconfig-002-20260730    clang-24
parisc                          alldefconfig    gcc-16.1.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc                        randconfig-001    clang-24
parisc               randconfig-001-20260729    clang-24
parisc               randconfig-001-20260730    gcc-14.3.0
parisc               randconfig-002-20260729    clang-24
parisc               randconfig-002-20260730    gcc-14.3.0
powerpc                mpc8313_rdb_defconfig    gcc-16.1.0
powerpc              randconfig-001-20260729    clang-24
powerpc              randconfig-001-20260730    gcc-14.3.0
powerpc              randconfig-002-20260729    clang-24
powerpc              randconfig-002-20260730    gcc-14.3.0
powerpc64            randconfig-001-20260729    clang-24
powerpc64            randconfig-001-20260730    gcc-14.3.0
powerpc64            randconfig-002-20260729    clang-24
powerpc64            randconfig-002-20260730    gcc-14.3.0
riscv            nommu_k210_sdcard_defconfig    gcc-16.1.0
riscv                         randconfig-001    gcc-15.2.0
riscv                randconfig-001-20260729    gcc-15.2.0
riscv                randconfig-002-20260729    gcc-15.2.0
s390                 randconfig-001-20260729    gcc-15.2.0
s390                 randconfig-002-20260729    gcc-15.2.0
sh                                 defconfig    gcc-16.1.0
sh                           hp6xx_defconfig    gcc-16.1.0
sh                   randconfig-001-20260729    gcc-15.2.0
sh                   randconfig-002-20260729    gcc-15.2.0
sparc                randconfig-001-20260729    gcc-10.5.0
sparc                randconfig-001-20260730    clang-24
sparc                randconfig-002-20260729    gcc-10.5.0
sparc                randconfig-002-20260730    clang-24
sparc64              randconfig-001-20260729    gcc-10.5.0
sparc64              randconfig-001-20260730    clang-24
sparc64              randconfig-002-20260729    gcc-10.5.0
sparc64              randconfig-002-20260730    clang-24
um                   randconfig-001-20260729    gcc-10.5.0
um                   randconfig-001-20260730    clang-24
um                   randconfig-002-20260729    gcc-10.5.0
um                   randconfig-002-20260730    clang-24
x86_64              buildonly-randconfig-001    clang-22
x86_64              buildonly-randconfig-001    gcc-14
x86_64     buildonly-randconfig-001-20260729    clang-22
x86_64     buildonly-randconfig-001-20260729    gcc-14
x86_64     buildonly-randconfig-002-20260729    clang-22
x86_64     buildonly-randconfig-002-20260729    gcc-14
x86_64     buildonly-randconfig-003-20260729    clang-22
x86_64     buildonly-randconfig-004-20260729    clang-22
x86_64     buildonly-randconfig-004-20260729    gcc-14
x86_64     buildonly-randconfig-005-20260729    clang-22
x86_64     buildonly-randconfig-006-20260729    clang-22
x86_64     buildonly-randconfig-006-20260729    gcc-14
x86_64                                 kexec    clang-22
x86_64                        randconfig-001    clang-22
x86_64               randconfig-001-20260729    clang-22
x86_64               randconfig-002-20260729    clang-22
x86_64               randconfig-003-20260729    clang-22
x86_64               randconfig-004-20260729    clang-22
x86_64               randconfig-005-20260729    clang-22
x86_64               randconfig-006-20260729    clang-22
x86_64                        randconfig-011    gcc-14
x86_64               randconfig-011-20260729    gcc-14
x86_64               randconfig-012-20260729    gcc-14
x86_64               randconfig-013-20260729    gcc-14
x86_64               randconfig-014-20260729    gcc-14
x86_64               randconfig-015-20260729    gcc-14
x86_64               randconfig-016-20260729    gcc-14
x86_64                        randconfig-071    gcc-12
x86_64               randconfig-071-20260729    gcc-12
x86_64               randconfig-072-20260729    gcc-12
x86_64               randconfig-073-20260729    gcc-12
x86_64               randconfig-074-20260729    gcc-12
x86_64               randconfig-075-20260729    gcc-12
x86_64               randconfig-076-20260729    gcc-12
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260729    gcc-10.5.0
xtensa               randconfig-001-20260730    clang-24
xtensa               randconfig-002-20260729    gcc-10.5.0
xtensa               randconfig-002-20260730    clang-24

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
