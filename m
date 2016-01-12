From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 13/17] cpufreq: dt: Unsupported OPPs are already disabled
Date: Mon, 11 Jan 2016 17:53:49 -0800
Message-ID: <20160112015349.GR22188@codeaurora.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
 <c1abc34d5aaf0eb584c4cbeb6771d393c850ba85.1450777582.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:43284 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761798AbcALBxv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jan 2016 20:53:51 -0500
Content-Disposition: inline
In-Reply-To: <c1abc34d5aaf0eb584c4cbeb6771d393c850ba85.1450777582.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com

On 12/22, Viresh Kumar wrote:
> The core already have a valid regulator set for the device opp and the
> unsupported OPPs are already disabled by the core. There is no need to
> repeat that in the user drivers, get rid of it.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
