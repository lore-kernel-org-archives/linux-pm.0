From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 1/3] mfd: intel_soc_pmic: Fix a mess with compilation
 units
Date: Mon, 3 Apr 2017 10:20:28 +0100
Message-ID: <20170403092028.z4xtrwz5wj3go3jd@dell>
References: <20170317153715.48555-1-andriy.shevchenko@linux.intel.com>
 <201704030357.HdHD43mM%fengguang.wu@intel.com>
 <CAHp75Vdt3ys=tFax5iK5tnANNCLj-b4-VxO78b4ZT0jqdAnsdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f182.google.com ([209.85.128.182]:35110 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752304AbdDCJUc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Apr 2017 05:20:32 -0400
Received: by mail-wr0-f182.google.com with SMTP id k6so154962514wre.2
        for <linux-pm@vger.kernel.org>; Mon, 03 Apr 2017 02:20:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAHp75Vdt3ys=tFax5iK5tnANNCLj-b4-VxO78b4ZT0jqdAnsdg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: kbuild test robot <lkp@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, kbuild-all@01.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

On Sun, 02 Apr 2017, Andy Shevchenko wrote:

> On Sun, Apr 2, 2017 at 11:03 PM, kbuild test robot <lkp@intel.com> wrote:
> > Hi Andy,
> >
> > [auto build test ERROR on ljones-mfd/for-mfd-next]
> > [also build test ERROR on v4.11-rc4 next-20170331]
> > [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> Thank you for report, though...
> 
> >
> > url:    https://github.com/0day-ci/linux/commits/Andy-Shevchenko/mfd-intel_soc_pmic-Fix-a-mess-with-compilation-units/20170320-153539
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
> > config: tile-allyesconfig (attached as .config)
> > compiler: tilegx-linux-gcc (GCC) 4.6.2
> > reproduce:
> >         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # save the attached .config to linux build tree
> 
> >         make.cross ARCH=tile
> 
> ...I doubt how below is related to my patch. This is obvious x86 code
> which was initially submitted without
> depend on X86
> line in corresponding Kconfig.

I think you should probably specify the architecture in the Kconfig
entry, or else some `randconfig`s will fail.

> > All errors (new ones prefixed by >>):
> >
> >>> drivers/mfd/intel_soc_pmic_bxtwc.c:24:31: fatal error: asm/intel_pmc_ipc.h: No such file or directory
> >    compilation terminated.
> >
> > vim +24 drivers/mfd/intel_soc_pmic_bxtwc.c
> >
> > 39d047c0 Qipeng Zha 2015-09-15   8   * version 2, as published by the Free Software Foundation.
> > 39d047c0 Qipeng Zha 2015-09-15   9   *
> > 39d047c0 Qipeng Zha 2015-09-15  10   * This program is distributed in the hope it will be useful, but WITHOUT
> > 39d047c0 Qipeng Zha 2015-09-15  11   * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> > 39d047c0 Qipeng Zha 2015-09-15  12   * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> > 39d047c0 Qipeng Zha 2015-09-15  13   * more details.
> > 39d047c0 Qipeng Zha 2015-09-15  14   */
> > 39d047c0 Qipeng Zha 2015-09-15  15
> > 39d047c0 Qipeng Zha 2015-09-15  16  #include <linux/module.h>
> > 39d047c0 Qipeng Zha 2015-09-15  17  #include <linux/acpi.h>
> > 39d047c0 Qipeng Zha 2015-09-15  18  #include <linux/err.h>
> > 39d047c0 Qipeng Zha 2015-09-15  19  #include <linux/delay.h>
> > 39d047c0 Qipeng Zha 2015-09-15  20  #include <linux/interrupt.h>
> > 39d047c0 Qipeng Zha 2015-09-15  21  #include <linux/kernel.h>
> > 39d047c0 Qipeng Zha 2015-09-15  22  #include <linux/mfd/core.h>
> > 39d047c0 Qipeng Zha 2015-09-15  23  #include <linux/mfd/intel_bxtwc.h>
> > 39d047c0 Qipeng Zha 2015-09-15 @24  #include <asm/intel_pmc_ipc.h>
> > 39d047c0 Qipeng Zha 2015-09-15  25
> > 39d047c0 Qipeng Zha 2015-09-15  26  /* PMIC device registers */
> > 39d047c0 Qipeng Zha 2015-09-15  27  #define REG_ADDR_MASK               0xFF00
> > 39d047c0 Qipeng Zha 2015-09-15  28  #define REG_ADDR_SHIFT              8
> > 39d047c0 Qipeng Zha 2015-09-15  29  #define REG_OFFSET_MASK             0xFF
> > 39d047c0 Qipeng Zha 2015-09-15  30
> > 39d047c0 Qipeng Zha 2015-09-15  31  /* Interrupt Status Registers */
> > 39d047c0 Qipeng Zha 2015-09-15  32  #define BXTWC_IRQLVL1               0x4E02
> >
> > :::::: The code at line 24 was first introduced by commit
> > :::::: 39d047c0b1c812e9f0014e7100e372e61f2de3de mfd: add Intel Broxton Whiskey Cove PMIC driver
> >
> > :::::: TO: Qipeng Zha <qipeng.zha@intel.com>
> > :::::: CC: Lee Jones <lee.jones@linaro.org>
> >
> > ---
> > 0-DAY kernel test infrastructure                Open Source Technology Center
> > https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
> 
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
