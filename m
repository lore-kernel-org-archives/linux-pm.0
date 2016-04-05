From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v9 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Tue, 5 Apr 2016 14:46:37 +0800
Message-ID: <20160405064637.GA31351@shlinux2.ap.freescale.net>
References: <cover.1459494743.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33795 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752996AbcDEGxS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 Apr 2016 02:53:18 -0400
Content-Disposition: inline
In-Reply-To: <cover.1459494743.git.baolin.wang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: balbi@kernel.org, gregkh@linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, lee.jones@linaro.org, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org

On Fri, Apr 01, 2016 at 03:21:48PM +0800, Baolin Wang wrote:
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
> Changes since v8:
>  - Remove the bus type things.
>  - Introduce one charger_detect() callback to detect charger type if it is needed.
>  - Add some sysfs attributes for showing the charger type and state.
>  - Change the charger current attributes to read only.
>  - Move charger state and type definition to include/uapi.
>  - Some other optimiazations.
> 
> Baolin Wang (4):
>   gadget: Introduce the usb charger framework
>   gadget: Support for the usb charger framework
>   gadget: Integrate with the usb gadget supporting for usb charger
>   power: wm831x_power: Support USB charger current limit management
> 

We are thinking USB charger framework for Freescale i.mx SoC series,
since our internal framework is not good enough.
So I have more questions for your framework since there are many
different USB charger designs, and I hope it is universal.

- I would like to see your all code to let the charger work, eg
you have said the charger detection is done by PMIC automatically,
but I did not find your PMIC code to read charger type.

Besides, how you can make sure the charger detection has finished
before the framework handles USB_CHARGER_PRESENT event?

- I commented the current limit at different situations for USB
charger last time, but I have not seen your further comments.
I would like give it again. For DCP, you can notify charger IC
once you get the charger type. But for CDP/SDP, you need to
notify charger IC after set configuration has finished, since
the host may still not be ready to give high current.

-- 

Best Regards,
Peter Chen
