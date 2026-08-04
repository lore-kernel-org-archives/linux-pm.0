Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885F72F8EB5;
	Tue,  4 Aug 2026 01:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785806715; cv=none; b=M9Rs78ug1cHZnkL51O7f+IOvV18mkZOH01D8nFx5JLfOY/pF7BIUbbPoJV7z5VqkwsHmJDeyY2Uffq5ppNcBTekVCAs5Q0BVgSeAu86ZKzMunhzxXhe7dpRZW8Iw1UdAZnf7vAS+RPHbbCmSgxtmLOgyqTXdH0cHcxjtZ5HwOxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785806715; c=relaxed/simple;
	bh=Y+OIbTIIsmSA1P7cHx9w4wPVXwlpY4uAT5Piso5Uwmk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hZcbiQi19A+COwDzjfJqfdI/Qf4x6ldwLZVou9PV7nnly+9gkw1dPUXw9AHbYMHXubL34+zYDkNjIqIWPqSsfGScT4iz27IU+tQxKoZE+9n475X7YhEax78SE2Ofm5jIjHVVM6fI9zp1BmCczWwwk9E1OlkyEnd5f4qtMI1z6fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ICKUvxEt; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ICKUvxEt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785806714; x=1817342714;
  h=date:from:to:cc:subject:message-id;
  bh=Y+OIbTIIsmSA1P7cHx9w4wPVXwlpY4uAT5Piso5Uwmk=;
  b=ICKUvxEt71KUUxdhkgSk2wo1vrpqyCY09t6AIKVz1Cy1P1rTy5dhO/fv
   Yi3yaCv3JkwTHHWLsyDZ0YnKjb1Wim+bTSg5nhaLdxQTdwrl+6KWLXg2L
   RwwWATxhQOcm5KsugWSxKFptvs9/hK9GS/pFqxGnM2oDSrqqMMxxZ70vE
   rbrMkgw5CEDs5LMVbEIfOZro4C3Ki+EEN4VIM3pcggtoyXg9bbcXR2nvd
   6oVuGAufANI6bPC1OOsoeE2kpfAyM9e89/ghOg4mHj58a/W6ezKEOZlq/
   mwvZ3zLHbx7h1ELvDkI/jmXuJ4WNPe5IedN6Gzu6R31CC8Te7MUGCFrPm
   Q==;
X-CSE-ConnectionGUID: 8DCVaLitQ8as1NGrUaqU0A==
X-CSE-MsgGUID: 5dux7NSSQCaGLDjMt3EvwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="103888487"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="103888487"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 18:25:14 -0700
X-CSE-ConnectionGUID: ouiHpNLESZGvmKRKOzJpfQ==
X-CSE-MsgGUID: 5yicxDGCTm2py50oCVtR+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="263350577"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 03 Aug 2026 18:25:12 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wr3u2-000000008ao-1bYC;
	Tue, 04 Aug 2026 01:25:10 +0000
Date: Tue, 04 Aug 2026 09:24:34 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 521f490c074058622352f7f92feccdd5aa3f9e0b
Message-ID: <202608040921.ur395bgZ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: 521f490c074058622352f7f92feccdd5aa3f9e0b  Merge branch 'thermal-hwmon' into fixes

elapsed time: 737m

