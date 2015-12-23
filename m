From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 00/17] PM / OPP: Introduce APIs to transition OPPs
Date: Wed, 23 Dec 2015 04:12:34 +0100
Message-ID: <4682546.lJygGXp7M3@vostro.rjw.lan>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51102 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751178AbbLWCmQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Dec 2015 21:42:16 -0500
In-Reply-To: <cover.1450777582.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com

On Tuesday, December 22, 2015 03:46:01 PM Viresh Kumar wrote:
> This patchset add APIs in OPP layer to allow OPPs transitioning from
> within OPP layer. Currently all OPP users need to replicate the same
> code to switch between OPPs. While the same can be handled easily by
> OPP-core.
> 
> The first Eight patches update the OPP core to introduce the new APIs
> and the next Nine patches update cpufreq-dt for the same.
> 
> Testing:
> - Tested on exynos 5250-arndale (dual-cortex-A15)
> - Tested for both Old-V1 bindings and New V2 bindings
> - Tested with regulator names as: 'cpu-supply' and 'cpu0-supply'
> - Tested with Unsupported supply ranges as well, to check the
>   opp-disable logic
> 
> Viresh Kumar (17):
>   PM / OPP: get/put regulators from OPP core
>   PM / OPP: Add APIs to set regulator-name
>   PM / OPP: Disable OPPs that aren't supported by the regulator
>   PM / OPP: Introduce dev_pm_opp_get_max_volt_latency()
>   PM / OPP: Introduce dev_pm_opp_get_max_transition_latency()
>   PM / OPP: Parse clock-latency and voltage-tolerance for v1 bindings
>   PM / OPP: Manage device clk
>   PM / OPP: Add dev_pm_opp_set_rate()
>   cpufreq: dt: Convert few pr_XXX() calls to dev_XXX()
>   cpufreq: dt: Rename 'need_update' to 'opp_v1'
>   cpufreq: dt: OPP layers handles clock-latency for V1 bindings as well
>   cpufreq: dt: Pass regulator name to the OPP core for V1 bindings
>   cpufreq: dt: Unsupported OPPs are already disabled
>   cpufreq: dt: Reuse dev_pm_opp_get_max_transition_latency()
>   cpufreq: dt: Use dev_pm_opp_set_rate() to switch frequency
>   cpufreq: dt: drop references to DT node
>   cpufreq: dt: No need to allocate resources anymore
> 
>  drivers/base/power/opp/core.c | 428 ++++++++++++++++++++++++++++++++++++++++--
>  drivers/base/power/opp/opp.h  |  15 ++
>  drivers/cpufreq/cpufreq-dt.c  | 254 ++++++++-----------------
>  include/linux/pm_opp.h        |  27 +++
>  4 files changed, 530 insertions(+), 194 deletions(-)

As per our earlier deal regarding the OPP maintenance, I'll be waiting for ACKs
from other OPP developers for this series.

Thanks,
Rafael

