From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] PM / OPP: add missing of_node_put() for
 of_get_cpu_node()
Date: Wed, 11 Oct 2017 15:51:46 +0530
Message-ID: <20171011102146.GB32532@vireshk-i7>
References: <1507632519-19648-1-git-send-email-sudeep.holla@arm.com>
 <1507716661-27146-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:47151 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750705AbdJKKVu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Oct 2017 06:21:50 -0400
Received: by mail-pg0-f48.google.com with SMTP id r25so752255pgn.4
        for <linux-pm@vger.kernel.org>; Wed, 11 Oct 2017 03:21:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1507716661-27146-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-pm@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 11-10-17, 11:11, Sudeep Holla wrote:
> Commit 762792913f8c ("PM / OPP: Fix get sharing CPUs when hotplug is used")
> moved away from using cpu_dev->of_node because of some limitations.
> However commit 7467c9d95989 ("of: return of_get_cpu_node from
> of_cpu_device_node_get if CPUs are not registered") added support to
> falls back to of_get_cpu_node if called if CPUs are not registered yet.
> 
> It adds the missing of_node_put for the CPU device nodes. This patch also
> moves back to use of_cpu_device_node_get in dev_pm_opp_of_get_sharing_cpus
> to avoid scanning the device tree again.
> 
> Cc: Viresh Kumar <vireshk@kernel.org>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Fixes: 762792913f8c ("PM / OPP: Fix get sharing CPUs when hotplug is used")
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Cc: 4.14+ <stable@vger.kernel.org> # 4.14+

> ---
>  drivers/opp/of.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> v1->v2:
> 	- Moved of_node_put after using cpu_np
> 	- Renamed the $subject as fixing refcount is key part of the part
> 	  and correctly relates to "Fixes" tag
> 	- Also added include change which was accidentally missed

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
