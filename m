Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E2132A3E1;
	Sat,  2 May 2026 16:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777740569; cv=none; b=rnrqpMV5JhOJjPwd1yszoq1XIYjyAR72LvpEgN1UH16FcgTma8KyV9c71hSx23tHLwZo7ulYL0pgrFlENyD71B41ZxlTSP3LgnQ+2bDzwc/CTN62tlwRDhCfqj4NWUqL+KebAMhG4zRp8p8Eocc9IivTok5sYSyqDKoaCy/2A6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777740569; c=relaxed/simple;
	bh=cd91LKasQwNVroGebur+8tYpBxZcvzvH5Oljam35N9o=;
	h=Date:From:To:Cc:Subject:Message-ID; b=YTmj6RKazFrLieibuF9r+zPPqp6IwVCkalMq5Jwfn0CQeuO8Ay1XAJy5cwnM+LXDc+70caBo3AJMJmVyGrBj+8g6giTuYsgTacYOUz3TQnHVEPba0CM9oG5IyVbEIKdc/55B0nTxw3Hh69BMW2KqHU+AblxMNze5G5HoaNIDsZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ecl0FLZl; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ecl0FLZl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777740568; x=1809276568;
  h=date:from:to:cc:subject:message-id;
  bh=cd91LKasQwNVroGebur+8tYpBxZcvzvH5Oljam35N9o=;
  b=Ecl0FLZlu+a0yvjRAF6eH+AJFGAUtEkCxRWXTgelRr9X4nV7jfcUmo6V
   af6WrywoCkzgR9Wri+Z0bmccpTLftcrKgRQ8vUEhf/V6QCnnsmusz3COM
   BvgAL26pyOWSIg9T0P8prLIQ+YIkoacvo676wmdoHe9MustMvV+nnLGMB
   +deT/Y3hEYVVvj5SafX0CAUY0fSZArxC0f/JRCTuu3sIEqPQJws1oPpfk
   ggyQlMzKnssKgwurtEJ+YPfNOqsaH5mdCTwHX5jnnY5l9L2ZTN/jrHPvo
   Z8szfSQVpghJK9RPXowzuqkPsqdMHuCC04IiIl/YNO2rBkrl6NDhL9Zg/
   g==;
X-CSE-ConnectionGUID: CNR3ywisS9+Ak89Yw295FA==
X-CSE-MsgGUID: e/DCHfIJQiKP/0uHC//3IA==
X-IronPort-AV: E=McAfee;i="6800,10657,11774"; a="82522640"
X-IronPort-AV: E=Sophos;i="6.23,212,1770624000"; 
   d="scan'208";a="82522640"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2026 09:49:28 -0700
X-CSE-ConnectionGUID: nvQPzf3lRFeMVhvJb9z2FQ==
X-CSE-MsgGUID: /+PK2PzGQNOo1BcjRPvLQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,212,1770624000"; 
   d="scan'208";a="232479486"
Received: from lkp-server01.sh.intel.com (HELO 781826d00641) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 02 May 2026 09:49:26 -0700
Received: from kbuild by 781826d00641 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wJDWt-000000001bN-3GoB;
	Sat, 02 May 2026 16:49:23 +0000
Date: Sun, 03 May 2026 00:48:57 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 2c1a59d5298cc73d41fa37cc761a343e8ecce43e
Message-ID: <202605030038.UYt4cuTV-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 2c1a59d5298cc73d41fa37cc761a343e8ecce43e  Merge branch 'pm-tools' into bleeding-edge

elapsed time: 2684m

