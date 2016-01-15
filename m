From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 06/17] PM / OPP: Parse clock-latency and
 voltage-tolerance for v1 bindings
Date: Thu, 14 Jan 2016 17:54:19 -0800
Message-ID: <20160115015419.GH22188@codeaurora.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
 <25cb4d7e9169815448193bd93305fae31a83792c.1450777582.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:45128 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805AbcAOByW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 14 Jan 2016 20:54:22 -0500
Content-Disposition: inline
In-Reply-To: <25cb4d7e9169815448193bd93305fae31a83792c.1450777582.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com

On 12/22, Viresh Kumar wrote:
> V2 bindings have better support for clock-latency and voltage-tolerance
> and doesn't need special care. To use callbacks, like
> dev_pm_opp_get_max_{transition|volt}_latency(), irrespective of the
> bindings, the core needs to know clock-latency/voltage-tolerance for the
> earlier bindings.
> 
> This patch reads clock-latency/voltage-tolerance from the device node,
> irrespective of the bindings (to keep it simple) and use them only for
> V1 bindings.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
