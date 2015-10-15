From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v3 3/5] clk: qoriq: Add ls2080a support.
Date: Thu, 15 Oct 2015 12:53:16 -0700
Message-ID: <20151015195316.GS4558@codeaurora.org>
References: <1442723397-26329-1-git-send-email-scottwood@freescale.com>
 <1442723397-26329-4-git-send-email-scottwood@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:53318 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbbJOTxR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 15 Oct 2015 15:53:17 -0400
Content-Disposition: inline
In-Reply-To: <1442723397-26329-4-git-send-email-scottwood@freescale.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Scott Wood <scottwood@freescale.com>
Cc: Michael Turquette <mturquette@baylibre.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Russell King <linux@arm.linux.org.uk>, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Tang Yuantian <Yuantian.Tang@freescale.com>

On 09/19, Scott Wood wrote:
> LS2080A is the first implementation of the chassis 3 clockgen, which
> has a different register layout than previous chips.  It is also little
> endian, unlike previous chips.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
