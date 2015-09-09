From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: tegra20: remove superfluous CONFIG_PM ifdefs
Date: Wed, 09 Sep 2015 22:14:50 +0200
Message-ID: <2371290.4u0K8mkgaF@vostro.rjw.lan>
References: <1441732403-7248-1-git-send-email-b.zolnierkie@samsung.com> <9512123.FfVbKErfZO@vostro.rjw.lan> <1615370.p6S63xknIg@amdc1976>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:41728 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753830AbbIITq7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Sep 2015 15:46:59 -0400
In-Reply-To: <1615370.p6S63xknIg@amdc1976>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday, September 09, 2015 12:36:39 PM Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On Wednesday, September 09, 2015 03:13:45 AM Rafael J. Wysocki wrote:
> > On Tuesday, September 08, 2015 07:13:23 PM Bartlomiej Zolnierkiewicz wrote:
> > > CONFIG_PM ifdefs are superfluous and can be removed.
> > > 
> > > Cc: Stephen Warren <swarren@wwwdotorg.org>
> > > Cc: Thierry Reding <thierry.reding@gmail.com>
> > > Cc: Alexandre Courbot <gnurou@gmail.com>
> > > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > 
> > What tree does this apply to?
> 
> It applies fine to both next (next-20150909 branch) and current Linus'
> tree (top commit is a794b4f).

OK

My cpufreq branch has not acquired tegra20-cpufreq.c yet, so I'll apply this
one when -rc1 is out.  Or please ask whoever merged that driver to apply it
earlier if you want to.


> > > ---
> > >  drivers/cpufreq/tegra20-cpufreq.c | 2 --
> > >  1 file changed, 2 deletions(-)
> > > 
> > > diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
> > > index 8084c7f..2bd6284 100644
> > > --- a/drivers/cpufreq/tegra20-cpufreq.c
> > > +++ b/drivers/cpufreq/tegra20-cpufreq.c
> > > @@ -175,9 +175,7 @@ static struct cpufreq_driver tegra_cpufreq_driver = {
> > >  	.exit			= tegra_cpu_exit,
> > >  	.name			= "tegra",
> > >  	.attr			= cpufreq_generic_attr,
> > > -#ifdef CONFIG_PM
> > >  	.suspend		= cpufreq_generic_suspend,
> > > -#endif
> > >  };
> > >  
> > >  static int __init tegra_cpufreq_init(void)
> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
