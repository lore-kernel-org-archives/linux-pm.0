Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793970999;
	b=jkEhBM3YY8XybFtvGW2sJ1BZWnrXG1Zw9iHpqUraP2nI7dSjeM4mLSlHqNcmHig9Yeph
	 b9Wh5ugQWBdXSnOXdedPcOn9eqVHxYqc64W0yZffuCT2uhcKYSRVzDoOesXsB0G0CfWnN
	 xKiGpXyWMC5ZVVgw+YWC/2z1dFZyWk5hPfwfn19Op1wKkxYqHP/dWYL91u7xqqwIn9R/i
	 xZqhXaJWtEU3z3sKW8Xb+Y62D1fF85kuUOemXNXMLJ6Uq24ZXagHR/AoGj8ZKxe/L4wa1
	 4Fv/5rM9iSfbr8BBvxD/uI7YqaNstkRCVWQ2AdIoerqPGUIQAEuHjEyXhr9qDMHMuSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793970999;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=neUcqy59rdGTYWUWYiDMs3mftI6dCDRyXplcb66k+CI=;
	b=EnHWrY0zOONwcgkkRVwzJph4a4Ulbieg/7++WDZUgYeOYpVVJlwHLzc38j0ZUk4pHKgq
	 tA27eJsEBu+zONfYi7s4OlnoYVWFzApfU72bsXtNyUlOtljgMAWlRmJMZACO6CI9tOjZp
	 sFLFpd6lhKddJqEXXPxA/s1A2hLqX7ikny62bc64YwNc4SHD/9ZCo7wlPrY6fUWFqrDPw
	 n6Dnw7g0YPvIwQzdOw8GdGJw/exfYU3kbSlffqsptpYN4wvGdgOBl644NwR5Au9qM/hpg
	 l0Q+AVOlGyHz8ggn3s1p3CajHNXyzbh4/1ZilRTxXKj/jvHSij33oh0YRUmGx6K0Cgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OFlSjWP4;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ACF606A329;
	Fri,  6 Nov 2026 13:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7ACF606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OFlSjWP4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793970998; x=1825506998;
  h=date:from:to:cc:subject:message-id;
  bh=AQIQu7halLOaNxnud5Lubg5lS8LJP5GpUCzKr7oms/g=;
  b=OFlSjWP4wqXiMmCQmiD02fT3U3QjRPQj8W3ha0q0zk0dRM4+QyCYE9D4
   YqXbHU0eppNSpxkD9ahSpiTGkYcI0iNwuF8FS1h3W1RVtjjGGKaRAj1gi
   szcEUMtMg1fRUhtJbAYq+LfQ4/YEk1AgNpHdSfoQz7/EpS3Wovyo2elmV
   ProtH/ieq2auTxVXrfsfXND4vq0DsvDKyky69RQTehJ/G/PNuDc11S1qm
   2+vzje8ZpdcQK2fdhh4U4TANSyxrpG15xxg6kL9k2zbG35m8mMmf9cO2s
   jR61Ngj857DUAM349/a4lNNKJ7pLnTZM6ybAWvMFCnSfQK0VCuLaOk2dw
   g==;
X-CSE-ConnectionGUID: NDwGzEniTw2QSvtnvG+x0g==
X-CSE-MsgGUID: ZYtKCAZCR5S7gYVIOBBCVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2822055"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2822055"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 05:16:37 -0800
X-CSE-ConnectionGUID: 9GtI855aSA2F/0iHAs1IdQ==
X-CSE-MsgGUID: cCok+T3mTs2t0E3/zMSi+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7612910"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 06 Nov 2026 05:16:35 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xPJo1-00000000pJF-1MSX;
	Fri, 06 Nov 2026 13:16:33 +0000
Date: Fri, 06 Nov 2026 21:15:32 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 36a4f923401598d1e351fcc36cf42013b1053402
Message-ID: <20261106211532.izTbybdg-lkp@intel.com>
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
branch HEAD: 36a4f923401598d1e351fcc36cf42013b1053402  Merge branch 'acpi-pci' into bleeding-edge

elapsed time: 1028m

