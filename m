From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v19 2/4] usb: gadget: Support for the usb charger framework
Date: Mon, 20 Feb 2017 18:18:02 +0800
Message-ID: <CAMz4ku+63ZUJqkBdnDa2uELNV2dDpwGuT0oTkeZo7Ziy9r4eqA@mail.gmail.com>
References: <b12c8ed224a033a2d5290df881ecb77fe22e388d.1487578977.git.baolin.wang@linaro.org>
 <201702201731.rFMXYrjY%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:32839 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751232AbdBTKSD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Feb 2017 05:18:03 -0500
Received: by mail-oi0-f46.google.com with SMTP id 2so11707756oif.0
        for <linux-pm@vger.kernel.org>; Mon, 20 Feb 2017 02:18:03 -0800 (PST)
In-Reply-To: <201702201731.rFMXYrjY%fengguang.wu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, John Stultz <john.stultz@linaro.org>, NeilBrown <neilb@suse.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vg>

On 20 February 2017 at 18:08, kbuild test robot <lkp@intel.com> wrote:
> Hi Baolin,
>
> [auto build test ERROR on v4.9-rc8]
> [cannot apply to balbi-usb/next usb/usb-testing battery/master next-20170220]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Baolin-Wang/Introduce-usb-charger-framework-to-deal-with-the-usb-gadget-power-negotation/20170220-173051
> config: i386-randconfig-x015-201708 (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386
>
> All errors (new ones prefixed by >>):
>
>    In file included from drivers/usb/gadget/udc/core.c:28:0:
>    include/linux/usb/charger.h: In function 'usb_charger_get_state':
>>> include/linux/usb/charger.h:151:9: error: 'USB_CHARGER_REMOVE' undeclared (first use in this function)
>      return USB_CHARGER_REMOVE;

Ah, missed fixing the state name without enable USB charger. Will fix
in next version.

>             ^~~~~~~~~~~~~~~~~~
>    include/linux/usb/charger.h:151:9: note: each undeclared identifier is reported only once for each function it appears in
>
> vim +/USB_CHARGER_REMOVE +151 include/linux/usb/charger.h
>
> 28929615 Baolin Wang 2017-02-20  145    return UNKNOWN_TYPE;
> 28929615 Baolin Wang 2017-02-20  146  }
> 28929615 Baolin Wang 2017-02-20  147
> 28929615 Baolin Wang 2017-02-20  148  static inline enum usb_charger_state
> 28929615 Baolin Wang 2017-02-20  149  usb_charger_get_state(struct usb_charger *uchger)
> 28929615 Baolin Wang 2017-02-20  150  {
> 28929615 Baolin Wang 2017-02-20 @151    return USB_CHARGER_REMOVE;
> 28929615 Baolin Wang 2017-02-20  152  }
> 28929615 Baolin Wang 2017-02-20  153
> 28929615 Baolin Wang 2017-02-20  154  static inline int usb_charger_detect_type(struct usb_charger *uchger)
>
> :::::: The code at line 151 was first introduced by commit
> :::::: 289296154f05985dedc08273f04d5b738450b3c7 usb: gadget: Introduce the usb charger framework
>
> :::::: TO: Baolin Wang <baolin.wang@linaro.org>
> :::::: CC: 0day robot <fengguang.wu@intel.com>
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation



-- 
Baolin.wang
Best Regards
