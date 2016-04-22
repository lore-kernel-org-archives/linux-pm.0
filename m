From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 09/10] cpufreq: dt: Kill platform-data
Date: Fri, 22 Apr 2016 15:26:05 -0700
Message-ID: <20160422222605.GT13149@codeaurora.org>
References: <cover.1461228504.git.viresh.kumar@linaro.org>
 <03e9d9e74651277bdfeac885fd86b0e482333b86.1461228504.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:59139 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719AbcDVW0H (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Apr 2016 18:26:07 -0400
Content-Disposition: inline
In-Reply-To: <03e9d9e74651277bdfeac885fd86b0e482333b86.1461228504.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, arnd.bergmann@linaro.org, andrew@lunn.ch, gregory.clement@free-electrons.com, jason@lakedaemon.net, sebastian.hesselbarth@gmail.com, thomas.petazzoni@free-electrons.com, linux-kernel@vger.kernel.org

On 04/21, Viresh Kumar wrote:
> There are no more users of platform-data for cpufreq-dt driver, get rid
> of it.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
