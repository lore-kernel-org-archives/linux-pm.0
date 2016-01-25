From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v7 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Mon, 25 Jan 2016 12:14:56 +0800
Message-ID: <CAMz4kuJOfze8r-4XUoPaSQmNyn1074G4Kdw=1kAsWn13Y6yqsg@mail.gmail.com>
References: <cover.1451876014.git.baolin.wang@linaro.org>
	<20160125034405.GA25279@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f169.google.com ([209.85.160.169]:33442 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755110AbcAYEO5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 24 Jan 2016 23:14:57 -0500
Received: by mail-yk0-f169.google.com with SMTP id k129so149331712yke.0
        for <linux-pm@vger.kernel.org>; Sun, 24 Jan 2016 20:14:56 -0800 (PST)
In-Reply-To: <20160125034405.GA25279@kroah.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Felipe Balbi <balbi@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>

On 25 January 2016 at 11:44, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Mon, Jan 04, 2016 at 11:04:26AM +0800, Baolin Wang wrote:
>> Currently the Linux kernel does not provide any standard integration of this
>> feature that integrates the USB subsystem with the system power regulation
>> provided by PMICs meaning that either vendors must add this in their kernels
>> or USB gadget devices based on Linux (such as mobile phones) may not behave
>> as they should. Thus provide a standard framework for doing this in kernel.
>>
>> Now introduce one user with wm831x_power to support and test the usb charger,
>> which is pending testing. Moreover there may be other potential users will use
>> it in future.
>>
>> Changes since v5:
>>  - Remove the notifier chain things from the gadget and introduce one callback
>>  function to report to the usb charger when the gadget state is changed.
>>  - Flesh out the port type detection which combines the USB negotiation and
>>  PMICs detection.
>>  - Supply the notification mechanism to userspace when charger state is changed.
>>  - Integrate with the vbus staff in the gadget API.
>>  - Spilt up the functionality for userspace with one file per USB charger type.
>>  - Rebase on "4.4-rc7".
>
> You already sent out v7, so this should be v8, right?  What changed
> since v7?  Why resend it if nothing changed?

I'm sorry for confusing, This is v7 without any changing, but I'm not
sure maintainers have seen the big improvements since v5, so I resend
it for catching attentions. Sorry again for confusing.

>
> confused,
>
> greg k-h



-- 
Baolin.wang
Best Regards
