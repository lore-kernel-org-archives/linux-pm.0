From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] PM / Runtime: Only force-resume device if it has been force-suspended
Date: Thu, 21 Apr 2016 02:30:11 +0300
Message-ID: <1747840.aL2QAkXYBh@avalon>
References: <Pine.LNX.4.44L0.1603041021200.1885-100000@iolanthe.rowland.org> <2096023.P4Pq9IvUAO@avalon> <CAPDyKFqtrdw+MHh6tAz658=PQi+REGAEiNzNs_4aRzTTpOwP9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from galahad.ideasonboard.com ([185.26.127.97]:33481 "EHLO
	galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbcDTX37 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Apr 2016 19:29:59 -0400
In-Reply-To: <CAPDyKFqtrdw+MHh6tAz658=PQi+REGAEiNzNs_4aRzTTpOwP9Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, linux-renesas-soc@vger.kernel.org

Hello,

Reviving this old thread.

On Monday 07 Mar 2016 11:10:08 Ulf Hansson wrote:
> [...]
> 
> >> I agree, that's a better idea. Drivers shouldn't call
> >> pm_runtime_force_resume() if they haven't called
> >> pm_runtime_force_suspend(), so checking the PM use count should be fine.
> >> I'll modify the patch, test it and resubmit.
> > 
> > I gave it an unfortunately unsuccessful try. The problem I ran into is
> > that device_prepare() calls pm_runtime_get_noresume() calls
> > pm_runtime_get_noresume(), with the corresponding pm_runtime_put() call
> > being performed in device_complete(). The device power usage_count is
> > thus always non-zero in the system resume handler, so I can't base the
> > decision on that.
>
> As Alan said, let's just check against 1 instead.

I gave this a try, and unfortunately it won't work.

pm_genpd_prepare() resumes devices without increasing the usage count, which 
leads to the device always being active in pm_runtime_force_suspend(). The 
usage count will be 1 if the device was suspended prior to entering system 
suspend (due to the pm_runtime_get_noresume() call in device_prepare()) or 
higher than 1 if the device was active.

However, pm_genpd_prepare() will not resume the device if suspend_power_off is 
set. In that case the device will be suspended with a usage count of 1 in 
pm_runtime_force_suspend() or active with a usage count higher than 1.

We thus can't detect at resume time whether we have force-suspended the device 
using the usage count.

Unless someone has another clever idea I'll keep the power.is_force_suspended 
flag and protect it with power.lock.

> > I also noticed that pm_genpd_prepare() runtime-resumes the device (when
> > the power domain is in the GPD_STATE_ACTIVE state). I don't know why that
> > is, but it means that in practice my device gets runtime-resumed when
> > suspending the system while it could stay runtime-suspended in practice.
> 
> I am aware of this and it's on my TODO list of improvements of genpd,
> The issue is related to an unoptimized behaviour for how genpd deal
> with wakeups during system PM.

Looking forward to seeing patches :-)

-- 
Regards,

Laurent Pinchart

