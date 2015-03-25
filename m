From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V3 2/8] ARM: cpuidle: Add a cpuidle ops structure to be
 used for DT
Date: Wed, 25 Mar 2015 14:34:30 -0700
Message-ID: <20150325213430.GA30227@codeaurora.org>
References: <1426851841-2072-1-git-send-email-daniel.lezcano@linaro.org>
 <1426851841-2072-3-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:42562 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947AbbCYVec (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Mar 2015 17:34:32 -0400
Content-Disposition: inline
In-Reply-To: <1426851841-2072-3-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@rjwysocki.net, lorenzo.pieralisi@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Catalin.Marinas@arm.com, robherring2@gmail.com, arnd@arndb.de, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lina.iyer@linaro.org

On 03/20, Daniel Lezcano wrote:
> The current state of the different cpuidle drivers is the different PM
> operations are passed via the platform_data using the platform driver
> paradigm.
> 
> This approach allowed to split the low level PM code from the arch specific
> and the generic cpuidle code.
> 
> Unfortunately there are complaints about this approach as, in the context of the
> single kernel image, we have multiple drivers loaded in memory for nothing and
> the platform driver is not adequate for cpuidle.
> 
> This patch provides a common interface via cpuidle ops for all new cpuidle
> driver and a definition for the device tree.
> 
> It will allow with the next patches to a have a common definition with ARM64
> and share the same cpuidle driver.
> 
> The code is optimized to use the __init section intensively in order to reduce
> the memory footprint after the driver is initialized and unify the function
> names with ARM64.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Kevin Hilman <khilman@linaro.org>
> Acked-by: Rob Herring <robherring2@gmail.com>

Thanks for moving to OF tables. We can merge smp ops and cpuidle
ops later on.

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
