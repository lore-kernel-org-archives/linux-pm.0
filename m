From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Thu, 12 Apr 2012 10:28:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204121017460.1496-100000@iolanthe.rowland.org>
References: <1334193773.23924.316.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1334193773.23924.316.camel-f9ZlEuEWxVcI6MkJdU+c8EEOCMrvLtNR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
Cc: Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>, jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 11 Apr 2012, Steven Rostedt wrote:

> On Thu, 2012-04-12 at 04:09 +0600, Andrey Rahmatullin wrote:
> > On Wed, Apr 11, 2012 at 05:13:51PM -0400, Alan Stern wrote:
> > > > I replaced the hcd_pci_suspend_noirq call with retval=0 and suspend/resume
> > > > was successful.
> > >  
> > > This indicates that your computer doesn't like to suspend while the
> > > EHCI controllers are in D3hot.  I have no idea why not.
> > > 
> > > If you want a really thorough test, try changing 
> > > drivers/pci/pci-driver.c:pci_pm_suspend_noirq.  In the "if (!pm)" 
> > > clause, add a call to
> > > 
> > > 	pci_prepare_to_sleep(pci_dev);
> > > 
> > > just after the pci_save_state line.  Then try suspending with the 
> > > script enabled (ehci-hcd unbound from the controllers).  If this fails 
> > > then we'll know it is the source of the trouble.
> > Looks like it works even with this line added.
> > 
> 
> I reverted the retval change (that worked) and added this line. Put the
> script back and did a suspend. The suspend and resume worked without
> issue.

Hmmm.  This is a situation where the wakeup setting might matter.  Did 
the /sys/bus/pci/devices/0000:00:1[ad].0/power/wakeup files both 
contain "enabled" when you ran the test?

Here's a diagnostic patch that will give us a little more information.  
Keep the previous change (so that pci_prepare_to_sleep gets called 
whether ehci-hcd is bound or not) and let's see what it says.  Try 
doing it both with and without ehci-hcd bound.  Running this with "echo 
devices >/sys/power/pm_test" ought to be good enough.

Alan Stern



Index: usb-3.4/drivers/pci/pci.c
===================================================================
--- usb-3.4.orig/drivers/pci/pci.c
+++ usb-3.4/drivers/pci/pci.c
@@ -1720,6 +1720,9 @@ int pci_prepare_to_sleep(struct pci_dev
 
 	error = pci_set_power_state(dev, target_state);
 
+	dev_info(&dev->dev, "target %d wakeup %d error %d\n",
+			target_state, device_may_wakeup(&dev->dev), error);
+
 	if (error)
 		pci_enable_wake(dev, target_state, false);
 

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
