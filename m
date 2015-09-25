From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [patch] PM / OPP: passing NULL to PTR_ERR()
Date: Fri, 25 Sep 2015 23:55:29 +0200
Message-ID: <6540909.mH5lzIF4eN@vostro.rjw.lan>
References: <20150921162602.GE5648@mwanda> <20150921185939.GB24314@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20150921185939.GB24314@linux>
Sender: kernel-janitors-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@codeaurora.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, September 21, 2015 11:59:39 AM Viresh Kumar wrote:
> On 21-09-15, 19:26, Dan Carpenter wrote:
> > The code was using PTR_ERR(NULL) which causes a static checker warning.
> > I have fixed up the printks and changed the return to -ENOENT.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > diff --git a/drivers/base/power/opp/cpu.c b/drivers/base/power/opp/cpu.c
> > index 3d946b5..7654c56 100644
> > --- a/drivers/base/power/opp/cpu.c
> > +++ b/drivers/base/power/opp/cpu.c
> > @@ -223,8 +223,7 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask
> >  	/* Get OPP descriptor node */
> >  	np = _of_get_opp_desc_node(cpu_dev);
> >  	if (!np) {
> > -		dev_dbg(cpu_dev, "%s: Couldn't find opp node: %ld\n", __func__,
> > -			PTR_ERR(np));
> > +		dev_dbg(cpu_dev, "%s: Couldn't find cpu_dev node.\n", __func__);
> >  		return -ENOENT;
> >  	}
> >  
> > @@ -247,9 +246,9 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask
> >  		/* Get OPP descriptor node */
> >  		tmp_np = _of_get_opp_desc_node(tcpu_dev);
> >  		if (!tmp_np) {
> > -			dev_err(tcpu_dev, "%s: Couldn't find opp node: %ld\n",
> > -				__func__, PTR_ERR(tmp_np));
> > -			ret = PTR_ERR(tmp_np);
> > +			dev_err(tcpu_dev, "%s: Couldn't find tcpu_dev node.\n",
> > +				__func__);
> > +			ret = -ENOENT;
> >  			goto put_cpu_node;
> >  		}
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!

Rafael

