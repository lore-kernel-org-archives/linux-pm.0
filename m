From: loody <miloody@gmail.com>
Subject: Re: any global parameter to know system power state
Date: Fri, 11 Oct 2013 00:05:15 +0800
Message-ID: <CANudz+s22Cz0H_7+iK9mJFD9=UEyMdrF4MgUp+c=yZ-po5x4hA@mail.gmail.com>
References: <CANudz+ur37HRgygXrzgDPHrg-2LCRfR23sPZ4DWo_R5bRjetxg@mail.gmail.com>
	<Pine.LNX.4.44L0.1310101032110.1307-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:56821 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756900Ab3JJQFR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Oct 2013 12:05:17 -0400
Received: by mail-wg0-f47.google.com with SMTP id f12so2717881wgh.2
        for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2013 09:05:16 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44L0.1310101032110.1307-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Sarah Sharp <sarah.a.sharp@linux.intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

hi Alan:
Wow!! Suprise!!
you are here  :-)
Does linux hacker need to monitor every topic?

> On matters concerning xHCI, you really should CC: the xHCI maintainer.
Yes, but I thought this our soc issue, and it is under debugging.
So i try not to bother Sarah. :)

>
> On Thu, 10 Oct 2013, loody wrote:
>
>> in xhci_resume, we will do xhci_halt usually.
>> But our embedded system has something wrong and xhci_halt will make it
>> core dump during resume.
>>
>> I try to know whether there is any global parameter to let us do the
>> sw workaround.
>> (just like below + line)
>>
>>
>> int xhci_resume(struct xhci_hcd *xhci, bool hibernated)
>> {
>>     u32            command, temp = 0;
>>     struct usb_hcd        *hcd = xhci_to_hcd(xhci);
>>     struct usb_hcd        *secondary_hcd;
>>     int            retval = 0;
>>     ....
>>     ......
>>     xhci_dbg(xhci, "Stop HCD\n");
>> +    if (global_pm_state !=resume){
>>         xhci_halt(xhci);
>> +    }
>>     xhci_reset(xhci);
>>     spin_unlock_irq(&xhci->lock);
>>     ......
>
> Wouldn't it be better to test the platform?  Then the xhci_halt() could
> be skipped on your embedded systems but nowhere else.

Yes, actually our designer is trying to figure out why "xhci_halt"
make our system core dump.
off cause I can keep my own parameter to record pm_state, but it would
be better if there is already a global one to the same thing.

Nice to see U, and hope one day I have the pleasure to drink beer with you.
