From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / runtime: Drop children check from __pm_runtime_set_status()
Date: Mon, 4 Dec 2017 11:41:07 +0100
Message-ID: <CAPDyKFr4=Vct_-w1euOsEnb3WdeBvH9mz12zNTUfX7Z6nEwRuw@mail.gmail.com>
References: <1713438.irjm9MTSvo@aspire.rjw.lan> <CAMuHMdV4LV2Uzh2oGdaPiS4W4dfsZ-pn3rGcJNiZLStfo39How@mail.gmail.com>
 <TY1PR06MB09928D43D4E5E5752A6A604ED83A0@TY1PR06MB0992.apcprd06.prod.outlook.com>
 <CAPDyKFoF0WMSTuK4AAyDzerpVpnfEq=Hn1n9kDJM0fYMkFL_wA@mail.gmail.com>
 <TY1PR06MB09924E4F66C6FCF131EE71CFD83B0@TY1PR06MB0992.apcprd06.prod.outlook.com>
 <CAPDyKFoG2-mVGDtzPyg2FDVbXnsWGy543craKqeBVE_awKpf8Q@mail.gmail.com>
 <CAMuHMdViD3vqzits=th52+01d5y3p5iwbAg0jbUBcoGvYfULuA@mail.gmail.com>
 <CAPDyKFpRrQr3LRXH_CoLSYe2a=2PnUqvuNWUYSuh0wm+rBJ0dw@mail.gmail.com>
 <TY1PR06MB09928B145D35E52444F8D462D8380@TY1PR06MB0992.apcprd06.prod.outlook.com>
 <CAPDyKFr8D4jL2vwO5tdBJnNVP=DoAD6H_K=4SQbu7rFAZFd3Xg@mail.gmail.com> <TY1PR06MB09929CD76E67B64FDE54B170D8390@TY1PR06MB0992.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:39328 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751390AbdLDKlI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Dec 2017 05:41:08 -0500
Received: by mail-it0-f53.google.com with SMTP id 68so5500728ite.4
        for <linux-pm@vger.kernel.org>; Mon, 04 Dec 2017 02:41:08 -0800 (PST)
In-Reply-To: <TY1PR06MB09929CD76E67B64FDE54B170D8390@TY1PR06MB0992.apcprd06.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, USB list <linux-usb@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>

On 1 December 2017 at 12:03, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Hi,
>
>> From: Ulf Hansson, Sent: Friday, December 1, 2017 6:22 PM
>>
>> + Kishon
>>
>> On 30 November 2017 at 13:51, Yoshihiro Shimoda
>> <yoshihiro.shimoda.uh@renesas.com> wrote:
>> > Hi,
>> >
>> >> From: Ulf Hansson, Sent: Wednesday, November 29, 2017 6:59 PM
>> >>
>> >> On 29 November 2017 at 10:43, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> >> > Hi Ulf,
>> > <snip>
>> >> Okay, so the problem remains no matter which solution for wakeup you
>> >> pick in genpd.
>> >
>> > Yes. Today I could reproduce this issue without usb host driver.
>> > - The renesas_usb3 usb peripheral driver has generic phy handling.
>> >   (The peripheral driver uses different generic phy driver (phy-rcar-gen3-usb3.c) though.)
>> >  --> If I used the current renesas_usb3 (this means doesn't call phy_power_{on,off}(),
>> >      the issue didn't happen.
>> >  --> If I added phy_power_{on,off}() calling, the issue happened.
>> >   --> So, I'm thinking the APIs are related to the issue.
>>
>> Yes.
>>
>> >
>> > - The generic phy APIs are in drivers/phy/phy-core.c.
>> >  --> The phy-rcar-gen3-usb[23] drivers call only pm_runtime_enable() before devm_phy_create().
>> >   --> The phy-core will call pm_runtime_{get_sync,put}() in phy_{init,exit,power_{on,off}}.
>> >    --> So, IIUC, both devices of phy-<dev_name>.<id> and <dev_name> will be handled by runtime PM APIs.
>> >  --> The runtime PM implementation of phy-core seems good to me. But...?
>>
>>
>> I have digested the information that you and Geert provided, thanks!
>>
>> So, my conclusions so far is:
>>
>> The phy core is using runtime PM reference counting at
>> phy_power_on|off(). Although it does that on the phy core device,
>> which is a child device of the phy provider device.
>>
>> Because phy_power_off() is called during system suspend from phy
>> consumer drivers like usb, the phy core device (child) and the phy
>> provider device (parent) will never become runtime suspended (because
>> the PM core has invoked pm_runtime_get_no_resume() for all device in
>> the device prepare phase).
>>
>> Then, when genpd calls pm_runtime_force_suspend() at the suspend noirq
>> phase for the phy provider device, the call to
>> pm_runtime_set_suspended() in there, triggers the earlier error
>> message, which is because the child (phy core device) is still runtime
>> resumed.
>
> Thank you very much for the conclusions!
> It's helpful to me about runtime PM behavior.
>
>> >> Then this seems to point to that the driver may be misbehaving in some
>> >> way. I can help to check what is going on.
>> >
>> > I guess so. But, I don't find yet...
>>
>> I think the below patch will help, although I am not sure if that is
>> sufficient as a long term fix.
>
> Thank you very much for your help!
> Also, I'm not sure how to fix for a long term kernels though...
>
>> Can you please try and see if it solves the problems?
>
> Sure! I tested your patch, and then the following message disappeared!
>
>    Enabling runtime PM for inactive device (ee080200.usb-phy) with active children

Great, that confirms my theory.

I will re-work the patch and re-post it to see what people thinks about it.

>
> However, the following message still exists.
>
>    Enabling runtime PM for inactive device (ee080000.usb) with active children
>
> So, I guess ohci-platform.c also has similar issue.

Yes, very likely!

However, I need some more time to look into this to be able to suggest
a solution.

>
> JFYI, the ehci-platform.c doesn't have runtime PM handling.
> So, I think that error message doesn't output from ehci devices.

Right, thanks!

Kind regards
Uffe
