From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM / USB: hcd_pci: Skip secondary root hub check for
 HCD_DEAD()
Date: Tue, 25 Jul 2017 17:06:40 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1707251705060.1605-100000@iolanthe.rowland.org>
References: <1934081.cLRahvktBu@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1934081.cLRahvktBu@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux USB <linux-usb@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mathias Nyman <mathias.nyman@linux.intel.com>, Felipe Balbi <balbi@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 25 Jul 2017, Rafael J. Wysocki wrote:

> On Tuesday, July 25, 2017 05:59:04 PM Rafael J. Wysocki wrote:
> > On Tuesday, July 25, 2017 10:05:03 AM Alan Stern wrote:
> > > On Tue, 25 Jul 2017, Rafael J. Wysocki wrote:
> > > 
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > 
> > > > If HCD_DEAD(hcd) is "true" in check_root_hub_suspended(), it is
> > > > rather pointless to check the secondary root hub, so return early
> > > > then.
> > > > 
> > > > This actually fixes occasional suspend failures on one of my test
> > > > machines.
> > > > 
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > > >  drivers/usb/core/hcd-pci.c |    3 +++
> > > >  1 file changed, 3 insertions(+)
> > > > 
> > > > Index: linux-pm/drivers/usb/core/hcd-pci.c
> > > > ===================================================================
> > > > --- linux-pm.orig/drivers/usb/core/hcd-pci.c
> > > > +++ linux-pm/drivers/usb/core/hcd-pci.c
> > > > @@ -427,6 +427,9 @@ static int check_root_hub_suspended(stru
> > > >  		dev_warn(dev, "Root hub is not suspended\n");
> > > >  		return -EBUSY;
> > > >  	}
> > > > +	if (HCD_DEAD(hcd))
> > > > +		return 0;
> > > > +
> > > >  	if (hcd->shared_hcd) {
> > > >  		hcd = hcd->shared_hcd;
> > > >  		if (HCD_RH_RUNNING(hcd)) {
> > > 
> > > While this is an okay solution, IMO it would be more reliable and more 
> > > general to have usb_hc_died() clear the HCD_FLAG_RH_RUNNING bit and set 
> > > the HCD_FLAG_DEAD bit in the shared hcd.  Right now it only does these 
> > > things for the primary.
> > > 
> > > Would you like to write and test a patch to do that?
> > 
> > I can do that.
> 
> Just to make sure that we are on the same page, is the below what you mean?
> 
> ---
>  drivers/usb/core/hcd.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> Index: linux-pm/drivers/usb/core/hcd.c
> ===================================================================
> --- linux-pm.orig/drivers/usb/core/hcd.c
> +++ linux-pm/drivers/usb/core/hcd.c
> @@ -2485,6 +2485,8 @@ void usb_hc_died (struct usb_hcd *hcd)
>  	}
>  	if (usb_hcd_is_primary_hcd(hcd) && hcd->shared_hcd) {
>  		hcd = hcd->shared_hcd;
> +		clear_bit(HCD_FLAG_RH_RUNNING, &hcd->flags);
> +		set_bit(HCD_FLAG_DEAD, &hcd->flags);
>  		if (hcd->rh_registered) {
>  			clear_bit(HCD_FLAG_POLL_RH, &hcd->flags);

Yes, exactly.  Does it fix your suspend problem?

Alan Stern
