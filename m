From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Fwd: [pm:bleeding-edge] e29a81ef381645c1096f622ff7d4c8cb6e6512f8 BUILD DONE
Date: Fri, 06 Nov 2015 02:52:33 +0100
Message-ID: <1874777.izKSG6BHmO@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart1787330.qvIM4hnGen"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61355 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1030248AbbKFBXW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 Nov 2015 20:23:22 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart1787330.qvIM4hnGen
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi Tomeu,

This is introduced by one of your recent patches.

Can you please have a look at this issue?

Thanks,
Rafael
--nextPart1787330.qvIM4hnGen
Content-Type: message/rfc822
Content-Disposition: inline; filename="forwarded message"
Content-Description: kbuild test robot <fengguang.wu@intel.com>: [pm:bleeding-edge] e29a81ef381645c1096f622ff7d4c8cb6e6512f8 BUILD DONE

Return-Path: <fengguang.wu@intel.com>
Received: from mga09.intel.com (134.134.136.24) (HELO mga09.intel.com) by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer v0.80) id f298af65dff3ec20; Fri, 6 Nov 2015 00:33:09 +0100
Received: from orsmga003.jf.intel.com ([10.7.209.27]) by orsmga102.jf.intel.com with ESMTP; 05 Nov 2015 15:33:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,249,1444719600"; d="scan'208";a="679269913"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14]) by orsmga003.jf.intel.com with ESMTP; 05 Nov 2015 15:33:07 -0800
Received: from kbuild by bee with local (Exim 4.83) (envelope-from <fengguang.wu@intel.com>) id 1ZuU1W-000WPL-6E; Fri, 06 Nov 2015 07:32:54 +0800
Date: Fri, 06 Nov 2015 07:34:29 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [pm:bleeding-edge] e29a81ef381645c1096f622ff7d4c8cb6e6512f8 BUILD DONE
Message-ID: <563be785.gJIHdPyzOc4Wt9ZZ%fengguang.wu@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
e29a81ef381645c1096f622ff7d4c8cb6e6512f8  Merge branch 'pm-sleep-next' into bleeding-edge

drivers/gpu/vga/vga_switcheroo.c:668:3: error: implicit declaration of function 'dev_pm_domain_set' [-Werror=implicit-function-declaration]

Error ids grouped by kconfigs:

recent_errors
├── i386-allmodconfig
│   └── drivers-gpu-vga-vga_switcheroo.c:error:implicit-declaration-of-function-dev_pm_domain_set
├── i386-randconfig-a0-11051806
│   └── drivers-gpu-vga-vga_switcheroo.c:error:implicit-declaration-of-function-dev_pm_domain_set
├── i386-randconfig-x006-11051803
│   └── drivers-gpu-vga-vga_switcheroo.c:error:implicit-declaration-of-function-dev_pm_domain_set
├── x86_64-allmodconfig
│   └── drivers-gpu-vga-vga_switcheroo.c:error:implicit-declaration-of-function-dev_pm_domain_set
├── x86_64-allyesconfig
│   └── drivers-gpu-vga-vga_switcheroo.c:error:implicit-declaration-of-function-dev_pm_domain_set
├── x86_64-allyesdebian
│   └── drivers-gpu-vga-vga_switcheroo.c:error:implicit-declaration-of-function-dev_pm_domain_set
├── x86_64-randconfig-x001-11051802
│   └── drivers-gpu-vga-vga_switcheroo.c:error:implicit-declaration-of-function-dev_pm_domain_set
├── x86_64-randconfig-x002-11051802
│   └── drivers-gpu-vga-vga_switcheroo.c:error:implicit-declaration-of-function-dev_pm_domain_set
├── x86_64-randconfig-x007-11051802
│   └── drivers-gpu-vga-vga_switcheroo.c:error:implicit-declaration-of-function-dev_pm_domain_set
├── x86_64-randconfig-x012-11051832
│   └── drivers-gpu-vga-vga_switcheroo.c:error:implicit-declaration-of-function-dev_pm_domain_set
├── x86_64-randconfig-x018-11051832
│   └── drivers-gpu-vga-vga_switcheroo.c:error:implicit-declaration-of-function-dev_pm_domain_set
├── x86_64-randconfig-x019-11051832
│   └── drivers-gpu-vga-vga_switcheroo.c:error:implicit-declaration-of-function-dev_pm_domain_set
└── x86_64-rhel
    └── drivers-gpu-vga-vga_switcheroo.c:error:implicit-declaration-of-function-dev_pm_domain_set

elapsed time: 73m

configs tested: 107

alpha                               defconfig
parisc                            allnoconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                   randconfig-a0-11051806
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
parisc                         b180_defconfig
i386                             allmodconfig
x86_64               randconfig-x018-11051832
x86_64               randconfig-x019-11051832
x86_64               randconfig-x016-11051832
x86_64               randconfig-x010-11051832
x86_64               randconfig-x012-11051832
x86_64               randconfig-x017-11051832
x86_64               randconfig-x014-11051832
x86_64               randconfig-x013-11051832
x86_64               randconfig-x015-11051832
x86_64               randconfig-x011-11051832
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201544
i386                     randconfig-s1-201544
x86_64                           allmodconfig
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                               tinyconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
x86_64                 randconfig-i0-11051808
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                   randconfig-i0-11051808
i386                   randconfig-i1-11051808
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
x86_64                                    lkp
x86_64                                   rhel
i386                     randconfig-n0-201544
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                                  at_hdmac
arm                                    ep93xx
arm                       imx_v6_v7_defconfig
arm                                  iop-adma
arm                          marzen_defconfig
arm                          prima2_defconfig
arm                                    sa1100
arm                                   samsung
arm                                        sh
arm                       spear13xx_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64               randconfig-x000-11051802
x86_64               randconfig-x009-11051802
x86_64               randconfig-x002-11051802
x86_64               randconfig-x007-11051802
x86_64               randconfig-x001-11051802
x86_64               randconfig-x006-11051802
x86_64               randconfig-x004-11051802
x86_64               randconfig-x003-11051802
x86_64               randconfig-x005-11051802
x86_64               randconfig-x008-11051802
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
i386                     randconfig-r0-201544
i386                 randconfig-x003-11051803
i386                 randconfig-x009-11051803
i386                 randconfig-x000-11051803
i386                 randconfig-x008-11051803
i386                 randconfig-x001-11051803
i386                 randconfig-x005-11051803
i386                 randconfig-x006-11051803
i386                 randconfig-x007-11051803
i386                 randconfig-x002-11051803
i386                 randconfig-x004-11051803

Thanks,
Fengguang

--nextPart1787330.qvIM4hnGen--

