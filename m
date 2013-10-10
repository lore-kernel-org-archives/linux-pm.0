From: loody <miloody@gmail.com>
Subject: Re: any global parameter to know system power state
Date: Thu, 10 Oct 2013 21:52:48 +0800
Message-ID: <CANudz+ur37HRgygXrzgDPHrg-2LCRfR23sPZ4DWo_R5bRjetxg@mail.gmail.com>
References: <CANudz+tjdjwZvSRmYxDO67M0LTqjbPK2iZTMPLerZZnBufLixA@mail.gmail.com>
	<CANudz+v+iUrKLtA93VqkY3chcuk2L8PZ_s9NWD6XvmiBBOMBcQ@mail.gmail.com>
	<52569A4B.6060006@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:58790 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269Ab3JJNwt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Oct 2013 09:52:49 -0400
Received: by mail-wg0-f50.google.com with SMTP id f12so2560249wgh.17
        for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2013 06:52:48 -0700 (PDT)
In-Reply-To: <52569A4B.6060006@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

hi Daniel:


2013/10/10 Daniel Lezcano <daniel.lezcano@linaro.org>:
> On 10/10/2013 01:31 PM, loody wrote:
>>
>> hi all:
>> Is there any global parameter which can let us know the pm state?
>> Such that we can apply different software workaround in our embedded
>> system by different power state.
>
>
> Can you elaborate and give an example ?
Sure.
I forget to do that to make this question more clear :)


in xhci_resume, we will do xhci_halt usually.
But our embedded system has something wrong and xhci_halt will make it
core dump during resume.

I try to know whether there is any global parameter to let us do the
sw workaround.
(just like below + line)


int xhci_resume(struct xhci_hcd *xhci, bool hibernated)
{
    u32            command, temp = 0;
    struct usb_hcd        *hcd = xhci_to_hcd(xhci);
    struct usb_hcd        *secondary_hcd;
    int            retval = 0;
    ....
    ......
    xhci_dbg(xhci, "Stop HCD\n");
+    if (global_pm_state !=resume){
        xhci_halt(xhci);
+    }
    xhci_reset(xhci);
    spin_unlock_irq(&xhci->lock);
    ......



Appreciate your help,
