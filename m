Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B113D2DF12F;
	Sat, 29 Aug 2026 03:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787975030; cv=none; b=kdFl9pq9tguj2T3LwmYxmdFrqSjVilnPdmNAnFV2KoQf4hssczxKn5UiuJDUXYVl+C9u1mlJqHRwKwsYj31jStDq52Nv7EqLump3AduxboZupxq/Lc1daj4HcIwpT9B/ScfGxXHShTaiZayvNrFftIuuTdipgY4I3KSKd3SvSWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787975030; c=relaxed/simple;
	bh=uM+Cwv/c2L34XRWEDhGL/yAVRia5gZDoa4n/V/IpnbA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=d4jLODFoguchbsny3Yx5TOXLGy3oJ90o3Cq9BMBBfw/IoiiU1iS0m2yH2EUie8CO9Yu6THEkJ5+6+uteoC1sw8FKuj5v6XtIRgWEhXtku0MKYj980CFcRqpdIOss2vLs/SHPZwBgtpnvrjAAoGe+EnJH+l7LkhhSSKDBMVXrTVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HibyWPDZ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HibyWPDZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787975029; x=1819511029;
  h=date:from:to:cc:subject:message-id;
  bh=uM+Cwv/c2L34XRWEDhGL/yAVRia5gZDoa4n/V/IpnbA=;
  b=HibyWPDZ1EGxYuPrpZBvm5e0ubDi+grRMeQ/TZhBNc9hS+GqAkxWelQV
   qGejZUZDgrplmf7yBfnJETSaL1JCg5Elf23BOWg5aLyxAAMBwhv5qA1hk
   3NTSJAaGZj6iIZ6enT69t3ZEFe70vfnz9yVi1waXGfErnGl0JeOWN0fSA
   PLrRoHRDIlZl6hQuOoneM3vL9vaElDrR5AP51iFjsAGxyNAmgsDGzw2+L
   pDW5OtCHjNspsyQlXHBOeFao/SKUeciBIln0FOUpi/Y2k9uyuqwwaN3Dh
   8NhF5OyZmDYuEHBkt0EDy/Rqhqg/U5O76XVYJ1Efnki3lVrKucFeMre0T
   g==;
X-CSE-ConnectionGUID: sF98P1VCS2qXHEHpBGgaow==
X-CSE-MsgGUID: M3oI8/tXQLWtL1pj+U+s3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11889"; a="99077674"
X-IronPort-AV: E=Sophos;i="6.25,249,1779174000"; 
   d="scan'208";a="99077674"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 20:43:48 -0700
X-CSE-ConnectionGUID: r+rtv7HtSlGw1BHyVESoAw==
X-CSE-MsgGUID: DT+1pfm7Qh+xgqJwwfBCdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,249,1779174000"; 
   d="scan'208";a="268366245"
Received: from lkp-server01.sh.intel.com (HELO 3532383e6126) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 28 Aug 2026 20:43:46 -0700
Received: from kbuild by 3532383e6126 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x09yq-00000000CLA-0vmb;
	Sat, 29 Aug 2026 03:43:44 +0000
Date: Sat, 29 Aug 2026 11:43:04 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 b2f3581c6481ee2953b7707daa90c6f6ad16befd
Message-ID: <202608291150.FB6p0poo-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: b2f3581c6481ee2953b7707daa90c6f6ad16befd  Merge branch 'acpi-scan' into fixes

elapsed time: 789m

