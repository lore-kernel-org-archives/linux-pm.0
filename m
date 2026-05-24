Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB1F63B9;
	Sun, 24 May 2026 07:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779608436; cv=none; b=LZoLrHjTLj0ycdusSw044oRNTgqk12gw8zvTY7xMs71dEShzlg33PE6BavBS4LjxCqDIf8f/fQe/sMVmldQu4MvFnNN9h0su51HIQUXwRiMnFTnDTlhSGnen+v72marS4Z7GG48ueE4XYECcAC4/iDQizqiwksYs0NMjRHYwTVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779608436; c=relaxed/simple;
	bh=p8BF20Pbxy+xNlnxy5Yr/pV69sHshV4mIdwWySKeKuY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WcksrRzoHL4R7qf1oR+wy/BsYqvy/E/8ZO2ZK/qInRK47uhniL2bE0PnZ+fLmecLzoLrOB+bUJQdiJWEplCktq6eWVsEHJqx/GIfT6iL3qX+4DTqSirDZefgq/DTeRSWuzcEuCgn17OFjhwW8ybX2yS9yubiltilnd1ngvVQw5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G66sWIN2; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G66sWIN2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779608435; x=1811144435;
  h=date:from:to:cc:subject:message-id;
  bh=p8BF20Pbxy+xNlnxy5Yr/pV69sHshV4mIdwWySKeKuY=;
  b=G66sWIN2EMVsYIm7araglppPRgXin9Db+E3PFUej1xd86Og2V5jeWsyn
   PcmYrz18iO+cb1+1DEikZgISkFG6FkQm51XuyabKPXipBMcQcLRWYHCcv
   vaxmhuv3FStU0Zwo8LrEmQdy2vvzy2GN1sqPrvbvj+tyMTRj8SyY3waFW
   wbFaNdZ7sNGmKl2CTKnSxOs89buu2IrUU24noOV0GCurBP6d6Q1O4UmNh
   Ue6Epap6z1EWg7XUtii8ZPoK3K3jPkf3WFykbC96elm9v6VWD6wJPEJT3
   X0m7IvvKg3p0uDGanGbwvQX1Gqoeh6rDk8hloDefnQmgUYZ/9rRKtyf+w
   A==;
X-CSE-ConnectionGUID: WRI7u15JTVuKhjSloc2XzA==
X-CSE-MsgGUID: V3IKH9+3TEi9Cf4hNAPFug==
X-IronPort-AV: E=McAfee;i="6800,10657,11795"; a="91939221"
X-IronPort-AV: E=Sophos;i="6.24,165,1774335600"; 
   d="scan'208";a="91939221"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2026 00:40:35 -0700
X-CSE-ConnectionGUID: Qpn8zzywScKwfMdyZI7K3Q==
X-CSE-MsgGUID: SKPGQ12yTEu9FSPE/oAmjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,165,1774335600"; 
   d="scan'208";a="245585735"
Received: from lkp-server01.sh.intel.com (HELO 6ba8523b1a8f) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 24 May 2026 00:40:34 -0700
Received: from kbuild by 6ba8523b1a8f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wR3Rm-000000000mn-3Mgp;
	Sun, 24 May 2026 07:40:30 +0000
Date: Sun, 24 May 2026 15:39:35 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 5eb11e016f257898c4778e3df4a4a8148c9fb17e
Message-ID: <202605241527.oLYpFk5v-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 5eb11e016f257898c4778e3df4a4a8148c9fb17e  Merge branch 'thermal-core' into bleeding-edge

elapsed time: 830m

configs tested: 71
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-15.2.0
alpha                  allyesconfig    gcc-15.2.0
arc                    allmodconfig    gcc-15.2.0
arc                     allnoconfig    gcc-15.2.0
arc                    allyesconfig    gcc-15.2.0
arc         randconfig-001-20260524    gcc-8.5.0
arc         randconfig-002-20260524    gcc-8.5.0
arm                     allnoconfig    clang-23
arm                    allyesconfig    gcc-15.2.0
arm         randconfig-001-20260524    clang-23
arm         randconfig-002-20260524    gcc-11.5.0
arm         randconfig-003-20260524    clang-19
arm64                  allmodconfig    clang-19
arm64                   allnoconfig    gcc-15.2.0
csky                   allmodconfig    gcc-15.2.0
csky                    allnoconfig    gcc-15.2.0
hexagon                allmodconfig    clang-17
hexagon                 allnoconfig    clang-23
i386                   allmodconfig    gcc-14
i386                    allnoconfig    gcc-14
i386                   allyesconfig    gcc-14
loongarch              allmodconfig    clang-19
loongarch               allnoconfig    clang-23
m68k                   allmodconfig    gcc-15.2.0
m68k                    allnoconfig    gcc-15.2.0
m68k                   allyesconfig    gcc-15.2.0
microblaze              allnoconfig    gcc-15.2.0
microblaze             allyesconfig    gcc-15.2.0
mips                   allmodconfig    gcc-15.2.0
mips                    allnoconfig    gcc-15.2.0
mips                   allyesconfig    gcc-15.2.0
nios2                  allmodconfig    gcc-11.5.0
nios2                   allnoconfig    gcc-11.5.0
openrisc               allmodconfig    gcc-15.2.0
openrisc                allnoconfig    gcc-15.2.0
parisc                 allmodconfig    gcc-15.2.0
parisc                  allnoconfig    gcc-15.2.0
parisc                 allyesconfig    gcc-15.2.0
parisc      randconfig-001-20260524    gcc-15.2.0
parisc      randconfig-002-20260524    gcc-12.5.0
powerpc                allmodconfig    gcc-15.2.0
powerpc                 allnoconfig    gcc-15.2.0
powerpc     randconfig-001-20260524    gcc-8.5.0
powerpc     randconfig-002-20260524    clang-23
powerpc64   randconfig-001-20260524    clang-23
powerpc64   randconfig-002-20260524    clang-23
riscv                  allmodconfig    clang-23
riscv                   allnoconfig    gcc-15.2.0
riscv                  allyesconfig    clang-16
s390                   allmodconfig    clang-18
s390                    allnoconfig    clang-23
s390                   allyesconfig    gcc-15.2.0
s390        randconfig-002-20260524    gcc-10.5.0
sh                     allmodconfig    gcc-15.2.0
sh                      allnoconfig    gcc-15.2.0
sh                     allyesconfig    gcc-15.2.0
sh                        defconfig    gcc-15.2.0
sh          randconfig-001-20260524    gcc-15.2.0
sparc                   allnoconfig    gcc-15.2.0
sparc64                allmodconfig    clang-23
um                     allmodconfig    clang-19
um                      allnoconfig    clang-23
um                     allyesconfig    gcc-14
um                        defconfig    clang-23
um                   i386_defconfig    gcc-14
um                 x86_64_defconfig    clang-23
x86_64                 allmodconfig    clang-20
x86_64                  allnoconfig    clang-20
x86_64                 allyesconfig    clang-20
x86_64                rhel-9.4-rust    clang-20
xtensa                  allnoconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
