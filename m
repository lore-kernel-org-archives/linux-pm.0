From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: qoriq depends on thermal
Date: Sat, 27 Feb 2016 00:57:40 +0100
Message-ID: <2754986.CN3tVUPQd5@vostro.rjw.lan>
References: <1456489361-469413-1-git-send-email-arnd@arndb.de> <20160226152015.GA21797@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:44142 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755249AbcBZX4F (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2016 18:56:05 -0500
In-Reply-To: <20160226152015.GA21797@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Jia Hongtao <hongtao.jia@freescale.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday, February 26, 2016 08:50:15 PM Viresh Kumar wrote:
> On 26-02-16, 13:22, Arnd Bergmann wrote:
> > The thermal subsystem can be a loadable module, so the qoriq driver has to be
> > a module in that case as well in order to call of_cpufreq_cooling_register:
> > 
> > drivers/built-in.o: In function `qoriq_cpufreq_ready':
> > text+0x1f4548): undefined reference to `of_cpufreq_cooling_register'
> > 
> > This adds a dependency that clarifies how we can either build the driver
> > when the cpu_thermal support is completely disabled, or how it depends
> > on the thermal support to enforce the qoriq driver to be a module.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Fixes: 8ae1702a0df5 ("cpufreq: qoriq: Register cooling device based on device tree")
> > ---
> >  drivers/cpufreq/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > My patch is from Dec 22, and I had marked it as submitted, but can't
> > find the email now, so maybe I forgot to send it out back then.
> > 
> > The problem still exists in linux-next, please apply the patch
> > for 4.6.
> > 
> > diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> > index dcb972a38fbc..ca05037dd565 100644
> > --- a/drivers/cpufreq/Kconfig
> > +++ b/drivers/cpufreq/Kconfig
> > @@ -297,6 +297,7 @@ endif
> >  config QORIQ_CPUFREQ
> >  	tristate "CPU frequency scaling driver for Freescale QorIQ SoCs"
> >  	depends on OF && COMMON_CLK && (PPC_E500MC || ARM)
> > +	depends on !CPU_THERMAL || THERMAL=y
> >  	select CLK_QORIQ
> >  	help
> >  	  This adds the CPUFreq driver support for Freescale QorIQ SoCs
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!

