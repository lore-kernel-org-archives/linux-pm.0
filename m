From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / Runtime: Only force-resume device if it has been force-suspended
Date: Thu, 21 Apr 2016 11:10:19 +0200
Message-ID: <CAPDyKFokRP5MiQkyFHBOZLVpO=xxa4ec_U45VNpQ+uZ=qarZvQ@mail.gmail.com>
References: <Pine.LNX.4.44L0.1603041021200.1885-100000@iolanthe.rowland.org>
	<2096023.P4Pq9IvUAO@avalon>
	<CAPDyKFqtrdw+MHh6tAz658=PQi+REGAEiNzNs_4aRzTTpOwP9Q@mail.gmail.com>
	<1747840.aL2QAkXYBh@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1747840.aL2QAkXYBh@avalon>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, linux-renesas-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 21 April 2016 at 01:30, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hello,
>
> Reviving this old thread.
>
> On Monday 07 Mar 2016 11:10:08 Ulf Hansson wrote:
>> [...]
>>
>> >> I agree, that's a better idea. Drivers shouldn't call
>> >> pm_runtime_force_resume() if they haven't called
>> >> pm_runtime_force_suspend(), so checking the PM use count should be fine.
>> >> I'll modify the patch, test it and resubmit.
>> >
>> > I gave it an unfortunately unsuccessful try. The problem I ran into is
>> > that device_prepare() calls pm_runtime_get_noresume() calls
>> > pm_runtime_get_noresume(), with the corresponding pm_runtime_put() call
>> > being performed in device_complete(). The device power usage_count is
>> > thus always non-zero in the system resume handler, so I can't base the
>> > decision on that.
>>
>> As Alan said, let's just check against 1 instead.
>
> I gave this a try, and unfortunately it won't work.
>
> pm_genpd_prepare() resumes devices without increasing the usage count, which

It doesn't resume them, it only increases the usage count.

> leads to the device always being active in pm_runtime_force_suspend(). The
> usage count will be 1 if the device was suspended prior to entering system
> suspend (due to the pm_runtime_get_noresume() call in device_prepare()) or
> higher than 1 if the device was active.

It's only greater than 1 - if someone else than the PM core has
increased the usage count.

>
> However, pm_genpd_prepare() will not resume the device if suspend_power_off is
> set. In that case the device will be suspended with a usage count of 1 in
> pm_runtime_force_suspend() or active with a usage count higher than 1.
>
> We thus can't detect at resume time whether we have force-suspended the device
> using the usage count.

We don't need to detect this no more! Let me give you some background to why.

When the pm_runtime_force_suspend|resume() helpers were invented, we
still had CONFIG_PM_RUNTIME and CONFIG_PM_SLEEP as separate Kconfig
options.

To make sure these helpers worked for all combinations and without
introducing too much complexity, we needed to always resume the device
in pm_runtime_force_resume(). More precisely, when CONFIG_PM_SLEEP was
used without CONFIG_PM_RUNTIME, we needed to resume the device as the
driver/subsystem couldn't do it via a call to pm_runtime_get_sync()
(or similar API).

As we have merged CONFIG_PM_RUNTIME into CONFIG_PM, the above
described option has disappeared. This means the driver/bus indeed
will be able to use pm_runtime_get_sync() to resume the device at a
later point when needed.

>
> Unless someone has another clever idea I'll keep the power.is_force_suspended
> flag and protect it with power.lock.
>
>> > I also noticed that pm_genpd_prepare() runtime-resumes the device (when
>> > the power domain is in the GPD_STATE_ACTIVE state). I don't know why that
>> > is, but it means that in practice my device gets runtime-resumed when
>> > suspending the system while it could stay runtime-suspended in practice.
>>
>> I am aware of this and it's on my TODO list of improvements of genpd,
>> The issue is related to an unoptimized behaviour for how genpd deal
>> with wakeups during system PM.
>
> Looking forward to seeing patches :-)

I have been cooking a patch. Very soon I will post it and will make
sure you are on cc!

Of course any help in testing/reviewing will be highly appreciated!

Kind regards
Uffe
