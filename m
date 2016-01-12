From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 03/17] PM / OPP: Disable OPPs that aren't supported by
 the regulator
Date: Mon, 11 Jan 2016 17:19:53 -0800
Message-ID: <20160112011953.GI22188@codeaurora.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
 <b3edc6d769720792791bda5701545f019d7a9329.1450777582.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:40850 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759231AbcALBTz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jan 2016 20:19:55 -0500
Content-Disposition: inline
In-Reply-To: <b3edc6d769720792791bda5701545f019d7a9329.1450777582.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com

On 12/22, Viresh Kumar wrote:
> Disable any OPPs where the connected regulator isn't able to provide the
> specified voltage.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
