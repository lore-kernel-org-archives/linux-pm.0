From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] PM / Runtime: Only force-resume device if it has been force-suspended
Date: Sun, 06 Mar 2016 17:38:43 +0200
Message-ID: <2096023.P4Pq9IvUAO@avalon>
References: <Pine.LNX.4.44L0.1603041021200.1885-100000@iolanthe.rowland.org> <1481433.r0tFS4sTcH@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1481433.r0tFS4sTcH@avalon>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, linux-renesas-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello,

On Friday 04 March 2016 23:04:46 Laurent Pinchart wrote:
> On Friday 04 March 2016 10:24:10 Alan Stern wrote:
> > On Fri, 4 Mar 2016, Ulf Hansson wrote:
> >> On 3 March 2016 at 21:16, Laurent Pinchart wrote:
> >>> The pm_runtime_force_suspend() and pm_runtime_force_resume() helpers
> >>> are designed to help driver being RPM-centric by offering an easy way to
> >>> manager runtime PM state during system suspend and resume. The first
> >>> function will force the device into runtime suspend at system suspend
> >>> time, while the second one will perform the reverse operation at system
> >>> resume time.
> >>> 
> >>> However, the pm_runtime_force_resume() really forces resume, regarding
> >>> of whether the device was running or already suspended before the call
> >>> to pm_runtime_force_suspend(). This results in devices being runtime
> >>> resumed at system resume time when they shouldn't.
> >>> 
> >>> Fix this by recording whether the device has been forcefully suspended
> >>> in pm_runtime_force_suspend() and condition resume in
> >>> pm_runtime_force_resume() to that state.
> >>> 
> >>> All current users of pm_runtime_force_resume() call the function
> >>> uncontionally in their system resume handler (some actually set it as
> >>> the resume handler), all after calling pm_runtime_force_suspend() at
> >>> system suspend time. The change in behaviour should thus be safe.
> >>> 
> >>> Signed-off-by: Laurent Pinchart
> >>> <laurent.pinchart+renesas@ideasonboard.com>
> >>> 
> >>> @@ -1475,6 +1476,7 @@ int pm_runtime_force_suspend(struct device *dev)
> >>>                 goto err;
> >>>         
> >>>         pm_runtime_set_suspended(dev);
> >>> +       dev->power.is_force_suspended = true;
> >>>         return 0;
> >>>  err:
> >>>         pm_runtime_enable(dev);
> >>> @@ -1510,6 +1515,7 @@ int pm_runtime_force_resume(struct device *dev)
> >>>         if (ret)
> >>>                 goto out;
> >>> 
> >>> +       dev->power.is_force_suspended = false;
> >>>         pm_runtime_set_active(dev);
> >>>         pm_runtime_mark_last_busy(dev);
> >>>  out:
> >
> > Setting a bitflag is not SMP-safe.  When you write to one of the
> > runtime-PM bits under dev->power, it is necessary to hold
> > dev->power.lock.
> > 
> >> Overall I have no objections to this change, as I think it's improving
> >> the behaviour!
> >> 
> >> What I was thinking though, but it might be a bit controversial. :-)...
> >> Instead of relying on whether we actually forced runtime suspend
> >> earlier, why couldn't we instead check the runtime PM usage count of
> >> the device?
> >> 
> >> Only when it's greater than zero, we shall do the forced resume of the
> >> device, otherwise just re-enable runtime PM.
> >> 
> >> This would have the affect of leaving devices in runtime suspend,
> >> until they really needs to be used again. It would thus decrease the
> >> total system PM resume time.
> >> 
> >> Do you think this could work?
> > 
> > If you do this then there would be no need for is_force_suspended.  It
> > seems like a good idea to me.
> 
> I agree, that's a better idea. Drivers shouldn't call
> pm_runtime_force_resume() if they haven't called pm_runtime_force_suspend(),
> so checking the PM use count should be fine. I'll modify the patch, test it
> and resubmit.

I gave it an unfortunately unsuccessful try. The problem I ran into is that 
device_prepare() calls pm_runtime_get_noresume() calls 
pm_runtime_get_noresume(), with the corresponding pm_runtime_put() call being 
performed in device_complete(). The device power usage_count is thus always 
non-zero in the system resume handler, so I can't base the decision on that.

I also noticed that pm_genpd_prepare() runtime-resumes the device (when the 
power domain is in the GPD_STATE_ACTIVE state). I don't know why that is, but 
it means that in practice my device gets runtime-resumed when suspending the 
system while it could stay runtime-suspended in practice.

-- 
Regards,

Laurent Pinchart
