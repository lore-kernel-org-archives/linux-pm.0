From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 2/3] usb: phy: Add USB charger support
Date: Wed, 28 Jun 2017 13:28:21 +0800
Message-ID: <CAMz4kuLdvJBXL83Je8LHx2oCWL8um2dKTo4erkFTDySM1Q91CQ@mail.gmail.com>
References: <e0f9ed54d6834231dd5785781ddedb9346f15720.1498548022.git.baolin.wang@linaro.org>
 <201706281044.sD7wiJXZ%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:33066 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751043AbdF1F2X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Jun 2017 01:28:23 -0400
Received: by mail-oi0-f53.google.com with SMTP id p66so33562797oia.0
        for <linux-pm@vger.kernel.org>; Tue, 27 Jun 2017 22:28:22 -0700 (PDT)
In-Reply-To: <201706281044.sD7wiJXZ%fengguang.wu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Jun Li <jun.li@nxp.com>, Peter Chen <peter.chen@freescale.com>, Mark Brown <broonie@kernel.org>, John Stultz <john.stultz@linaro.org>, NeilBrown <neilb@suse.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>

Hi,

On 28 June 2017 at 10:44, kbuild test robot <lkp@intel.com> wrote:
> Hi Baolin,
>
> [auto build test ERROR on balbi-usb/next]
> [also build test ERROR on next-20170627]
> [cannot apply to v4.12-rc7]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Baolin-Wang/include-uapi-usb-Introduce-USB-charger-type-and-state-definition/20170628-093530
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git next
> config: i386-randconfig-x076-06262345 (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386
>
> All errors (new ones prefixed by >>):
>
>    drivers/power/supply/rt9455_charger.o: In function `usb_phy_set_charger_current':
>>> rt9455_charger.c:(.text+0x1660): multiple definition of `usb_phy_set_charger_current'
>    drivers/power/supply/pda_power.o:pda_power.c:(.text+0xad0): first defined here
>    drivers/power/supply/rt9455_charger.o: In function `usb_phy_get_charger_current':
>>> rt9455_charger.c:(.text+0x1670): multiple definition of `usb_phy_get_charger_current'
>    drivers/power/supply/pda_power.o:pda_power.c:(.text+0xae0): first defined here
>    drivers/power/supply/rt9455_charger.o: In function `usb_phy_set_charger_state':
>>> rt9455_charger.c:(.text+0x1680): multiple definition of `usb_phy_set_charger_state'
>    drivers/power/supply/pda_power.o:pda_power.c:(.text+0xaf0): first defined here

Sorry for missing "static inline" for these exported functions, will
fix in next version.

-- 
Baolin.wang
Best Regards
