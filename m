From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 05/10] PM / OPP: Mark shared-opp for non-dt case
Date: Fri, 22 Apr 2016 15:21:38 -0700
Message-ID: <20160422222138.GQ13149@codeaurora.org>
References: <cover.1461228504.git.viresh.kumar@linaro.org>
 <11b3f4234120113b3493e9adf5c3e1ce1700f886.1461228504.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:58377 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752969AbcDVWVl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Apr 2016 18:21:41 -0400
Content-Disposition: inline
In-Reply-To: <11b3f4234120113b3493e9adf5c3e1ce1700f886.1461228504.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, andrew@lunn.ch, gregory.clement@free-electrons.com, jason@lakedaemon.net, sebastian.hesselbarth@gmail.com, thomas.petazzoni@free-electrons.com, linux-kernel@vger.kernel.org

On 04/21, Viresh Kumar wrote:
> opp core allows OPPs to be explicitly marked as shared from platform
> code, in case of operating-point v1 bindings.
> 
> Though we do everything fine in that case, we don't set the flag in the
> opp-table to indicate that the OPPs are shared. It works fine today as
> the flag isn't used anywhere else in the core, but we should be doing
> the right thing by marking it set.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
