From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v3] PM / OPP: add missing of_node_put() for
 of_get_cpu_node()
Date: Thu, 12 Oct 2017 13:58:51 -0700
Message-ID: <ff407681-0730-a314-15ba-fee869e16dd8@codeaurora.org>
References: <1507632519-19648-1-git-send-email-sudeep.holla@arm.com>
 <1507804343-2472-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:34246 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751961AbdJLU6x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Oct 2017 16:58:53 -0400
In-Reply-To: <1507804343-2472-1-git-send-email-sudeep.holla@arm.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 10/12/2017 03:32 AM, Sudeep Holla wrote:
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
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Acked-by: Viresh Kumar <vireshk@kernel.org>
> Fixes: 762792913f8c ("PM / OPP: Fix get sharing CPUs when hotplug is used")
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---


Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
