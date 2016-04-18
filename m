From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v10 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Mon, 18 Apr 2016 13:45:53 +0800
Message-ID: <CAMz4kuK3NPOW_G2uRa1VoxHLSfQ++vyVX9Ugswa2BBJSH0d=Fg@mail.gmail.com>
References: <cover.1460029375.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f170.google.com ([209.85.161.170]:35713 "EHLO
	mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806AbcDRFpy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Apr 2016 01:45:54 -0400
Received: by mail-yw0-f170.google.com with SMTP id g133so8341642ywb.2
        for <linux-pm@vger.kernel.org>; Sun, 17 Apr 2016 22:45:53 -0700 (PDT)
In-Reply-To: <cover.1460029375.git.baolin.wang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Baolin Wang <baolin.wang@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>

Hi Felipe,

What do you think of this version patchset? Could you review this
patchset when you feel free? I really hope to move the usb charger
forwards with suggestions. Thanks.

On 7 April 2016 at 19:48, Baolin Wang <baolin.wang@linaro.org> wrote:
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
> Changes since v9:
>  - Remove some redundant sysfs attributes.
>  - Change the SDP charger default current if gadget is SS.
>  - Remove the 'get_charger_type' callback in gadget->ops.
>
> Baolin Wang (4):
>   gadget: Introduce the usb charger framework
>   gadget: Support for the usb charger framework
>   gadget: Integrate with the usb gadget supporting for usb charger
>   power: wm831x_power: Support USB charger current limit management
>
>  drivers/power/wm831x_power.c      |   69 ++++
>  drivers/usb/gadget/Kconfig        |    7 +
>  drivers/usb/gadget/udc/Makefile   |    1 +
>  drivers/usb/gadget/udc/charger.c  |  766 +++++++++++++++++++++++++++++++++++++
>  drivers/usb/gadget/udc/udc-core.c |   11 +
>  include/linux/mfd/wm831x/pdata.h  |    3 +
>  include/linux/usb/charger.h       |  173 +++++++++
>  include/linux/usb/gadget.h        |   13 +
>  include/uapi/linux/usb/charger.h  |   31 ++
>  9 files changed, 1074 insertions(+)
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
