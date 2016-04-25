From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 07/10] cpufreq: dt: Identify cpu-sharing for platforms without operating-points-v2
Date: Tue, 26 Apr 2016 00:03:30 +0200
Message-ID: <27586812.kWb8msD2sM@vostro.rjw.lan>
References: <cover.1461228504.git.viresh.kumar@linaro.org> <CAJZ5v0htz=F29BAkkGR3XPa1F15o0qg_pUbcPkqbY-COD8UDsQ@mail.gmail.com> <20160425215608.GB29990@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:44399 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S965214AbcDYWAc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Apr 2016 18:00:32 -0400
In-Reply-To: <20160425215608.GB29990@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Arnd Bergmann <arnd.bergmann@linaro.org>, andrew@lunn.ch, gregory.clement@free-electrons.com, Jason Cooper <jason@lakedaemon.net>, sebastian.hesselbarth@gmail.com, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Monday, April 25, 2016 02:56:08 PM Stephen Boyd wrote:
> On 04/25, Rafael J. Wysocki wrote:
> > On Mon, Apr 25, 2016 at 11:45 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > > On 04/25, Viresh Kumar wrote:
> > >> On 22-04-16, 15:27, Stephen Boyd wrote:
> > >> > On 04/21, Viresh Kumar wrote:
> > >> > > @@ -167,14 +167,16 @@ static int cpufreq_init(struct cpufreq_policy *policy)
> > >> > >   /* Get OPP-sharing information from "operating-points-v2" bindings */
> > >> > >   ret = dev_pm_opp_of_get_sharing_cpus(cpu_dev, policy->cpus);
> > > [..]
> > >> > > +         if (dev_pm_opp_get_sharing_cpus(cpu_dev, policy->cpus))
> > >> > > +                 fallback = true;
> > >> >
> > >> > I'm sort of lost, we make the same call twice here. Why would the
> > >> > return value change between the first time and the second?
> > >>
> > >> Two different APIs, which look similar :)
> > >>
> > >> The first one tries to find the sharing-cpus relation from DT, the
> > >> other one is for v1 bindings and finds it due to platform code
> > >> dev_pm_opp_set_sharing_cpus() call.
> > >
> > > Ah thanks. My eyes glossed over the "of" part. Sounds fine.
> > 
> > So that would be an "ACK", right?
> 
> Sure, I thought this was going for another round though.

OK

> I had to go back and re-read the patch once more, but you can
> have my reviewed-by on this one too.

Well, I'm still unsure what about the [6/10].

I have applied [1-5/10] for now and I'll be expecting updates or resends of
the rest.

Thanks,
Rafael

