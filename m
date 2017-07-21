From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: dt: Add zynqmp to the cpufreq dt platdev
Date: Sat, 22 Jul 2017 00:41:23 +0200
Message-ID: <2036558.expUFVpD1Y@aspire.rjw.lan>
References: <3a2d9e482adc907a03a55c99aa1583cc2618077c.1499937548.git.michal.simek@xilinx.com> <20170713091953.GE352@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:45910 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753853AbdGUWtR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jul 2017 18:49:17 -0400
In-Reply-To: <20170713091953.GE352@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, linux-pm@vger.kernel.org

On Thursday, July 13, 2017 02:49:53 PM Viresh Kumar wrote:
> On 13-07-17, 11:19, Michal Simek wrote:
> > From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> > 
> > Add zynqmp to the cpufreq dt platform device.
> > 
> > Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> > Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> > ---
> > 
> >  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> > index 1c262923fe58..2eb40d46d357 100644
> > --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> > +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> > @@ -94,6 +94,7 @@
> >  	{ .compatible = "ti,omap5", },
> >  
> >  	{ .compatible = "xlnx,zynq-7000", },
> > +	{ .compatible = "xlnx,zynqmp", },
> >  
> >  	{ .compatible = "zte,zx296718", },
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> 

Applied, thanks!
