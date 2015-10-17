From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH v9 4/4] USB / PM: Allow USB devices to remain runtime-suspended
 when sleeping
Date: Sat, 17 Oct 2015 11:12:57 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1510171107060.10498-100000@netrider.rowland.org>
References: <20151017063824.GB13889@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151017063824.GB13889-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, martyn.welch-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Fri, 16 Oct 2015, Greg Kroah-Hartman wrote:

> On Mon, Oct 05, 2015 at 04:45:32PM +0200, Tomeu Vizoso wrote:
> > Have dev_pm_ops.prepare return 1 for USB devices and ports so that USB
> > devices can remain runtime-suspended when the system goes to a sleep
> > state, if their wakeup state is correct and they have runtime PM enabled.
> > 
> > Signed-off-by: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
> > ---
> > 
> > 
> >  drivers/usb/core/port.c |  6 ++++++
> >  drivers/usb/core/usb.c  | 11 ++++++++++-
> >  2 files changed, 16 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
> > index 210618319f10..f49707d73b5a 100644
> > --- a/drivers/usb/core/port.c
> > +++ b/drivers/usb/core/port.c
> > @@ -168,12 +168,18 @@ static int usb_port_runtime_suspend(struct device *dev)
> >  
> >  	return retval;
> >  }
> > +
> > +static int usb_port_prepare(struct device *dev)
> > +{
> > +	return 1;
> > +}
> >  #endif
> >  
> >  static const struct dev_pm_ops usb_port_pm_ops = {
> >  #ifdef CONFIG_PM
> >  	.runtime_suspend =	usb_port_runtime_suspend,
> >  	.runtime_resume =	usb_port_runtime_resume,
> > +	.prepare =		usb_port_prepare,
> >  #endif
> >  };
> >  
> > diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
> > index 8d5b2f4113cd..cf4dde11db1c 100644
> > --- a/drivers/usb/core/usb.c
> > +++ b/drivers/usb/core/usb.c
> > @@ -316,7 +316,16 @@ static int usb_dev_uevent(struct device *dev, struct kobj_uevent_env *env)
> >  
> >  static int usb_dev_prepare(struct device *dev)
> >  {
> > -	return 0;		/* Implement eventually? */
> > +	struct usb_device *udev = to_usb_device(dev);
> > +
> > +	if (!pm_runtime_enabled(dev))
> > +		return 0;
> > +
> > +	/* Return 0 if the current wakeup setting is wrong, otherwise 1 */
> > +	if (udev->do_remote_wakeup != device_may_wakeup(dev))
> > +		return 0;
> > +
> > +	return 1;
> >  }
> >  
> >  static void usb_dev_complete(struct device *dev)
> 
> I'll defer to Alan if this is correct or not.
> 
> Alan?

It's okay with me.  However, I believe the pm_runtime_enabled() test 
isn't really needed.  USB devices are always enabled for runtime PM 
once they are initialized.  Furthermore, if the test really were needed 
then it should go in the PM core, not here.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
