From: Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH v18 04/11] ARM: cpuidle: Add cpuidle support for QCOM cpus
Date: Fri, 27 Mar 2015 11:22:43 -0500
Message-ID: <40C051E9-43C0-4BDD-ADE1-1B96DCC13656@codeaurora.org>
References: <1427315136-44321-1-git-send-email-lina.iyer@linaro.org> <1427315136-44321-5-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:56835 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752987AbbC0QWr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Mar 2015 12:22:47 -0400
In-Reply-To: <1427315136-44321-5-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org, agross@codeaurora.org, Arnd Bergmann <arnd@arndb.de>


On Mar 25, 2015, at 3:25 PM, Lina Iyer <lina.iyer@linaro.org> wrote:

> Define ARM_QCOM_CPUIDLE config item to enable cpuidle support.
> 
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> ---
> drivers/cpuidle/Kconfig.arm | 7 +++++++
> 1 file changed, 7 insertions(+)

Acked-by: Kumar Gala <galak@codeaurora.org>

- k
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

