From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V3 16/16] cpufreq: dt: No need to allocate resources
 anymore
Date: Tue, 9 Feb 2016 11:09:01 -0800
Message-ID: <20160209190901.GD30978@codeaurora.org>
References: <cover.1454992186.git.viresh.kumar@linaro.org>
 <3acd23bf00b9afa69de6069a289eaed220303cb5.1454992187.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:55441 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754417AbcBITJD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Feb 2016 14:09:03 -0500
Content-Disposition: inline
In-Reply-To: <3acd23bf00b9afa69de6069a289eaed220303cb5.1454992187.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, open list <linux-kernel@vger.kernel.org>

On 02/09, Viresh Kumar wrote:
> OPP layer manages it now and cpufreq-dt driver doesn't need it. But, we
> still need to check for availability of resources for deferred probing.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
