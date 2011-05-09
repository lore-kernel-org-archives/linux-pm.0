From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3/5] PM: Support for system-wide power
	transitions in generic power domains
Date: Mon, 9 May 2011 21:20:41 +0200
Message-ID: <201105092120.42005.rjw__40257.6285334819$1304968918$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1105091032190.2002-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1105091032190.2002-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-sh@vger.kernel.org, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: linux-pm@vger.kernel.org

On Monday, May 09, 2011, Alan Stern wrote:
> On Sun, 8 May 2011, Rafael J. Wysocki wrote:
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Make generic power domains support system-wide power transitions
> > (system suspend and hibernation).  Add suspend, resume, freeze and
> > thaw callbacks to be associated with struct generic_power_domain
> > objects and make pm_genpd_init() use them as appropriate.
> 
> ...
> 
> > Index: linux-2.6/drivers/base/power/domain.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/base/power/domain.c
> > +++ linux-2.6/drivers/base/power/domain.c
> > @@ -273,6 +273,280 @@ static int pm_genpd_runtime_resume(struc
> >  
> >  #endif /* CONFIG_PM_RUNTIME */
> >  
> > +#ifdef CONFIG_PM_SLEEP
> > +
> > +/**
> > + * pm_genpd_powered_down - Check if power has been removed from a power domain.
> > + * @genpd: Power domain to check.
> > + */
> > +static bool pm_genpd_powered_down(struct generic_power_domain *genpd)
> > +{
> > +	bool ret;
> > +
> > +	mutex_lock(&genpd->lock);
> > +	ret = genpd->power_is_off;
> > +	mutex_unlock(&genpd->lock);
> > +
> > +	return ret;
> > +}
> 
> What is the purpose of the mutex?  On the face of it, there's nothing 
> to prevent another thread from changing the domain's power state in 
> between the mutex_unlock() call and the return statement.

Now, that I think of it, the mutex isn't really necessary.

genpd->power_is_off is only changed by the runtime PM code that will
never be called during system suspend if genpd->power_is_off is set
already.

I'm going to post an update shortly, I'll include a fix for that in it.

Thanks,
Rafael
