From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 4/4] PM / Runtime: Don't allow to suspend a device with an
 active child
Date: Wed, 26 Oct 2016 13:30:44 +0200
Message-ID: <CAPDyKFrC+Jpxrw+rXq5UE2rwo89C5=OqRXG_Hh-FAAyk6sKKTQ@mail.gmail.com>
References: <1476728221-26530-1-git-send-email-ulf.hansson@linaro.org>
 <1476728221-26530-5-git-send-email-ulf.hansson@linaro.org>
 <CAMuHMdX4Si0pfZ0cnZU=KC+kHK0bJiLcArqLLaU1Rw7-zZ0bsA@mail.gmail.com>
 <CAPDyKFoxSiCrfbWRGpSxpwYuL_5okARjqum25nZVe0KyOg_QYg@mail.gmail.com> <CAMuHMdUYRck5bBuxszjhKrOJoezSYaSqe8z-WVQanDh0fmrvBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdUYRck5bBuxszjhKrOJoezSYaSqe8z-WVQanDh0fmrvBw@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alan Stern <stern@rowland.harvard.edu>, Linux PM list <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 26 October 2016 at 11:47, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Ulf,
>
> On Tue, Oct 25, 2016 at 11:31 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 25 October 2016 at 15:59, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>> On Mon, Oct 17, 2016 at 8:17 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>> When resuming a device in __pm_runtime_set_status(), the prerequisite is
>>>> that its parent must already be active, else an error code is returned and
>>>> the device's status remains suspended.
>>>>
>>>> When suspending a device there is no similar constraints being validated.
>>>> Let's change this to make the behaviour consistent, by not allowing to
>>>> suspend a device with an active child, unless it has been explicitly set to
>>>> ignore its children.
>>>>
>>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>
>>> This is now commit 8b1107b85efd78c in pm/linux-next.
>>>
>>> This breaks resume from s2ram on r8a73a4/ape6evm and sh73a0/kzm9g, where the
>>> smsc911x Ethernet is connected to an external bus, whose clock is controlled
>>> through Runtime PM and the simple-pm-bus driver.
>>>
>>> Reverting this commit fixes the issue.
>>
>> Geert, thanks again for testing and reporting. I believe this problem
>> is directly related to what you reported for another patch [1] as
>> well.
>
> Indeed. At first I thought that patch got applied, but I couldn't find it ;-)
>
>> Can you please try out this rather trivial patch to the Ethernet
>> driver (smsc911x), to see if that solves the problem(s).
>
> Thanks, it does!

Great, thanks for testing!

I will re-post the patch with a proper change-log.

>
> Difference between before and after is:
>
>  PM: Suspending system (mem)
>  cpg_div6_clock_disable: sdhi1ck
>  cpg_div6_clock_disable: sdhi0ck
> -PM: suspend of devices complete after 22.932 msecs
> -PM: late suspend of devices complete after 7.311 msecs
> +PM: suspend of devices complete after 23.131 msecs
> +PM: late suspend of devices complete after 7.300 msecs
>  cpg_div6_clock_disable: mmc0
>  cpg_div6_clock_disable: zb
> -simple-pm-bus fec10000.bus: runtime PM trying to suspend device but
> active child
>  rmobile_pd_power_down: a3sp
> -PM: noirq suspend of devices complete after 26.937 msecs
> +PM: noirq suspend of devices complete after 18.467 msecs
>  Disabling non-boot CPUs ...
> -Suspended for 2.579 seconds
> +Suspended for 2.949 seconds
>  rmobile_pd_power_up: a3sp
> +cpg_div6_clock_enable: zb
>  cpg_div6_clock_enable: sdhi0ck
>  cpg_div6_clock_enable: sdhi1ck
>  cpg_div6_clock_enable: mmc0
> -PM: noirq resume of devices complete after 128.014 msecs
> -PM: early resume of devices complete after 6.121 msecs
> -Unhandled fault: imprecise external abort (0x1406) at 0x00000000
>
> The zb clock is enabled again.
>
> BTW, shouldn't "runtime PM trying to suspend device but active child"
> become a WARN()? If this happens, something is really wrong, and
> the device will be left in half-suspended state (clock disabled).

That would make sense to me!
Although if we decide to change that, we should also convert from
dev_err() to WARN() when failing to set RPM_ACTIVE in
__pm_runtime_set_status(), as to be consistent.

Do you want to send a patch?

>
>> From: Ulf Hansson <ulf.hansson@linaro.org>
>> Date: Tue, 25 Oct 2016 23:11:51 +0200
>> Subject: [PATCH] net: smsc911x: Synchronize the runtime PM status during
>>  system suspend
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Gr{oetje,eeting}s,
>
>                         Geert
>

Kind regards
Uffe
