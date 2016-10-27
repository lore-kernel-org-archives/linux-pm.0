From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v18 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Thu, 27 Oct 2016 15:33:48 +0800
Message-ID: <CAMz4ku+5=LebdDB9waDD8GYQmYM=uxuOqN6hYZ+E1HSALa1GMQ@mail.gmail.com>
References: <cover.1476780088.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yb0-f170.google.com ([209.85.213.170]:35247 "EHLO
        mail-yb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934268AbcJ0Hdt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Oct 2016 03:33:49 -0400
Received: by mail-yb0-f170.google.com with SMTP id d128so11726259ybh.2
        for <linux-pm@vger.kernel.org>; Thu, 27 Oct 2016 00:33:49 -0700 (PDT)
In-Reply-To: <cover.1476780088.git.baolin.wang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, John Stultz <john.stultz@linaro.org>, NeilBrown <neilb@suse.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Baolin Wang <baolin.wang@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>

Hi Felipe,

On 19 October 2016 at 10:37, Baolin Wang <baolin.wang@linaro.org> wrote:
> Currently the Linux kernel does not provide any standard integration of this
> feature that integrates the USB subsystem with the system power regulation
> provided by PMICs meaning that either vendors must add this in their kernels
> or USB gadget devices based on Linux (such as mobile phones) may not behave
> as they should. Thus provide a standard framework for doing this in kernel.
>
> Now introduce one user with wm831x_power to support and test the usb charger,
> which is pending testing. Moreover there may be other potential users will use
> it in future.
>
> Changes since v17:
>  - Remove goto section in usb_charger_register() function.
>  - Remove 'extern' in charger.h file.
>  - Move the kfree() to usb_charger_exit() function.
>
> Changes since v16:
>  - Modify the charger current range with introducing the maximum and minimum
>  current.
>  - Remove the getting charger type method from power supply.
>  - Add the getting charger type method from extcon system.
>  - Introduce new usb_charger_get_current() API for users to get the maximum and
>  minimum current.
>  - Rename some APIs and other optimization.
>
> Changes since v15:
>  - Add charger state checking to avoid sending out duplicate notifies to users.
>  - Add one work to notify power users the current has been changed.
>
> Changes since v14:
>  - Add kernel documentation for struct usb_cahrger.
>  - Remove some redundant WARN() functions.
>
> Changes since v13:
>  - Remove the charger checking in usb_gadget_vbus_draw() function.
>  - Rename some functions in charger.c file.
>  - Rebase on git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git tags/usb-for-v4.8
>
> Changes since v12:
>  - Remove the class and device things.
>  - Link usb charger to udc-core.ko.
>  - Create one "charger" subdirectory which holds all charger-related attributes.
>
> Changes since v11:
>  - Reviewed and tested by Li Jun.
>
> Changes since v10:
>  - Introduce usb_charger_get_state() function to check charger state.
>  - Remove the mutex lock in usb_charger_set_cur_limit_by_type() function
>  in case will be issued in atomic context.

Could you apply this patchset into your branch if there are no other
comments? Thanks.

>
> Baolin Wang (4):
>   usb: gadget: Introduce the usb charger framework
>   usb: gadget: Support for the usb charger framework
>   usb: gadget: Integrate with the usb gadget supporting for usb charger
>   power: wm831x_power: Support USB charger current limit management
>
>  drivers/power/wm831x_power.c     |   75 ++++
>  drivers/usb/gadget/Kconfig       |    8 +
>  drivers/usb/gadget/udc/Makefile  |    1 +
>  drivers/usb/gadget/udc/charger.c |  877 ++++++++++++++++++++++++++++++++++++++
>  drivers/usb/gadget/udc/core.c    |   19 +-
>  include/linux/mfd/wm831x/pdata.h |    3 +
>  include/linux/usb/charger.h      |  185 ++++++++
>  include/linux/usb/gadget.h       |    3 +
>  include/uapi/linux/usb/charger.h |   31 ++
>  9 files changed, 1201 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/usb/gadget/udc/charger.c
>  create mode 100644 include/linux/usb/charger.h
>  create mode 100644 include/uapi/linux/usb/charger.h
>
> --
> 1.7.9.5
>



-- 
Baolin.wang
Best Regards
