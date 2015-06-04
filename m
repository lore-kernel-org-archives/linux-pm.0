From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v3 4/5] clk: scpi: add support for cpufreq virtual device
Date: Thu, 4 Jun 2015 14:19:04 -0700
Message-ID: <20150604211904.GO676@codeaurora.org>
References: <1432720398-5701-1-git-send-email-sudeep.holla@arm.com>
 <1432720398-5701-5-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60326 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566AbbFDVTG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jun 2015 17:19:06 -0400
Content-Disposition: inline
In-Reply-To: <1432720398-5701-5-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Liviu Dudau <Liviu.Dudau@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Jon Medhurst (Tixy)" <tixy@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>, Olof Johansson <olof@lixom.net>, Mike Turquette <mturquette@linaro.org>

On 05/27, Sudeep Holla wrote:
> The clocks for the CPUs are provided by SCP and are managed by this
> clock driver. So the cpufreq device needs to be added only after the
> clock get registered and removed when this driver is unloaded.
> 
> This patch manages the cpufreq virtual device based on the clock
> availability.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Liviu Dudau <Liviu.Dudau@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Jon Medhurst (Tixy) <tixy@linaro.org>
> Cc: linux-clk@vger.kernel.org
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>


I guess there's no better place for this right now.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
