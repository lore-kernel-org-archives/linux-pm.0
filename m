From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: dt: Add support for APM X-Gene 2
Date: Fri, 06 Jan 2017 02:28:07 +0100
Message-ID: <4338433.dnYXJL6UjA@aspire.rjw.lan>
References: <1481842500-11836-1-git-send-email-hotran@apm.com> <20170102070620.GA8588@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:57180 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751418AbdAFBcX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Jan 2017 20:32:23 -0500
In-Reply-To: <20170102070620.GA8588@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Hoan Tran <hotran@apm.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, lho@apm.com, Duc Dang <dhdang@apm.com>

On Monday, January 02, 2017 12:36:20 PM Viresh Kumar wrote:
> On 15-12-16, 14:55, Hoan Tran wrote:
> > Add the compatible string for supporting the generic device tree cpufreq-dt
> > driver on APM's X-Gene 2 SoC.
> > 
> > Signed-off-by: Hoan Tran <hotran@apm.com>
> > ---
> >  drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> > index bc97b6a..7fcaf26 100644
> > --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> > +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> > @@ -26,6 +26,8 @@
> >  	{ .compatible = "allwinner,sun8i-a83t", },
> >  	{ .compatible = "allwinner,sun8i-h3", },
> >  
> > +	{ .compatible = "apm,xgene-shadowcat", },
> > +
> >  	{ .compatible = "arm,integrator-ap", },
> >  	{ .compatible = "arm,integrator-cp", },
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied.

Thanks,
Rafael

