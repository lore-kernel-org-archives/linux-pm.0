From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/3] cpufreq: dt: Create platform device from generic code
Date: Thu, 24 Mar 2016 15:16:13 +0100
Message-ID: <4531000.a0G78BGFu1@wuerfel>
References: <cover.1458801338.git.viresh.kumar@linaro.org> <5800397.rNERvs0XYE@wuerfel> <20160324140600.GM22062@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:64808 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753553AbcCXOQg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Mar 2016 10:16:36 -0400
In-Reply-To: <20160324140600.GM22062@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, arnd.bergmann@linaro.org, kgene.kim@samsung.com, heiko@sntech.de, xf@rock-chips.com, mmcclint@codeaurora.org, linux-pm@vger.kernel.org

On Thursday 24 March 2016 19:36:00 Viresh Kumar wrote:
> On 24-03-16, 14:36, Arnd Bergmann wrote:
> > I've tried implementing something similar when we last discussed it,
> > but didn't get far enough to test it our properly, and I had trouble
> > integrating some of the more complex platforms (omap, imx, sunxi)
> > that have lots of root compatible strings to fit in nicely.
> > 
> > I think having a lookup table as in your patch 2 makes sense here,
> > but I still would prefer not having a device at all. See the patch
> 
> We don't have any other option really. The platform-device logic was
> added to make -EPROBE-DEFER work :)

Hmm, can you give an example where this is needed? I assume you are
thinking of some clock controller or regulator that gets initialized
after the cpufreq driver, right?

Are there any that are in loadable modules, rather than just later
in the init sequence for built-in drivers?

> > Another idea I had was to make dt_cpufreq_init() a global function
> > that can simply be called by platforms that pass non-NULL platform
> > data today, avoiding the need for the pdata in a global location.
> 
> I think its high time that we kill platform data if we don't care
> about old DT compatibility with new kernel for mvebu platform, if it
> hasn't gone into product already. We can do everything with opp-v2
> now, and pdata doesn't do anything special.

I think we do care about compatibility there, but there are clearly
other ways to handle the special case for opp-v1 if we want to.

> > diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> > index f951f911786e..b3817cc86597 100644
> > --- a/drivers/cpufreq/cpufreq-dt.c
> > +++ b/drivers/cpufreq/cpufreq-dt.c
> > @@ -356,7 +356,7 @@ static struct cpufreq_driver dt_cpufreq_driver = {
> >  	.suspend = cpufreq_generic_suspend,
> >  };
> >  
> > -static int dt_cpufreq_probe(struct platform_device *pdev)
> > +static int 	(void *data)
> 
> dt_cpufreq_init ? :)

Yes, I must have removed the string from my email when copying the
text above.

	Arnd
