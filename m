From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v7 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Sun, 24 Jan 2016 19:44:05 -0800
Message-ID: <20160125034405.GA25279@kroah.com>
References: <cover.1451876014.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:55495 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752145AbcAYDoG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 24 Jan 2016 22:44:06 -0500
Content-Disposition: inline
In-Reply-To: <cover.1451876014.git.baolin.wang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: balbi@ti.com, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, lee.jones@linaro.org, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org

On Mon, Jan 04, 2016 at 11:04:26AM +0800, Baolin Wang wrote:
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
> Changes since v5:
>  - Remove the notifier chain things from the gadget and introduce one callback
>  function to report to the usb charger when the gadget state is changed.
>  - Flesh out the port type detection which combines the USB negotiation and
>  PMICs detection.
>  - Supply the notification mechanism to userspace when charger state is changed.
>  - Integrate with the vbus staff in the gadget API.
>  - Spilt up the functionality for userspace with one file per USB charger type.
>  - Rebase on "4.4-rc7". 

You already sent out v7, so this should be v8, right?  What changed
since v7?  Why resend it if nothing changed?

confused,

greg k-h
