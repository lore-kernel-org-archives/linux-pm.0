From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 2/3] phy: core: Drop unused runtime PM APIs
Date: Thu, 21 Dec 2017 15:23:52 +0100
Message-ID: <CAPDyKFrncD7nHRWuYbdrNWjHxD0CcTR+zXA4tPCgWsMCmzabSg@mail.gmail.com>
References: <1513778960-10073-1-git-send-email-ulf.hansson@linaro.org>
 <1513778960-10073-3-git-send-email-ulf.hansson@linaro.org>
 <TY1PR06MB0992E87FAA770B745DCBA690D80D0@TY1PR06MB0992.apcprd06.prod.outlook.com>
 <CAPDyKFrOONTsm5xiXrvqqy3koG5=11bKk1b2igx+FzSJbzj_Ng@mail.gmail.com> <TY1PR06MB0992357759B33F1F3C826439D80D0@TY1PR06MB0992.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:42179 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751658AbdLUOXx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Dec 2017 09:23:53 -0500
Received: by mail-io0-f177.google.com with SMTP id x67so15095605ioi.9
        for <linux-pm@vger.kernel.org>; Thu, 21 Dec 2017 06:23:53 -0800 (PST)
In-Reply-To: <TY1PR06MB0992357759B33F1F3C826439D80D0@TY1PR06MB0992.apcprd06.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>

On 21 December 2017 at 13:24, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
>
>> From: Ulf Hansson, Sent: Thursday, December 21, 2017 7:58 PM
>>
>> On 21 December 2017 at 11:33, Yoshihiro Shimoda
>> <yoshihiro.shimoda.uh@renesas.com> wrote:
>> > Hi Ulf-san,
>> >
>> >> -----Original Message-----
>> >> From: Ulf Hansson, Sent: Wednesday, December 20, 2017 11:09 PM
>> > <snip>
>> >> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
>> >> index b4298a1..050b620 100644
>> >> --- a/include/linux/phy/phy.h
>> >> +++ b/include/linux/phy/phy.h
>> >> @@ -17,7 +17,6 @@
>> >>  #include <linux/err.h>
>> >>  #include <linux/of.h>
>> >>  #include <linux/device.h>
>> >> -#include <linux/pm_runtime.h>
>> >
>> > After I applied this patch, some ata and gpu drivers causes build error [1].
>> > So, we should fix the drivers at first...
>>
>> Huh, right, those drivers shouldn't be relying on the phy.h to include
>> pm_runtime.h.
>>
>> The easiest way at this point is to just put back "#include
>> <linux/pm_runtime.h>" in phy.h, then we can deal with these problems
>> separately. I do that in a re-spin soon.
>
> I got it.
>
>> BTW, I would be great if you could test this on the Renesas SoC to
>> make sure it still fixes the problems (at least half of them I mean).
>
> Sure. I put back the "#include <linux/pm_runtime.h>" in the phy.h and tested
> the patches on my environment (r8a7795-salvator-x.dts with v4.15-rc4). And then,
> the issue [1] disappeared.
> [1]:
> printed "Enabling runtime PM for inactive device (ee0a0200.usb-phy) with active children"
> in resume timing.
>
> So,
>
> Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Great, thanks!

I add your tag in the next re-vision!

Kind regards
Uffe
