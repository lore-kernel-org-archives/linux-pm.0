Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793170984;
	b=r/vteJvZsUmObUVi5VaHvHBDb/hDV+/SvbugfXZ9vRSmf2iC+CCrzTOpmE8BKmJHuCvI
	 5dkgHV86R9pd1je5AAVi3pUX58sqI5FIQe63hWBX6meBfIsB7gd9KZcqcj56ObDb47pSn
	 7Ho8SuXj6jYHSBAnlCvXcxLgUk0oVyqHcNo7IAw57q4KL0L4b/UKcHxhkidQWE8J0vyW2
	 3RxTMEE7O0IUujaFjD3I+gGDF3WtXGMDVBnzmpHqB5iWxtgb0oW/S0yayLs+W45Y1HPCg
	 ekjk7sJ4/z/NFAvnQ54lmUmrIrES4GF8ebT8N4V1uwLlxXyLaBz4eZQcw3WRzDdnPMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793170984;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=M8gsc1FnnuRcyVD5mhCC8rAgj2DGzpXHiJ7DPrzJ4hs=;
	b=dDaPJQmLv6+bPLjLd8nDiBHLBxrx14y16waSYvoEfMUMqPiUeAdeRnbY+jkVXZwYgyfp
	 C0/ATvJno9uP01iw9y5eQHnJ8XBMurobAFG1AEcn4Pcap6M+y/26Us8DMvk9HFfS/kUDp
	 ozyCe1+LmXKWVWZC6UUEzzj/n7ROZL7YYiAbd8rpuoIuMu01TcvgnxZYYIlDrV0B/6Bpv
	 aUcK6MW5dVRDa5e9xqT90+mJJ0BuaVQuzo0i5DK7Csgvhshqa84PtWYztawU/Fh4BniBg
	 ij8/51sblLu/NXcUbTXaxQmGKb55s72Ew8ZL71V8Na9K85qGt9pVfxAZP/gV1SjPdRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bfejrytF;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A7E606A31D;
	Wed, 28 Oct 2026 07:03:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39A7E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bfejrytF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793170984; x=1824706984;
  h=date:from:to:cc:subject:message-id;
  bh=uK9dnM9AP16fcvStgcsdsHc/HnE6mO8kvECyM4PKsjo=;
  b=bfejrytFO2ARUrXBJdB9C6qY+dsPWemtFiSMM6wPzmLPmMen7mjbfXJy
   T1Y+0hCLNfWuVVscJrMqdnudDCWw90lKsePC0rFSvnyPiIUL5O25cN60/
   Bf/afs5W6opJFYtPmtrlCg+NfBHuFzGWur0Wof3npBk9carVF2W56Sjon
   H24JZtJGuOqjO/iDxcgPywapBxSwXoBhS9708IOmqiQTHH3EKraxh3g9z
   rSEY4nkZaETlBHCioWdbcQh2/n4w1Rlsy9hsnG7p1yFGM4IG+jHC7ryrr
   A2KDPTe3xz6R0SheYz7tVqp8jR9q693BMwngS7tUZs9mGHpKVojbZbSgk
   Q==;
X-CSE-ConnectionGUID: oNNttEYyTMy829o1RlQjCw==
X-CSE-MsgGUID: /5bnaW8xTkCo02jbSFIn1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1913533"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1913533"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 00:03:03 -0700
X-CSE-ConnectionGUID: QnPTXitRQy2DLPsIsA/Wdw==
X-CSE-MsgGUID: 3xfeYapAT7eVcRwIsmUAxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="4741685"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 28 Oct 2026 00:03:01 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xLxgZ-00000000YPg-01Vd;
	Wed, 28 Oct 2026 07:02:59 +0000
Date: Wed, 28 Oct 2026 15:02:11 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 f95680d1205afbcc23ce1b093b0b86fbc62c8aec
Message-ID: <202610281508.ZgsKoCRg-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: f95680d1205afbcc23ce1b093b0b86fbc62c8aec  Merge branch 'pm-cpufreq' into bleeding-edge

elapsed time: 487m

