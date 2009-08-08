From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH update x2] PM: Introduce core framework for
	run-time PM of I/O devices (rev. 13)
Date: Sat, 8 Aug 2009 16:03:02 +0200
Message-ID: <200908081603.02713.rjw__47355.3507043563$1249740229$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0908071130440.3063-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0908071130440.3063-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday 07 August 2009, Alan Stern wrote:
> On Thu, 6 Aug 2009, Rafael J. Wysocki wrote:
> 
> > Hi,
> > 
> > The patch below should address all of your most recent comments.
> 
> Only two comments.
> 
> 
> > +static int __pm_request_idle(struct device *dev)
> > +{
> ...
> > +	if (dev->power.request_pending) {
> > +		/* Any requests other then RPM_REQ_IDLE take precedence. */
> > +		if (dev->power.request != RPM_REQ_NONE)
> 
> Replace != with ==.

Good catch, thanks!

> > +			dev->power.request = RPM_REQ_IDLE;
> > +		else if (dev->power.request != RPM_REQ_IDLE)
> > +			retval = -EAGAIN;
> > +		return retval;
> 
> 
> > --- linux-2.6.orig/drivers/base/dd.c
> > +++ linux-2.6/drivers/base/dd.c
> ...
> > @@ -306,6 +317,8 @@ static void __device_release_driver(stru
> >  
> >  	drv = dev->driver;
> >  	if (drv) {
> > +		pm_runtime_disable(dev);
> > +
> >  		driver_sysfs_remove(dev);
> >  
> >  		if (dev->bus)
> > @@ -324,6 +337,8 @@ static void __device_release_driver(stru
> >  			blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
> >  						     BUS_NOTIFY_UNBOUND_DRIVER,
> >  						     dev);
> > +
> > +		pm_runtime_enable(dev);
> >  	}
> >  }
> 
> We may need to be more careful here.  The driver's remove method may
> want to do some runtime PM stuff to the device before giving up
> control.  On the other hand I'm not sure what _should_ be done here, so
> I can't suggest anything better.

Hmm.  Perhaps we can do something along the lines of our .probe() handling.
Namely, call

pm_runtime_disable(dev);
pm_runtime_get_noresume(dev);
pm_runtime_enable(dev);

before and

pm_runtime_put_noidle()

after?  Then, if the driver's or bus type's .remove() needs to resume, it will
be able to do that right away and if it wants to suspend, it can always call
pm_runtime_put*(), because our pm_runtime_put_noidle() won't decrease the
usage counter below zero.

At the same time we can avoid "leftover" suspends that could interfere with
.remove() in case it needs to access the hardware.

Best,
Rafael
