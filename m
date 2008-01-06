From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: Acquire device locks on suspend
Date: Sun, 6 Jan 2008 20:05:11 +0100
Message-ID: <200801062005.12097.rjw__5635.84681735865$1199646237$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0801061203510.7367-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0801061203510.7367-100000@netrider.rowland.org>
Content-Disposition: inline
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
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Sunday, 6 of January 2008, Alan Stern wrote:
> On Sun, 6 Jan 2008, Rafael J. Wysocki wrote:
> 
> > > If you can figure out a way to disable the warning in device_del() for 
> > > just the one device being unregistered by 
> > > device_pm_destroy_suspended(),
> > 
> > Something like this, perhaps:
> > 
> > @@ -905,6 +915,18 @@ void device_del(struct device * dev)
> >  	struct device * parent = dev->parent;
> >  	struct class_interface *class_intf;
> >  
> > +	if (down_trylock(&dev->sem)) {
> > +		if (pm_sleep_lock()) {
> > +			dev_warn(dev, "Illegal %s during suspend\n",
> > +				__FUNCTION__);
> > +			dump_stack();
> > +		} else {
> > +			pm_sleep_unlock();
> > +		}
> > +	} else {
> > +		up(&dev->sem);
> > +	}
> > +
> >  	if (parent)
> >  		klist_del(&dev->knode_parent);
> >  	if (MAJOR(dev->devt))
> 
> Bizarre, but it should work.

OK

Still, shouldn't we fail the removal of the device apart from giving the
warning?

> Be sure to include plenty of explanatory comments

I will.

I think that code can be moved to its own function in
drivers/base/power/main.c, btw.

> -- otherwise nobody will be able to figure it out!  :-) 

Well, I guess so. :-)

Thanks,
Rafael
