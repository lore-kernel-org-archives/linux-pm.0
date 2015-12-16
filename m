From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / runtime: Add new helper for conditional usage count incrementation
Date: Wed, 16 Dec 2015 04:11:28 +0100
Message-ID: <2059159.DKa1ZpCTbg@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1512151001170.1891-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58628 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933917AbbLPClT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Dec 2015 21:41:19 -0500
In-Reply-To: <Pine.LNX.4.44L0.1512151001170.1891-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Chris Wilson <chris@chris-wilson.co.uk>, Imre Deak <imre.deak@intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Intel graphics driver community testing & development <intel-gfx@lists.freedesktop.org>, linux-pm@vger.kernel.org

On Tuesday, December 15, 2015 10:06:33 AM Alan Stern wrote:
> On Mon, 14 Dec 2015, Rafael J. Wysocki wrote:
> 
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Introduce a new runtime PM function, pm_runtime_get_if_in_use(),
> > that will increment the device's runtime PM usage counter and
> > return 'true' if its status is RPM_ACTIVE and its usage counter
> > is greater than 0 at the same time ('false' will be returned
> > otherwise).
> > 
> > This is useful for things that should only be done if the device
> > is active (from the runtime PM perspective) and used by somebody
> > (as indicated by the usage counter) already and they are not worth
> > bothering otherwise.
> 
> 
> > --- linux-pm.orig/drivers/base/power/runtime.c
> > +++ linux-pm/drivers/base/power/runtime.c
> > @@ -966,6 +966,27 @@ int __pm_runtime_resume(struct device *d
> >  EXPORT_SYMBOL_GPL(__pm_runtime_resume);
> >  
> >  /**
> > + * pm_runtime_get_if_in_use - Conditionally bump up the device's usage counter.
> > + * @dev: Device to handle.
> > + *
> > + * Increment the device's runtime PM usage counter and return 'true' if its
> > + * runtime PM status is RPM_ACTIVE and its usage counter is already different
> > + * from zero at the same time.  Otherwise, return 'false'.
> 
> The phrasing of this comment is slightly ambiguous (it's not clear 
> whether the "if" clause applies to both the increment and the return 
> or just the return).  IMO it would be somewhat better to write:
> 
> 	If the runtime PM status is RPM_ACTIVE and the runtime PM usage
> 	counter is nonzero, increment the counter and return 'true'.
> 	Otherwise return false without changing the counter.

Yes, that sounds better, thanks!

I'll resend the patch with that modification.

Thanks,
Rafael