configs tested: 107
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha               allnoconfig    gcc-16.1.0
alpha              allyesconfig    gcc-16.1.0
alpha                 defconfig    gcc-16.1.0
arc                allmodconfig    clang-24
arc                allmodconfig    gcc-16.1.0
arc                 allnoconfig    gcc-16.1.0
arc                allyesconfig    clang-24
arc                allyesconfig    gcc-16.1.0
arc                   defconfig    gcc-16.1.0
arm                 allnoconfig    clang-17
arm                 allnoconfig    gcc-16.1.0
arm                allyesconfig    clang-24
arm                allyesconfig    gcc-16.1.0
arm                   defconfig    gcc-16.1.0
arm64              allmodconfig    clang-24
arm64               allnoconfig    gcc-16.1.0
arm64                 defconfig    gcc-16.1.0
csky               allmodconfig    gcc-16.1.0
csky                allnoconfig    gcc-16.1.0
csky                  defconfig    gcc-16.1.0
hexagon            allmodconfig    clang-24
hexagon            allmodconfig    gcc-16.1.0
hexagon             allnoconfig    clang-24
hexagon             allnoconfig    gcc-16.1.0
hexagon               defconfig    gcc-16.1.0
i386               allmodconfig    clang-22
i386                allnoconfig    gcc-14
i386                allnoconfig    gcc-16.1.0
i386               allyesconfig    clang-22
i386                  defconfig    gcc-16.1.0
loongarch          allmodconfig    clang-19
loongarch          allmodconfig    clang-24
loongarch           allnoconfig    clang-20
loongarch           allnoconfig    gcc-16.1.0
loongarch             defconfig    clang-24
m68k               allmodconfig    gcc-16.1.0
m68k                allnoconfig    gcc-16.1.0
m68k               allyesconfig    clang-24
m68k               allyesconfig    gcc-16.1.0
m68k                  defconfig    clang-24
microblaze          allnoconfig    gcc-16.1.0
microblaze         allyesconfig    gcc-16.1.0
microblaze            defconfig    clang-24
mips               allmodconfig    gcc-16.1.0
mips                allnoconfig    gcc-16.1.0
mips               allyesconfig    gcc-16.1.0
nios2              allmodconfig    clang-20
nios2              allmodconfig    gcc-11.5.0
nios2               allnoconfig    clang-24
nios2               allnoconfig    gcc-11.5.0
nios2                 defconfig    clang-24
openrisc           allmodconfig    clang-20
openrisc           allmodconfig    gcc-16.1.0
openrisc            allnoconfig    clang-24
openrisc            allnoconfig    gcc-16.1.0
parisc             allmodconfig    gcc-16.1.0
parisc              allnoconfig    clang-24
parisc              allnoconfig    gcc-16.1.0
parisc             allyesconfig    clang-17
parisc             allyesconfig    gcc-16.1.0
parisc64              defconfig    clang-24
powerpc            allmodconfig    gcc-16.1.0
powerpc             allnoconfig    clang-24
powerpc             allnoconfig    gcc-16.1.0
riscv              allmodconfig    clang-24
riscv               allnoconfig    clang-24
riscv               allnoconfig    gcc-16.1.0
riscv              allyesconfig    clang-24
s390               allmodconfig    clang-17
s390               allmodconfig    clang-24
s390                allnoconfig    clang-24
s390               allyesconfig    gcc-16.1.0
sh                 allmodconfig    gcc-16.1.0
sh                  allnoconfig    clang-24
sh                  allnoconfig    gcc-16.1.0
sh                 allyesconfig    clang-17
sh                 allyesconfig    gcc-16.1.0
sh                    defconfig    gcc-14
sparc               allnoconfig    clang-24
sparc               allnoconfig    gcc-16.1.0
sparc64            allmodconfig    clang-20
sparc64               defconfig    gcc-14
um                 allmodconfig    clang-17
um                  allnoconfig    clang-17
um                  allnoconfig    clang-24
um                 allyesconfig    gcc-14
um                 allyesconfig    gcc-16.1.0
um                    defconfig    gcc-14
um               i386_defconfig    gcc-14
um             x86_64_defconfig    gcc-14
x86_64             allmodconfig    clang-22
x86_64              allnoconfig    clang-22
x86_64              allnoconfig    clang-24
x86_64             allyesconfig    clang-22
x86_64                defconfig    gcc-14
x86_64                    kexec    clang-22
x86_64                 rhel-9.4    clang-22
x86_64             rhel-9.4-bpf    gcc-14
x86_64            rhel-9.4-func    clang-22
x86_64      rhel-9.4-kselftests    clang-22
x86_64           rhel-9.4-kunit    gcc-14
x86_64             rhel-9.4-ltp    gcc-14
x86_64            rhel-9.4-rust    clang-22
xtensa              allnoconfig    clang-24
xtensa              allnoconfig    gcc-16.1.0
xtensa             allyesconfig    clang-20
xtensa             allyesconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
