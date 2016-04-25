From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 07/10] cpufreq: dt: Identify cpu-sharing for platforms
 without operating-points-v2
Date: Mon, 25 Apr 2016 14:56:08 -0700
Message-ID: <20160425215608.GB29990@codeaurora.org>
References: <cover.1461228504.git.viresh.kumar@linaro.org>
 <e42f0fdd6b67461a631ca9d966a52357bbc6cc75.1461228504.git.viresh.kumar@linaro.org>
 <20160422222736.GU13149@codeaurora.org>
 <20160425093650.GG32183@vireshk-i7>
 <20160425214533.GA29990@codeaurora.org>
 <CAJZ5v0htz=F29BAkkGR3XPa1F15o0qg_pUbcPkqbY-COD8UDsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:43576 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965184AbcDYV4L (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Apr 2016 17:56:11 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0htz=F29BAkkGR3XPa1F15o0qg_pUbcPkqbY-COD8UDsQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Arnd Bergmann <arnd.bergmann@linaro.org>, andrew@lunn.ch, gregory.clement@free-electrons.com, Jason Cooper <jason@lakedaemon.net>, sebastian.hesselbarth@gmail.com, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 04/25, Rafael J. Wysocki wrote:
> On Mon, Apr 25, 2016 at 11:45 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > On 04/25, Viresh Kumar wrote:
> >> On 22-04-16, 15:27, Stephen Boyd wrote:
> >> > On 04/21, Viresh Kumar wrote:
> >> > > @@ -167,14 +167,16 @@ static int cpufreq_init(struct cpufreq_policy *policy)
> >> > >   /* Get OPP-sharing information from "operating-points-v2" bindings */
> >> > >   ret = dev_pm_opp_of_get_sharing_cpus(cpu_dev, policy->cpus);
> > [..]
> >> > > +         if (dev_pm_opp_get_sharing_cpus(cpu_dev, policy->cpus))
> >> > > +                 fallback = true;
> >> >
> >> > I'm sort of lost, we make the same call twice here. Why would the
> >> > return value change between the first time and the second?
> >>
> >> Two different APIs, which look similar :)
> >>
> >> The first one tries to find the sharing-cpus relation from DT, the
> >> other one is for v1 bindings and finds it due to platform code
> >> dev_pm_opp_set_sharing_cpus() call.
> >
> > Ah thanks. My eyes glossed over the "of" part. Sounds fine.
> 
> So that would be an "ACK", right?

Sure, I thought this was going for another round though.

I had to go back and re-read the patch once more, but you can
have my reviewed-by on this one too.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
