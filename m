From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: scmi: fix use-after-free in scmi_cpufreq_exit()
Date: Tue, 19 Feb 2019 11:18:39 +0100
Message-ID: <2386834.BKf6y2r8fF@aspire.rjw.lan>
References: <20190216163148.12375-1-tiny.windzz@gmail.com> <20190218045330.zpiivw7mvv4hzctq@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190218045330.zpiivw7mvv4hzctq@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Yangtao Li <tiny.windzz@gmail.com>, sudeep.holla@arm.com, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, February 18, 2019 5:53:30 AM CET Viresh Kumar wrote:
> On 16-02-19, 11:31, Yangtao Li wrote:
> > This issue was detected with the help of Coccinelle. So
> > change the order of function calls to fix it.
> > 
> > Fixes: 1690d8bb91e37 (cpufreq: scpi/scmi: Fix freeing of dynamic OPPs)
> > 
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  drivers/cpufreq/scmi-cpufreq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> > index 242c3370544e..9ed46d188cb5 100644
> > --- a/drivers/cpufreq/scmi-cpufreq.c
> > +++ b/drivers/cpufreq/scmi-cpufreq.c
> > @@ -187,8 +187,8 @@ static int scmi_cpufreq_exit(struct cpufreq_policy *policy)
> >  
> >  	cpufreq_cooling_unregister(priv->cdev);
> >  	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
> > -	kfree(priv);
> >  	dev_pm_opp_remove_all_dynamic(priv->cpu_dev);
> > +	kfree(priv);
> >  
> >  	return 0;
> >  }
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> @Rafael: Please pick it up for 5.0-rc8 as the bug was introduced
> during 5.0 cycle only.
> 
> The patch it fixes had this tag:
> 
>     Cc: 4.20 <stable@vger.kernel.org> # v4.20
> 
> And so will get applied to 4.20.N, I guess we need to mark this patch
> as well for stable then.

Done now, thanks!
