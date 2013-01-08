From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/3] PM / OPP: Export more symbols for module usage
Date: Tue, 8 Jan 2013 23:06:15 +0800
Message-ID: <20130108150610.GE19534@S2101-09.ap.freescale.net>
References: <1357628043-19256-1-git-send-email-shawn.guo@linaro.org>
 <1357628043-19256-2-git-send-email-shawn.guo@linaro.org>
 <20130108144720.GA6062@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130108144720.GA6062@kahuna>
Sender: cpufreq-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Sascha Hauer <s.hauer@pengutronix.de>, Mark Langsdorf <mark.langsdorf@calxeda.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 08, 2013 at 08:47:21AM -0600, Nishanth Menon wrote:
> On 14:54-20130108, Shawn Guo wrote:
> > Export opp_init_cpufreq_table and opp_free_cpufreq_table for module
> > usage.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  drivers/base/power/opp.c |    2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> > index 50b2831..d16db9a 100644
> > --- a/drivers/base/power/opp.c
> > +++ b/drivers/base/power/opp.c
> > @@ -661,6 +661,7 @@ int opp_init_cpufreq_table(struct device *dev,
> >  
> >  	return 0;
> >  }
> > +EXPORT_SYMBOL(opp_init_cpufreq_table);
> >  
> >  /**
> >   * opp_free_cpufreq_table() - free the cpufreq table
> > @@ -678,6 +679,7 @@ void opp_free_cpufreq_table(struct device *dev,
> >  	kfree(*table);
> >  	*table = NULL;
> >  }
> > +EXPORT_SYMBOL(opp_free_cpufreq_table);
> >  #endif		/* CONFIG_CPU_FREQ */
> 
> Is'nt this already covered in 
> https://patchwork.kernel.org/patch/1847261/
> ?

Sorry, I'm working against v3.8-rc and missed that.  Will drop it.

Shawn

