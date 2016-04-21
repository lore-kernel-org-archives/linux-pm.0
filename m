From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] PM / Runtime: Only force-resume device if it has been force-suspended
Date: Thu, 21 Apr 2016 18:11:08 +0300
Message-ID: <17609720.HzoTaUK4Y8@avalon>
References: <Pine.LNX.4.44L0.1603041021200.1885-100000@iolanthe.rowland.org> <8167646.6La0EzZQBr@avalon> <CAPDyKFp1B35pndFJ=HkPTyyG6j+MGc5yQBAnq-SjKF5ggLOf-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from galahad.ideasonboard.com ([185.26.127.97]:34122 "EHLO
	galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692AbcDUPKy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Apr 2016 11:10:54 -0400
In-Reply-To: <CAPDyKFp1B35pndFJ=HkPTyyG6j+MGc5yQBAnq-SjKF5ggLOf-Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, linux-renesas-soc@vger.kernel.org

Hi Ulf,

On Thursday 21 Apr 2016 15:52:06 Ulf Hansson wrote:
> On 21 April 2016 at 14:41, Laurent Pinchart wrote:
> > On Thursday 21 Apr 2016 11:10:19 Ulf Hansson wrote:
> >> On 21 April 2016 at 01:30, Laurent Pinchart wrote:
> >>> On Monday 07 Mar 2016 11:10:08 Ulf Hansson wrote:
> >>>> [...]
> >>>> 
> >>>>>> I agree, that's a better idea. Drivers shouldn't call
> >>>>>> pm_runtime_force_resume() if they haven't called
> >>>>>> pm_runtime_force_suspend(), so checking the PM use count should be
> >>>>>> fine. I'll modify the patch, test it and resubmit.
> >>>>> 
> >>>>> I gave it an unfortunately unsuccessful try. The problem I ran into
> >>>>> is that device_prepare() calls pm_runtime_get_noresume() calls
> >>>>> pm_runtime_get_noresume(), with the corresponding pm_runtime_put()
> >>>>> call being performed in device_complete(). The device power
> >>>>> usage_count is thus always non-zero in the system resume handler, so
> >>>>> I can't base the decision on that.
> >>>> 
> >>>> As Alan said, let's just check against 1 instead.
> >>> 
> >>> I gave this a try, and unfortunately it won't work.
> >>> 
> >>> pm_genpd_prepare() resumes devices without increasing the usage count,
> >>> which
> >> 
> >> It doesn't resume them, it only increases the usage count.
> > 
> > Maybe there's something I don't get, but pm_genpd_prepare() ends with
> 
> I realize that I did read *pm_genpd_prepare()* as *device_prepare()*,
> which represents the behaviour of the PM core during the prepare phase
> (drivers/base/power/main.c). In such cases my earlier reply would make
> more sense, I believe.
> 
> Apologize for giving you the wrong input by not reading your response
> in more detail!

No worries, thanks for taking the time to reply now.

> >     /*
> >      * The PM domain must be in the GPD_STATE_ACTIVE state at this point,
> >      * so genpd_poweron() will return immediately, but if the device
> >      * is suspended (e.g. it's been stopped by genpd_stop_dev()), we need
> >      * to make it operational.
> >      */
> >     pm_runtime_resume(dev);
> >     __pm_runtime_disable(dev, false);
> >         
> >     ret = pm_generic_prepare(dev);
> >     if (ret) {
> >             ... /* irrelevant error handling */
> >     }
> >         
> >     pm_runtime_put(dev);
> >     return ret;
> > 
> > The device is thus resumed. Note that the pm_runtime_put() call will
> > decrease the usage count that was increased at the beginning of the
> > function (and thus makes pm_genpd_prepare() neutral from a usage count
> > point of view) but won't resume the device as the disable depth is
> > increased by __pm_runtime_disable().
> > 
> > As far as I understand, the device is thus effectively active when
> > entering the driver's system suspend handler, with a usage count equal to
> > 1 or more. pm_runtime_force_suspend(), which decides whether to suspend
> > the device based on the device pm state and not the usage count, will thus
> > always pm suspend the device.
> > 
> > Is the above analysis correct ?
> 
> Yes.
> 
> Although, genpd is not behaving as it should here. It must *not*
> resume all devices, just because the domain is powered.

We agree on that.

> > Now I'm a bit lost as to what happens (and what should happen) at resume
> > time. Does genpd and the PM core try to suspend the device after calling
> > the driver's resume handler (pm_runtime_force_resume() in this case)
> > under some conditions, or does the resume handler have the last word in
> > deciding the PM runtime status of the device after system resume ?
> 
> The resume callback of genpd decides what will happen, as its a PM
> domain and it sits on top of the hierarchy of a devices PM callbacks.
> 
> As you have realized, there are issues in genpd regarding the system
> PM code, there have even been reports about it.
> 
> For example, genpd prevents subsystem/drivers from manage their
> devices during system PM - when it start the system PM phase with the
> domain in powered off state.
> 
> That's not an okay behaviour, as it can't know whether a device needs
> to be used to serve a request after that point, causing the device to
> be runtime resumed. As genpd prevents it to be suspended via system
> PM, it will stay resumed during the system PM suspend phase, at least
> that is my understanding and it seems like bad idea.
> 
> In general, the system PM code in genpd needs to be modernized. It
> somewhat duplicating some code from the PM core and I think the code
> can be greatly simplified.
> 
> I have started to work on this quite recently, once the first steps
> are done I will consider optimizations, such as not runtime resuming
> devices unnecessarily.
> 
> >>> leads to the device always being active in pm_runtime_force_suspend().
> >>> The usage count will be 1 if the device was suspended prior to entering
> >>> system suspend (due to the pm_runtime_get_noresume() call in
> >>> device_prepare()) or higher than 1 if the device was active.
> >> 
> >> It's only greater than 1 - if someone else than the PM core has
> >> increased the usage count.
> > 
> > That I agree with.
> 
> Okay, great! :-)
> 
> [...]
> 
> Again, sorry for the giving the wrong input earlier!
> 
> Future wise, I will keep you on cc on any related genpd patches.

Yeah \o/ more patches in my inbox, thank you so much ;-)

-- 
Regards,

Laurent Pinchart