configs tested: 110
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260804    gcc-8.5.0
arc                  randconfig-002-20260804    gcc-8.5.0
arm                            mxs_defconfig    clang-17
arm                  randconfig-001-20260804    gcc-8.5.0
arm                  randconfig-002-20260804    gcc-8.5.0
arm                  randconfig-003-20260804    gcc-8.5.0
arm                  randconfig-004-20260804    gcc-8.5.0
arm64                randconfig-001-20260804    gcc-11.5.0
arm64                randconfig-002-20260804    gcc-11.5.0
arm64                randconfig-003-20260804    gcc-11.5.0
arm64                randconfig-004-20260804    gcc-11.5.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260804    gcc-11.5.0
csky                 randconfig-002-20260804    gcc-11.5.0
hexagon              randconfig-001-20260804    gcc-16.1.0
hexagon              randconfig-002-20260804    gcc-16.1.0
i386                            allmodconfig    gcc-14
i386                 randconfig-001-20260804    clang-22
i386                 randconfig-002-20260804    clang-22
i386                 randconfig-003-20260804    clang-22
i386                 randconfig-004-20260804    clang-22
i386                 randconfig-005-20260804    clang-22
i386                 randconfig-006-20260804    clang-22
i386                 randconfig-007-20260804    clang-22
i386                 randconfig-011-20260804    clang-22
i386                 randconfig-011-20260804    gcc-13
i386                 randconfig-012-20260804    gcc-13
i386                 randconfig-012-20260804    gcc-14
i386                 randconfig-013-20260804    clang-22
i386                 randconfig-013-20260804    gcc-13
i386                 randconfig-014-20260804    gcc-13
i386                 randconfig-014-20260804    gcc-14
i386                 randconfig-015-20260804    clang-22
i386                 randconfig-015-20260804    gcc-13
i386                 randconfig-016-20260804    gcc-13
i386                 randconfig-017-20260804    clang-22
i386                 randconfig-017-20260804    gcc-13
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260804    gcc-16.1.0
loongarch            randconfig-002-20260804    gcc-16.1.0
m68k                         atari_defconfig    gcc-16.1.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260804    gcc-16.1.0
nios2                randconfig-002-20260804    gcc-16.1.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260804    gcc-8.5.0
parisc               randconfig-002-20260804    gcc-8.5.0
powerpc              randconfig-001-20260804    gcc-8.5.0
powerpc              randconfig-002-20260804    gcc-8.5.0
powerpc                    taishan_defconfig    clang-21
powerpc64            randconfig-001-20260804    gcc-8.5.0
powerpc64            randconfig-002-20260804    gcc-8.5.0
riscv                randconfig-002-20260804    gcc-13.4.0
s390                 randconfig-001-20260804    clang-21
s390                 randconfig-002-20260804    clang-18
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260804    gcc-16.1.0
sh                   randconfig-002-20260804    gcc-16.1.0
sparc                randconfig-001-20260804    gcc-16.1.0
sparc                randconfig-002-20260804    gcc-16.1.0
sparc64              randconfig-001-20260804    clang-24
sparc64              randconfig-001-20260804    gcc-16.1.0
sparc64              randconfig-002-20260804    clang-20
sparc64              randconfig-002-20260804    gcc-16.1.0
um                   randconfig-001-20260804    gcc-14
um                   randconfig-001-20260804    gcc-16.1.0
um                   randconfig-002-20260804    gcc-14
um                   randconfig-002-20260804    gcc-16.1.0
x86_64     buildonly-randconfig-001-20260804    gcc-14
x86_64     buildonly-randconfig-002-20260804    gcc-14
x86_64     buildonly-randconfig-003-20260804    gcc-14
x86_64     buildonly-randconfig-004-20260804    gcc-14
x86_64     buildonly-randconfig-005-20260804    gcc-14
x86_64     buildonly-randconfig-006-20260804    gcc-14
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260804    gcc-14
x86_64               randconfig-002-20260804    gcc-13
x86_64               randconfig-002-20260804    gcc-14
x86_64               randconfig-003-20260804    clang-22
x86_64               randconfig-003-20260804    gcc-14
x86_64               randconfig-004-20260804    clang-22
x86_64               randconfig-004-20260804    gcc-14
x86_64               randconfig-005-20260804    gcc-14
x86_64               randconfig-006-20260804    clang-22
x86_64               randconfig-006-20260804    gcc-14
x86_64               randconfig-011-20260804    clang-22
x86_64               randconfig-012-20260804    clang-22
x86_64               randconfig-013-20260804    clang-22
x86_64               randconfig-014-20260804    clang-22
x86_64               randconfig-015-20260804    clang-22
x86_64               randconfig-016-20260804    clang-22
x86_64               randconfig-071-20260804    clang-22
x86_64               randconfig-072-20260804    clang-22
x86_64               randconfig-073-20260804    clang-22
x86_64               randconfig-074-20260804    clang-22
x86_64               randconfig-075-20260804    clang-22
x86_64               randconfig-076-20260804    clang-22
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260804    gcc-16.1.0
xtensa               randconfig-001-20260804    gcc-8.5.0
xtensa               randconfig-002-20260804    gcc-14.3.0
xtensa               randconfig-002-20260804    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
