From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v2 0/3] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Fri, 14 Aug 2015 19:04:56 +0800
Message-ID: <CAMz4kuK7f=rGOO-YdB0AB8PzpTbnWZtasuQK8gOXLuM9zyn3gw@mail.gmail.com>
References: <cover.1439519412.git.baolin.wang@linaro.org>
	<20150814085527.GA17920@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f179.google.com ([209.85.160.179]:33462 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754009AbbHNLE5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 14 Aug 2015 07:04:57 -0400
Received: by ykll84 with SMTP id l84so2275110ykl.0
        for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2015 04:04:57 -0700 (PDT)
In-Reply-To: <20150814085527.GA17920@shlinux2>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Li Jun <b47624@freescale.com>
Cc: Felipe Balbi <balbi@ti.com>, Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Peter Chen <peter.chen@freescale.com>, sojka@merica.cz, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, sameo@linux.intel.com, lee.jones@linaro.org, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org

On 14 August 2015 at 16:55, Li Jun <b47624@freescale.com> wrote:
> Hi Baolin,
>
> On Fri, Aug 14, 2015 at 05:47:43PM +0800, Baolin Wang wrote:
>> Currently the Linux kernel does not provide any standard integration of this
>> feature that integrates the USB subsystem with the system power regulation
>> provided by PMICs meaning that either vendors must add this in their kernels
>> or USB gadget devices based on Linux (such as mobile phones) may not behave
>> as they should.
>>
>> Providing a standard framework for doing this in the kernel.
>>
>
> Why not add power supply class support into this?
>

Hi Jun,

We don't need the power supply class support into the usb charger,
just introduce the notify mechanism for power to set the current limit
when notifying some events from usb charger. Maybe I misunderstand
your meanings, please describe it detailedly. Thanks for your
comments.

> Li Jun
>



-- 
Baolin.wang
Best Regards
