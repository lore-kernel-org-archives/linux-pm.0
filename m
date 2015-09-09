From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH 5/9] clk: qcom: gcc-msm8960: add child devices support.
Date: Wed, 09 Sep 2015 09:03:10 +0530
Message-ID: <55EFA876.30708@codeaurora.org>
References: <1436348838-22671-1-git-send-email-rnayak@codeaurora.org> <1436348838-22671-6-git-send-email-rnayak@codeaurora.org> <20150811224902.GO2839@codeaurora.org> <55CB0B26.2020105@linaro.org> <55CC1CFE.7000005@codeaurora.org> <20150814004206.GU26614@codeaurora.org> <55CD5BD2.3070907@codeaurora.org> <55E660F6.3020007@codeaurora.org> <20150903172743.GE15099@codeaurora.org> <55ED311E.1070404@codeaurora.org> <20150908192115.GP15099@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:41491 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752829AbbIIDdU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2015 23:33:20 -0400
In-Reply-To: <20150908192115.GP15099@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-arm-msm@vger.kernel.org, lina.iyer@linaro.org, nrajan@codeaurora.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org


On 09/09/2015 12:51 AM, Stephen Boyd wrote:
> On 09/07, Rajendra Nayak wrote:
>>>
>>> Yeah this might happen though because we've assigned the of_node
>>> pointer to the tsens device before we register it on the platform
>>> bus. The other way to pass that data down from gcc to tsens would
>>> be to not have an of_node assigned to the tsens device, and check
>>> for that case in the tsens driver. If there isn't an of_node,
>>> then we look at the parent device's of_node to figure out which
>>> gcc it is (if this even matters) and parse DT properties.
>>
>> Parsing DT properties from parent (in the tsens driver) is fine, but
>> the nvmem apis still expect an of_node for the tsens device and hence
>> fail.
>
> So pass the parent device to the nvmem APIs? Or adjust the nvmem
> APIs to look for a parent of_node if there isn't an of_node for
> the device being passed? Or make the nvmem APIs work without
> using DT, and copy over the nvmem information from the gcc node
> to the virtual tsens child device?

Srini, you being the nvmem maintainer, any thoughts?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
