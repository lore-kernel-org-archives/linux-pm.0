Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793150605;
	b=2O4NGEFkZj1h1/v+8JwXzKlcD1vecUQv0WtwMiRWzX5jzGIXkaqL9ihAzCvUh8b3FMBG
	 g/uLrhJCaIhsbclO5eK5SkB41eFHRu5FHmmeg1/2aJu7gBazvNQcOryda7Hm/G8Dij2KN
	 9kcfsbNSiy9PDE1seP3aWVISsT8g2TDxwyVqObe32AJT9UJhO+6Cp64n9pl4vTFktj2yg
	 lRKghvwVe/1eLkrruicXcEO+31bhs4cfAMH0VMb89Xul4Xc1Vrj9fw8keH25w9MZ/jWyE
	 VBtyM18ArSHB0nY09I7y1tKs9lYIrvUpA7/lKZ2/MEMyLrKpVZtPKY72732vQ1NDerQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793150605;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=z4lL/va3hRQrO6UmbYnPLHkiRHndwpW4aNgxZpSshco=;
	b=dhj4LtTkhEh86rQCi4TuSprZe+qye/Tw25jPSDOx6dhsbX22sWeryvEMcPQ+LoNwcerU
	 11LBIpbY+bhZWlnZgEi74eGwL4Rnw6oB1IhyZJpWIemp2Dt0luyw/PsKyDygujbdWnTox
	 n8cQct5qE4O6mbHCqRQSs0GMN6AUuojT8Xr5levsPYYVHa8w94qZfQ94/lgd3LmWe7xio
	 tZX+WjmeUD2BD20VwWRPa/sqSrBeMFtZ18KRkhtpSjjAgNYjeHmnTKhWl8I3aWBm/6szM
	 pGiqCTMWB4CwG9TUPlxG9HSWorIJ28I378NQ0dKxvg2z9f+0krE15Rnp0PHI6pgYURA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=A6oObGxG;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E401C606A31A;
	Wed, 28 Oct 2026 01:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E401C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=A6oObGxG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793150604; x=1824686604;
  h=date:from:to:cc:subject:message-id;
  bh=1w277LaduK9/Af5yCwpqyZW2ck1wsrlhfrGh5WCgG58=;
  b=A6oObGxG/rNwSu8matFwxZ6M4TEmPgbHuNQPHaVetuquyOLlJpUtMOeL
   zaSzFAjieOg5tVrG5ylDJ70T1pwvFX5yPkg8CNzEpYqI4s/ywrARau7L5
   QJcEnIWe0YyIgxV19rPfCUCmKVGhajhvGSzlMGKEIxrsb8W12h6KFIS7E
   1Cio5Qrj33GYMZBGMfNr7TRk+nhi+MWC/hsf42GWrGlLvhNESGytf95qo
   BIvpZIAI19sByD2n2Sr23A1v0Q0YDKUAzQ4yaBbqBOyUKu0qqmFBXDTv3
   kiUOIBh/6v4o/eXezKArV+Wj9e9btZCEWirZdWYVU+L8M6QT4nGHbxVVO
   Q==;
X-CSE-ConnectionGUID: BGlMn2jNT+ec73PPwVf4qA==
X-CSE-MsgGUID: JAPl3edsT4KvlTOCHYu02A==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1894975"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1894975"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 18:23:23 -0700
X-CSE-ConnectionGUID: nYlFxMKoSxSjbjeEEIRV7A==
X-CSE-MsgGUID: F6As0nsCSB6STMG2ayF9Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="4644521"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 27 Oct 2026 18:23:22 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xLsNr-00000000XzQ-1frD;
	Wed, 28 Oct 2026 01:23:19 +0000
Date: Wed, 28 Oct 2026 09:22:18 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 0f60d2bdc364232f07145d2114b95cc9cfa45c8b
Message-ID: <202610280913.n33Hdl21-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 0f60d2bdc364232f07145d2114b95cc9cfa45c8b  Merge branch 'thermal-core' into bleeding-edge

