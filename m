From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 09/17] cpufreq: dt: Convert few pr_debug/err() calls to
 dev_dbg/err()
Date: Mon, 11 Jan 2016 17:40:31 -0800
Message-ID: <20160112014031.GN22188@codeaurora.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
 <3d3628d7dab6f5bca0e911ab60544a919c2d4075.1450777582.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:42139 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758859AbcALBkc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jan 2016 20:40:32 -0500
Content-Disposition: inline
In-Reply-To: <3d3628d7dab6f5bca0e911ab60544a919c2d4075.1450777582.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com

On 12/22, Viresh Kumar wrote:
> We have the device structure available now, lets use it for better print
> messages.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
