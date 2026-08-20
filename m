Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0D438B14F;
	Thu, 20 Aug 2026 05:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787203747; cv=none; b=rPmmldnMjLQ6HpZo/eirYuKCLmwiJIVuVqLRzQzK1McEvk0soN4wrMSM4I92RLLQcT8oNLEdJPaiMcZp6XwOu3H/UVi8X/tOGmb44fZOMWEdKHRb9dnnLeSzaR+yIjByjf1arBecy3HOH2LQ0TcVNrON1YiIrbuAPW7m2YO+js4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787203747; c=relaxed/simple;
	bh=RfU1A7vXyWL26FRiJOohgvBEQVoVyyfwSEGF1erUSxw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=M6tT/q9QD7MNGYiIAKexXjdjPta0keNlbvlemwyUxrGRIBeN5dLrm82iLMu74PTeUF+hLFvT5pq5kmDtiBb+sAzvZestBDKpEv6DNI4KaIaKkzux+5PEZOd7FFUpMtrdaH/dSD7+2wjugGcYogdPawUCjbdqmqGi/umDt7dRbgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aCg5eKb5; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aCg5eKb5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787203746; x=1818739746;
  h=date:from:to:cc:subject:message-id;
  bh=RfU1A7vXyWL26FRiJOohgvBEQVoVyyfwSEGF1erUSxw=;
  b=aCg5eKb57GYlIG/vObGb9MBUiHHDLX8k+jbLQ632gZC7H1V6yZvhAnNM
   2LsnJ46oVojgTUdg0ZlZQQWYgFooo1f4kzP6niWbNqoDd6Q/fW+bTWXkL
   1Eu+6328EHniIIKLI8tYpVmrfGbDsHtanM408RI7HybKjFY3M16iWSskh
   1VMahVwS4pMbHyHgIpx8w0hqfXF3Qp5t8cU+miAIeaHy8RSeTCou4Ygzk
   3Dka/epGDJSBWUltsB0dNfAe2IIfZYCRyiRytM7SvwWno0vPp4Br5ohao
   O0KtjYnWaZivQD/llJ+XdxzZRRgs1I6L5iCODzTC41L9zpV6TY1iaiJh8
   g==;
X-CSE-ConnectionGUID: 5TKjUl0tTEqUZjsLfQ/+qg==
X-CSE-MsgGUID: bx9qAto9R/SBFDnY3xYAvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="87492907"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="87492907"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 22:29:05 -0700
X-CSE-ConnectionGUID: Yvb7V50lTXCw0C/TILxy3g==
X-CSE-MsgGUID: NDo9j9F+Rle9d5NdVerMpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="290649803"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 19 Aug 2026 22:29:01 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wwvKk-00000000hwL-0l17;
	Thu, 20 Aug 2026 05:28:58 +0000
Date: Thu, 20 Aug 2026 13:28:18 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 4b97ed73d95ee0bb7f2c8782ae7b73f5ecc39dc4
Message-ID: <202608201305.4zCSfH6m-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 4b97ed73d95ee0bb7f2c8782ae7b73f5ecc39dc4  Merge branch 'testing' into bleeding-edge

elapsed time: 1857m

