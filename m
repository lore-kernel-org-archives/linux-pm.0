From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] s5pv210-cpufreq: fix wrong do_div() usage
Date: Thu, 05 Nov 2015 23:34:58 +0100
Message-ID: <13808096.NXRWtLePsS@vostro.rjw.lan>
References: <alpine.LFD.2.20.1511031706460.630@knanqh.ubzr> <20151104015033.GN3685@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:42303 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756859AbbKEWFq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 Nov 2015 17:05:46 -0500
In-Reply-To: <20151104015033.GN3685@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: linux-pm@vger.kernel.org

On Wednesday, November 04, 2015 07:20:33 AM Viresh Kumar wrote:
> On 03-11-15, 17:13, Nicolas Pitre wrote:
> > It is wrong to use do_div() with 32-bit dividends (unsigned long is
> > 32 bits on 32-bit architectures).
> > 
> > Signed-off-by: Nicolas Pitre <nico@linaro.org>
> > 
> > diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
> > index 9e231f5215..051a8a8224 100644
> > --- a/drivers/cpufreq/s5pv210-cpufreq.c
> > +++ b/drivers/cpufreq/s5pv210-cpufreq.c
> > @@ -212,11 +212,11 @@ static void s5pv210_set_refresh(enum s5pv210_dmc_port ch, unsigned long freq)
> >  	/* Find current DRAM frequency */
> >  	tmp = s5pv210_dram_conf[ch].freq;
> >  
> > -	do_div(tmp, freq);
> > +	tmp /= freq;
> >  
> >  	tmp1 = s5pv210_dram_conf[ch].refresh;
> >  
> > -	do_div(tmp1, tmp);
> > +	tmp1 /= tmp;
> >  
> >  	__raw_writel(tmp1, reg);
> >  }
> 
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!

Rafael

