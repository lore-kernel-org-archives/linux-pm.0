From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v10 06/10] arm: dts: qcom: Update power-controller device
 node for 8064 Krait CPUs
Date: Wed, 26 Nov 2014 12:06:53 -0800
Message-ID: <547632DD.4030005@codeaurora.org>
References: <1416593037-27527-1-git-send-email-lina.iyer@linaro.org> <1416593037-27527-7-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:49333 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbaKZUGy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Nov 2014 15:06:54 -0500
In-Reply-To: <1416593037-27527-7-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org

On 11/21/2014 10:03 AM, Lina Iyer wrote:
> Update the SAW2 DT bindings to add qcom,apq8064-saw2-v1.1-cpu compatible
> binding string to configure SPM registers and allow the SPM to put the
> core in deeper idle states when the core is idle.
>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

