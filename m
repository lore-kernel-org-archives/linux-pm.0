Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A6A3B2FD6;
	Wed, 12 Aug 2026 11:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786533864; cv=none; b=nQ/EU1E/ozfc7qspetXs8Y/sdJSAnt+GO/FJnSq2V/gdCo8Ov70RHNUvo1SuT6E0KP51nDp+fPs5+w2+6Fv5sgI/LmS6MFScsjOM/ocoQ8u9fQa7r2HgWGEgrJpjTLH9gfclzNYayTFLa/qtDrfvAtaxVe3K2E88ndUlD+lyyNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786533864; c=relaxed/simple;
	bh=Y0QKdNQuzvuy4BfLAcJfLDiiAg5mKauDUJoFCyOZyXY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=k5F49QN/y5W7Kh4AAedDZZjd5TLAreppmt9o9z2eKwY/2yzXsW9QN9OYexIGDf7aE9wSGeqx3m92P57vtXLMjvaPqDR9jmz82otoH2I0jET+1WW+AuMumS+0mHsAhAbQdDmzGWjfJPmvoO3kmwScUJOVPbZQ5fKDeN5LcrVv6RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MGrSp54M; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MGrSp54M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786533863; x=1818069863;
  h=date:from:to:cc:subject:message-id;
  bh=Y0QKdNQuzvuy4BfLAcJfLDiiAg5mKauDUJoFCyOZyXY=;
  b=MGrSp54MNgFujk8Zec2lKG66j0t4lz//A2vP2DBjKqWAG30eWbuEmFM5
   h2Nf7R4O6d1Djts7kpWJVNa0A2nYqSh+ns9yWaN4tLv1rY74st6boMWNi
   g7F4iM8uhmdyciANwn6Xef28YoGKlNsHh4Cn6sdQZcbejJPnoE84uqIBn
   NRWoB76g/dPUzEDyHbqkGSqw/s5iTayrVRRvrHgaiqyWSP3BwRO4duAKc
   wgszBJZD0MubHNr6310hnU2I2fRdvEAHYuF8hoX26z2/f0aCUZ+ijMuaT
   cmvdieHRANc9V8QmfYUbGa/aAs6OXXEFkkrUplUs8ed4bCBkiqSOkcCw/
   w==;
X-CSE-ConnectionGUID: 0hd9fTcKTNGMHojllb8UUw==
X-CSE-MsgGUID: UPcq/VtDQ7uA2EMws1ihOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="90897480"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="90897480"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 04:24:22 -0700
X-CSE-ConnectionGUID: OFS49Sm2RaabJAjViEHXaA==
X-CSE-MsgGUID: iBaEpgkYSX2hBFgaRlH/sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="260995314"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 12 Aug 2026 04:24:21 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wu74E-00000000QWP-2XNb;
	Wed, 12 Aug 2026 11:24:18 +0000
Date: Wed, 12 Aug 2026 19:23:51 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 fc02d96a639b5b4ca32bd249e971e5d0aafeb874
Message-ID: <202608121937.J7M1vGVB-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: fc02d96a639b5b4ca32bd249e971e5d0aafeb874  Merge branch 'test/acpi-driver' into testing

elapsed time: 1515m

