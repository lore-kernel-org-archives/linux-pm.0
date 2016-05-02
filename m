From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v3 1/2] PM / OPP: add non-OF versions of
 dev_pm_opp_{cpumask_,}remove_table
Date: Mon, 2 May 2016 15:55:54 -0700
Message-ID: <5727DAFA.5040902@codeaurora.org>
References: <1461926262-24732-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:41603 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755191AbcEBWz4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 May 2016 18:55:56 -0400
In-Reply-To: <1461926262-24732-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org

On 04/29/2016 03:37 AM, Sudeep Holla wrote:
> Functions dev_pm_opp_of_{cpumask_,}remove_table removes/frees all the
> static OPP entries associated with the device and/or all cpus(in case
> of cpumask) that are created from DT.
>
> However the OPP entries are populated reading from the firmware or some
> different method using dev_pm_opp_add are marked dynamic and can't be
> removed using above functions.
>
> This patch adds non DT/OF versions of dev_pm_opp_{cpumask_,}remove_table
> to support the above mentioned usecase.
>
> This is in preparation to make use of the same in scpi-cpufreq.c
>
> Cc: Viresh Kumar <vireshk@kernel.org>
> Cc: Nishanth Menon <nm@ti.com>
> CC: Stephen Boyd <sboyd@codeaurora.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: linux-pm@vger.kernel.org
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Could you rebase this on top of Arnd's patch[1] to fix the cpumask_var_t
usage? Your patch introduces more incorrect use of that type.

[1]
http://lkml.kernel.org/r/1462016049-1976580-1-git-send-email-arnd@arndb.de

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

