From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: integrator: Fix module autoload for OF platform driver
Date: Mon, 05 Oct 2015 22:51:42 +0200
Message-ID: <1776253.J5g3a7BOh2@vostro.rjw.lan>
References: <20150916202446.GA4303@goodgumbo.baconseed.org> <20150917015756.GQ29943@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51689 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751394AbbJEUXN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 5 Oct 2015 16:23:13 -0400
In-Reply-To: <20150917015756.GQ29943@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Luis de Bethencourt <luis@debethencourt.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Thursday, September 17, 2015 07:27:56 AM Viresh Kumar wrote:
> On 16-09-15, 22:24, Luis de Bethencourt wrote:
> > This platform driver has a OF device ID table but the OF module
> > alias information is not created so module autoloading won't work.
> > 
> > Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
> > ---
> > 
> > Hello,
> > 
> > This patch adds the missing MODULE_DEVICE_TABLE() for OF to export
> > that information so modules have the correct aliases built-in and
> > autoloading works correctly.
> > 
> > A longer explanation by Javier Canillas can be found here:
> > https://lkml.org/lkml/2015/7/30/519
> > 
> > Thanks,
> > Luis
> > 
> >  drivers/cpufreq/integrator-cpufreq.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/cpufreq/integrator-cpufreq.c b/drivers/cpufreq/integrator-cpufreq.c
> > index 2faa421..79e3ff2 100644
> > --- a/drivers/cpufreq/integrator-cpufreq.c
> > +++ b/drivers/cpufreq/integrator-cpufreq.c
> > @@ -221,6 +221,8 @@ static const struct of_device_id integrator_cpufreq_match[] = {
> >  	{ },
> >  };
> >  
> > +MODULE_DEVICE_TABLE(of, integrator_cpufreq_match);
> > +
> >  static struct platform_driver integrator_cpufreq_driver = {
> >  	.driver = {
> >  		.name = "integrator-cpufreq",
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!

Rafael

