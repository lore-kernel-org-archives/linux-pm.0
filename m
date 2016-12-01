From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V6 06/10] PM / OPP: Add infrastructure to manage multiple
 regulators
Date: Thu, 1 Dec 2016 16:29:29 +0530
Message-ID: <20161201105929.GC7682@vireshk-i7>
References: <cover.1480481312.git.viresh.kumar@linaro.org>
 <3b3ce1dac198fb668b97e81490bcbcf03d31e40d.1480481312.git.viresh.kumar@linaro.org>
 <20161130223712.GM6095@codeaurora.org>
 <20161201005149.GQ3288@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161201005149.GQ3288@vireshk-i7>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, d-gerlach-l0cyMroinI0@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 01-12-16, 06:21, Viresh Kumar wrote:
> On 30-11-16, 14:37, Stephen Boyd wrote:
> > > +static bool opp_debug_create_supplies(struct dev_pm_opp *opp,
> > > +				      struct opp_table *opp_table,
> > > +				      struct dentry *pdentry)
> > > +{
> > > +	struct dentry *d;
> > > +	int i = 0;
> > > +	char *name;
> > > +
> > > +	/* Always create at least supply-0 directory */
> > > +	do {
> > > +		name = kasprintf(GFP_KERNEL, "supply-%d", i);
> > 
> > Sorry I haven't noticed this before. Wouldn't we want to put the
> > supply name here instead of a number?
> 
> The OPP core provides a way for platforms to use the set-OPP
> functionality, but that is not compulsory for its user. Which makes it
> very much possible that the OPP core wouldn't know the names of the
> supplies at all. And so I used the numbers here. Anyway, the numbers
> matches the order in which they are passed from DT, so that should be
> readable.
> 
> Here is the new rebased version of the patch. I will send the complete
> series again later on. Please see if it looks fine.
> 
> -------------------------8<-------------------------
> 
> From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Date: Tue, 4 Oct 2016 17:07:28 +0530
> Subject: [PATCH] PM / OPP: Add infrastructure to manage multiple regulators
> 
> This patch adds infrastructure to manage multiple regulators and updates
> the only user (cpufreq-dt) of dev_pm_opp_set{put}_regulator().
> 
> This is preparatory work for adding full support for devices with
> multiple regulators.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Tested-by: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>

Ignore this one now. I have resent the series again after resolving
all the pending issues. Please review that.

Thanks.

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
