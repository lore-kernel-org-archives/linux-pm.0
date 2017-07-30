From: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH] USB: hcd: Mark secondary HCD as dead if the primary one
 died
Date: Sun, 30 Jul 2017 07:13:46 -0700
Message-ID: <20170730141346.GA21969@kroah.com>
References: <Pine.LNX.4.44L0.1707261021380.1965-100000@iolanthe.rowland.org>
 <29451701.e6zKZOze4p@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <29451701.e6zKZOze4p-yvgW3jdyMHm1GS7QM15AGw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux USB <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mathias Nyman <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 26, 2017 at 07:07:51PM +0200, Rafael J. Wysocki wrote:
> On Wednesday, July 26, 2017 10:21:54 AM Alan Stern wrote:
> > On Tue, 25 Jul 2017, Rafael J. Wysocki wrote:
> > 
> > > From: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > > 
> > > Make usb_hc_died() clear the HCD_FLAG_RH_RUNNING flag for the shared
> > > HCD and set HCD_FLAG_DEAD for it, in analogy with what is done for
> > > the primary one.
> > > 
> > > Among other thigs, this prevents check_root_hub_suspended() from
> > > returning -EBUSY for dead HCDs which helps to work around system
> > > suspend issues in some situations.
> > > 
> > > This actually fixes occasional suspend failures on one of my test
> > > machines.
> > > 
> > > Suggested-by: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > > ---
> > >  drivers/usb/core/hcd.c |    2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > Index: linux-pm/drivers/usb/core/hcd.c
> > > ===================================================================
> > > --- linux-pm.orig/drivers/usb/core/hcd.c
> > > +++ linux-pm/drivers/usb/core/hcd.c
> > > @@ -2485,6 +2485,8 @@ void usb_hc_died (struct usb_hcd *hcd)
> > >  	}
> > >  	if (usb_hcd_is_primary_hcd(hcd) && hcd->shared_hcd) {
> > >  		hcd = hcd->shared_hcd;
> > > +		clear_bit(HCD_FLAG_RH_RUNNING, &hcd->flags);
> > > +		set_bit(HCD_FLAG_DEAD, &hcd->flags);
> > >  		if (hcd->rh_registered) {
> > >  			clear_bit(HCD_FLAG_POLL_RH, &hcd->flags);
> > 
> > Acked-by: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
> > 
> 
> Thanks!
> 
> I guess this should go in via USB, so Felipe & Greg, please apply or let me
> know if you prefer me to handle it.

I'll take it, thanks.

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