configs tested: 173
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
arc                            randconfig-001    gcc-8.5.0
arc                   randconfig-001-20260502    gcc-8.5.0
arc                            randconfig-002    gcc-8.5.0
arc                   randconfig-002-20260502    gcc-8.5.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                            randconfig-001    gcc-8.5.0
arm                   randconfig-001-20260502    gcc-8.5.0
arm                            randconfig-002    gcc-8.5.0
arm                   randconfig-002-20260502    gcc-8.5.0
arm                            randconfig-003    gcc-8.5.0
arm                   randconfig-003-20260502    gcc-8.5.0
arm                            randconfig-004    gcc-8.5.0
arm                   randconfig-004-20260502    gcc-8.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                          randconfig-001    gcc-10.5.0
arm64                 randconfig-001-20260502    gcc-10.5.0
arm64                          randconfig-002    gcc-10.5.0
arm64                 randconfig-002-20260502    gcc-10.5.0
arm64                          randconfig-003    gcc-10.5.0
arm64                 randconfig-003-20260502    gcc-10.5.0
arm64                          randconfig-004    gcc-10.5.0
arm64                 randconfig-004-20260502    gcc-10.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                           randconfig-001    gcc-10.5.0
csky                  randconfig-001-20260502    gcc-10.5.0
csky                           randconfig-002    gcc-10.5.0
csky                  randconfig-002-20260502    gcc-10.5.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260502    clang-23
hexagon               randconfig-002-20260502    clang-23
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260502    gcc-14
i386        buildonly-randconfig-002-20260502    gcc-14
i386        buildonly-randconfig-003-20260502    gcc-14
i386        buildonly-randconfig-004-20260502    gcc-14
i386        buildonly-randconfig-005-20260502    gcc-14
i386        buildonly-randconfig-006-20260502    gcc-14
i386                                defconfig    gcc-15.2.0
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260502    clang-23
loongarch             randconfig-002-20260502    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
m68k                        mvme147_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260502    clang-23
nios2                 randconfig-002-20260502    clang-23
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                         randconfig-001    gcc-12.5.0
parisc                randconfig-001-20260502    gcc-12.5.0
parisc                         randconfig-002    gcc-12.5.0
parisc                randconfig-002-20260502    gcc-12.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                        randconfig-001    gcc-12.5.0
powerpc               randconfig-001-20260502    gcc-12.5.0
powerpc                        randconfig-002    gcc-12.5.0
powerpc               randconfig-002-20260502    gcc-12.5.0
powerpc64                      randconfig-001    gcc-12.5.0
powerpc64             randconfig-001-20260502    gcc-12.5.0
powerpc64                      randconfig-002    gcc-12.5.0
powerpc64             randconfig-002-20260502    gcc-12.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260502    gcc-14.3.0
riscv                 randconfig-002-20260502    gcc-14.3.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260502    gcc-14.3.0
s390                  randconfig-002-20260502    gcc-14.3.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260502    gcc-14.3.0
sh                    randconfig-002-20260502    gcc-14.3.0
sh                      rts7751r2d1_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260502    gcc-8.5.0
sparc                 randconfig-002-20260502    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260502    gcc-8.5.0
sparc64               randconfig-002-20260502    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260502    gcc-8.5.0
um                    randconfig-002-20260502    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64               buildonly-randconfig-001    clang-20
x86_64      buildonly-randconfig-001-20260502    clang-20
x86_64               buildonly-randconfig-002    clang-20
x86_64      buildonly-randconfig-002-20260502    clang-20
x86_64               buildonly-randconfig-003    clang-20
x86_64      buildonly-randconfig-003-20260502    clang-20
x86_64               buildonly-randconfig-004    clang-20
x86_64      buildonly-randconfig-004-20260502    clang-20
x86_64               buildonly-randconfig-005    clang-20
x86_64      buildonly-randconfig-005-20260502    clang-20
x86_64               buildonly-randconfig-006    clang-20
x86_64      buildonly-randconfig-006-20260502    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260502    clang-20
x86_64                randconfig-002-20260502    clang-20
x86_64                randconfig-003-20260502    clang-20
x86_64                randconfig-004-20260502    clang-20
x86_64                randconfig-005-20260502    clang-20
x86_64                randconfig-006-20260502    clang-20
x86_64                randconfig-071-20260502    gcc-14
x86_64                randconfig-072-20260502    gcc-14
x86_64                randconfig-073-20260502    gcc-14
x86_64                randconfig-074-20260502    gcc-14
x86_64                randconfig-075-20260502    gcc-14
x86_64                randconfig-076-20260502    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260502    gcc-8.5.0
xtensa                randconfig-002-20260502    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
