From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Discrete Nvidia GPU shutdown with recent kernel / BIOS (on T440s
 laptop) - Should be automatic with runtime pm now ?
Date: Wed, 22 Jul 2015 21:21:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1507222116430.12068-100000@netrider.rowland.org>
References: <CAHL+j09=tc4ytFmzuhw5K_AvQ6aDsViREkwCY6re4A-iJTnTUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAHL+j09=tc4ytFmzuhw5K_AvQ6aDsViREkwCY6re4A-iJTnTUw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Sylvain Munaut <246tnt@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 22 Jul 2015, Sylvain Munaut wrote:

> Hi Alan,
> 
> 
> Thanks for the details.
> 
> 
> >> tl;dr : Should device allowed to do runtime pm that have no driver go
> >> to D3 on their own ?
> >
> > Quick answer: See the comments at the start of local_pci_probe() in
> > drivers/pci/pci-driver.c.  PCI devices without a kernel driver are
> > always left in D0, regardless of the runtime PM status.  This is
> > because userspace may try to use the device, and the kernel wouldn't
> > know to take the device out of D3 when that happens.
> 
> Does linux expose some way for userspace to transition the device to
> another power state without the need for a driver ?

I don't think so.  Of course, such a thing could be added.  One simple 
way to do it would be to create a "do-nothing" driver that would allow 
userspace to access the device directly and would include runtime PM 
suport.

> I looked at the docs and tried poking some of the sysfs files, but
> except enabling/disabling the runtme pm, I couldn't really change
> anything, but maybe I missed something.

You probably didn't miss anything.

> >>  And should pci root bridge go to D3 when all the
> >> device on them are on D3 ?
> >
> > I don't know the answer to that.  It's probably closely related to the
> > issue of whether PCI bridges need to have a kernel driver.
> 
> OK.
> 
> Do you know if there could be any adverse effect of transitioning it myself ?
> 
> Basically I'm doing this when turning off the card :
> 
> struct pci_dev *port_dev = pci_upstream_bridge(pdev);
> 
> pci_save_state(port_dev);
> pci_clear_master(port_dev);
> pci_disable_device(port_dev);
> pci_set_power_state(port_dev, PCI_D3hot);
> 
> 
> And this when waking it up :
> 
> pci_set_power_state(port_dev, PCI_D0);
> pci_restore_state(port_dev);
> pci_enable_device(port_dev);
> pci_set_master(port_dev);
> 
> (I removed the return value checking to make the code more concise here).

That seems reasonable.  But I am far from an expert on PCI or Linux's
PCI subsystem.  You really should address this sort of question to the
linux-pci mailing list.

Alan Stern

