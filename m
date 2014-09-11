From: Maciej Matraszek <m.matraszek@samsung.com>
Subject: Re: [PATCH] PM / Domains: add debugfs listing of struct
 generic_pm_domain-s
Date: Thu, 11 Sep 2014 19:02:58 +0200
Message-ID: <1410454978.8852.18.camel@AMDC723>
References: <1410348536-15201-1-git-send-email-m.matraszek@samsung.com>
 <20140910144340.GA17967@kroah.com> <1410363493.15593.26.camel@AMDC723>
 <20140910182712.GE14642@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:11379 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044AbaIKRDF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Sep 2014 13:03:05 -0400
In-reply-to: <20140910182712.GE14642@kroah.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Wed, 2014-09-10 at 11:27 -0700, Greg Kroah-Hartman wrote:
> > > 
> > > > +	if (!d)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +late_initcall(pm_genpd_debug_init);
> > > > +#endif /* CONFIG_PM_ADVANCED_DEBUG */
> > > 
> > > No tear-down of the debugfs files on shutdown?
> > 
> > In drivers/clk/clk.c, there is no tear-down of debugfs files paired
> > with clk_debug_init(), same with wakeup_sources_debugfs_init() from
> > drivers/base/power/wakeup.c. On the other hand, some subsystems
> > perform it. What would you prefer?
> 
> In my quest for symmetry I prefer to see files you add to be removed at
> the proper time. :)

And they will be! (in v2 :)


Thanks,
-- 
Maciej Matraszek
Samsung R&D Institute Poland
Samsung Electronics


