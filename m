From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v12 02/10] qcom: scm: Add SCM warmboot support for quad
 core SoCs
Date: Wed, 26 Nov 2014 16:55:53 -0800
Message-ID: <54767699.1030001@codeaurora.org>
References: <1417047195-18978-1-git-send-email-lina.iyer@linaro.org> <1417047195-18978-3-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:45590 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699AbaK0Az4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Nov 2014 19:55:56 -0500
In-Reply-To: <1417047195-18978-3-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org

On 11/26/2014 04:13 PM, Lina Iyer wrote:
> Quad core SoCs like APQ8074, APQ8064, APQ8084 need SCM support set up
> warm boot addresses in the Secure Monitor. Extend the SCM flags to
> support warm boot addresses for secondary cores.
>
> We do not need to export the warmboot flags. Move them into the
> implementation file.
>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

