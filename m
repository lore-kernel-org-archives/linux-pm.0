From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / runtime: Fix handling of suppliers with disabled runtime PM
Date: Fri, 01 Dec 2017 15:29:44 +0100
Message-ID: <5094556.AJdJzoj6qp@aspire.rjw.lan>
References: <1532136.s6buYvDjaS@aspire.rjw.lan> <20171201141801.GA20189@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:53809 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751677AbdLAOaP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Dec 2017 09:30:15 -0500
In-Reply-To: <20171201141801.GA20189@wunner.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Friday, December 1, 2017 3:18:01 PM CET Lukas Wunner wrote:
> On Fri, Dec 01, 2017 at 02:58:34PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Prevent rpm_get_suppliers() from returning an error code if runtime
> > PM is disabled for one or more of the supplier devices it wants to
> > runtime-resume, so as to make runtime PM work for devices with links
> > to suppliers that don't use runtime PM (such links may be created
> > during device enumeration even before it is known whether or not
> > runtime PM will be enabled for the devices in question, for example).
> > 
> > Reported-by: Adrian Hunter <adrian.hunter@intel.com>
> > Fixes: 21d5c57b3726 (PM / runtime: Use device links)
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/base/power/runtime.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > Index: linux-pm/drivers/base/power/runtime.c
> > ===================================================================
> > --- linux-pm.orig/drivers/base/power/runtime.c
> > +++ linux-pm/drivers/base/power/runtime.c
> > @@ -276,7 +276,8 @@ static int rpm_get_suppliers(struct devi
> >  			continue;
> >  
> >  		retval = pm_runtime_get_sync(link->supplier);
> > -		if (retval < 0) {
> > +		/* Ignore suppliers with disabled runtime PM. */
> > +		if (retval < 0 && retval != -EACCES) {
> >  			pm_runtime_put_noidle(link->supplier);
> >  			return retval;
> >  		}
> > 
> 
> You could alternatively call pm_runtime_get_sync() under the condition
> link->supplier->power.disable_depth > 0 but then the usage_count wouldn't
> be incremented and I guess we want that in case runtime PM is only
> temporarily disabled and later enabled, right?
> 
> I'm wondering if checking for that condition in lieu of retval != -EACCES
> would be more explicit and less fragile here (there's a theoretical
> possibility that the supplier's ->runtime_resume callback returns -EACCESS,
> leading to a false positive).

That will be filtered out by rpm_callback() which converts -EACCES to -EIO.

> 
> Apart from that,
> 
> Reviewed-by: Lukas Wunner <lukas@wunner.de>

Thanks,
Rafael
