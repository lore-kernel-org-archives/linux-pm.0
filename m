From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v2 3/7] drivers: cpu: Define CPU devices as IRQ safe
Date: Thu, 3 Sep 2015 21:00:08 -0700
Message-ID: <20150904040008.GM15099@codeaurora.org>
References: <1441310314-8857-1-git-send-email-lina.iyer@linaro.org>
 <1441310314-8857-4-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:38799 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704AbbIDEAL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Sep 2015 00:00:11 -0400
Content-Disposition: inline
In-Reply-To: <1441310314-8857-4-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: ulf.hansson@linaro.org, khilman@linaro.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, geert@linux-m68k.org, k.kozlowski@samsung.com, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org

On 09/03, Lina Iyer wrote:
> CPUs may be powered off from CPUIdle or hotplug and are called with
> IRQ's disabled. Define CPU devices as IRQ safe, so they may be runtime
> suspended/resumed.
> 
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
