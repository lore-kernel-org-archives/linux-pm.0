From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: ehci_hcd related S3 lockup on ASUS laptops, again
Date: Thu, 12 Apr 2012 13:06:18 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204121247430.1496-100000@iolanthe.rowland.org>
References: <1334248402.23924.337.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1334248402.23924.337.camel@gandalf.stny.rr.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Steven Rostedt <rostedt@goodmis.org>
Cc: jrnieder@gmail.com, Andrey Rahmatullin <wrar@wrar.name>, linux-pm@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>, Greg KH <greg@kroah.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 12 Apr 2012, Steven Rostedt wrote:

> On Thu, 2012-04-12 at 10:28 -0400, Alan Stern wrote:
> 
> > Hmmm.  This is a situation where the wakeup setting might matter.  Did 
> > the /sys/bus/pci/devices/0000:00:1[ad].0/power/wakeup files both 
> > contain "enabled" when you ran the test?
> 
> They're both enabled for me too.
> 
> > 
> > Here's a diagnostic patch that will give us a little more information.  
> > Keep the previous change (so that pci_prepare_to_sleep gets called 
> > whether ehci-hcd is bound or not) and let's see what it says.  Try 
> > doing it both with and without ehci-hcd bound.  Running this with "echo 
> > devices >/sys/power/pm_test" ought to be good enough.
> 
> Where do I read out the dev info?

It should appear in the dmesg log after the system returns from the 
suspend test.

> > Index: usb-3.4/drivers/pci/pci.c
> > ===================================================================
> > --- usb-3.4.orig/drivers/pci/pci.c
> > +++ usb-3.4/drivers/pci/pci.c
> > @@ -1720,6 +1720,9 @@ int pci_prepare_to_sleep(struct pci_dev
> >  
> >  	error = pci_set_power_state(dev, target_state);
> >  
> > +	dev_info(&dev->dev, "target %d wakeup %d error %d\n",
> > +			target_state, device_may_wakeup(&dev->dev), error);
> > +
> >  	if (error)
> >  		pci_enable_wake(dev, target_state, false);
> >  

Hmmm, looking at the PCI PM implementation more closely, it does seem a 
little strange.

Rafael, evidently pci_pm_suspend and pci_pm_suspend_noirq don't check
to see if the device is already runtime-suspended.  And if it is, 
there's no check to see if the wakeup settings need to be changed.

In addition, pci_pm_resume doesn't set the runtime status back to 
RPM_ACTIVE.

Is this stuff supposed to be handled at the device level?  It seems 
like the sort of thing that the subsystem code should take care of.

Maybe that's the problem here.  Steve and Andrey, does it make any 
difference to the behavior if you do

	echo on >/sys/bus/pci/devices/0000:00:1a.0/power/control

(and likewise for 1d.0) before starting the system suspend?

Alan Stern