configs tested: 145
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260819    gcc-11.5.0
arc                  randconfig-002-20260819    gcc-11.5.0
arc                  randconfig-002-20260819    gcc-13.4.0
arm                  randconfig-001-20260819    gcc-11.5.0
arm                  randconfig-001-20260819    gcc-13.4.0
arm                  randconfig-002-20260819    gcc-11.5.0
arm                  randconfig-002-20260819    gcc-15.2.0
arm                  randconfig-003-20260819    gcc-10.5.0
arm                  randconfig-003-20260819    gcc-11.5.0
arm                  randconfig-004-20260819    gcc-11.5.0
arm                  randconfig-004-20260819    gcc-15.2.0
arm                          sunxi_defconfig    gcc-16.1.0
arm64                         randconfig-001    gcc-14.3.0
arm64                randconfig-001-20260819    gcc-11.5.0
arm64                randconfig-001-20260819    gcc-14.3.0
arm64                randconfig-001-20260819    gcc-9.5.0
arm64                randconfig-002-20260819    clang-17
arm64                randconfig-002-20260819    gcc-14.3.0
arm64                randconfig-002-20260819    gcc-9.5.0
arm64                randconfig-003-20260819    clang-17
arm64                randconfig-003-20260819    gcc-14.3.0
arm64                randconfig-003-20260819    gcc-9.5.0
arm64                randconfig-004-20260819    gcc-14.3.0
arm64                randconfig-004-20260819    gcc-8.5.0
arm64                randconfig-004-20260819    gcc-9.5.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260819    gcc-14.3.0
csky                 randconfig-001-20260819    gcc-9.5.0
csky                 randconfig-002-20260819    gcc-11.5.0
csky                 randconfig-002-20260819    gcc-14.3.0
csky                 randconfig-002-20260819    gcc-9.5.0
hexagon                       randconfig-001    gcc-11.5.0
hexagon              randconfig-001-20260819    clang-22
hexagon              randconfig-001-20260819    gcc-11.5.0
hexagon              randconfig-002-20260819    clang-24
hexagon              randconfig-002-20260819    gcc-11.5.0
i386                            allmodconfig    gcc-14
i386                buildonly-randconfig-001    gcc-14
i386       buildonly-randconfig-001-20260819    gcc-14
i386       buildonly-randconfig-002-20260819    gcc-14
i386       buildonly-randconfig-003-20260819    gcc-14
i386       buildonly-randconfig-004-20260819    gcc-14
i386       buildonly-randconfig-005-20260819    gcc-14
i386       buildonly-randconfig-006-20260819    gcc-14
i386                          randconfig-001    gcc-14
i386                 randconfig-001-20260819    gcc-14
i386                 randconfig-002-20260819    gcc-14
i386                 randconfig-003-20260819    gcc-14
i386                 randconfig-004-20260819    gcc-14
i386                 randconfig-005-20260819    gcc-14
i386                 randconfig-006-20260819    gcc-14
i386                 randconfig-007-20260819    gcc-14
i386                          randconfig-011    gcc-14
i386                 randconfig-011-20260819    gcc-13
i386                 randconfig-011-20260819    gcc-14
i386                 randconfig-012-20260819    gcc-14
i386                 randconfig-013-20260819    gcc-14
i386                 randconfig-014-20260819    clang-22
i386                 randconfig-014-20260819    gcc-14
i386                 randconfig-015-20260819    clang-22
i386                 randconfig-015-20260819    gcc-14
i386                 randconfig-016-20260819    clang-22
i386                 randconfig-016-20260819    gcc-14
i386                 randconfig-017-20260819    clang-22
i386                 randconfig-017-20260819    gcc-14
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260819    clang-24
loongarch            randconfig-001-20260819    gcc-11.5.0
loongarch            randconfig-002-20260819    gcc-11.5.0
loongarch            randconfig-002-20260819    gcc-16.1.0
m68k                         atari_defconfig    gcc-16.1.0
mips                    cu1000-neo_defconfig    gcc-16.1.0
mips                         rb532_defconfig    clang-24
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260819    gcc-11.5.0
nios2                randconfig-002-20260819    gcc-11.5.0
nios2                randconfig-002-20260819    gcc-8.5.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc                        randconfig-001    clang-24
parisc               randconfig-001-20260819    clang-24
parisc               randconfig-002-20260819    clang-24
powerpc              randconfig-001-20260819    clang-24
powerpc              randconfig-002-20260819    clang-24
powerpc                   sam440ep_defconfig    gcc-16.1.0
powerpc64            randconfig-001-20260819    clang-24
powerpc64            randconfig-002-20260819    clang-24
riscv                         randconfig-001    clang-24
riscv                randconfig-001-20260819    clang-24
riscv                randconfig-002-20260819    clang-24
s390                 randconfig-001-20260819    clang-24
s390                 randconfig-002-20260819    clang-24
sh                                 defconfig    gcc-16.1.0
sh                kfr2r09-romimage_defconfig    gcc-16.1.0
sh                   randconfig-001-20260819    clang-24
sh                   randconfig-002-20260819    clang-24
sparc                randconfig-001-20260819    gcc-10.5.0
sparc                randconfig-002-20260819    gcc-10.5.0
sparc64              randconfig-001-20260819    gcc-10.5.0
sparc64              randconfig-002-20260819    gcc-10.5.0
um                   randconfig-001-20260819    gcc-10.5.0
um                   randconfig-002-20260819    gcc-10.5.0
x86_64              buildonly-randconfig-001    gcc-14
x86_64     buildonly-randconfig-001-20260819    gcc-14
x86_64     buildonly-randconfig-001-20260820    gcc-14
x86_64     buildonly-randconfig-002-20260819    gcc-14
x86_64     buildonly-randconfig-002-20260820    gcc-14
x86_64     buildonly-randconfig-003-20260819    gcc-14
x86_64     buildonly-randconfig-003-20260820    gcc-14
x86_64     buildonly-randconfig-004-20260819    gcc-14
x86_64     buildonly-randconfig-004-20260820    gcc-14
x86_64     buildonly-randconfig-005-20260819    gcc-14
x86_64     buildonly-randconfig-005-20260820    gcc-14
x86_64     buildonly-randconfig-006-20260819    gcc-14
x86_64     buildonly-randconfig-006-20260820    gcc-14
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260819    gcc-14
x86_64               randconfig-002-20260819    gcc-14
x86_64               randconfig-003-20260819    gcc-14
x86_64               randconfig-004-20260819    gcc-14
x86_64               randconfig-005-20260819    gcc-14
x86_64               randconfig-006-20260819    gcc-14
x86_64                        randconfig-011    clang-22
x86_64               randconfig-011-20260819    clang-22
x86_64               randconfig-012-20260819    clang-22
x86_64               randconfig-013-20260819    clang-22
x86_64               randconfig-014-20260819    clang-22
x86_64               randconfig-015-20260819    clang-22
x86_64               randconfig-016-20260819    clang-22
x86_64               randconfig-071-20260819    clang-22
x86_64               randconfig-072-20260819    clang-22
x86_64               randconfig-073-20260819    clang-22
x86_64               randconfig-074-20260819    clang-22
x86_64               randconfig-075-20260819    clang-22
x86_64               randconfig-076-20260819    clang-22
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260819    gcc-10.5.0
xtensa               randconfig-002-20260819    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
