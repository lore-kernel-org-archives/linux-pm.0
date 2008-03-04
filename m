From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] PM: Make PM core handle device
	registrations concurrent with suspend/hibernation
Date: Tue, 4 Mar 2008 22:52:50 +0100
Message-ID: <200803042252.51440.rjw__23406.8231577568$1204667868$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0803041041270.4039-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0803041041270.4039-100000@iolanthe.rowland.org>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 4 of March 2008, Alan Stern wrote:
> On Tue, 4 Mar 2008, Rafael J. Wysocki wrote:
> 
> > Hi,
> > 
> > The appended patch is intended to fix the issue with the PM core that it allows
> > device registrations to complete successfully even if they run concurrently
> > with the suspending of their parents, which may lead to a wrong ordering of
> > devices on the dpm_active list and, as a result, to failures during suspend and
> > hibernation transitions.
> > 
> > Comments welcome.
> 
> > Index: linux-2.6/include/linux/pm.h
> > ===================================================================
> > --- linux-2.6.orig/include/linux/pm.h
> > +++ linux-2.6/include/linux/pm.h
> > @@ -186,6 +186,7 @@ struct dev_pm_info {
> >  #ifdef	CONFIG_PM_SLEEP
> >  	unsigned		should_wakeup:1;
> >  	struct list_head	entry;
> > +	bool			sleeping;	/* Owned by the PM core */
> >  #endif
> >  };
> 
> Drivers might want to use this field without having to add protective 
> "#ifdef CONFIG_PM_SLEEP" lines.

I guess you mean that driver writers may not want to make each piece of code
referring to this flag depend on CONFIG_PM_SLEEP.  Any driver that actually
writes to it will be buggy ...

> You can change it to a single-bit bitfield and place it adjacent to
> can_wakeup. 

Yeah, good catch.  I will.

> > -void device_pm_add(struct device *dev)
> > +int device_pm_add(struct device *dev)
> >  {
> > +	int error = 0;
> > +
> >  	pr_debug("PM: Adding info for %s:%s\n",
> >  		 dev->bus ? dev->bus->name : "No Bus",
> >  		 kobject_name(&dev->kobj));
> >  	mutex_lock(&dpm_list_mtx);
> > -	list_add_tail(&dev->power.entry, &dpm_active);
> > +	if (dev->parent && dev->parent->power.sleeping)
> > +		error = -EBUSY;
> 
> Add a stack dump?  When this isn't a race, it's the kind of bug we want
> to fix.

Yes, I'll do that.

> > +	else
> > +		list_add_tail(&dev->power.entry, &dpm_active);
> >  	mutex_unlock(&dpm_list_mtx);
> > +	return error;
> >  }
> 
> > @@ -426,6 +404,11 @@ static int dpm_suspend(pm_message_t stat
> >  		struct list_head *entry = dpm_active.prev;
> >  		struct device *dev = to_device(entry);
> >  
> > +		if (dev->parent && dev->parent->power.sleeping) {
> > +			error = -EAGAIN;
> > +			break;
> > +		}
> 
> It's not clear that we want to have this check.  It would cause
> problems if the device ordering got mixed up by device_move(), which is
> pretty much the only way it could be triggered.

Well, isn't it actually dangerous to suspend parents before their children?
What happens, for example, if putting the parent into D3 causes power to be
cut from the children and then we attempt to suspend them?

> If you do want to leave it in, add a stack dump (and perhaps make it 
> not return an error).  This would help force people to figure out safe 
> ways to use device_move().

Yes, I'll add a stack dump here.

In fact, I'm going to add WARN_ON(true) in both places.

> > +		dev->power.sleeping = true;;
> 
> Extra ';'.

Hah, thanks, will remove.

Rafael
