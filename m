From: Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH v4 5/6] power: cros_usbpd-charger: Add EC-based USB PD
 charger driver
Date: Tue, 15 Mar 2016 15:30:06 -0700
Message-ID: <CANLzEksGnyPEwx17m--T=FXTjFMyk3hU=hP_VfJo=gGYDOHTMg@mail.gmail.com>
References: <1457433358-28151-6-git-send-email-tomeu.vizoso@collabora.com>
	<201603090203.NRAyMe5M%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:34738 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932508AbcCOWaH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Mar 2016 18:30:07 -0400
Received: by mail-vk0-f45.google.com with SMTP id e185so39967148vkb.1
        for <linux-pm@vger.kernel.org>; Tue, 15 Mar 2016 15:30:07 -0700 (PDT)
In-Reply-To: <201603090203.NRAyMe5M%fengguang.wu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, kbuild-all@01.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sameer Nanda <snanda@chromium.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Lee Jones <lee.jones@linaro.org>, =?UTF-8?Q?Enric_Balletb=C3=B2?= <enric.balletbo@collabora.co.uk>, Vic Yang <victoryang@chromium.org>, Stephen Boyd <sboyd@codeaurora.org>, Vincent Palatin <vpalatin@chromium.org>, Randall Spangler <rspangler@chromium.org>, Todd Broch <tbroch@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Shawn Nematbakhsh <shawnn@chromium.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-pm@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>

On Tue, Mar 8, 2016 at 10:09 AM, kbuild test robot <lkp@intel.com> wrote:
> Hi Sameer,
>
> [auto build test WARNING on v4.5-rc7]
> [also build test WARNING on next-20160308]
> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
>
> url:    https://github.com/0day-ci/linux/commits/Tomeu-Vizoso/mfd-cros_ec-Add-MKBP-event-support/20160308-184326
> config: blackfin-allmodconfig (attached as .config)
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=blackfin
>
> All warnings (new ones prefixed by >>):
>
>    drivers/power/cros_usbpd-charger.c: In function 'get_ec_usb_pd_power_info':
>    drivers/power/cros_usbpd-charger.c:241:21: error: 'POWER_SUPPLY_TYPE_USB_PD_DRP' undeclared (first use in this function)
>    drivers/power/cros_usbpd-charger.c:241:21: note: each undeclared identifier is reported only once for each function it appears in
>    drivers/power/cros_usbpd-charger.c:249:20: error: 'POWER_SUPPLY_TYPE_USB_TYPE_C' undeclared (first use in this function)
>    drivers/power/cros_usbpd-charger.c:261:21: error: 'POWER_SUPPLY_TYPE_USB_PD' undeclared (first use in this function)


I think this patch is being built with the wrong git tree. The new
types for these three errors landed in sre's linux-power-supply here :
https://git.kernel.org/cgit/linux/kernel/git/sre/linux-power-supply.git/commit/?h=next&id=6659b55dae09b2042d8cdd0f4576502c3e81957c

It should be in most recent linux-nexts, but it wouldn't be in v4.5-rc7.

-- 
Benson Leung
Senior Software Engineer, Chrom* OS
bleung@chromium.org
