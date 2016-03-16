From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v7 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Wed, 16 Mar 2016 19:56:33 +0800
Message-ID: <CAMz4kuLU=tps0yVPJMR34G-HLL-cwML+N4LTj_G0ohtvK9DYOg@mail.gmail.com>
References: <cover.1458128215.git.baolin.wang@linaro.org>
	<87wpp2hcdr.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:34640 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754908AbcCPL4e (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2016 07:56:34 -0400
Received: by mail-yw0-f173.google.com with SMTP id h129so58417342ywb.1
        for <linux-pm@vger.kernel.org>; Wed, 16 Mar 2016 04:56:33 -0700 (PDT)
In-Reply-To: <87wpp2hcdr.fsf@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>

On 16 March 2016 at 19:48, Felipe Balbi <balbi@kernel.org> wrote:
>
> Hi Baolin,
>
> Baolin Wang <baolin.wang@linaro.org> writes:
>> [ text/plain ]
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
>>  - Rebase on "4.5-rc4".
>>
>> Baolin Wang (4):
>>   gadget: Introduce the usb charger framework
>>   gadget: Support for the usb charger framework
>>   gadget: Integrate with the usb gadget supporting for usb charger
>>   power: wm831x_power: Support USB charger current limit management
>
> Thank you for resending this. I'll review it ASAP (probably tomorrow
> when I get to the office. If I have time, still today)

OK. Thanks:)

>
> --
> balbi



-- 
Baolin.wang
Best Regards
