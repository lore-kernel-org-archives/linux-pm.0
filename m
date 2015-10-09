From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH v3 4/9] clk: qcom: create virtual child device for TSENS
Date: Fri, 09 Oct 2015 08:44:42 +0530
Message-ID: <56173122.2030203@codeaurora.org>
References: <1444280468-17159-1-git-send-email-rnayak@codeaurora.org> <1444280468-17159-5-git-send-email-rnayak@codeaurora.org> <20151008232110.GK26883@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:49819 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753433AbbJIDOt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 8 Oct 2015 23:14:49 -0400
In-Reply-To: <20151008232110.GK26883@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com, srinivas.kandagatla@linaro.org, nrajan@codeaurora.org, lina.iyer@linaro.org, punit.agrawal@arm.com


On 10/09/2015 04:51 AM, Stephen Boyd wrote:
> On 10/08, Rajendra Nayak wrote:
>> 8960 family of devices have TSENS as part of GCC in hardware.
>> Hence DT would represent a GCC node with GCC properties as well
>> as TSENS. Create a virtual platform child device here for TSENS
>> so the driver can probe it and use the parent (GCC) to extract DT
>> properties.
>>
>> Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> ---
> 
> Applied to clk-next with some massaging. Is there going to be an
> update to the gcc binding too?

Thanks, I will update the gcc bindings as part of the patch which
adds support for 8960 tsens.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
