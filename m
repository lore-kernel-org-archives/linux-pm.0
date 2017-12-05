From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM / runtime: Drop children check from __pm_runtime_set_status()
Date: Tue, 5 Dec 2017 16:23:35 +0100
Message-ID: <CAJZ5v0j6u3oH_mRac4zcZsJdZtXAD0UxUQUYf4pj2SDwmaHsNw@mail.gmail.com>
References: <TY1PR06MB0992214C75585618A1400A1CD83D0@TY1PR06MB0992.apcprd06.prod.outlook.com>
 <Pine.LNX.4.44L0.1712050958090.1416-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1712050958090.1416-100000@iolanthe.rowland.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, USB list <linux-usb@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 5, 2017 at 4:03 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Tue, 5 Dec 2017, Yoshihiro Shimoda wrote:
>
>> Hi,
>>
>> > From: Ulf Hansson, Sent: Monday, December 4, 2017 7:41 PM
>> >
>> > On 1 December 2017 at 12:03, Yoshihiro Shimoda
>> > <yoshihiro.shimoda.uh@renesas.com> wrote:
>> <snip>
>> > > Sure! I tested your patch, and then the following message disappeared!
>> > >
>> > >    Enabling runtime PM for inactive device (ee080200.usb-phy) with active children
>> >
>> > Great, that confirms my theory.
>> >
>> > I will re-work the patch and re-post it to see what people thinks about it.
>>
>> Thank you!
>>
>> > >
>> > > However, the following message still exists.
>> > >
>> > >    Enabling runtime PM for inactive device (ee080000.usb) with active children
>> > >
>> > > So, I guess ohci-platform.c also has similar issue.
>> >
>> > Yes, very likely!
>> >
>> > However, I need some more time to look into this to be able to suggest
>> > a solution.
>>
>> I found a solution and sent a report as below:
>> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1551146.html
>>
>> What do you think about using pm_runtime_forbid()?
>
> In general, drivers should not use pm_runtime_forbid().

I'd rather say that it's not very useful to them. :-)

> It is meant for use by userspace, through the /sys/.../power/control file.

Or when the driver wants to change the default setting.

> Drivers cannot rely on the result of calling pm_runtime_forbid()
> or pm_runtime_allow(), because the user can change it at any time.

Right.

> If you really want to prevent the OHCI controller from going into
> runtime suspend, the proper approach is to call pm_runtime_get() in the
> probe routine and pm_runtime_put() in the release routine.  However,
> this will waste energy because it will force the controller to remain
> at full power even when no active devices are attached.
>
> In this case, there probably is a better to solution to your problem
> (such as fixing the runtime PM support in the phy driver).

Agreed.

Thanks,
Rafael
