From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / Runtime: Only force-resume device if it has been force-suspended
Date: Mon, 7 Mar 2016 11:10:08 +0100
Message-ID: <CAPDyKFqtrdw+MHh6tAz658=PQi+REGAEiNzNs_4aRzTTpOwP9Q@mail.gmail.com>
References: <Pine.LNX.4.44L0.1603041021200.1885-100000@iolanthe.rowland.org>
	<1481433.r0tFS4sTcH@avalon>
	<2096023.P4Pq9IvUAO@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <2096023.P4Pq9IvUAO@avalon>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, linux-renesas-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

[...]

>> I agree, that's a better idea. Drivers shouldn't call
>> pm_runtime_force_resume() if they haven't called pm_runtime_force_suspend(),
>> so checking the PM use count should be fine. I'll modify the patch, test it
>> and resubmit.
>
> I gave it an unfortunately unsuccessful try. The problem I ran into is that
> device_prepare() calls pm_runtime_get_noresume() calls
> pm_runtime_get_noresume(), with the corresponding pm_runtime_put() call being
> performed in device_complete(). The device power usage_count is thus always
> non-zero in the system resume handler, so I can't base the decision on that.

As Alan said, let's just check against 1 instead.

>
> I also noticed that pm_genpd_prepare() runtime-resumes the device (when the
> power domain is in the GPD_STATE_ACTIVE state). I don't know why that is, but
> it means that in practice my device gets runtime-resumed when suspending the
> system while it could stay runtime-suspended in practice.

I am aware of this and it's on my TODO list of improvements of genpd,
The issue is related to an unoptimized behaviour for how genpd deal
with wakeups during system PM.

Kind regards
Uffe
