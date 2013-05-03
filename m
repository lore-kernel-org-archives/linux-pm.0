From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH V2] cpufreq: cpu0: Free parent node for error cases
Date: Fri, 03 May 2013 14:47:58 +0200
Message-ID: <455891364.DU1qQaFqNq@vostro.rjw.lan>
References: <03c6b0e0f41238c1b4346b4186040ff69e369b4a.1367556239.git.viresh.kumar@linaro.org> <20130503060327.GA19902@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130503060327.GA19902@S2101-09.ap.freescale.net>
Sender: cpufreq-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com
List-Id: linux-pm@vger.kernel.org

On Friday, May 03, 2013 02:03:29 PM Shawn Guo wrote:
> On Fri, May 03, 2013 at 10:14:25AM +0530, Viresh Kumar wrote:
> > We are freeing parent node in success cases but not in failure cases. Lets do
> > it.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Acked-by: Shawn Guo <shawn.guo@linaro.org>

OK, queued up for the v3.10-rc2 push.

Thanks,
Rafael


> > ---
> >  drivers/cpufreq/cpufreq-cpu0.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
> > index 3ab8294..8565d41 100644
> > --- a/drivers/cpufreq/cpufreq-cpu0.c
> > +++ b/drivers/cpufreq/cpufreq-cpu0.c
> > @@ -189,7 +189,8 @@ static int cpu0_cpufreq_probe(struct platform_device *pdev)
> >  
> >  	if (!np) {
> >  		pr_err("failed to find cpu0 node\n");
> > -		return -ENOENT;
> > +		ret = -ENOENT;
> > +		goto out_put_parent;
> >  	}
> >  
> >  	cpu_dev = &pdev->dev;
> > @@ -264,6 +265,8 @@ out_free_table:
> >  	opp_free_cpufreq_table(cpu_dev, &freq_table);
> >  out_put_node:
> >  	of_node_put(np);
> > +out_put_parent:
> > +	of_node_put(parent);
> >  	return ret;
> >  }
> >  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe cpufreq" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
