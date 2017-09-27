From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V2] PM / OPP: Move the OPP directory out of power/
Date: Wed, 27 Sep 2017 15:15:11 -0700
Message-ID: <20170927221511.GH457@codeaurora.org>
References: <3eaed52523d54bdc7b43b335d5aefda9b4d1b4a8.1506463860.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:40748 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752065AbdI0WPN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2017 18:15:13 -0400
Content-Disposition: inline
In-Reply-To: <3eaed52523d54bdc7b43b335d5aefda9b4d1b4a8.1506463860.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org

On 09/26, Viresh Kumar wrote:
> The drivers/base/power/ directory is special and contains code related
> to power management core like system suspend/resume, hibernation, etc.
> It was fine to keep the OPP code inside it when we had just one file for
> it, but it is growing now and already has a directory for itself.
> 
> Lets move it directly under drivers/ directory, just like cpufreq and
> cpuidle.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
