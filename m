From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 00/17] PM / OPP: Introduce APIs to transition OPPs
Date: Wed, 23 Dec 2015 08:16:50 +0530
Message-ID: <20151223024650.GE3303@ubuntu>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
 <4682546.lJygGXp7M3@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34454 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755784AbbLWCqz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Dec 2015 21:46:55 -0500
Received: by mail-pa0-f46.google.com with SMTP id uo6so21033508pac.1
        for <linux-pm@vger.kernel.org>; Tue, 22 Dec 2015 18:46:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4682546.lJygGXp7M3@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com

On 23-12-15, 04:12, Rafael J. Wysocki wrote:
> On Tuesday, December 22, 2015 03:46:01 PM Viresh Kumar wrote:
> > This patchset add APIs in OPP layer to allow OPPs transitioning from
> > within OPP layer. Currently all OPP users need to replicate the same
> > code to switch between OPPs. While the same can be handled easily by
> > OPP-core.
> > 
> > The first Eight patches update the OPP core to introduce the new APIs
> > and the next Nine patches update cpufreq-dt for the same.
> > 
> > Testing:
> > - Tested on exynos 5250-arndale (dual-cortex-A15)
> > - Tested for both Old-V1 bindings and New V2 bindings
> > - Tested with regulator names as: 'cpu-supply' and 'cpu0-supply'
> > - Tested with Unsupported supply ranges as well, to check the
> >   opp-disable logic
> > 
> > Viresh Kumar (17):
> >   PM / OPP: get/put regulators from OPP core
> >   PM / OPP: Add APIs to set regulator-name
> >   PM / OPP: Disable OPPs that aren't supported by the regulator
> >   PM / OPP: Introduce dev_pm_opp_get_max_volt_latency()
> >   PM / OPP: Introduce dev_pm_opp_get_max_transition_latency()
> >   PM / OPP: Parse clock-latency and voltage-tolerance for v1 bindings
> >   PM / OPP: Manage device clk
> >   PM / OPP: Add dev_pm_opp_set_rate()
> >   cpufreq: dt: Convert few pr_XXX() calls to dev_XXX()
> >   cpufreq: dt: Rename 'need_update' to 'opp_v1'
> >   cpufreq: dt: OPP layers handles clock-latency for V1 bindings as well
> >   cpufreq: dt: Pass regulator name to the OPP core for V1 bindings
> >   cpufreq: dt: Unsupported OPPs are already disabled
> >   cpufreq: dt: Reuse dev_pm_opp_get_max_transition_latency()
> >   cpufreq: dt: Use dev_pm_opp_set_rate() to switch frequency
> >   cpufreq: dt: drop references to DT node
> >   cpufreq: dt: No need to allocate resources anymore
> > 
> >  drivers/base/power/opp/core.c | 428 ++++++++++++++++++++++++++++++++++++++++--
> >  drivers/base/power/opp/opp.h  |  15 ++
> >  drivers/cpufreq/cpufreq-dt.c  | 254 ++++++++-----------------
> >  include/linux/pm_opp.h        |  27 +++
> >  4 files changed, 530 insertions(+), 194 deletions(-)
> 
> As per our earlier deal regarding the OPP maintenance, I'll be waiting for ACKs
> from other OPP developers for this series.

Yeah, I was sitting on them for a long time now (based on the
multi-regulator support, which never went anywhere). And so wanted to
get them out..

I will wait for Stephen to come and look at them, Nishanth seems to be
too busy to do reviews here :)

-- 
viresh
