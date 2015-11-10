From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v3 1/2] thermal: mediatek: Add cpu power cooling model.
Date: Tue, 10 Nov 2015 10:41:22 -0800
Message-ID: <20151110184121.GC5240@localhost.localdomain>
References: <1445515359-8587-1-git-send-email-dawei.chien@mediatek.com>
 <1445515359-8587-2-git-send-email-dawei.chien@mediatek.com>
 <20151104193958.GC14127@localhost.localdomain>
 <1446721837.4016.57.camel@mtksdaap41>
 <20151106032433.GL3773@ubuntu>
 <20151110112017.GA3551@e104805>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34500 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154AbbKJSl0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2015 13:41:26 -0500
Content-Disposition: inline
In-Reply-To: <20151110112017.GA3551@e104805>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, dawei chien <dawei.chien@mediatek.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Matthias Brugger <matthias.bgg@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, Sascha Hauer <s.hauer@pengutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>

On Tue, Nov 10, 2015 at 11:20:18AM +0000, Javi Merino wrote:
> On Fri, Nov 06, 2015 at 08:54:33AM +0530, Viresh Kumar wrote:
> > Cc'ing Javi (which you should have as he wrote the power-thing for
> > cpu-cooling).
> > 
> > On 05-11-15, 19:10, dawei chien wrote:
> > > This is because our platform currently only support mt8173_cpufreq.c, so
> > > that I only add static power model for our owner IC.
> > 
> > Bindings are (normally) supposed to be general than a platform
> > specific.
> > 
> > > Please understanding that I wouldn't give a DT binding document since I
> > > will remove static power table on next version, but I can try to explain
> > > it.
> > 
> > Then just don't add things in the first place.
> > 
> > > As far as I know, static power is somewhat leakage of CPU clusters, so
> > > that we hardly to find a formula, which can suitable all kinds of CPUs
> > > since leakage is different. In ARM IPA framework, static power only need
> > > to be defined by who register cpufreq_power_cooling_register. The
> > > voltage/power table is just one way to present leakage power of CPUs.
> > 
> > The bindings don't fix the values for static power, but just provides
> > a field for platforms to use. Everyone can then send its own power
> > figures. Why do you thing it can't be generalized?
> 
> The way they are described here is useful only for this platform, but
> it's not generic.  It only takes into account voltage as (I assume)
> it's the only variable that affects it in this implementation.  A
> generalized version of the static power should take into account the
> temperature and the idle state.

Still, why would we have one binding to describe static power per platform?

I would prefer we go towards a generalized binding description.

If temperature is not needed on all platforms, make it an optional
property.

BR,

Eduardo Valentin