configs tested: 152
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
arc                               allmodconfig    clang-24
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.2.0
arc                   randconfig-1000-20261028    gcc-8.5.0
arc                   randconfig-1001-20261028    gcc-8.5.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                   randconfig-1000-20261028    gcc-8.5.0
arm                   randconfig-1001-20261028    gcc-8.5.0
arm                   randconfig-1002-20261028    gcc-8.5.0
arm                   randconfig-1003-20261028    gcc-8.5.0
arm64                             allmodconfig    clang-24
arm64                                defconfig    gcc-16.2.0
csky                              allmodconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
hexagon                           allmodconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261028    clang-17
hexagon               randconfig-1001-20261028    clang-17
i386                              allmodconfig    clang-22
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261028    clang-22
i386        buildonly-randconfig-1001-20261028    clang-22
i386        buildonly-randconfig-1002-20261028    clang-22
i386        buildonly-randconfig-1003-20261028    clang-22
i386        buildonly-randconfig-1004-20261028    clang-22
i386        buildonly-randconfig-1005-20261028    clang-22
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261028    gcc-14
i386                  randconfig-1001-20261028    gcc-14
i386                  randconfig-1002-20261028    gcc-14
i386                  randconfig-1003-20261028    gcc-14
i386                  randconfig-1004-20261028    gcc-14
i386                  randconfig-1005-20261028    gcc-14
i386                  randconfig-1006-20261028    gcc-14
i386                  randconfig-1007-20261028    clang-22
i386                  randconfig-1008-20261028    clang-22
i386                  randconfig-1009-20261028    clang-22
i386                  randconfig-1010-20261028    clang-22
i386                  randconfig-1011-20261028    clang-22
i386                  randconfig-1012-20261028    clang-22
i386                  randconfig-1013-20261028    clang-22
loongarch                         allmodconfig    clang-24
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261028    clang-17
loongarch             randconfig-1001-20261028    clang-17
m68k                              allmodconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
mips                              allmodconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261028    clang-17
nios2                 randconfig-1001-20261028    clang-17
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
openrisc                        virt_defconfig    clang-24
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261028    clang-19
parisc                randconfig-1001-20261028    clang-19
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                       bamboo_defconfig    clang-24
powerpc                       cm5200_defconfig    clang-24
powerpc                       ppc64e_defconfig    clang-24
powerpc               randconfig-1000-20261028    clang-19
powerpc               randconfig-1001-20261028    clang-19
powerpc                     sam440ep_defconfig    clang-24
powerpc64             randconfig-1000-20261028    clang-19
powerpc64             randconfig-1001-20261028    clang-19
riscv                             alldefconfig    clang-24
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                  kfr2r09-romimage_defconfig    clang-24
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261028    gcc-12
sparc                 randconfig-1001-20261028    gcc-12
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261028    gcc-12
sparc64               randconfig-1001-20261028    gcc-12
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261028    gcc-12
um                    randconfig-1001-20261028    gcc-12
um                            x86_64_defconfig    clang-24
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261028    clang-22
x86_64      buildonly-randconfig-1001-20261028    clang-22
x86_64      buildonly-randconfig-1002-20261028    clang-22
x86_64      buildonly-randconfig-1003-20261028    clang-22
x86_64      buildonly-randconfig-1004-20261028    clang-22
x86_64      buildonly-randconfig-1005-20261028    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261028    clang-22
x86_64                randconfig-1001-20261028    clang-22
x86_64                randconfig-1002-20261028    clang-22
x86_64                randconfig-1003-20261028    clang-22
x86_64                randconfig-1004-20261028    clang-22
x86_64                randconfig-1005-20261028    clang-22
x86_64                randconfig-1006-20261028    gcc-14
x86_64                randconfig-1007-20261028    gcc-14
x86_64                randconfig-1008-20261028    gcc-14
x86_64                randconfig-1009-20261028    gcc-14
x86_64                randconfig-1010-20261028    gcc-14
x86_64                randconfig-1011-20261028    gcc-14
x86_64                randconfig-1012-20261028    gcc-12
x86_64                randconfig-1013-20261028    gcc-12
x86_64                randconfig-1014-20261028    gcc-12
x86_64                randconfig-1015-20261028    gcc-12
x86_64                randconfig-1016-20261028    gcc-12
x86_64                randconfig-1017-20261028    gcc-12
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20261028    gcc-12
xtensa                randconfig-1001-20261028    gcc-12

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
