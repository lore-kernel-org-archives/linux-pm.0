From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 1/2] PM / OPP: add non-OF versions of dev_pm_opp_{cpumask_,}remove_table
Date: Fri, 06 May 2016 01:36:11 +0200
Message-ID: <1612350.VkL1mav6rL@vostro.rjw.lan>
References: <1461926262-24732-1-git-send-email-sudeep.holla@arm.com> <1462284305-32177-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:56355 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754614AbcEEXc6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 May 2016 19:32:58 -0400
In-Reply-To: <1462284305-32177-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-pm@vger.kernel.org

On Tuesday, May 03, 2016 03:05:04 PM Sudeep Holla wrote:
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

Both [1-2/2] applied, thanks!