elapsed time: 1660m

configs tested: 225
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
arc                               allmodconfig    clang-24
arc                               allmodconfig    gcc-16.2.0
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.2.0
arc                   randconfig-1000-20261027    gcc-10.5.0
arc                   randconfig-1000-20261028    gcc-8.5.0
arc                   randconfig-1001-20261027    gcc-10.5.0
arc                   randconfig-1001-20261028    gcc-8.5.0
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                              mxs_defconfig    clang-17
arm                   randconfig-1000-20261027    gcc-10.5.0
arm                   randconfig-1000-20261028    gcc-8.5.0
arm                   randconfig-1001-20261027    gcc-10.5.0
arm                   randconfig-1001-20261028    gcc-8.5.0
arm                   randconfig-1002-20261027    gcc-10.5.0
arm                   randconfig-1002-20261028    gcc-8.5.0
arm                   randconfig-1003-20261027    gcc-10.5.0
arm                   randconfig-1003-20261028    gcc-8.5.0
arm                          s5pv210_defconfig    clang-24
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261027    gcc-8.5.0
arm64                 randconfig-1001-20261027    gcc-8.5.0
arm64                 randconfig-1002-20261027    gcc-8.5.0
arm64                 randconfig-1003-20261027    gcc-8.5.0
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261027    gcc-8.5.0
csky                  randconfig-1001-20261027    gcc-8.5.0
hexagon                           alldefconfig    clang-17
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261027    clang-24
hexagon               randconfig-1001-20261027    clang-24
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261027    clang-22
i386        buildonly-randconfig-1001-20261027    clang-22
i386        buildonly-randconfig-1002-20261027    clang-22
i386        buildonly-randconfig-1003-20261027    clang-22
i386        buildonly-randconfig-1004-20261027    clang-22
i386        buildonly-randconfig-1005-20261027    clang-22
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261027    gcc-14
i386                  randconfig-1001-20261027    gcc-14
i386                  randconfig-1002-20261027    gcc-14
i386                  randconfig-1003-20261027    gcc-14
i386                  randconfig-1004-20261027    gcc-14
i386                  randconfig-1005-20261027    gcc-14
i386                  randconfig-1006-20261027    gcc-14
i386                  randconfig-1007-20261027    gcc-14
i386                  randconfig-1008-20261027    gcc-14
i386                  randconfig-1009-20261027    gcc-14
i386                  randconfig-1010-20261027    gcc-14
i386                  randconfig-1011-20261027    gcc-14
i386                  randconfig-1012-20261027    gcc-14
i386                  randconfig-1013-20261027    gcc-14
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch                 loongson64_defconfig    gcc-16.2.0
loongarch             randconfig-1000-20261027    clang-24
loongarch             randconfig-1001-20261027    clang-24
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                              allyesconfig    gcc-16.2.0
m68k                           amiga_defconfig    clang-17
m68k                           amiga_defconfig    gcc-16.2.0
m68k                          apollo_defconfig    clang-24
m68k                        bvme6000_defconfig    gcc-16.2.0
m68k                                 defconfig    clang-24
m68k                         m5272c3_defconfig    gcc-16.2.0
m68k                        m5475evb_defconfig    clang-24
m68k                         mvme147_defconfig    clang-17
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                   decstation_64_defconfig    gcc-16.2.0
mips                         qi_lb60_defconfig    clang-17
mips                           rb532_defconfig    clang-24
nios2                          3c120_defconfig    clang-24
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261027    clang-24
nios2                 randconfig-1001-20261027    clang-24
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261027    clang-22
parisc                randconfig-1001-20261027    clang-22
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                      asp8347_defconfig    clang-24
powerpc                    currituck_defconfig    clang-17
powerpc                mpc834x_itxgp_defconfig    gcc-16.2.0
powerpc                     mvme5100_defconfig    clang-24
powerpc                      powernv_defconfig    gcc-16.2.0
powerpc               randconfig-1000-20261027    clang-22
powerpc               randconfig-1001-20261027    clang-22
powerpc                      skiroot_defconfig    clang-24
powerpc                      stx_gp3_defconfig    clang-17
powerpc                      tqm8560_defconfig    clang-17
powerpc64             randconfig-1000-20261027    clang-22
powerpc64             randconfig-1001-20261027    clang-22
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261027    gcc-16.2.0
riscv                 randconfig-1001-20261027    gcc-16.2.0
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261027    gcc-16.2.0
s390                  randconfig-1001-20261027    gcc-16.2.0
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                    randconfig-1000-20261027    gcc-16.2.0
sh                    randconfig-1001-20261027    gcc-16.2.0
sh                           rsk7264_defconfig    gcc-16.2.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261027    clang-20
sparc                 randconfig-1000-20261028    gcc-12
sparc                 randconfig-1001-20261027    clang-20
sparc                 randconfig-1001-20261028    gcc-12
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261027    clang-20
sparc64               randconfig-1000-20261028    gcc-12
sparc64               randconfig-1001-20261027    clang-20
sparc64               randconfig-1001-20261028    gcc-12
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261027    clang-20
um                    randconfig-1000-20261028    gcc-12
um                    randconfig-1001-20261027    clang-20
um                    randconfig-1001-20261028    gcc-12
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261027    gcc-14
x86_64      buildonly-randconfig-1000-20261028    clang-22
x86_64      buildonly-randconfig-1001-20261027    gcc-14
x86_64      buildonly-randconfig-1001-20261028    clang-22
x86_64      buildonly-randconfig-1002-20261027    gcc-14
x86_64      buildonly-randconfig-1002-20261028    clang-22
x86_64      buildonly-randconfig-1003-20261027    gcc-14
x86_64      buildonly-randconfig-1003-20261028    clang-22
x86_64      buildonly-randconfig-1004-20261027    gcc-14
x86_64      buildonly-randconfig-1004-20261028    clang-22
x86_64      buildonly-randconfig-1005-20261027    gcc-14
x86_64      buildonly-randconfig-1005-20261028    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261027    gcc-14
x86_64                randconfig-1000-20261028    clang-22
x86_64                randconfig-1001-20261027    gcc-14
x86_64                randconfig-1001-20261028    clang-22
x86_64                randconfig-1002-20261027    gcc-14
x86_64                randconfig-1002-20261028    clang-22
x86_64                randconfig-1003-20261027    gcc-14
x86_64                randconfig-1003-20261028    clang-22
x86_64                randconfig-1004-20261027    gcc-14
x86_64                randconfig-1004-20261028    clang-22
x86_64                randconfig-1005-20261027    gcc-14
x86_64                randconfig-1005-20261028    clang-22
x86_64                randconfig-1006-20261027    clang-22
x86_64                randconfig-1006-20261028    gcc-14
x86_64                randconfig-1007-20261027    clang-22
x86_64                randconfig-1007-20261028    gcc-14
x86_64                randconfig-1008-20261027    clang-22
x86_64                randconfig-1008-20261028    gcc-14
x86_64                randconfig-1009-20261027    clang-22
x86_64                randconfig-1009-20261028    gcc-14
x86_64                randconfig-1010-20261027    clang-22
x86_64                randconfig-1010-20261028    gcc-14
x86_64                randconfig-1011-20261027    clang-22
x86_64                randconfig-1011-20261028    gcc-14
x86_64                randconfig-1012-20261027    clang-22
x86_64                randconfig-1013-20261027    clang-22
x86_64                randconfig-1014-20261027    clang-22
x86_64                randconfig-1015-20261027    clang-22
x86_64                randconfig-1016-20261027    clang-22
x86_64                randconfig-1017-20261027    clang-22
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20261027    clang-20
xtensa                randconfig-1000-20261028    gcc-12
xtensa                randconfig-1001-20261027    clang-20
xtensa                randconfig-1001-20261028    gcc-12

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
