From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM / Runtime: Only force-resume device if it has been
 force-suspended
Date: Sun, 6 Mar 2016 11:59:07 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1603061156590.26397-100000@netrider.rowland.org>
References: <2096023.P4Pq9IvUAO@avalon>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <2096023.P4Pq9IvUAO@avalon>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, linux-renesas-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sun, 6 Mar 2016, Laurent Pinchart wrote:

> > >> What I was thinking though, but it might be a bit controversial. :-)...
> > >> Instead of relying on whether we actually forced runtime suspend
> > >> earlier, why couldn't we instead check the runtime PM usage count of
> > >> the device?
> > >> 
> > >> Only when it's greater than zero, we shall do the forced resume of the
> > >> device, otherwise just re-enable runtime PM.
> > >> 
> > >> This would have the affect of leaving devices in runtime suspend,
> > >> until they really needs to be used again. It would thus decrease the
> > >> total system PM resume time.
> > >> 
> > >> Do you think this could work?
> > > 
> > > If you do this then there would be no need for is_force_suspended.  It
> > > seems like a good idea to me.
> > 
> > I agree, that's a better idea. Drivers shouldn't call
> > pm_runtime_force_resume() if they haven't called pm_runtime_force_suspend(),
> > so checking the PM use count should be fine. I'll modify the patch, test it
> > and resubmit.
> 
> I gave it an unfortunately unsuccessful try. The problem I ran into is that 
> device_prepare() calls pm_runtime_get_noresume() calls 
> pm_runtime_get_noresume(), with the corresponding pm_runtime_put() call being 
> performed in device_complete(). The device power usage_count is thus always 
> non-zero in the system resume handler, so I can't base the decision on that.

You could check for usage_count > 1 instead of > 0.  With a comment 
explaining why, of course.

Alan Stern

> I also noticed that pm_genpd_prepare() runtime-resumes the device (when the 
> power domain is in the GPD_STATE_ACTIVE state). I don't know why that is, but 
> it means that in practice my device gets runtime-resumed when suspending the 
> system while it could stay runtime-suspended in practice.
