From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2] PCI / PM: Avoid using device_may_wakeup() for runtime
 PM
Date: Fri, 30 Jun 2017 11:44:57 +0300
Message-ID: <20170630084457.GS629@lahna.fi.intel.com>
References: <Pine.LNX.4.44L0.1706191415180.1715-100000@iolanthe.rowland.org>
 <2883450.A8OIi7Gmb8@aspire.rjw.lan>
 <2677722.OnHOCzR3UZ@aspire.rjw.lan>
 <2254362.EY9ByagAJb@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2254362.EY9ByagAJb-yvgW3jdyMHm1GS7QM15AGw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Kai-Heng Feng <kai.heng.feng-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 30, 2017 at 12:37:00AM +0200, Rafael J. Wysocki wrote:
> On Friday, June 23, 2017 02:58:11 PM Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > 
> > pci_target_state() calls device_may_wakeup() which checks whether
> > or not the device may wake up the system from sleep states, but
> > pci_target_state() is used for runtime PM too.
> > 
> > Since runtime PM is expected to always enable remote wakeup if
> > possible, modify pci_target_state() to take additional argument
> > indicating whether or not it should look for a state from which
> > the device can signal wakeup and pass either the return value
> > of device_can_wakeup(), or "false" (if the device itself is not
> > wakeup-capable) to it from the code related to runtime PM.
> > 
> > While at it, fix the comment in pci_dev_run_wake() which is not
> > about sleep states.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > ---
> > 
> > -> v2:
> > 
> > Passing "true" as the second argument to pci_target_state() for runtime PM
> > might trigger suboptimal state choices to be made, so pass the return value
> > of device_can_wakeup() to it instead and pass "false" to it in pci_dev_run_wake(),
> > because that assumes device_can_wakeup() to return "false" already.
> 
> This was sent a week ago without any response so far.
> 
> Any concerns?

No concerns from me.

Reviewed-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
