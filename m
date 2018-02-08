From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] arm: imx: Add MODULE_ALIAS for cpufreq
Date: Thu, 08 Feb 2018 11:13:51 +0100
Message-ID: <1713681.4FvdsgcfpH@aspire.rjw.lan>
References: <20180130095526.9478-1-kwizart@gmail.com> <20180130152008.GE13395@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:42501 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751069AbeBHKPe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Feb 2018 05:15:34 -0500
In-Reply-To: <20180130152008.GE13395@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Nicolas Chauvet <kwizart@gmail.com>
Cc: linux-pm@vger.kernel.org

On Tuesday, January 30, 2018 4:20:08 PM CET Viresh Kumar wrote:
> On 30-01-18, 10:55, Nicolas Chauvet wrote:
> > Without this, the imx6q-cpufreq driver isn't loaded
> > automatically when built as a module
> > 
> > Tested on wandboard quad with a fedora 27 kernel rpm
> > 
> > Signed-off-by: Nicolas Chauvet <kwizart@gmail.com>
> > ---
> >  drivers/cpufreq/imx6q-cpufreq.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> > index d9b2c2de49c4..cef3d46fd642 100644
> > --- a/drivers/cpufreq/imx6q-cpufreq.c
> > +++ b/drivers/cpufreq/imx6q-cpufreq.c
> > @@ -473,6 +473,7 @@ static struct platform_driver imx6q_cpufreq_platdrv = {
> >  };
> >  module_platform_driver(imx6q_cpufreq_platdrv);
> >  
> > +MODULE_ALIAS("platform:imx6q-cpufreq");
> >  MODULE_AUTHOR("Shawn Guo <shawn.guo@linaro.org>");
> >  MODULE_DESCRIPTION("Freescale i.MX6Q cpufreq driver");
> >  MODULE_LICENSE("GPL");
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 

Patch applied, thanks!
