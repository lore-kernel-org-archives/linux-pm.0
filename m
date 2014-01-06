From: loody <miloody@gmail.com>
Subject: Re: how to know how long it takes on suspend/resume for platform usb driver
Date: Mon, 6 Jan 2014 22:16:40 +0800
Message-ID: <CANudz+vLJCwDVfhc-8VSF6kumjW7fBOkWQLFF+UihQhE34eUVg@mail.gmail.com>
References: <CANudz+uTBobmR5tCbtZLAzTnZ_9qXmWyKHvEm5hsAfgwG9Tcqw@mail.gmail.com>
	<Pine.LNX.4.44L0.1401041127520.31700-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=bcaec53d5ae594af3004ef4de8cb
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:60032 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099AbaAFOQl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jan 2014 09:16:41 -0500
Received: by mail-wg0-f46.google.com with SMTP id m15so15563167wgh.25
        for <linux-pm@vger.kernel.org>; Mon, 06 Jan 2014 06:16:40 -0800 (PST)
In-Reply-To: <Pine.LNX.4.44L0.1401041127520.31700-100000@netrider.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux PM list <linux-pm@vger.kernel.org>

--bcaec53d5ae594af3004ef4de8cb
Content-Type: text/plain; charset=ISO-8859-1

hi alan:

>>
>> I have some questions:
>> 1. "call 0000:00:1d.0+ returned 0 after 15495 usecs" mean all ports
>> under this ehci host total cost 15495 us for resuming?
>
> In the log messages above, 15495 us was the time required for
> suspending, not resuming.  It means that putting the host controller
> into D3 took 15495 us.  The times required to suspend the root hub and
> each port are mentioned elsewhere in the log.
>
Yes. you are correct.
I excerpt the wrong part.

>> 2. is it possible to change the order of calling resume callback?
>>     for example, suppose the original sequence is "ehci -> xhci -> tty
>> ..." and I want to change as "tty-> ehci -> xhci".
>
> It is possible only to a very limited extent.  You can turn async
> suspend/resume on or off, and this will affect the order.  Of course,
> when async suspend/resume is off, the total time required will be
> longer than when it is on.
>
> Why do you want to change the order?  It shouldn't make any difference.
Because I want the GUI and input part of driver resume as earlier as possible.
Such that user can keep on their previous work more quicker.


>
>> 3. what is above "usb2+" mean? after trace source code, It seems "type" resume.
>>     I can tell "bus" resume, since it is bus driver layer resume call back API.
>>     What is "type" resume?
>
> There can be several different "types" of devices all attached to the
> same bus.  For example, on a USB bus we have devices representing USB
> peripherals, USB interfaces, and USB ports -- three different types.
> A "type" resume is the type-specific resume callback API.  See how
> usb_device_type is defined and used in drivers/usb/core/usb.c.

when I "echo 1 > /sys/power/pm_print_time" on my embedded system,
there are some message I am curious.
after we resume ehci by " call platform3-ehci.0+ returned 0 after 7746
usecs" and
type driver "call usb3+ returned 0 after 100475 usecs

why there come below resume message:
"calling  ehci.2+ @ 63, parent: none
bus resume
call ehci.2+ returned 0 after 2 usecs
"

Thanks for your kind help,

--bcaec53d5ae594af3004ef4de8cb
Content-Type: application/x-bzip2;
	name="2014.01.06.pm_pirnt_time.log.tar.bz2"
Content-Disposition: attachment;
	filename="2014.01.06.pm_pirnt_time.log.tar.bz2"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hq3tb5z40

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
oSFXy2py
--bcaec53d5ae594af3004ef4de8cb--
