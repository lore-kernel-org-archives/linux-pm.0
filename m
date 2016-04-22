From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 04/10] PM / OPP: Relocate dev_pm_opp_set_sharing_cpus()
Date: Fri, 22 Apr 2016 15:22:11 -0700
Message-ID: <20160422222211.GR13149@codeaurora.org>
References: <cover.1461228504.git.viresh.kumar@linaro.org>
 <2e64f9a691dd6549baee5bf81cfe99d4b287b161.1461228504.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:58525 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980AbcDVWWN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Apr 2016 18:22:13 -0400
Content-Disposition: inline
In-Reply-To: <2e64f9a691dd6549baee5bf81cfe99d4b287b161.1461228504.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, andrew@lunn.ch, gregory.clement@free-electrons.com, jason@lakedaemon.net, sebastian.hesselbarth@gmail.com, thomas.petazzoni@free-electrons.com, linux-kernel@vger.kernel.org

On 04/21, Viresh Kumar wrote:
> Move dev_pm_opp_set_sharing_cpus() towards the end of the file. This
> is required for better readability after the next patch is applied,
> which adds dev_pm_opp_get_sharing_cpus().
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

Although the next patch is not the one that needs this...

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
