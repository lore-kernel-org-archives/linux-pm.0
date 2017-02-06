From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/6] PM / Domains: Implement domain performance states
Date: Mon, 06 Feb 2017 12:39:42 +0100
Message-ID: <1683164.QFNep65OJ4@aspire.rjw.lan>
References: <cover.1483439894.git.viresh.kumar@linaro.org> <20170116053007.GA15930@vireshk-i7> <20170206053505.GI3131@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:50854 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751663AbdBFLoa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Feb 2017 06:44:30 -0500
In-Reply-To: <20170206053505.GI3131@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: khilman@baylibre.com, ulf.hansson@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Vincent Guittot <vincent.guittot@linaro.org>, robh+dt@kernel.org, mark.rutland@arm.com, lina.iyer@linaro.org, rnayak@codeaurora.org

On Monday, February 06, 2017 11:05:05 AM Viresh Kumar wrote:
> On 16-01-17, 11:00, Viresh Kumar wrote:
> > On 03-01-17, 16:36, Viresh Kumar wrote:
> > > Hi,
> > > 
> > > An earlier series[1] tried to implement bindings for PM domain
> > > performance states. Rob Herring suggested that we can actually write the
> > > supporting code first instead of bindings, as that will make things
> > > easier to understand for all.
> > > 
> > > The bindings [1] aren't discarded yet and this series is based on a
> > > version of those only. The bindings are only used by the last patch,
> > > which should not be applied and is only sent for completeness.
> > > 
> > > All other patches can be reviewed/applied whenever the maintainers feel
> > > they look good.
> > > 
> > > 
> > > A brief summary of the problem this series is trying to solve:
> > > 
> > > Some platforms have the capability to configure the performance state of
> > > their Power Domains. The performance levels are represented by positive
> > > integer values, a lower value represents lower performance state.
> > > 
> > > We decided earlier that we should extend Power Domain framework to
> > > support active state power management as well.  The power-domains until
> > > now were only concentrating on the idle state management of the device
> > > and this needs to change in order to reuse the infrastructure of power
> > > domains for active state management.
> > > 
> > > The first 5 patches update the PM domain and QoS frameworks to support
> > > that and the last one presents the front end interface to it.
> > > 
> > > All the patches are tested by hacking the OPP core a bit for now.
> > 
> > Ping !
> 
> Ping !!

I've been waiting for comments from Kevin and Ulf.

I guess it's better to resend at this point.

Thanks,
Rafael

