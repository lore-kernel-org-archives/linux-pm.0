From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 0/2] thermal, OPP: move the CPU power estimation to the
 OPP library
Date: Wed, 10 Jan 2018 11:34:33 -0800
Message-ID: <20180110193431.GE3837@localhost.localdomain>
References: <20180109110252.13557-1-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:46164 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752790AbeAJTe2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jan 2018 14:34:28 -0500
Received: by mail-pg0-f65.google.com with SMTP id r2so122703pgq.13
        for <linux-pm@vger.kernel.org>; Wed, 10 Jan 2018 11:34:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20180109110252.13557-1-quentin.perret@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, sudeep.holla@arm.com, amit.kachhap@gmail.com, javi.merino@kernel.org, rui.zhang@intel.com, matthias.bgg@gmail.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, patrick.bellasi@arm.com, ionela.voinescu@arm.com

On Tue, Jan 09, 2018 at 11:02:50AM +0000, Quentin Perret wrote:
> Currently, IPA estimates the power dissipated by a CPU at each available OPP
> using its capacitance (the dynamic-power-coefficient DT binding). This series
> relocates this feature into the OPP library as a preparation for future
> changes. More specifically:
> 
>    1. The current DT-based approach for power estimation will need deep
>       changes to support SCMI-provided power values. While the thermal
>       subsystem is not necessarily the best place to hide multiple power
>       estimation methods, the OPP library appears to be a good candidate to
>       implement the required platform abstraction.
>    2. The energy models of CPUs will be needed by other clients in the future
>       (such as the task scheduler or CPUFreq governors for example) in order
>       to make energy-aware decisions. The relocation to the OPP library will
>       enable code re-use and all clients will benefit form the platform
>       abstraction mentioned previously.

To be quite frank, I am happy to see this leaving thermal subsystem.
However, a few concerns with the patch set as it is. First, I am not
convinced PM OPP is the right place to put this, nor I see a good
explanation put in the patch set why it must be part of PM OPP.
Second, looks like we are following ARM "good" practice of fixing
problems of the future. I would only really sign off for this series
when we see real "other future users", otherwise we end up with the
infamous static power scenario in 2-3 years down the row. If we
currently do not have users of this IN MAINLINE KERNEL, then the series
is not for upstream.

> 
> Quentin Perret (2):
>   PM / OPP: introduce an OPP power estimation helper
>   thermal: cpu_cooling: use power models from the OPP library
> 
>  drivers/cpufreq/arm_big_little.c   |  2 ++
>  drivers/cpufreq/cpufreq-dt.c       |  2 ++
>  drivers/cpufreq/mediatek-cpufreq.c |  2 ++
>  drivers/opp/core.c                 | 40 +++++++++++++++++++++++++
>  drivers/opp/of.c                   | 61 ++++++++++++++++++++++++++++++++++++++
>  drivers/opp/opp.h                  |  4 +++
>  drivers/thermal/cpu_cooling.c      | 33 ++++++---------------
>  include/linux/pm_opp.h             | 20 +++++++++++++
>  8 files changed, 140 insertions(+), 24 deletions(-)
> 
> -- 
> 2.15.1
> 
