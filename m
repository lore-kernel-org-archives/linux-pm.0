From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 0/2] thermal, OPP: move the CPU power estimation to
 the OPP library
Date: Fri, 19 Jan 2018 15:42:30 +0530
Message-ID: <20180119101230.GA2421@vireshk-i7>
References: <20180119094549.5468-1-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52]:41319 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754881AbeASKMe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jan 2018 05:12:34 -0500
Received: by mail-pg0-f52.google.com with SMTP id 136so1064288pgd.8
        for <linux-pm@vger.kernel.org>; Fri, 19 Jan 2018 02:12:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20180119094549.5468-1-quentin.perret@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, sudeep.holla@arm.com, amit.kachhap@gmail.com, javi.merino@kernel.org, rui.zhang@intel.com, edubezval@gmail.com, matthias.bgg@gmail.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, patrick.bellasi@arm.com, ionela.voinescu@arm.com, joelaf@google.com, tkjos@google.com

On 19-01-18, 09:45, Quentin Perret wrote:
> Hi,
> 
> Currently, IPA estimates the power dissipated by a CPU at each available OPP
> using its capacitance (the dynamic-power-coefficient DT binding). This series
> relocates this per-OPP power model in the OPP core as a preparation for
> future changes. More specifically:
> 
>    1. The current DT-based approach for power estimation will need deep
>       changes to support SCMI-provided power values. While the thermal
>       subsystem is not necessarily the best place to hide multiple power
>       estimation methods, the OPP library appears to be a good candidate to
>       implement the required platform abstraction and respect the existing
>       design (the thermal subsystem already relies on the OPP library to
>       provide voltages no matter where they come from -- DT or SCPI).
> 
>    2. The energy models of CPUs will be needed by other clients in the future
>       (such as the task scheduler or CPUFreq governors for example) in order
>       to make energy-aware decisions. The relocation to the OPP library will
>       enable code re-use and all clients will benefit form the platform
>       abstraction mentioned previously.
> 
> As mentionned during the review of V1, this series will have a chance to get
> merged only when the clients (the scheduler, or the SCMI driver) depending
> on it are ready to be merged as well. This V3 is here for reference and
> addresses the main changes requested on the previous versions.
> 
> Changes in v2:
>  - Changed the OPP power estimation to be done upon OPP creation (V. Kumar)
>  - Updated the cover letter to motivate the choice of PM OPP (E. Valentin)
> 
> Changes in v3
>  - Removed the has_power logic to simplify the thermal code (V. Kumar)
>  - Moved _opp_estimate_power() call to _opp_add() to avoid duplication (V. Kumar)

So I am mostly fine with the changes here and can apply them to the OPP tree as
soon as Eduardo Acks them (as he had some concerns about the users).

Thanks.

-- 
viresh
