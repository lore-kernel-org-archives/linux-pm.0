Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4DD23D2A1;
	Fri, 22 May 2026 12:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779452344; cv=none; b=HO9g5Bxs/Aog4wbW+mgbEp/fJ0zDZHd98JlsAqno5IpEnvW+NjAvIO0VWFqQI4RC9fyRLGNNRaGjkL1/psbsNg9p8ua+6DNWs9aMKZx6dKb9bZ1qQWrRJqND+kL5dkBrNVLNBplwJnr8cgNEDnnokID53c6/mfMX72fOsXf4xnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779452344; c=relaxed/simple;
	bh=iEK0pm/OdSJMUQmbIRG7MGuwSTN/cahJFrtQLO+zWqg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=U1SJ3UJ7c1lb9YH19iKt4XjN1K6kRw6B6iFvWyLhbdY8RwvWFG3Z9wZoBJclHHZeipTcJq/LinPGL9rjByyjJ5ikTgCz0i3gKvKiYv9hIjxhst/PGkeWNuPXZxzF/uqJes4/EoRmVSGFpTqYp5EwKnc4Q0uQaWIxBi0OyFjhdGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mFK7F0YX; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mFK7F0YX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779452343; x=1810988343;
  h=date:from:to:cc:subject:message-id;
  bh=iEK0pm/OdSJMUQmbIRG7MGuwSTN/cahJFrtQLO+zWqg=;
  b=mFK7F0YX6dvGN2cIOl/iZgkIdkczqSkBCSYOUD6Jt49cBJjLMOFn4wJU
   oByOThp8nU8J54ATWSsNj7MOrpLzR1pw8ZyXci+P1qD1V4JKjYx8U100O
   J9vUVUdI+zIVwjVgO8bXzmLo3r34GW8tH7koGdIjkGWhroWS5IfO8hHFZ
   1gwp7h/rm8IRZlkYbWKgXC2W4teW2jQPE4lF3aRLsTTMo/xwjPzcLg/HS
   J5i18RTcEc4I3W2eH/jQHjDC/4/BC5L/FtE4ekSQVOMRdb/g40kA6u4D4
   JKe58oWofZNd16cecL4wLLWM2mmWjXxjmNUhz8QbD/cn5KmtkZ3fFXydH
   g==;
X-CSE-ConnectionGUID: oCRattJ7QXCn+XIIz6h4SA==
X-CSE-MsgGUID: D0fXD7/cSB+ULnrpgLrk6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="91071163"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="91071163"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 05:19:02 -0700
X-CSE-ConnectionGUID: e0PIEjiBRrGFKK27VIRIcw==
X-CSE-MsgGUID: IRHCPHW5TYqFSNNcfXRQeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="245879676"
Received: from lkp-server01.sh.intel.com (HELO fdb68b0ce653) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 22 May 2026 05:19:00 -0700
Received: from kbuild by fdb68b0ce653 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wQOq9-000000002Kn-02aW;
	Fri, 22 May 2026 12:18:57 +0000
Date: Fri, 22 May 2026 20:18:40 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 80e40181008d03fdebbe7a139fde29831321b147
Message-ID: <202605222032.R1W88DNv-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 80e40181008d03fdebbe7a139fde29831321b147  Merge branch 'pm-cpufreq-fixes-next' into bleeding-edge

elapsed time: 935m

configs tested: 153
configs skipped: 18

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
arc                   randconfig-001-20260522    gcc-9.5.0
arc                   randconfig-002-20260522    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                   randconfig-001-20260522    gcc-8.5.0
arm                   randconfig-002-20260522    gcc-10.5.0
arm                   randconfig-003-20260522    gcc-11.5.0
arm                   randconfig-004-20260522    clang-23
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                          randconfig-001    gcc-8.5.0
arm64                 randconfig-001-20260522    clang-20
arm64                          randconfig-002    gcc-14.3.0
arm64                 randconfig-002-20260522    gcc-14.3.0
arm64                          randconfig-003    clang-23
arm64                 randconfig-003-20260522    clang-23
arm64                          randconfig-004    clang-23
arm64                 randconfig-004-20260522    gcc-10.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                           randconfig-001    gcc-10.5.0
csky                  randconfig-001-20260522    gcc-15.2.0
csky                           randconfig-002    gcc-10.5.0
csky                  randconfig-002-20260522    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260522    clang-23
hexagon               randconfig-002-20260522    clang-23
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20260522    clang-20
i386        buildonly-randconfig-002-20260522    gcc-14
i386        buildonly-randconfig-003-20260522    clang-20
i386        buildonly-randconfig-004-20260522    gcc-14
i386        buildonly-randconfig-005-20260522    clang-20
i386        buildonly-randconfig-006-20260522    gcc-13
i386                                defconfig    clang-20
i386                  randconfig-001-20260522    gcc-14
i386                  randconfig-002-20260522    clang-20
i386                  randconfig-003-20260522    gcc-13
i386                  randconfig-004-20260522    gcc-14
i386                  randconfig-005-20260522    gcc-14
i386                  randconfig-006-20260522    clang-20
i386                  randconfig-007-20260522    gcc-13
i386                  randconfig-011-20260522    gcc-14
i386                  randconfig-012-20260522    clang-20
i386                  randconfig-013-20260522    clang-20
i386                  randconfig-014-20260522    gcc-14
i386                  randconfig-015-20260522    clang-20
i386                  randconfig-016-20260522    clang-20
i386                  randconfig-017-20260522    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260522    clang-23
loongarch             randconfig-002-20260522    gcc-15.2.0
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
mips                           jazz_defconfig    clang-17
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260522    gcc-8.5.0
nios2                 randconfig-002-20260522    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260522    gcc-14.3.0
parisc                randconfig-002-20260522    gcc-8.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260522    clang-20
powerpc               randconfig-002-20260522    clang-18
powerpc64             randconfig-001-20260522    gcc-10.5.0
powerpc64             randconfig-002-20260522    gcc-12.5.0
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260522    clang-17
riscv                 randconfig-002-20260522    clang-23
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-001-20260522    clang-23
s390                  randconfig-002-20260522    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260522    gcc-10.5.0
sh                    randconfig-002-20260522    gcc-14.3.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260522    gcc-15.2.0
sparc                 randconfig-002-20260522    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260522    gcc-14.3.0
sparc64               randconfig-002-20260522    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260522    clang-23
um                    randconfig-002-20260522    gcc-14
um                           x86_64_defconfig    clang-23
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20260522    clang-20
x86_64      buildonly-randconfig-002-20260522    gcc-13
x86_64      buildonly-randconfig-003-20260522    gcc-14
x86_64      buildonly-randconfig-004-20260522    clang-20
x86_64      buildonly-randconfig-005-20260522    clang-20
x86_64      buildonly-randconfig-006-20260522    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260522    clang-20
x86_64                randconfig-002-20260522    clang-20
x86_64                randconfig-003-20260522    gcc-14
x86_64                randconfig-004-20260522    gcc-14
x86_64                randconfig-005-20260522    gcc-14
x86_64                randconfig-006-20260522    gcc-14
x86_64                randconfig-071-20260522    gcc-14
x86_64                randconfig-072-20260522    gcc-14
x86_64                randconfig-073-20260522    clang-20
x86_64                randconfig-074-20260522    gcc-14
x86_64                randconfig-075-20260522    clang-20
x86_64                randconfig-076-20260522    gcc-14
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-001-20260522    gcc-9.5.0
xtensa                randconfig-002-20260522    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
