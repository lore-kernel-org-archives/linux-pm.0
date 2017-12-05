From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / runtime: Drop children check from __pm_runtime_set_status()
Date: Tue, 5 Dec 2017 16:48:46 +0100
Message-ID: <CAPDyKFojEgSN9TfxywYW6Td-j--QzdZ5MNJjBXhJ_vQ=Rz=Aew@mail.gmail.com>
References: <1713438.irjm9MTSvo@aspire.rjw.lan> <CAMuHMdV4LV2Uzh2oGdaPiS4W4dfsZ-pn3rGcJNiZLStfo39How@mail.gmail.com>
 <TY1PR06MB09928D43D4E5E5752A6A604ED83A0@TY1PR06MB0992.apcprd06.prod.outlook.com>
 <CAPDyKFoF0WMSTuK4AAyDzerpVpnfEq=Hn1n9kDJM0fYMkFL_wA@mail.gmail.com>
 <TY1PR06MB09924E4F66C6FCF131EE71CFD83B0@TY1PR06MB0992.apcprd06.prod.outlook.com>
 <CAPDyKFoG2-mVGDtzPyg2FDVbXnsWGy543craKqeBVE_awKpf8Q@mail.gmail.com>
 <CAMuHMdViD3vqzits=th52+01d5y3p5iwbAg0jbUBcoGvYfULuA@mail.gmail.com>
 <CAPDyKFpRrQr3LRXH_CoLSYe2a=2PnUqvuNWUYSuh0wm+rBJ0dw@mail.gmail.com>
 <TY1PR06MB09928B145D35E52444F8D462D8380@TY1PR06MB0992.apcprd06.prod.outlook.com>
 <CAPDyKFr8D4jL2vwO5tdBJnNVP=DoAD6H_K=4SQbu7rFAZFd3Xg@mail.gmail.com>
 <TY1PR06MB09929CD76E67B64FDE54B170D8390@TY1PR06MB0992.apcprd06.prod.outlook.com>
 <CAPDyKFr4=Vct_-w1euOsEnb3WdeBvH9mz12zNTUfX7Z6nEwRuw@mail.gmail.com> <TY1PR06MB0992214C75585618A1400A1CD83D0@TY1PR06MB0992.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <TY1PR06MB0992214C75585618A1400A1CD83D0@TY1PR06MB0992.apcprd06.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, USB list <linux-usb@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>
List-Id: linux-pm@vger.kernel.org

On 5 December 2017 at 04:23, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Hi,
>
>> From: Ulf Hansson, Sent: Monday, December 4, 2017 7:41 PM
>>
>> On 1 December 2017 at 12:03, Yoshihiro Shimoda
>> <yoshihiro.shimoda.uh@renesas.com> wrote:
> <snip>
>> > Sure! I tested your patch, and then the following message disappeared!
>> >
>> >    Enabling runtime PM for inactive device (ee080200.usb-phy) with active children
>>
>> Great, that confirms my theory.
>>
>> I will re-work the patch and re-post it to see what people thinks about it.
>
> Thank you!
>
>> >
>> > However, the following message still exists.
>> >
>> >    Enabling runtime PM for inactive device (ee080000.usb) with active children
>> >
>> > So, I guess ohci-platform.c also has similar issue.
>>
>> Yes, very likely!
>>
>> However, I need some more time to look into this to be able to suggest
>> a solution.
>
> I found a solution and sent a report as below:
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1551146.html
>
> What do you think about using pm_runtime_forbid()?

As both Alan and Rafael pointed out in their replies, this is not the
right solution.

However, what is indeed interesting is how it can silence the error
messages. I keep this is mind while later moving forward.

Kind regards
Uffe
