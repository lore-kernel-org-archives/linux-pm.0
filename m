Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FA73AEF2D;
	Tue,  4 Aug 2026 01:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785806716; cv=none; b=iQoExOGdOnS+fkiy2QUyXKkflj71umSyfrcrUF4J7zFG8sQuijpVoF6oEvbh1EcHJrCrsARqLe2wJPwY6tMnwT6bp2fi1L1WOvrAN1Tz0PRBakxOGLjiWgY0g7UrGBQrm3nDhvb0v7k0PsPsr7G4tkUXVPffKZT9EGBLZV61iGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785806716; c=relaxed/simple;
	bh=xJG9D6WQ97P2gqZHA/dOKvxdoBphG4D8moCNuxe6L2Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mnUguUiQvkUTm1k690Qho9ujZ7ur53v5VooZjU0rOrjzA1ansASIsE5fLl7LWAOUI1KuDHYbu2RWxrhwO2z6StPy0t6AD7bB28QSBlCS3Pw+ShJ4S/B1LRsqofJVfA94Gid74aJ2DoBThRZl9+D76n2bZYkNS9Wjb0qc/JXlBcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AqZh4a1E; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AqZh4a1E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785806715; x=1817342715;
  h=date:from:to:cc:subject:message-id;
  bh=xJG9D6WQ97P2gqZHA/dOKvxdoBphG4D8moCNuxe6L2Q=;
  b=AqZh4a1Ei6hqw8foE3ZzNcL0sFKbdPETtLScIugWUG7ZWzr1I63q7Dou
   Oc6IeKkJIim2ZKeYMF4OnQIAL0KO92RqFc3KA32QldLR3M+n9OOnPRH8l
   Gwxw3nW55O6XfqDbWuzr4/6itbykgkujHar07smb6hHpD70/9qavBB755
   wLiTClXppJe2H+NFpPGIZeMLhMIe77scivUEgNDI2vEEKqPrNnzxuouvA
   S1DV8OJZ2iuGU/D3sWA+wwydw6g4g79m8FeYpVQ7sILHk0/J/LUxmy9hS
   EErpwJaoTUyWBMWj4Awu3OV7qRzSIOyNfyaqlH+7v/irxXcZKpAi4gKVQ
   g==;
X-CSE-ConnectionGUID: swVjUNncR6q9nxU7inLmug==
X-CSE-MsgGUID: XpDMPhk8TFuwVV+gzP2cNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="97859946"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="97859946"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 18:25:14 -0700
X-CSE-ConnectionGUID: V7WmvkeaQpmMpykej6rvaw==
X-CSE-MsgGUID: L2FLA2udTICRrG8gUVHcnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="266489513"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 03 Aug 2026 18:25:12 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wr3u2-000000008al-1Iji;
	Tue, 04 Aug 2026 01:25:10 +0000
Date: Tue, 04 Aug 2026 09:24:04 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 d0cfeb26099f010ea90043372a803ea19a6ee672
Message-ID: <202608040952.XoSrMphq-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: d0cfeb26099f010ea90043372a803ea19a6ee672  Merge branch 'test/acpi-driver' into testing

elapsed time: 737m

configs tested: 89
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
i386                 randconfig-011-20260804    gcc-13
i386                 randconfig-012-20260804    gcc-13
i386                 randconfig-013-20260804    gcc-13
i386                 randconfig-014-20260804    gcc-13
i386                 randconfig-015-20260804    gcc-13
i386                 randconfig-016-20260804    gcc-13
i386                 randconfig-017-20260804    gcc-13
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260804    gcc-16.1.0
loongarch            randconfig-002-20260804    gcc-16.1.0
m68k                         atari_defconfig    gcc-16.1.0
mips                      bmips_be_defconfig    gcc-16.1.0
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
sh                                 defconfig    gcc-16.1.0
sparc                randconfig-001-20260804    gcc-16.1.0
sparc                randconfig-002-20260804    gcc-16.1.0
sparc64              randconfig-001-20260804    gcc-16.1.0
sparc64              randconfig-002-20260804    gcc-16.1.0
um                   randconfig-001-20260804    gcc-16.1.0
um                   randconfig-002-20260804    gcc-16.1.0
x86_64     buildonly-randconfig-001-20260804    gcc-14
x86_64     buildonly-randconfig-002-20260804    gcc-14
x86_64     buildonly-randconfig-003-20260804    gcc-14
x86_64     buildonly-randconfig-004-20260804    gcc-14
x86_64     buildonly-randconfig-005-20260804    gcc-14
x86_64     buildonly-randconfig-006-20260804    gcc-14
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260804    gcc-14
x86_64               randconfig-002-20260804    gcc-14
x86_64               randconfig-003-20260804    gcc-14
x86_64               randconfig-004-20260804    gcc-14
x86_64               randconfig-005-20260804    gcc-14
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
xtensa               randconfig-002-20260804    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
