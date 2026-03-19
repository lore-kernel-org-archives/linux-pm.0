Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A183B3BEA;
	Thu, 19 Mar 2026 09:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773912445; cv=none; b=Yp+jPd/pFseIUSUxCk28CK5ls8183KUY4YD9Zd7o5FxaTMAwbXL5Y6azO3jfssk/tJ/1THXUaNolbt/6TGdjLOjh7e2xZprsZs+yUjfYqW6G+cQRq9oELRH8N5vUl7dcs8YLMpgKpxEIEXMakaB/EbUiPgIhxQRyPm2YoEzEmOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773912445; c=relaxed/simple;
	bh=SwQMr68qDGZqRIQvgirOtiJn5Cgsl2jYBkdLS+p6c+o=;
	h=Date:From:To:Cc:Subject:Message-ID; b=IiArRm5MpzJj0OpVKDDA7IsR/FeUI7BBsaCljV3t3eIaZxW3aG3+pV4gF+CYskIr7zu8sDc2rQBLs8gHpp8q3oFgLGn6Z1LPY2xxchmHbWoKI1vvJN67vvAovmkx6Mw1TXOEJJ80zMB9k0v3SFMWHeytxadKAB5bVa1fFAVEc9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Aj71A4P4; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aj71A4P4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773912444; x=1805448444;
  h=date:from:to:cc:subject:message-id;
  bh=SwQMr68qDGZqRIQvgirOtiJn5Cgsl2jYBkdLS+p6c+o=;
  b=Aj71A4P40AC9ineCNwZZdjaz1XUWIWc/rnaTts6rF51SRwa1ZC6ASX/Y
   EDj+o11OrkDLAHcwfWlaqpFZpNVPApnouBqDzJtC1kJQInEV9ZdxkEOad
   oa4LTvf9qc1DMWnd5ZN3xMMxTcqC0j6exBd8KcTX0Db2JuFWcV6scyJIJ
   HDA5Tw4jUnc416nTcNvHFW7jxB7CUpXhs0Lxlju0/icwTx0FQhCJy7Fc4
   bv+T67ZqkcJhJA6FJHssZNPqJc63FSnaM/rORBrgtaMruJlTj0A/mhYvf
   QTYnq3Kr8/45keCnxf3WBV4J7AzIOAYUUL5u+7HJdzeXp5l877x0DQUEb
   Q==;
X-CSE-ConnectionGUID: 3dl7PQ5XQOSpZ0dCIs6L/A==
X-CSE-MsgGUID: 4xORiqcLSIiU+6wirxUy3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="74864150"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="74864150"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 02:27:23 -0700
X-CSE-ConnectionGUID: CfZe5+2QQ260M0DiByR8HQ==
X-CSE-MsgGUID: YEFWAS6ATpiB7X3IdIaPcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="222007542"
Received: from lkp-server02.sh.intel.com (HELO a51c2a36b9df) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 19 Mar 2026 02:27:21 -0700
Received: from kbuild by a51c2a36b9df with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w39ew-000000000fB-0PCM;
	Thu, 19 Mar 2026 09:27:18 +0000
Date: Thu, 19 Mar 2026 17:25:07 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 989846451544c0330ee498cfdfc0183a4baf4270
Message-ID: <202603191701.6MkuIMm5-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: 989846451544c0330ee498cfdfc0183a4baf4270  Merge branch 'acpi-bus' into fixes

elapsed time: 1038m

configs tested: 168
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
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260319    gcc-11.5.0
arc                   randconfig-002-20260319    gcc-11.5.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260319    gcc-11.5.0
arm                   randconfig-002-20260319    gcc-11.5.0
arm                   randconfig-003-20260319    gcc-11.5.0
arm                   randconfig-004-20260319    gcc-11.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260319    gcc-15.2.0
arm64                 randconfig-002-20260319    gcc-15.2.0
arm64                 randconfig-003-20260319    gcc-15.2.0
arm64                 randconfig-004-20260319    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260319    gcc-15.2.0
csky                  randconfig-002-20260319    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260319    gcc-11.5.0
hexagon               randconfig-002-20260319    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260319    gcc-14
i386        buildonly-randconfig-002-20260319    gcc-14
i386        buildonly-randconfig-003-20260319    gcc-14
i386        buildonly-randconfig-004-20260319    gcc-14
i386        buildonly-randconfig-005-20260319    gcc-14
i386        buildonly-randconfig-006-20260319    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260319    gcc-14
i386                  randconfig-002-20260319    gcc-14
i386                  randconfig-003-20260319    gcc-14
i386                  randconfig-004-20260319    gcc-14
i386                  randconfig-005-20260319    gcc-14
i386                  randconfig-006-20260319    gcc-14
i386                  randconfig-007-20260319    gcc-14
i386                  randconfig-011-20260319    clang-20
i386                  randconfig-012-20260319    clang-20
i386                  randconfig-013-20260319    clang-20
i386                  randconfig-014-20260319    clang-20
i386                  randconfig-015-20260319    clang-20
i386                  randconfig-016-20260319    clang-20
i386                  randconfig-017-20260319    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260319    gcc-11.5.0
loongarch             randconfig-002-20260319    gcc-11.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
m68k                          sun3x_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260319    gcc-11.5.0
nios2                 randconfig-002-20260319    gcc-11.5.0
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260319    clang-19
parisc                randconfig-002-20260319    clang-19
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                      chrp32_defconfig    clang-19
powerpc               randconfig-001-20260319    clang-19
powerpc               randconfig-002-20260319    clang-19
powerpc64             randconfig-001-20260319    clang-19
powerpc64             randconfig-002-20260319    clang-19
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260319    gcc-10.5.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260319    gcc-10.5.0
s390                  randconfig-002-20260319    gcc-10.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260319    gcc-10.5.0
sh                    randconfig-002-20260319    gcc-10.5.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260319    gcc-8.5.0
sparc                 randconfig-002-20260319    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260319    gcc-8.5.0
sparc64               randconfig-002-20260319    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260319    gcc-8.5.0
um                    randconfig-002-20260319    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260319    clang-20
x86_64      buildonly-randconfig-002-20260319    clang-20
x86_64      buildonly-randconfig-003-20260319    clang-20
x86_64      buildonly-randconfig-004-20260319    clang-20
x86_64      buildonly-randconfig-005-20260319    clang-20
x86_64      buildonly-randconfig-006-20260319    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260319    gcc-14
x86_64                randconfig-002-20260319    gcc-14
x86_64                randconfig-003-20260319    gcc-14
x86_64                randconfig-004-20260319    gcc-14
x86_64                randconfig-005-20260319    gcc-14
x86_64                randconfig-006-20260319    gcc-14
x86_64                randconfig-011-20260319    gcc-13
x86_64                randconfig-012-20260319    gcc-13
x86_64                randconfig-013-20260319    gcc-13
x86_64                randconfig-014-20260319    gcc-13
x86_64                randconfig-015-20260319    gcc-13
x86_64                randconfig-016-20260319    gcc-13
x86_64                randconfig-071-20260319    clang-20
x86_64                randconfig-072-20260319    clang-20
x86_64                randconfig-073-20260319    clang-20
x86_64                randconfig-074-20260319    clang-20
x86_64                randconfig-075-20260319    clang-20
x86_64                randconfig-076-20260319    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260319    gcc-8.5.0
xtensa                randconfig-002-20260319    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
