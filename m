From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / runtime: Use synchronous runtime PM call in rpm_put_suppliers()
Date: Mon, 27 Mar 2017 14:05:57 +0200
Message-ID: <CAPDyKFoKwXijuSimt=Xr-qp4oYEGwcfZST_rUMFTCTUxS39PqA@mail.gmail.com>
References: <CGME20170322092305eucas1p20d2a6dfede483210febea5b5e0ff68db@eucas1p2.samsung.com>
 <1490174570-18345-1-git-send-email-m.szyprowski@samsung.com>
 <CAPDyKFq+mTvruQb5ifj3etMxSCWgDZTZ6ebGkk84UCQDqjR4-A@mail.gmail.com>
 <CAJZ5v0ihYQp4_oJCu3Tugbqrm=68hcxdg8-yUphbCXCUw3UzPw@mail.gmail.com>
 <CAPDyKFot3C1C1k45JovwKHFkvTJAFvdetoE8_ADAhMCkFw3hPA@mail.gmail.com> <20170324113736.GA21618@h08.hostsharing.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20170324113736.GA21618@h08.hostsharing.net>
Sender: linux-clk-owner@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-clk <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 24 March 2017 at 12:37, Lukas Wunner <lukas@wunner.de> wrote:
> On Thu, Mar 23, 2017 at 01:47:46PM +0100, Ulf Hansson wrote:
>> For the sync runtime PM suspend/idle case:
>> When a driver for a children/consumers decides to use the sync runtime
>> PM APIs, it's most likely because it wants the device to enter its low
>> power state as soon as possible.
>
> I think a driver is doing it wrong if it uses sync vs. async to achieve
> a certain policy.  (As in the example you've given above.)  That should
> be left to the PM core, and the PM core should try to suspend as early
> and as often as possible in order to save power.  If the driver wants to

I am not really sure what you mean by this.

The runtime PM APIs is what we have today and those are of course used
a bit differently depending on the client. I was trying to summarize
my impressions from those that using the asynchronous interface.

> achieve a policy such as "suspend this device ASAP but let this other
> device idle a bit before suspend because its usage pattern is bursty"
> then the correct way to implement this is via a sane default value for
> the autosuspend delay.

The runtime PM autosuspend feature is per definition asynchronous. And
since user space anyway can change the value of the timeout, I don't
think it make sense to consider this as separate case within this
context.

>
> Generelly, async should be used.  One example where sync is warranted
> is when the ->runtime_suspend hook needs to be finished before power
> is cut to the device.  That's a hard constraint.  E.g. vga_switcheroo
> does this when runtime suspending the GPU.  In this case, "runtime
> suspend" means that the driver puts the device in a state from which
> power can be cut.  The actual power switch is toggled afterwards.

No, this isn't a valid case. If this how vga_switcheroo deploys
runtime PM supports this surely needs to be fixed!

A call to pm_runtime_put_sync() may not trigger the runtime suspend
callback to be invoked, because userspace via sysfs can prevent that.

Kind regards
Uffe
