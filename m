From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v2 0/3] Introduce USB charger support in USB phy
Date: Tue, 18 Jul 2017 15:13:00 +0800
Message-ID: <CAMz4kuLp6C+ThKh8Y=QaocsPQ_swN7K4sMmebeGnnQA1M89G0w@mail.gmail.com>
References: <cover.1499061617.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:33637 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751026AbdGRHNB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jul 2017 03:13:01 -0400
Received: by mail-oi0-f48.google.com with SMTP id p188so10155865oia.0
        for <linux-pm@vger.kernel.org>; Tue, 18 Jul 2017 00:13:01 -0700 (PDT)
In-Reply-To: <cover.1499061617.git.baolin.wang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>
Cc: Jun Li <jun.li@nxp.com>, Peter Chen <peter.chen@freescale.com>, Mark Brown <broonie@kernel.org>, John Stultz <john.stultz@linaro.org>, NeilBrown <neilb@suse.com>, patches@opensource.wolfsonmicro.com, Baolin Wang <baolin.wang@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>

Hi,

On 3 July 2017 at 14:07, Baolin Wang <baolin.wang@linaro.org> wrote:
> Currently the Linux kernel does not provide any standard integration of this
> feature that integrates the USB subsystem with the system power regulation
> provided by PMICs meaning that either vendors must add this in their kernels
> or USB gadget devices based on Linux (such as mobile phones) may not behave
> as they should. Thus provide a standard USB charger support in USB phy core
> for doing this in kernel.
>
> Now introduce one user with wm831x_power to support and test the usb charger.
>
> Changes since v1:
>  - Fix building errors.
>
> Baolin Wang (3):
>   include: uapi: usb: Introduce USB charger type and state definition
>   usb: phy: Add USB charger support
>   power: wm831x_power: Support USB charger current limit management

Any suggestion for the USB charger support in USB phy core? Thanks.

>
>  drivers/power/supply/wm831x_power.c |   61 ++++++++
>  drivers/usb/phy/phy.c               |  265 +++++++++++++++++++++++++++++++++++
>  include/linux/usb/phy.h             |   49 +++++++
>  include/uapi/linux/usb/charger.h    |   31 ++++
>  4 files changed, 406 insertions(+)
>  create mode 100644 include/uapi/linux/usb/charger.h
>
> --
> 1.7.9.5
>



-- 
Baolin.wang
Best Regards
