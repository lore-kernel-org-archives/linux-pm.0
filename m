From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 0/6] PM / Domains: Implement domain performance states
Date: Mon, 20 Feb 2017 15:05:56 +0530
Message-ID: <20170220093556.GR21911@vireshk-i7>
References: <cover.1486611268.git.viresh.kumar@linaro.org>
 <m2mvdk4d3o.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:36537 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750920AbdBTJmx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Feb 2017 04:42:53 -0500
Received: by mail-pg0-f43.google.com with SMTP id s67so6047941pgb.3
        for <linux-pm@vger.kernel.org>; Mon, 20 Feb 2017 01:42:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <m2mvdk4d3o.fsf@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, sboyd@codeaurora.org, nm@ti.com, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org

On 17-02-17, 15:22, Kevin Hilman wrote:
> Viresh Kumar <viresh.kumar@linaro.org> writes:
> 
> > An earlier series[1] tried to implement bindings for PM domain
> > performance states. Rob Herring suggested that we can actually merge the
> > supporting code first instead of bindings, as that will make things
> > easier to understand for all. The bindings can be decided and merged
> > later.
> >
> > The bindings [1] aren't discarded yet and this series is based on a
> > version of those only. The bindings are only used by the last patch,
> > which should not be applied and is only sent for completeness.
> >
> > IOW, this series doesn't have any dependencies and can be merged
> > straight away without waiting for the DT bindings.
> >
> > A brief summary of the problem this series is trying to solve:
> >
> > Some platforms have the capability to configure the performance state of
> > their Power Domains. The performance levels are represented by positive
> > integer values, a lower value represents lower performance state.
> 
> And what about domains where the performance levels are represented by
> someting other than positive integer values? 

The V2 bindings were modified to take that into account:

https://marc.info/?l=linux-kernel&m=148154021427727&w=2

Copying an example from it:

+               domain_perf_state1: pstate@1 {
+                       performance-level = <1>;
+                       domain-microvolt = <970000 975000 985000>;
+               };

The above node describes one performance state for the power domain.
This node can have any number of configurables depending on the
individual platforms. The performance-level is the integer number we
have been talking about in this series, which can be used in all the
calculations to differentiate between different levels.

The final code in the generic PM layer will end up calling
set_performance_state(performance-level); Now the drivers can go find
a corresponding node to find different configurables like
domain-microvolt, etc and configure the hardware. Or in simple cases,
like Qcom, the performance-level can be used directly without
referring to the node.

Consider the 'performance-level' field as the 'opp-hz' field in the
OPP tables which is used to distinguish lower/higher OPPs. Just that
we will not always have a frequency here and so an integer value.

> IMO, this implementation should start with a more generic approach
> (e.g. OPPs) that would be useful on more SoCs that just qcom.

I agree with that opinion. Perhaps things became a bit confusing as
the bindings were sent separately earlier and the code followed
separately. Also not everything was finished here to follow proper
bindings. Like the generic helpers weren't introduced yet to parse the
nodes like domain_perf_state1.

> For SoCs
> like QCOM, you could use dummy/simplfied OPPs that represent the integer
> values passed to the qcom firmware.

I am not sure if reusing OPPs here would be a good choice. I would
rather have separate nodes like what I defined earlier.

In the next version I will try to send all things together and try to
close all the open ends..

-- 
viresh