configs tested: 98
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260812    gcc-12.5.0
arc                  randconfig-002-20260812    gcc-10.5.0
arm                  randconfig-001-20260812    clang-19
arm                  randconfig-002-20260812    gcc-12.5.0
arm                  randconfig-003-20260812    gcc-14.3.0
arm                  randconfig-004-20260812    clang-24
arm64                randconfig-001-20260812    clang-24
arm64                randconfig-002-20260812    clang-20
arm64                randconfig-003-20260812    clang-17
arm64                randconfig-004-20260812    clang-24
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260812    gcc-10.5.0
csky                 randconfig-002-20260812    gcc-16.1.0
hexagon              randconfig-001-20260812    clang-24
hexagon              randconfig-002-20260812    clang-17
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260812    clang-22
i386       buildonly-randconfig-002-20260812    gcc-14
i386       buildonly-randconfig-003-20260812    clang-22
i386       buildonly-randconfig-004-20260812    clang-22
i386       buildonly-randconfig-005-20260812    gcc-14
i386       buildonly-randconfig-006-20260812    clang-22
i386                          randconfig-001    clang-22
i386                 randconfig-001-20260812    gcc-14
i386                 randconfig-002-20260812    gcc-14
i386                 randconfig-003-20260812    clang-22
i386                 randconfig-004-20260812    gcc-14
i386                 randconfig-005-20260812    gcc-14
i386                 randconfig-006-20260812    clang-22
i386                 randconfig-007-20260812    gcc-14
i386                 randconfig-011-20260812    gcc-14
i386                 randconfig-012-20260812    gcc-12
i386                 randconfig-013-20260812    clang-22
i386                 randconfig-014-20260812    clang-22
i386                 randconfig-015-20260812    clang-22
i386                 randconfig-016-20260812    clang-22
i386                 randconfig-017-20260812    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260812    clang-24
loongarch            randconfig-002-20260812    clang-24
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260812    gcc-11.5.0
nios2                randconfig-002-20260812    gcc-10.5.0
openrisc        de0_nano_multicore_defconfig    gcc-16.1.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc                        randconfig-001    gcc-8.5.0
parisc               randconfig-001-20260812    gcc-8.5.0
parisc               randconfig-002-20260812    gcc-8.5.0
powerpc              randconfig-001-20260812    gcc-14.3.0
powerpc              randconfig-002-20260812    clang-24
powerpc64            randconfig-001-20260812    clang-17
powerpc64            randconfig-002-20260812    clang-24
riscv                randconfig-001-20260812    clang-20
riscv                randconfig-002-20260812    gcc-8.5.0
s390                 randconfig-001-20260812    gcc-9.5.0
s390                 randconfig-002-20260812    clang-24
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260812    gcc-14.3.0
sh                   randconfig-002-20260812    gcc-12.5.0
sparc                randconfig-001-20260812    gcc-15.2.0
sparc                randconfig-002-20260812    gcc-13.4.0
sparc64              randconfig-001-20260812    gcc-15.2.0
sparc64              randconfig-002-20260812    gcc-13.4.0
um                   randconfig-001-20260812    clang-17
um                   randconfig-002-20260812    clang-20
x86_64     buildonly-randconfig-001-20260812    gcc-14
x86_64     buildonly-randconfig-002-20260812    gcc-14
x86_64     buildonly-randconfig-003-20260812    clang-22
x86_64     buildonly-randconfig-004-20260812    gcc-14
x86_64     buildonly-randconfig-005-20260812    gcc-14
x86_64     buildonly-randconfig-006-20260812    gcc-14
x86_64               randconfig-001-20260812    clang-22
x86_64               randconfig-002-20260812    gcc-14
x86_64               randconfig-003-20260812    gcc-14
x86_64               randconfig-004-20260812    clang-22
x86_64               randconfig-005-20260812    clang-22
x86_64               randconfig-006-20260812    clang-22
x86_64               randconfig-011-20260812    clang-22
x86_64               randconfig-012-20260812    clang-22
x86_64               randconfig-013-20260812    clang-22
x86_64               randconfig-014-20260812    gcc-14
x86_64               randconfig-015-20260812    clang-22
x86_64               randconfig-016-20260812    clang-22
x86_64               randconfig-071-20260811    clang-22
x86_64               randconfig-072-20260811    gcc-14
x86_64               randconfig-073-20260811    gcc-14
x86_64               randconfig-074-20260811    gcc-14
x86_64               randconfig-075-20260811    clang-22
x86_64               randconfig-076-20260811    gcc-14
xtensa               randconfig-001-20260812    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
