From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v10 09/10] arm: dts: qcom: Add idle states device nodes
 for 8084
Date: Wed, 26 Nov 2014 12:16:02 -0800
Message-ID: <54763502.90709@codeaurora.org>
References: <1416593037-27527-1-git-send-email-lina.iyer@linaro.org> <1416593037-27527-10-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:50498 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbaKZUQE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Nov 2014 15:16:04 -0500
In-Reply-To: <1416593037-27527-10-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org

On 11/21/2014 10:03 AM, Lina Iyer wrote:
> Add ARM common idle states device bindings for cpuidle support for APQ
> 8084.
>
> Support standby and standalone power collapse (power down that does not
> affect any SoC idle states) for each cpu.
>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

