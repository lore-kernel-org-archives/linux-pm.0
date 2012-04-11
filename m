From: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Wed, 11 Apr 2012 17:19:25 -0400
Message-ID: <1334179165.23924.311.camel@gandalf.stny.rr.com>
References: <Pine.LNX.4.44L0.1204111703180.1351-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1204111703180.1351-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>, jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2012-04-11 at 17:13 -0400, Alan Stern wrote:
> On Wed, 11 Apr 2012, Steven Rostedt wrote:
> 
> > On Wed, 2012-04-11 at 15:12 -0400, Alan Stern wrote:
> > 
> > > If so, setting the value back to 0 before suspending (or never setting 
> > > it to 1 in the first place) might be important.  You can test this 
> > > easily enough.  In drivers/usb/host/ehci-pci.c:ehci_pci_suspend(), add 
> > > a line saying
> > > 
> > > 	ehci_writel(ehci, 0, &ehci->regs->configured_flag);
> > > 
> > > just before the spin_lock_irqrestore.  This will invalidate the
> > > driver's criterion for determining whether or not the controller's
> > > state got messed up during the suspend; we can worry about that later.
> > 
> > I just tried the above, and it made no difference. Note, I don't even
> > get to suspend. It locks up in suspend, so I haven't even tried a resume
> > yet.
> 
> What do you mean, you don't get to suspend?  Is that a typo?

I mean, as I hit suspend, the screen goes blank, but the backlight stays
on, and the system just hangs there. It never gets to the point where
the machine is in "suspend" mode. I have to press and hold the power
button to force a shutdown.

> 
> If the system locks up during the suspend procedure, it must do so
> after this code runs.  I know that because it runs during the "devices"  
> phase of suspending, and you said that "echo devices
> >/sys/power/pm_test" works.
> 
> > > You can try getting rid of the call to pci_prepare_to_sleep in 
> > > drivers/usb/core/hcd-pci.c:hcd_pci_suspend_noirq.  This will prevent 
> > > the controller from being put into D3hot and might interfere with 
> > > wakeup detection.
> > > 
> > 
> > What do I do with the retval? -EIO, 0, or other?
> 
> 0 or -EIO, either one.

I set it to 0 and it worked! (was able to suspend and resume)

> 
> 
> On Thu, 12 Apr 2012, Andrey Rahmatullin wrote:
> 
> > I replaced the hcd_pci_suspend_noirq call with retval=0 and suspend/resume
> > was successful.
>  
> This indicates that your computer doesn't like to suspend while the
> EHCI controllers are in D3hot.  I have no idea why not.
> 
> If you want a really thorough test, try changing 
> drivers/pci/pci-driver.c:pci_pm_suspend_noirq.  In the "if (!pm)" 
> clause, add a call to
> 
> 	pci_prepare_to_sleep(pci_dev);
> 
> just after the pci_save_state line.  Then try suspending with the 
> script enabled (ehci-hcd unbound from the controllers).  If this fails 
> then we'll know it is the source of the trouble.

I have to go for a few hours, but I can try this when I get back. Even
if Andrey does it first. I'll verify it it too.

Thanks Alan and Andrey!

-- Steve


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
