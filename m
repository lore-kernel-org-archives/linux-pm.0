From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: skip cpufreq resume if it's not suspended
Date: Mon, 5 Feb 2018 14:53:05 +0530
Message-ID: <20180205092305.GF28462@vireshk-i7>
References: <1516744675-21233-1-git-send-email-byan@nvidia.com>
 <1563547.VDOW1Ixonm@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1563547.VDOW1Ixonm@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Bo Yan <byan@nvidia.com>, sgurrappadi@nvidia.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 05-02-18, 10:19, Rafael J. Wysocki wrote:
> On Tuesday, January 23, 2018 10:57:55 PM CET Bo Yan wrote:
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 41d148af7748..95b1c4afe14e 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -1680,6 +1680,10 @@ void cpufreq_resume(void)
> >  	if (!cpufreq_driver)
> >  		return;
> >  
> > +	if (unlikely(!cpufreq_suspended)) {
> > +		pr_warn("%s: resume after failing suspend\n", __func__);
> > +		return;
> > +	}
> >  	cpufreq_suspended = false;
> >  
> >  	if (!has_target() && !cpufreq_driver->resume)
> 
> I've just edited this patch somewhat (mostly by dropping the pr_warn())
> and queued it up.

You can add my Ack as well.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
