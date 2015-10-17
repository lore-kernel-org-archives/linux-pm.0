From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v3] PM: check for complete cb before device lock in
 dpm_complete
Date: Sat, 17 Oct 2015 11:04:26 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1510171059250.10498-100000@netrider.rowland.org>
References: <20151016230603.GA12639@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:56901 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752043AbbJQPE1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 17 Oct 2015 11:04:27 -0400
In-Reply-To: <20151016230603.GA12639@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Todd E Brandt <todd.e.brandt@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, todd.e.brandt@intel.com

On Fri, 16 Oct 2015, Todd E Brandt wrote:

> On Sat, Oct 17, 2015 at 12:49:04AM +0200, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > On Sat, Oct 17, 2015 at 12:45 AM, Todd Brandt
> > <todd.e.brandt@linux.intel.com> wrote:
> > > If a device has no pm_ops complete callback it shouldn't have
> > > to be locked in order to skip it in the dpm_complete call. This causes
> > > problems when a device without a complete callback has already begun
> > > operation after its resume cb is called. It can end up holding up the
> > > system resume as the pm subsystem tries to get a device lock just to
> > > check for a callback that isn't there.
> > >
> > > This is basically the original v1 patch but updated for the latest kernel.
> > >
> > > Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>
> > > ---
> > >  drivers/base/power/main.c | 12 ++++++------
> > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > > index 1710c26..9bb8ff0 100644
> > > --- a/drivers/base/power/main.c
> > > +++ b/drivers/base/power/main.c
> > > @@ -899,8 +899,6 @@ static void device_complete(struct device *dev, pm_message_t state)
> > >         if (dev->power.syscore)
> > >                 return;
> > >
> > > -       device_lock(dev);
> > > -
> > >         if (dev->pm_domain) {
> > >                 info = "completing power domain ";
> > >                 callback = dev->pm_domain->ops.complete;
> > > @@ -920,13 +918,15 @@ static void device_complete(struct device *dev, pm_message_t state)
> > >                 callback = dev->driver->pm->complete;
> > >         }
> > >
> > > -       if (callback) {
> > > -               pm_dev_dbg(dev, state, info);
> > > -               callback(dev);
> > > -       }
> > > +       if (!callback)
> > > +               goto Complete;
> > >
> > 
> > Suppose that the devices is unregistered at this point and callback
> > was pointing to the driver callback.
> > 
> > > +       device_lock(dev);
> > > +       pm_dev_dbg(dev, state, info);
> > > +       callback(dev);
> > 
> > I don't think it is correct to execute that callback here in that case, is it?
> 
> Ahh, so we *should* be worried about an unregister in between the check and the call.
> I seem to remember a discussion where this was deemed a non-issue but I must have
> misheard (it was a while back).
> 
> It sounds to me then that there's just no way to do this safely :(. I'll experiment 
> with the i8042 driver to see if theres a way to fix this at a lower level. Thus far
> it's the only driver which has this issue.

Fixing it in the driver would be best.  (Why does the i8042 device stay
locked long enough to matter?  And doesn't the driver use async
suspend/resume anyway?)  Still, if you want to do it here safely, there
is a way:

	Compute the callback's address
	If it is not NULL:
		Lock the device
		Compute the callback's address again
		If it is not NULL:
			Invoke the callback
		Unlock the device

However, duplicating the computation likek this would be a waste for
almost all devices.  So unless there's a real need to do this, we
should avoid it.

Alan Stern

