From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM / Runtime: Only force-resume device if it has been
 force-suspended
Date: Fri, 4 Mar 2016 10:24:10 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1603041021200.1885-100000@iolanthe.rowland.org>
References: <CAPDyKFoGPcmYkt537FoQ+4zzFGfjeSK8aNSMfjL4dnoAS0J_rQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFoGPcmYkt537FoQ+4zzFGfjeSK8aNSMfjL4dnoAS0J_rQ@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, linux-renesas-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 4 Mar 2016, Ulf Hansson wrote:

> + Alan
> 
> On 3 March 2016 at 21:16, Laurent Pinchart
> <laurent.pinchart+renesas@ideasonboard.com> wrote:
> > The pm_runtime_force_suspend() and pm_runtime_force_resume() helpers are
> > designed to help driver being RPM-centric by offering an easy way to
> > manager runtime PM state during system suspend and resume. The first
> > function will force the device into runtime suspend at system suspend
> > time, while the second one will perform the reverse operation at system
> > resume time.
> >
> > However, the pm_runtime_force_resume() really forces resume, regarding
> > of whether the device was running or already suspended before the call
> > to pm_runtime_force_suspend(). This results in devices being runtime
> > resumed at system resume time when they shouldn't.
> >
> > Fix this by recording whether the device has been forcefully suspended
> > in pm_runtime_force_suspend() and condition resume in
> > pm_runtime_force_resume() to that state.
> >
> > All current users of pm_runtime_force_resume() call the function
> > uncontionally in their system resume handler (some actually set it as
> > the resume handler), all after calling pm_runtime_force_suspend() at
> > system suspend time. The change in behaviour should thus be safe.
> >
> > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>


> > @@ -1475,6 +1476,7 @@ int pm_runtime_force_suspend(struct device *dev)
> >                 goto err;
> >
> >         pm_runtime_set_suspended(dev);
> > +       dev->power.is_force_suspended = true;
> >         return 0;
> >  err:
> >         pm_runtime_enable(dev);

> > @@ -1510,6 +1515,7 @@ int pm_runtime_force_resume(struct device *dev)
> >         if (ret)
> >                 goto out;
> >
> > +       dev->power.is_force_suspended = false;
> >         pm_runtime_set_active(dev);
> >         pm_runtime_mark_last_busy(dev);
> >  out:

Setting a bitflag is not SMP-safe.  When you write to one of the
runtime-PM bits under dev->power, it is necessary to hold 
dev->power.lock.

> Overall I have no objections to this change, as I think it's improving
> the behaviour!
> 
> What I was thinking though, but it might be a bit controversial. :-)...
> Instead of relying on whether we actually forced runtime suspend
> earlier, why couldn't we instead check the runtime PM usage count of
> the device?
> 
> Only when it's greater than zero, we shall do the forced resume of the
> device, otherwise just re-enable runtime PM.
> 
> This would have the affect of leaving devices in runtime suspend,
> until they really needs to be used again. It would thus decrease the
> total system PM resume time.
> 
> Do you think this could work?

If you do this then there would be no need for is_force_suspended.  It 
seems like a good idea to me.

Alan Stern
