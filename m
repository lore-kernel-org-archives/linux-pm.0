From: Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] cpufreq: tegra20: remove superfluous CONFIG_PM ifdefs
Date: Wed, 09 Sep 2015 12:36:39 +0200
Message-ID: <1615370.p6S63xknIg@amdc1976>
References: <1441732403-7248-1-git-send-email-b.zolnierkie@samsung.com>
 <9512123.FfVbKErfZO@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <9512123.FfVbKErfZO-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


Hi,

On Wednesday, September 09, 2015 03:13:45 AM Rafael J. Wysocki wrote:
> On Tuesday, September 08, 2015 07:13:23 PM Bartlomiej Zolnierkiewicz wrote:
> > CONFIG_PM ifdefs are superfluous and can be removed.
> > 
> > Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
> > Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Cc: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> 
> What tree does this apply to?

It applies fine to both next (next-20150909 branch) and current Linus'
tree (top commit is a794b4f).

> > ---
> >  drivers/cpufreq/tegra20-cpufreq.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
> > index 8084c7f..2bd6284 100644
> > --- a/drivers/cpufreq/tegra20-cpufreq.c
> > +++ b/drivers/cpufreq/tegra20-cpufreq.c
> > @@ -175,9 +175,7 @@ static struct cpufreq_driver tegra_cpufreq_driver = {
> >  	.exit			= tegra_cpu_exit,
> >  	.name			= "tegra",
> >  	.attr			= cpufreq_generic_attr,
> > -#ifdef CONFIG_PM
> >  	.suspend		= cpufreq_generic_suspend,
> > -#endif
> >  };
> >  
> >  static int __init tegra_cpufreq_init(void)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
