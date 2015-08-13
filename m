From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] PM / Domains: Make pm_genpd_init() available to modules
Date: Thu, 13 Aug 2015 11:11:28 -0700
Message-ID: <20150813181128.GP26614@codeaurora.org>
References: <1439446917-32304-1-git-send-email-rnayak@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:49488 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993AbbHMSLa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2015 14:11:30 -0400
Content-Disposition: inline
In-Reply-To: <1439446917-32304-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: ulf.hansson@linaro.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, geert@linux-m68k.org

On 08/13, Rajendra Nayak wrote:
> Export symbol pm_genpd_init so it can be used in loadable
> kernel modules
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---

I'd like to take this through the clk tree somehow so that we can
merge the rest of the GDSC series this coming cycle.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
