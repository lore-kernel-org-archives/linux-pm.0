From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Runtime power management during system resume
Date: Thu, 26 Aug 2010 10:33:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1008261013390.1556-100000@iolanthe.rowland.org>
References: <BLU102-W283ED7848BB0495FBACF0BEB850@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BLU102-W283ED7848BB0495FBACF0BEB850@phx.gbl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Raj Kumar <rajkumar278@hotmail.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 26 Aug 2010, Raj Kumar wrote:

> Hi Alan,

You know, it would be a lot easier to reply to your emails if you
didn't put so many blank lines in them and you told your email client
to wrap lines after 72 columns or so.

> I have few more questions:
> 
>  
> 
> 1) If the platform device driver is using platform_bus_type as its bus type, in that case is the parent of device is its bus?

Maybe yes, maybe no.

> 
>  
> 
> 2) Because I saw the code in platform_device_register, when any platform device is register, its parent is set to
> 
> platform bus?
> 
> right?

No.  Look at the code again:

> 
>  
> 
> int platform_device_add(struct platform_device *pdev)
> {
> 
> ----------------------------------------
> 
> if (!pdev->dev.parent)
>                 pdev->dev.parent = &platform_bus;
> 
> ------------------------------------------------------
> 
> }

The parent is set to platform_bus _only_ if the parent wasn't already
set.

> 
>  
> 
> So when the platform device wants to use parent other than platform bus, is it possible to set the parent
> 
> of platform device to any other device rather than platform_bus?

You're making that same mistake again.  The _device_ doesn't get to 
choose what the parent is; the _driver_ does.

Repeat after me:

		Driver != Device

You need to learn that.  If you can't remember the distinction between 
a device and a driver then you will never be able to write kernel code.

Getting back to your question: Of course it is possible.  The driver 
merely has to set pdev->dev.parent before calling 
platform_add_device().

> 
>  
> 
>  
> 
> 3) The 3rd question is regarding, in this function
> 
>  
> 
> int __pm_runtime_resume(struct device *dev, bool from_wq)
>         __releases(&dev->power.lock) __acquires(&dev->power.lock)
> {
> 
>  
> 
> -----------------------
>         if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_resume) {
>                 spin_unlock_irq(&dev->power.lock);
> 
>                 retval = dev->bus->pm->runtime_resume(dev);
> 
>                 spin_lock_irq(&dev->power.lock);
>                 dev->power.runtime_error = retval;
>         }
> 
>  
> 
> --------------------
> 
>  out:
>         if (parent) {
>                 spin_unlock_irq(&dev->power.lock);
> 
>                 pm_runtime_put(parent);
> 
>                 spin_lock_irq(&dev->power.lock);
>         }
> 
> }
> 
>  
> 
> When the device is resumed and its status is set to RPM_ACTIVE, Now the control comes to 
> 
> pm_runtime_put(parent) (suppose device is resumed correctly)
> 
>  
> 
> Now it decrements the power usage count and call idle for parent.

Be careful.  This calls pm_runtime_idle() for the parent, but
pm_runtime_idle() probably won't call the runtime_idle callback for the
parent.  You'll see why if you read __pm_runtime_idle();  
pm_children_suspended(parent) will return 0 unless
parent->power.ignore_children is set.

> 
>  
> 
> Why after resuming the device, It will try to schedule idle for its parent?
> 
>  
> 
> Since the device is resumed so its parent should be active.

Of course the parent is active.  That's why pm_runtime_idle() is
called; only active devices get idle callbacks.  The opposite of
"active" is "suspended" -- obviously we don't want to make idle
callbacks for suspended devices!

It is possible for an active device to have an idle or suspended
parent.  This can happen if the parent's power.ignore_children flag is
set.  For example, consider a situation where the device remains at 
full power but the link between it and the computer has been powered 
down.  The device is still active, but its parent (the link) is 
suspended.

Alan Stern

P.S.: You do not need to include copies of old emails at the bottom of 
your messages.  Please stop doing it.

> > ----------------------------------------
> > > Date: Tue, 24 Aug 2010 10:30:25 -0400
> > > From: stern@rowland.harvard.edu
> > > To: rajkumar278@hotmail.com
> > > CC: linux-kernel@vger.kernel.org
> > > Subject: Re: Runtime power management during system resume
> > >
> > > On Tue, 24 Aug 2010, Raj Kumar wrote:
> > >
> > >> Hi Alan,
> > >>
> > >> I have implemented the run time power management in my drivers. I have one
> > >> issue regarding System resume.
> > >>
> > >> When the system sleep is triggered as it is mentioned that Power management
> > >> core will increment the power_usage counter during prepare and decrements when complete
> > >> is called.
> > >>
> > >> Now I have few questions:
> > >>
> > >> 1) When the system resume is done, it does not increase the power_usage counter.
> > >> right?
> > >
> > > That's right.
> > >
> > >> So Does then the driver need to update the power_usage counter with run time power management
> > >> core and again set it to active means RPM_ACTIVE?
> > >
> > > Read section 6 of Documentation/power/runtime_pm.h. It explains this.
> > >
> > >> 2) Suppose device is active, means its power_usage counter is already one, Now during system
> > >> sleep, does the driver first suspend it with run time power management core and then continue
> > >> System suspend?
> > >
> > > No.
> > >
> > >> 3) Because I have seen the code of power management core and I did not see the that during
> > >> system suspend, run time power management status is updated means RPM_SUSPENDED.
> > >> right?
> > >
> > > I don't understand your question.
> > >
> > > Alan Stern
> > >
> 
>  		 	   		  
