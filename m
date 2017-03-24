From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V4 1/9] PM / OPP: Allow OPP table to be used for
 power-domains
Date: Fri, 24 Mar 2017 10:44:51 -0500
Message-ID: <20170324154451.ljszby3mhc4rlgnw@rob-hp-laptop>
References: <cover.1490001099.git.viresh.kumar@linaro.org>
 <e772e67a5445319bb8e0f312846ace666adc097f.1490001099.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34457 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757348AbdCXPoy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Mar 2017 11:44:54 -0400
Content-Disposition: inline
In-Reply-To: <e772e67a5445319bb8e0f312846ace666adc097f.1490001099.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@linaro.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, lina.iyer@linaro.org, rnayak@codeaurora.org, devicetree@vger.kernel.org

On Mon, Mar 20, 2017 at 03:02:13PM +0530, Viresh Kumar wrote:
> Power-domains need to express their active states in DT and what's
> better than OPP table for that.
> 
> This patch allows power-domains to reuse OPP tables to express their
> active states. The "opp-hz" property isn't a required property anymore
> as power-domains may not always use them.

Then maybe you shouldn't be trying to make OPP table work here. At that 
point you just need a table of voltage(s) per performance state?

> Add a new property "domain-performance-state", which will contain
> positive integer values to represent performance levels of the
> power-domains as described in this patch.

Why not reference the OPP entries from the domain:

performance-states = <&opp1>, <&opp2>;

Just thinking out loud, not saying that is what you should do. The 
continual evolution of power (management) domain, idle state, and OPP 
bindings is getting tiring.

> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  Documentation/devicetree/bindings/opp/opp.txt | 73 ++++++++++++++++++++++++++-
>  1 file changed, 71 insertions(+), 2 deletions(-)
> 