configs tested: 622
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
alpha                 randconfig-2000-20261105    gcc-15.3.0
alpha                 randconfig-2000-20261106    gcc-8.5.0
alpha                 randconfig-2001-20261105    gcc-15.3.0
alpha                 randconfig-2001-20261106    gcc-8.5.0
alpha                 randconfig-2200-20261105    gcc-9.5.0  smatch
alpha                 randconfig-2200-20261106    gcc-14.4.0 smatch
alpha                randconfig-r2101-20261106    gcc-8.5.0  cocci
alpha                randconfig-r2102-20261106    gcc-8.5.0  cocci
alpha                randconfig-r2105-20261106    gcc-11.5.0 cocci
alpha                randconfig-r2105-20261106    gcc-16.2.0 cocci
alpha                randconfig-r2106-20261106    clang-24   cocci
alpha                randconfig-r2107-20261106    clang-24   cocci
alpha                randconfig-r2110-20261106    gcc-16.2.0 cocci
alpha                randconfig-r2111-20261106    clang-24   cocci
alpha                randconfig-r2301-20261106    gcc-11.5.0 sparse
alpha                randconfig-r2304-20261106    gcc-12     sparse
alpha                randconfig-r2308-20261105    gcc-8.5.0  sparse
alpha                randconfig-r2311-20261105    gcc-8.5.0  sparse
arc                               allmodconfig    clang-24
arc                               allmodconfig    gcc-16.2.0
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                           axs103_defconfig    clang-19
arc                                  defconfig    gcc-16.2.0
arc                         nsim_700_defconfig    gcc-16.2.0
arc                   randconfig-1000-20261106    gcc-8.5.0
arc                   randconfig-1001-20261106    gcc-8.5.0
arc                   randconfig-2000-20261105    gcc-8.5.0
arc                   randconfig-2000-20261106    gcc-12.5.0
arc                   randconfig-2001-20261105    gcc-8.5.0
arc                   randconfig-2001-20261106    gcc-12.5.0
arc                   randconfig-2002-20261105    gcc-8.5.0
arc                   randconfig-2002-20261106    gcc-12.5.0
arc                   randconfig-2003-20261105    gcc-8.5.0
arc                   randconfig-2003-20261106    gcc-12.5.0
arc                   randconfig-2004-20261105    gcc-8.5.0
arc                   randconfig-2004-20261106    gcc-12.5.0
arc                   randconfig-2005-20261105    gcc-8.5.0
arc                   randconfig-2005-20261106    gcc-12.5.0
arc                   randconfig-2200-20261105    gcc-8.5.0  smatch
arc                   randconfig-2200-20261106    gcc-10.5.0 smatch
arc                  randconfig-r2101-20261105    gcc-8.5.0  cocci
arc                  randconfig-r2106-20261106    clang-24   cocci
arc                  randconfig-r2106-20261106    gcc-14.4.0 cocci
arc                  randconfig-r2107-20261106    clang-24   cocci
arc                  randconfig-r2109-20261106    clang-24   cocci
arc                  randconfig-r2301-20261106    gcc-8.5.0  sparse
arc                  randconfig-r2302-20261106    gcc-11.5.0 sparse
arc                  randconfig-r2306-20261106    clang-17   sparse
arc                  randconfig-r2307-20261106    clang-17   sparse
arc                  randconfig-r2307-20261106    gcc-10.5.0 sparse
arc                  randconfig-r2310-20261106    gcc-16.2.0 sparse
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                         clps711x_defconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                          lpc32xx_defconfig    clang-17
arm                             mps2_defconfig    clang-24
arm                   randconfig-1000-20261106    gcc-8.5.0
arm                   randconfig-1001-20261106    gcc-8.5.0
arm                   randconfig-1002-20261106    gcc-8.5.0
arm                   randconfig-1003-20261106    gcc-8.5.0
arm                   randconfig-2000-20261105    clang-24
arm                   randconfig-2000-20261106    gcc-9.5.0
arm                   randconfig-2001-20261105    clang-24
arm                   randconfig-2001-20261106    gcc-9.5.0
arm                   randconfig-2002-20261105    clang-24
arm                   randconfig-2002-20261106    gcc-9.5.0
arm                   randconfig-2200-20261105    gcc-15.3.0 smatch
arm                   randconfig-2200-20261106    clang-17   smatch
arm                  randconfig-r2102-20261106    gcc-8.5.0  cocci
arm                  randconfig-r2104-20261105    clang-24   cocci
arm                  randconfig-r2104-20261106    gcc-16.2.0 cocci
arm                  randconfig-r2105-20261106    gcc-8.5.0  cocci
arm                  randconfig-r2107-20261106    gcc-16.2.0 cocci
arm                  randconfig-r2111-20261106    gcc-8.5.0  cocci
arm                  randconfig-r2304-20261106    gcc-8.5.0  sparse
arm                              rpc_defconfig    gcc-16.2.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261106    clang-17
arm64                 randconfig-1001-20261106    clang-17
arm64                 randconfig-1002-20261106    clang-17
arm64                 randconfig-1003-20261106    clang-17
arm64                 randconfig-2000-20261105    clang-24
arm64                 randconfig-2000-20261106    gcc-9.5.0
arm64                 randconfig-2001-20261105    clang-24
arm64                 randconfig-2001-20261106    gcc-9.5.0
arm64                 randconfig-2002-20261105    clang-24
arm64                 randconfig-2002-20261106    gcc-9.5.0
arm64                 randconfig-2200-20261105    clang-20   smatch
arm64                 randconfig-2200-20261106    clang-24   smatch
arm64                randconfig-r2100-20261106    gcc-10.5.0 cocci
arm64                randconfig-r2107-20261106    clang-24   cocci
arm64                randconfig-r2111-20261106    gcc-16.2.0 cocci
arm64                randconfig-r2308-20261106    clang-17   sparse
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261106    clang-17
csky                  randconfig-1001-20261106    clang-17
csky                  randconfig-2000-20261105    clang-24
csky                  randconfig-2000-20261106    clang-24
csky                  randconfig-2001-20261105    clang-24
csky                  randconfig-2001-20261106    clang-24
csky                  randconfig-2200-20261105    gcc-9.5.0  smatch
csky                  randconfig-2200-20261106    gcc-10.5.0 smatch
csky                 randconfig-r2105-20261105    clang-24   cocci
csky                 randconfig-r2108-20261106    clang-24   cocci
csky                 randconfig-r2108-20261106    gcc-8.5.0  cocci
csky                 randconfig-r2300-20261106    clang-17   sparse
csky                 randconfig-r2301-20261105    gcc-14     sparse
csky                 randconfig-r2304-20261106    clang-17   sparse
csky                 randconfig-r2309-20261106    gcc-16.2.0 sparse
csky                 randconfig-r2311-20261106    gcc-16.2.0 sparse
hexagon                           alldefconfig    clang-24
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261106    gcc-14.4.0
hexagon               randconfig-1001-20261106    gcc-14.4.0
hexagon               randconfig-2000-20261105    clang-24
hexagon               randconfig-2000-20261106    clang-24
hexagon               randconfig-2001-20261105    clang-24
hexagon               randconfig-2001-20261106    clang-24
hexagon               randconfig-2200-20261105    clang-17   smatch
hexagon               randconfig-2200-20261106    clang-24   smatch
hexagon              randconfig-r2102-20261105    clang-24   cocci
hexagon              randconfig-r2105-20261105    clang-24   cocci
hexagon              randconfig-r2105-20261106    gcc-8.5.0  cocci
hexagon              randconfig-r2106-20261106    gcc-16.2.0 cocci
hexagon              randconfig-r2106-20261106    gcc-8.5.0  cocci
hexagon              randconfig-r2109-20261106    gcc-14.4.0 cocci
hexagon              randconfig-r2110-20261105    gcc-16.2.0 cocci
hexagon              randconfig-r2110-20261106    clang-24   cocci
hexagon              randconfig-r2301-20261106    clang-17   sparse
hexagon              randconfig-r2308-20261106    clang-22   sparse
hexagon              randconfig-r2310-20261106    clang-17   sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261106    clang-22
i386        buildonly-randconfig-1001-20261106    clang-22
i386        buildonly-randconfig-1002-20261106    clang-22
i386        buildonly-randconfig-1003-20261106    clang-22
i386        buildonly-randconfig-1004-20261106    clang-22
i386        buildonly-randconfig-1005-20261106    clang-22
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261106    gcc-14
i386                  randconfig-1001-20261106    gcc-14
i386                  randconfig-1002-20261106    gcc-14
i386                  randconfig-1003-20261106    gcc-14
i386                  randconfig-1004-20261106    gcc-14
i386                  randconfig-1005-20261106    gcc-14
i386                  randconfig-1006-20261106    gcc-14
i386                  randconfig-1007-20261106    gcc-14
i386                  randconfig-1008-20261106    gcc-14
i386                  randconfig-1009-20261106    gcc-14
i386                  randconfig-1010-20261106    gcc-14
i386                  randconfig-1011-20261106    gcc-14
i386                  randconfig-1012-20261106    gcc-14
i386                  randconfig-1013-20261106    gcc-14
i386                  randconfig-2000-20261105    clang-22
i386                  randconfig-2000-20261106    gcc-14
i386                  randconfig-2001-20261105    clang-22
i386                  randconfig-2001-20261106    gcc-14
i386                  randconfig-2002-20261105    clang-22
i386                  randconfig-2002-20261106    gcc-14
i386                  randconfig-2003-20261105    clang-22
i386                  randconfig-2003-20261106    gcc-14
i386                  randconfig-2004-20261105    clang-22
i386                  randconfig-2004-20261106    gcc-14
i386                  randconfig-2005-20261105    clang-22
i386                  randconfig-2005-20261106    gcc-14
i386                  randconfig-2100-20261105    gcc-14     cocci
i386                  randconfig-2100-20261106    clang-22   cocci
i386                  randconfig-2101-20261105    gcc-14     cocci
i386                  randconfig-2101-20261106    clang-22   cocci
i386                  randconfig-2102-20261105    gcc-14     cocci
i386                  randconfig-2102-20261106    clang-22   cocci
i386                  randconfig-2103-20261105    gcc-14     cocci
i386                  randconfig-2103-20261106    clang-22   cocci
i386                  randconfig-2104-20261105    gcc-14     cocci
i386                  randconfig-2104-20261106    clang-22   cocci
i386                  randconfig-2105-20261105    gcc-14     cocci
i386                  randconfig-2105-20261106    clang-22   cocci
i386                  randconfig-2200-20261105    clang-22   smatch
i386                  randconfig-2200-20261106    clang-22   smatch
i386                  randconfig-2300-20261105    clang-22   sparse
i386                  randconfig-2300-20261106    clang-22   sparse
i386                  randconfig-2301-20261105    clang-22   sparse
i386                  randconfig-2301-20261106    clang-22   sparse
i386                  randconfig-2302-20261105    clang-22   sparse
i386                  randconfig-2302-20261106    clang-22   sparse
i386                 randconfig-r2103-20261105    clang-24   cocci
i386                 randconfig-r2109-20261106    gcc-8.5.0  cocci
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261106    gcc-14.4.0
loongarch             randconfig-1001-20261106    gcc-14.4.0
loongarch             randconfig-2000-20261105    gcc-16.2.0
loongarch             randconfig-2000-20261106    clang-19
loongarch             randconfig-2001-20261105    gcc-16.2.0
loongarch             randconfig-2001-20261106    clang-19
loongarch             randconfig-2200-20261105    gcc-16.2.0 smatch
loongarch             randconfig-2200-20261106    clang-24   smatch
loongarch            randconfig-r2106-20261106    clang-24   cocci
loongarch            randconfig-r2301-20261106    gcc-15.3.0 sparse
loongarch            randconfig-r2305-20261105    gcc-14     sparse
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                              allyesconfig    gcc-16.2.0
m68k                                 defconfig    clang-24
m68k                        m5329evb_defconfig    clang-24
m68k                       m54418evb_defconfig    clang-19
m68k                          nettel_defconfig    gcc-16.2.0
m68k                  randconfig-2000-20261105    gcc-15.3.0
m68k                  randconfig-2000-20261106    gcc-8.5.0
m68k                  randconfig-2001-20261105    gcc-15.3.0
m68k                  randconfig-2001-20261106    gcc-8.5.0
m68k                  randconfig-2200-20261105    gcc-8.5.0  smatch
m68k                  randconfig-2200-20261106    gcc-11.5.0 smatch
m68k                 randconfig-r2102-20261105    gcc-8.5.0  cocci
m68k                 randconfig-r2103-20261106    gcc-10.5.0 cocci
m68k                 randconfig-r2104-20261106    gcc-10.5.0 cocci
m68k                 randconfig-r2110-20261106    gcc-8.5.0  cocci
m68k                 randconfig-r2303-20261106    gcc-8.5.0  sparse
m68k                 randconfig-r2305-20261106    gcc-11.5.0 sparse
m68k                 randconfig-r2306-20261106    gcc-10.5.0 sparse
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
microblaze            randconfig-2000-20261105    gcc-15.3.0
microblaze            randconfig-2000-20261106    gcc-8.5.0
microblaze            randconfig-2001-20261105    gcc-15.3.0
microblaze            randconfig-2001-20261106    gcc-8.5.0
microblaze            randconfig-2200-20261105    gcc-9.5.0  smatch
microblaze            randconfig-2200-20261106    gcc-14.4.0 smatch
microblaze           randconfig-r2100-20261106    gcc-11.5.0 cocci
microblaze           randconfig-r2102-20261106    gcc-16.2.0 cocci
microblaze           randconfig-r2105-20261106    gcc-10.5.0 cocci
microblaze           randconfig-r2107-20261105    gcc-16.2.0 cocci
microblaze           randconfig-r2108-20261106    gcc-14.4.0 cocci
microblaze           randconfig-r2302-20261106    gcc-15.3.0 sparse
microblaze           randconfig-r2309-20261106    gcc-10.5.0 sparse
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                   cavium_octeon_defconfig    gcc-16.2.0
mips                          db1xxx_defconfig    gcc-16.2.0
mips                       loongson3_defconfig    gcc-16.2.0
mips                     maltaup_xpa_defconfig    clang-19
mips                  randconfig-2000-20261105    gcc-9.5.0
mips                  randconfig-2000-20261106    gcc-8.5.0
mips                  randconfig-2001-20261105    gcc-9.5.0
mips                  randconfig-2001-20261106    gcc-8.5.0
mips                  randconfig-2002-20261105    gcc-9.5.0
mips                  randconfig-2002-20261106    gcc-8.5.0
mips                  randconfig-2200-20261105    gcc-11.5.0 smatch
mips                  randconfig-2200-20261106    clang-17   smatch
mips                 randconfig-r2104-20261105    gcc-8.5.0  cocci
mips                 randconfig-r2104-20261106    gcc-11.5.0 cocci
mips                 randconfig-r2110-20261106    clang-24   cocci
mips                 randconfig-r2304-20261106    gcc-11.5.0 sparse
mips                 randconfig-r2311-20261106    clang-17   sparse
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261106    gcc-14.4.0
nios2                 randconfig-1001-20261106    gcc-14.4.0
nios2                 randconfig-2000-20261105    gcc-16.2.0
nios2                 randconfig-2000-20261106    clang-19
nios2                 randconfig-2001-20261105    gcc-16.2.0
nios2                 randconfig-2001-20261106    clang-19
nios2                 randconfig-2200-20261105    gcc-9.5.0  smatch
nios2                 randconfig-2200-20261106    gcc-10.5.0 smatch
nios2                randconfig-r2100-20261106    gcc-8.5.0  cocci
nios2                randconfig-r2102-20261106    gcc-10.5.0 cocci
nios2                randconfig-r2103-20261106    gcc-11.5.0 cocci
nios2                randconfig-r2108-20261106    clang-24   cocci
nios2                randconfig-r2111-20261106    clang-24   cocci
nios2                randconfig-r2300-20261106    gcc-12     sparse
nios2                randconfig-r2303-20261106    gcc-11.5.0 sparse
nios2                randconfig-r2310-20261105    gcc-8.5.0  sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                    de0_nano_defconfig    clang-19
openrisc                             defconfig    gcc-16.2.0
openrisc                   or1klitex_defconfig    clang-24
openrisc                   or1klitex_defconfig    gcc-16.2.0
openrisc              randconfig-2000-20261105    gcc-9.5.0
openrisc              randconfig-2000-20261106    gcc-8.5.0
openrisc              randconfig-2001-20261105    gcc-9.5.0
openrisc              randconfig-2001-20261106    gcc-8.5.0
openrisc              randconfig-2002-20261105    gcc-9.5.0
openrisc              randconfig-2002-20261106    gcc-8.5.0
openrisc              randconfig-2200-20261106    gcc-16.2.0 smatch
openrisc             randconfig-r2100-20261105    clang-24   cocci
openrisc             randconfig-r2102-20261106    gcc-11.5.0 cocci
openrisc             randconfig-r2106-20261106    clang-24   cocci
openrisc             randconfig-r2111-20261105    gcc-16.2.0 cocci
openrisc             randconfig-r2302-20261106    clang-17   sparse
openrisc             randconfig-r2304-20261105    gcc-14     sparse
openrisc             randconfig-r2309-20261106    clang-17   sparse
openrisc             randconfig-r2310-20261106    gcc-10.5.0 sparse
openrisc                  simple_smp_defconfig    gcc-16.2.0
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261106    clang-19
parisc                randconfig-1001-20261106    clang-19
parisc                randconfig-2000-20261105    gcc-16.2.0
parisc                randconfig-2000-20261106    clang-19
parisc                randconfig-2001-20261105    gcc-16.2.0
parisc                randconfig-2001-20261106    clang-19
parisc                randconfig-2200-20261105    gcc-15.3.0 smatch
parisc                randconfig-2200-20261106    gcc-12.5.0 smatch
parisc               randconfig-r2104-20261106    gcc-8.5.0  cocci
parisc               randconfig-r2109-20261106    clang-24   cocci
parisc               randconfig-r2300-20261106    gcc-11.5.0 sparse
parisc               randconfig-r2303-20261106    gcc-15.3.0 sparse
parisc               randconfig-r2304-20261106    gcc-15.3.0 sparse
parisc               randconfig-r2305-20261106    gcc-8.5.0  sparse
parisc               randconfig-r2306-20261105    gcc-8.5.0  sparse
parisc               randconfig-r2307-20261105    gcc-15.3.0 sparse
parisc               randconfig-r2308-20261105    gcc-15.3.0 sparse
parisc               randconfig-r2308-20261106    gcc-10.5.0 sparse
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                      ep8248e_defconfig    clang-24
powerpc                       ep88xc_defconfig    clang-17
powerpc                     gamecube_defconfig    clang-19
powerpc                      kmeter1_defconfig    gcc-16.2.0
powerpc                       mgcoge_defconfig    clang-17
powerpc                      mpc512x_defconfig    gcc-16.2.0
powerpc                   mpc885_ads_defconfig    clang-19
powerpc                       pcm030_defconfig    gcc-16.2.0
powerpc               randconfig-1000-20261106    clang-19
powerpc               randconfig-1001-20261106    clang-19
powerpc               randconfig-2000-20261105    clang-18
powerpc               randconfig-2000-20261106    gcc-8.5.0
powerpc               randconfig-2001-20261105    clang-18
powerpc               randconfig-2001-20261106    gcc-8.5.0
powerpc               randconfig-2002-20261105    clang-18
powerpc               randconfig-2002-20261106    gcc-8.5.0
powerpc               randconfig-2200-20261105    clang-17   smatch
powerpc               randconfig-2200-20261106    clang-24   smatch
powerpc              randconfig-r2101-20261106    gcc-11.5.0 cocci
powerpc              randconfig-r2108-20261106    clang-24   cocci
powerpc              randconfig-r2111-20261106    gcc-14.4.0 cocci
powerpc                      redwood_defconfig    gcc-16.2.0
powerpc                     sam440ep_defconfig    gcc-16.2.0
powerpc                      tqm8555_defconfig    clang-19
powerpc                  xes_mpc85xx_defconfig    clang-17
powerpc64             randconfig-1000-20261106    clang-19
powerpc64             randconfig-1001-20261106    clang-19
powerpc64             randconfig-2000-20261105    clang-18
powerpc64             randconfig-2000-20261106    gcc-8.5.0
powerpc64             randconfig-2001-20261105    clang-18
powerpc64             randconfig-2001-20261106    gcc-8.5.0
powerpc64             randconfig-2002-20261105    clang-18
powerpc64             randconfig-2002-20261106    gcc-8.5.0
powerpc64             randconfig-2200-20261105    clang-24   smatch
powerpc64             randconfig-2200-20261106    gcc-8.5.0  smatch
powerpc64            randconfig-r2101-20261106    gcc-16.2.0 cocci
powerpc64            randconfig-r2102-20261105    clang-24   cocci
powerpc64            randconfig-r2103-20261105    gcc-8.5.0  cocci
powerpc64            randconfig-r2302-20261105    gcc-14     sparse
powerpc64            randconfig-r2307-20261105    gcc-8.5.0  sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261106    gcc-14.4.0
riscv                 randconfig-1001-20261106    gcc-14.4.0
riscv                 randconfig-2000-20261105    clang-24
riscv                 randconfig-2000-20261106    gcc-13.5.0
riscv                 randconfig-2001-20261105    clang-24
riscv                 randconfig-2001-20261106    gcc-13.5.0
riscv                 randconfig-2002-20261105    clang-24
riscv                 randconfig-2002-20261106    gcc-13.5.0
riscv                 randconfig-2003-20261105    clang-24
riscv                 randconfig-2003-20261106    gcc-13.5.0
riscv                 randconfig-2004-20261105    clang-24
riscv                 randconfig-2004-20261106    gcc-13.5.0
riscv                 randconfig-2005-20261105    clang-24
riscv                 randconfig-2005-20261106    gcc-13.5.0
riscv                 randconfig-2200-20261105    clang-24   smatch
riscv                 randconfig-2200-20261106    gcc-11.5.0 smatch
riscv                randconfig-r2100-20261105    gcc-8.5.0  cocci
riscv                randconfig-r2103-20261106    gcc-8.5.0  cocci
riscv                randconfig-r2105-20261106    gcc-11.5.0 cocci
riscv                randconfig-r2300-20261106    gcc-8.5.0  sparse
riscv                randconfig-r2303-20261106    clang-17   sparse
riscv                randconfig-r2305-20261106    gcc-12     sparse
riscv                randconfig-r2309-20261105    gcc-8.5.0  sparse
riscv                randconfig-r2311-20261105    gcc-15.3.0 sparse
s390                              alldefconfig    clang-17
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261106    gcc-14.4.0
s390                  randconfig-1001-20261106    gcc-14.4.0
s390                  randconfig-2000-20261105    clang-24
s390                  randconfig-2000-20261106    gcc-8.5.0
s390                  randconfig-2001-20261105    clang-24
s390                  randconfig-2001-20261106    gcc-8.5.0
s390                  randconfig-2002-20261105    clang-24
s390                  randconfig-2002-20261106    gcc-8.5.0
s390                  randconfig-2003-20261105    clang-24
s390                  randconfig-2003-20261106    gcc-8.5.0
s390                  randconfig-2004-20261105    clang-24
s390                  randconfig-2004-20261106    gcc-8.5.0
s390                  randconfig-2005-20261105    clang-24
s390                  randconfig-2005-20261106    gcc-8.5.0
s390                  randconfig-2200-20261105    clang-24   smatch
s390                  randconfig-2200-20261106    clang-18   smatch
s390                 randconfig-r2101-20261106    gcc-11.5.0 cocci
s390                 randconfig-r2101-20261106    gcc-8.5.0  cocci
s390                 randconfig-r2108-20261105    gcc-16.2.0 cocci
s390                 randconfig-r2109-20261106    clang-24   cocci
s390                 randconfig-r2303-20261105    gcc-14     sparse
s390                 randconfig-r2305-20261106    clang-17   sparse
s390                 randconfig-r2307-20261106    clang-22   sparse
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                  kfr2r09-romimage_defconfig    clang-17
sh                             migor_defconfig    clang-24
sh                    randconfig-1000-20261106    gcc-14.4.0
sh                    randconfig-1001-20261106    gcc-14.4.0
sh                    randconfig-2000-20261105    gcc-16.2.0
sh                    randconfig-2000-20261106    gcc-16.2.0
sh                    randconfig-2001-20261105    gcc-16.2.0
sh                    randconfig-2001-20261106    gcc-16.2.0
sh                    randconfig-2002-20261105    gcc-16.2.0
sh                    randconfig-2002-20261106    gcc-16.2.0
sh                    randconfig-2003-20261105    gcc-16.2.0
sh                    randconfig-2003-20261106    gcc-16.2.0
sh                    randconfig-2004-20261105    gcc-16.2.0
sh                    randconfig-2004-20261106    gcc-16.2.0
sh                    randconfig-2005-20261105    gcc-16.2.0
sh                    randconfig-2005-20261106    gcc-16.2.0
sh                    randconfig-2200-20261105    gcc-13.5.0 smatch
sh                    randconfig-2200-20261106    gcc-16.2.0 smatch
sh                   randconfig-r2100-20261106    gcc-11.5.0 cocci
sh                   randconfig-r2101-20261105    clang-24   cocci
sh                   randconfig-r2103-20261106    gcc-11.5.0 cocci
sh                   randconfig-r2108-20261106    gcc-16.2.0 cocci
sh                   randconfig-r2300-20261106    gcc-15.3.0 sparse
sh                   randconfig-r2306-20261106    gcc-16.2.0 sparse
sh                   randconfig-r2308-20261106    gcc-16.2.0 sparse
sh                   randconfig-r2309-20261105    gcc-15.3.0 sparse
sh                         sh7757lcr_defconfig    gcc-16.2.0
sh                              shx3_defconfig    clang-17
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261106    gcc-15.3.0
sparc                 randconfig-1001-20261106    gcc-15.3.0
sparc                 randconfig-2000-20261105    clang-24
sparc                 randconfig-2000-20261106    gcc-8.5.0
sparc                 randconfig-2001-20261105    clang-24
sparc                 randconfig-2001-20261106    gcc-8.5.0
sparc                 randconfig-2200-20261105    gcc-16.2.0 smatch
sparc                 randconfig-2200-20261106    gcc-8.5.0  smatch
sparc                randconfig-r2101-20261105    clang-24   cocci
sparc                randconfig-r2107-20261106    gcc-14.4.0 cocci
sparc                randconfig-r2110-20261106    gcc-14.4.0 cocci
sparc                randconfig-r2302-20261106    gcc-8.5.0  sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261106    gcc-15.3.0
sparc64               randconfig-1001-20261106    gcc-15.3.0
sparc64               randconfig-2000-20261105    clang-24
sparc64               randconfig-2000-20261106    gcc-8.5.0
sparc64               randconfig-2001-20261105    clang-24
sparc64               randconfig-2001-20261106    gcc-8.5.0
sparc64               randconfig-2200-20261105    gcc-8.5.0  smatch
sparc64               randconfig-2200-20261106    gcc-8.5.0  smatch
sparc64              randconfig-r2100-20261105    clang-24   cocci
sparc64              randconfig-r2103-20261106    gcc-8.5.0  cocci
sparc64              randconfig-r2104-20261105    clang-24   cocci
sparc64              randconfig-r2109-20261106    clang-24   cocci
sparc64              randconfig-r2302-20261106    gcc-12     sparse
sparc64              randconfig-r2309-20261106    clang-22   sparse
sparc64              randconfig-r2311-20261106    clang-22   sparse
sparc64              randconfig-r2311-20261106    gcc-10.5.0 sparse
um                                alldefconfig    gcc-16.2.0
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261106    gcc-15.3.0
um                    randconfig-1001-20261106    gcc-15.3.0
um                    randconfig-2000-20261105    clang-24
um                    randconfig-2000-20261106    gcc-8.5.0
um                    randconfig-2001-20261105    clang-24
um                    randconfig-2001-20261106    gcc-8.5.0
um                    randconfig-2200-20261105    clang-19   smatch
um                    randconfig-2200-20261106    gcc-13     smatch
um                   randconfig-r2101-20261106    gcc-10.5.0 cocci
um                   randconfig-r2102-20261106    gcc-11.5.0 cocci
um                   randconfig-r2103-20261105    clang-24   cocci
um                   randconfig-r2103-20261106    gcc-16.2.0 cocci
um                   randconfig-r2108-20261106    clang-24   cocci
um                   randconfig-r2109-20261106    gcc-16.2.0 cocci
um                   randconfig-r2110-20261106    clang-24   cocci
um                   randconfig-r2300-20261105    gcc-14     sparse
um                   randconfig-r2303-20261106    gcc-12     sparse
um                   randconfig-r2306-20261105    gcc-15.3.0 sparse
um                            x86_64_defconfig    gcc-14
x86_64                            alldefconfig    clang-19
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261106    gcc-13
x86_64      buildonly-randconfig-1001-20261106    gcc-13
x86_64      buildonly-randconfig-1002-20261106    gcc-13
x86_64      buildonly-randconfig-1003-20261106    gcc-13
x86_64      buildonly-randconfig-1004-20261106    gcc-13
x86_64      buildonly-randconfig-1005-20261106    gcc-13
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261106    clang-22
x86_64                randconfig-1001-20261106    clang-22
x86_64                randconfig-1002-20261106    clang-22
x86_64                randconfig-1003-20261106    clang-22
x86_64                randconfig-1004-20261106    clang-22
x86_64                randconfig-1005-20261106    clang-22
x86_64                randconfig-1006-20261106    clang-22
x86_64                randconfig-1007-20261106    clang-22
x86_64                randconfig-1008-20261106    clang-22
x86_64                randconfig-1009-20261106    clang-22
x86_64                randconfig-1010-20261106    clang-22
x86_64                randconfig-1011-20261106    clang-22
x86_64                randconfig-1012-20261106    gcc-14
x86_64                randconfig-1013-20261106    gcc-14
x86_64                randconfig-1014-20261106    gcc-14
x86_64                randconfig-1015-20261106    gcc-14
x86_64                randconfig-1016-20261106    gcc-14
x86_64                randconfig-1017-20261106    gcc-14
x86_64                randconfig-2000-20261105    gcc-14
x86_64                randconfig-2000-20261106    gcc-14
x86_64                randconfig-2001-20261105    gcc-14
x86_64                randconfig-2001-20261106    gcc-14
x86_64                randconfig-2002-20261105    gcc-14
x86_64                randconfig-2002-20261106    gcc-14
x86_64                randconfig-2003-20261105    gcc-14
x86_64                randconfig-2003-20261106    gcc-14
x86_64                randconfig-2004-20261105    gcc-14
x86_64                randconfig-2004-20261106    gcc-14
x86_64                randconfig-2005-20261105    gcc-14
x86_64                randconfig-2005-20261106    gcc-14
x86_64                randconfig-2100-20261105    gcc-14     cocci
x86_64                randconfig-2100-20261106    clang-22   cocci
x86_64                randconfig-2101-20261105    gcc-14     cocci
x86_64                randconfig-2101-20261106    clang-22   cocci
x86_64                randconfig-2102-20261105    gcc-14     cocci
x86_64                randconfig-2102-20261106    clang-22   cocci
x86_64                randconfig-2103-20261105    gcc-14     cocci
x86_64                randconfig-2103-20261106    clang-22   cocci
x86_64                randconfig-2104-20261105    gcc-14     cocci
x86_64                randconfig-2104-20261106    clang-22   cocci
x86_64                randconfig-2105-20261105    gcc-14     cocci
x86_64                randconfig-2105-20261106    clang-22   cocci
x86_64                randconfig-2200-20261105    clang-22   smatch
x86_64                randconfig-2200-20261106    gcc-14     smatch
x86_64                randconfig-2300-20261105    clang-22   sparse
x86_64                randconfig-2300-20261106    clang-22   sparse
x86_64                randconfig-2301-20261105    clang-22   sparse
x86_64                randconfig-2301-20261106    clang-22   sparse
x86_64                randconfig-2302-20261105    clang-22   sparse
x86_64                randconfig-2302-20261106    clang-22   sparse
x86_64               randconfig-r2104-20261106    gcc-8.5.0  cocci
x86_64               randconfig-r2107-20261106    clang-24   cocci
x86_64               randconfig-r2107-20261106    gcc-8.5.0  cocci
x86_64               randconfig-r2109-20261105    gcc-16.2.0 cocci
x86_64               randconfig-r2301-20261106    gcc-12     sparse
x86_64               randconfig-r2306-20261106    clang-22   sparse
x86_64               randconfig-r2307-20261106    gcc-16.2.0 sparse
x86_64               randconfig-r2310-20261105    gcc-15.3.0 sparse
x86_64               randconfig-r2310-20261106    clang-22   sparse
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    clang-22
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                   nommu_kc705_defconfig    clang-24
xtensa                randconfig-1000-20261106    gcc-15.3.0
xtensa                randconfig-1001-20261106    gcc-15.3.0
xtensa                randconfig-2000-20261105    clang-24
xtensa                randconfig-2000-20261106    clang-24
xtensa                randconfig-2001-20261105    clang-24
xtensa                randconfig-2001-20261106    clang-24
xtensa                randconfig-2200-20261105    gcc-8.5.0  smatch
xtensa                randconfig-2200-20261106    gcc-8.5.0  smatch
xtensa               randconfig-r2100-20261106    gcc-16.2.0 cocci
xtensa               randconfig-r2100-20261106    gcc-8.5.0  cocci
xtensa               randconfig-r2105-20261105    gcc-8.5.0  cocci
xtensa               randconfig-r2106-20261105    gcc-16.2.0 cocci
xtensa               randconfig-r2111-20261106    clang-24   cocci
xtensa               randconfig-r2305-20261106    gcc-15.3.0 sparse
xtensa                     xip_kc705_defconfig    clang-17

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
