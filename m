From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] PM / Domains: add debugfs listing of struct
 generic_pm_domain-s
Date: Wed, 10 Sep 2014 11:27:12 -0700
Message-ID: <20140910182712.GE14642@kroah.com>
References: <1410348536-15201-1-git-send-email-m.matraszek@samsung.com>
 <20140910144340.GA17967@kroah.com>
 <1410363493.15593.26.camel@AMDC723>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1410363493.15593.26.camel@AMDC723>
Sender: linux-kernel-owner@vger.kernel.org
To: Maciej Matraszek <m.matraszek@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 10, 2014 at 05:38:13PM +0200, Maciej Matraszek wrote:
> Hi Greg,
> thanks for your reply!
> 
> > > +static int __init pm_genpd_debug_init(void)
> > > +{
> > > +	struct dentry *d;
> > > +
> > > +	pm_genpd_debugfs_dir = debugfs_create_dir("pm_genpd", NULL);
> > > +
> > > +	/* No debugfs */
> > > +	if (IS_ERR(pm_genpd_debugfs_dir))
> > > +		return PTR_ERR(pm_genpd_debugfs_dir);
> > 
> > You shouldn't care at all, just do this check:
> > 
> > > +	if (!pm_genpd_debugfs_dir)
> > > +		return -ENOMEM;
> > 
> > And all will be fine, because:
> > 
> > > +	d = debugfs_create_file("pm_genpd_summary", S_IRUGO,
> > > +			pm_genpd_debugfs_dir, NULL, &pm_genpd_summary_fops);
> > 
> > That call will resolve away to nothing if debugfs is not enabled, and it
> > doesn't make much sense to do anything with an "error" of no debugfs.
> 
> Great! I'll fix this bizarre double check.
> 
> > 
> > > +	if (!d)
> > > +		return -ENOMEM;
> > > +
> > > +	return 0;
> > > +}
> > > +late_initcall(pm_genpd_debug_init);
> > > +#endif /* CONFIG_PM_ADVANCED_DEBUG */
> > 
> > No tear-down of the debugfs files on shutdown?
> 
> In drivers/clk/clk.c, there is no tear-down of debugfs files paired
> with clk_debug_init(), same with wakeup_sources_debugfs_init() from
> drivers/base/power/wakeup.c. On the other hand, some subsystems
> perform it. What would you prefer?

In my quest for symmetry I prefer to see files you add to be removed at
the proper time. :)

thanks,

greg k-h
