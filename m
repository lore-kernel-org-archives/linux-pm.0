From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC] usb: Add support for runtime power
	management	of the hcd
Date: Thu, 13 Aug 2009 13:30:34 +0100
Message-ID: <20090813123034.GA25770__28735.9936432496$1250166704$gmane$org@srcf.ucam.org>
References: <200908081625.57333.rjw@sisk.pl>
	<20090813002925.GA2532@srcf.ucam.org>
	<20090813003544.GB2532@srcf.ucam.org>
	<200908131416.42189.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200908131416.42189.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Greg KH <gregkh@suse.de>, linux-pci@vger.kernel.org, linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 13, 2009 at 02:16:41PM +0200, Oliver Neukum wrote:
> Am Donnerstag, 13. August 2009 02:35:44 schrieb Matthew Garrett:
> 
> > The power savings from this are measurable but not huge - it still seems
> 
> How large?

About 0.2W on an ich9 system.

> > like a decent optimisation. The main problem is that BIOS bugs on some
> > Dell laptops will kill USB if this is used, so we either default to off
> > or add some quirks to handle that case (I have some ideas in that
> > respect).
> 
> Your earlier failures don't look promising regarding BIOSes.
> What do you have in mind?

They range from pragmatic to ugly. We could blacklist all Dells, though 
I'm trying to find out if there's a BIOS date that guarantees the system 
is fixed. Alternatively, it's a single-line bug in the DSDT - we could 
implement some kind of fixup in the ACPI parsing code. I find the latter 
interesting but possibly too hideous to live :)

> > @@ -1968,6 +1972,9 @@ struct usb_hcd *usb_create_hcd (const struct
> > hc_driver *driver, INIT_WORK(&hcd->wakeup_work, hcd_resume_work);
> >  #endif
> >
> > +	pm_runtime_enable(dev);
> 
> So you don't get a reference from that?

No, but...

> > +	pm_runtime_get(dev);
> 
> What happens if you get a runtime suspend request in between? Is this a flaw
> of the API?

I suspect that just swapping the order of those two lines would be fine.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
