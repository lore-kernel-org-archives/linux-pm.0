From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] PM / runtime: Use synchronous runtime PM call in
 rpm_put_suppliers()
Date: Fri, 24 Mar 2017 12:37:36 +0100
Message-ID: <20170324113736.GA21618@h08.hostsharing.net>
References: <CGME20170322092305eucas1p20d2a6dfede483210febea5b5e0ff68db@eucas1p2.samsung.com>
 <1490174570-18345-1-git-send-email-m.szyprowski@samsung.com>
 <CAPDyKFq+mTvruQb5ifj3etMxSCWgDZTZ6ebGkk84UCQDqjR4-A@mail.gmail.com>
 <CAJZ5v0ihYQp4_oJCu3Tugbqrm=68hcxdg8-yUphbCXCUw3UzPw@mail.gmail.com>
 <CAPDyKFot3C1C1k45JovwKHFkvTJAFvdetoE8_ADAhMCkFw3hPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFot3C1C1k45JovwKHFkvTJAFvdetoE8_ADAhMCkFw3hPA@mail.gmail.com>
Sender: linux-clk-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-clk <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 23, 2017 at 01:47:46PM +0100, Ulf Hansson wrote:
> For the sync runtime PM suspend/idle case:
> When a driver for a children/consumers decides to use the sync runtime
> PM APIs, it's most likely because it wants the device to enter its low
> power state as soon as possible.

I think a driver is doing it wrong if it uses sync vs. async to achieve
a certain policy.  (As in the example you've given above.)  That should
be left to the PM core, and the PM core should try to suspend as early
and as often as possible in order to save power.  If the driver wants to
achieve a policy such as "suspend this device ASAP but let this other
device idle a bit before suspend because its usage pattern is bursty"
then the correct way to implement this is via a sane default value for
the autosuspend delay.

Generelly, async should be used.  One example where sync is warranted
is when the ->runtime_suspend hook needs to be finished before power
is cut to the device.  That's a hard constraint.  E.g. vga_switcheroo
does this when runtime suspending the GPU.  In this case, "runtime
suspend" means that the driver puts the device in a state from which
power can be cut.  The actual power switch is toggled afterwards.

Regards,

Lukas
