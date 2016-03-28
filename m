From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v8 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Mon, 28 Mar 2016 17:09:54 +0800
Message-ID: <CAMz4kuK33mfiO9OttbRF9yVbQE1DFeuOtwyUWkCa5iPYbE-H8g@mail.gmail.com>
References: <cover.1458822334.git.baolin.wang@linaro.org>
	<20160325070937.GA22398@peterchendt>
	<CAMz4kuJYBg4eortA35Dhr4-jPVhLzu9XhjpOcu0hDWq6FV09mw@mail.gmail.com>
	<20160328071351.GC3302@peterchendt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:34287 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754112AbcC1JJ4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Mar 2016 05:09:56 -0400
Received: by mail-qk0-f180.google.com with SMTP id x64so62386420qkd.1
        for <linux-pm@vger.kernel.org>; Mon, 28 Mar 2016 02:09:56 -0700 (PDT)
In-Reply-To: <20160328071351.GC3302@peterchendt>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Chen <hzpeterchen@gmail.com>
Cc: Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>

On 28 March 2016 at 15:13, Peter Chen <hzpeterchen@gmail.com> wrote:
> On Mon, Mar 28, 2016 at 02:51:40PM +0800, Baolin Wang wrote:
>> On 25 March 2016 at 15:09, Peter Chen <hzpeterchen@gmail.com> wrote:
>> > On Thu, Mar 24, 2016 at 08:35:53PM +0800, Baolin Wang wrote:
>> >> Currently the Linux kernel does not provide any standard integration of this
>> >> feature that integrates the USB subsystem with the system power regulation
>> >> provided by PMICs meaning that either vendors must add this in their kernels
>> >> or USB gadget devices based on Linux (such as mobile phones) may not behave
>> >> as they should. Thus provide a standard framework for doing this in kernel.
>> >>
>> >> Now introduce one user with wm831x_power to support and test the usb charger,
>> >> which is pending testing. Moreover there may be other potential users will use
>> >> it in future.
>> >>
>> >
>> > I am afraid I still not find the user (udc driver) for this framework, I would
>> > like to see how udc driver block the enumeration until the charger detection
>> > has finished, or am I missing something?
>>
>> It is not for udc driver but for power users who want to negotiate
>> with USB subsystem.
>>
>
> Then, where is the code the test user to decide what kinds of USB charger
> (SDP, CDP, DCP) is connecting now?

Users can choose to implement multiple ways to get the charger type In
'usb_charger_detect_type()' function.

>
> --
> Best Regards,
> Peter Chen



-- 
Baolin.wang
Best Regards
