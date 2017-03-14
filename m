From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v19 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Tue, 14 Mar 2017 09:57:29 +0000
Message-ID: <20170314095729.cmbzdhikdtjoqrmp@dell>
References: <cover.1487578977.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f172.google.com ([209.85.128.172]:34910 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750744AbdCNJ5e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Mar 2017 05:57:34 -0400
Received: by mail-wr0-f172.google.com with SMTP id g10so120347966wrg.2
        for <linux-pm@vger.kernel.org>; Tue, 14 Mar 2017 02:57:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <cover.1487578977.git.baolin.wang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: balbi@kernel.org, gregkh@linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, robh@kernel.org, jun.li@nxp.com, m.szyprowski@samsung.com, ruslan.bilovol@gmail.com, peter.chen@freescale.com, stern@rowland.harvard.edu, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, broonie@kernel.org, john.stultz@linaro.org, neilb@suse.com, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org

On Mon, 20 Feb 2017, Baolin Wang wrote:

[...]

>  drivers/power/supply/wm831x_power.c |   63 +++
>  drivers/usb/gadget/Kconfig          |    8 +
>  drivers/usb/gadget/udc/Makefile     |    1 +
>  drivers/usb/gadget/udc/charger.c    |  865 +++++++++++++++++++++++++++++++++++
>  drivers/usb/gadget/udc/core.c       |   19 +-
>  include/linux/usb/charger.h         |  176 +++++++
>  include/linux/usb/gadget.h          |    3 +
>  include/uapi/linux/usb/charger.h    |   31 ++
>  8 files changed, 1165 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/usb/gadget/udc/charger.c
>  create mode 100644 include/linux/usb/charger.h
>  create mode 100644 include/uapi/linux/usb/charger.h

Why have you sent this set to me?

Please be careful when submitting patches, since a lot of us have
enough mail to contend with already.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
