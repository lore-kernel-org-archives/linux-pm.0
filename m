From: Maciej Matraszek <m.matraszek@samsung.com>
Subject: Re: [PATCH] PM / Domains: add debugfs listing of struct
 generic_pm_domain-s
Date: Wed, 10 Sep 2014 17:38:13 +0200
Message-ID: <1410363493.15593.26.camel@AMDC723>
References: <1410348536-15201-1-git-send-email-m.matraszek@samsung.com>
 <20140910144340.GA17967@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20140910144340.GA17967@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Greg,
thanks for your reply!

> > +static int __init pm_genpd_debug_init(void)
> > +{
> > +	struct dentry *d;
> > +
> > +	pm_genpd_debugfs_dir = debugfs_create_dir("pm_genpd", NULL);
> > +
> > +	/* No debugfs */
> > +	if (IS_ERR(pm_genpd_debugfs_dir))
> > +		return PTR_ERR(pm_genpd_debugfs_dir);
> 
> You shouldn't care at all, just do this check:
> 
> > +	if (!pm_genpd_debugfs_dir)
> > +		return -ENOMEM;
> 
> And all will be fine, because:
> 
> > +	d = debugfs_create_file("pm_genpd_summary", S_IRUGO,
> > +			pm_genpd_debugfs_dir, NULL, &pm_genpd_summary_fops);
> 
> That call will resolve away to nothing if debugfs is not enabled, and it
> doesn't make much sense to do anything with an "error" of no debugfs.

Great! I'll fix this bizarre double check.

> 
> > +	if (!d)
> > +		return -ENOMEM;
> > +
> > +	return 0;
> > +}
> > +late_initcall(pm_genpd_debug_init);
> > +#endif /* CONFIG_PM_ADVANCED_DEBUG */
> 
> No tear-down of the debugfs files on shutdown?

In drivers/clk/clk.c, there is no tear-down of debugfs files paired
with clk_debug_init(), same with wakeup_sources_debugfs_init() from
drivers/base/power/wakeup.c. On the other hand, some subsystems
perform it. What would you prefer?


> 
> thanks,
> 
> greg k-h

Thanks,
--
Maciej Matraszek
Samsung R&D Institute Poland
Samsung Electronics
