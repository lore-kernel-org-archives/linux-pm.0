From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 0/7] PM / Domains: Implement domain performance states
Date: Mon, 13 Mar 2017 16:09:33 +0530
Message-ID: <20170313103933.GA3102@vireshk-i7>
References: <cover.1487926924.git.viresh.kumar@linaro.org>
 <m237ekrhok.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34866 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752234AbdCMKji (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Mar 2017 06:39:38 -0400
Received: by mail-pf0-f172.google.com with SMTP id j5so67872788pfb.2
        for <linux-pm@vger.kernel.org>; Mon, 13 Mar 2017 03:39:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <m237ekrhok.fsf@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org, robh+dt@kernel.org, rnayak@codeaurora.org, lina.iyer@linaro.org

On 10-03-17, 12:38, Kevin Hilman wrote:
> Why limit it to just voltage levels.
> 
> As I suggested earlier, I think this should use OPPs.  Remember that a
> PM domain is not limited to a hardware power domain, but is just a
> grouping mechanism for devices that share some PM properties.  As
> mentioned by Geert, this can also be a clock domain, where frequencies
> would make sense as well.  One can imagine using this type of PM domain
> to manage an interconnect/bus which has scalable voltage/frequencies as
> well.

Okay, I tried to do that change today and am blocked a bit right now.

The OPP core and all of its APIs/interfaces have dependency on the
"struct device" for their working. It gets the of_node from it, stores
the device pointer to manage cases where multiple devices share OPP
table, uses it to get clk and regulators.

But the "genpd" structure doesn't have a 'struct device' associated
with it. How should I make both of them work together?

I tried to create separate helpers that don't accept 'dev', but that
is also not good.  Just too much redundant code everywhere.

Would creating a 'dev' structure within 'generic_pm_domain' be
acceptable? Or should we ask the domain-drivers to call something like
of_genpd_parse_idle_states(), with a fake 'dev' structure which has
its of_node initialized? Or maybe move that hack within the OPP-core
API, which can create a dev structure at runtime for the genpd passed
to it and get the OPP table out?

-- 
viresh
