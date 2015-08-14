From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH 5/9] clk: qcom: gcc-msm8960: add child devices support.
Date: Fri, 14 Aug 2015 08:39:06 +0530
Message-ID: <55CD5BD2.3070907@codeaurora.org>
References: <1436348838-22671-1-git-send-email-rnayak@codeaurora.org> <1436348838-22671-6-git-send-email-rnayak@codeaurora.org> <20150811224902.GO2839@codeaurora.org> <55CB0B26.2020105@linaro.org> <55CC1CFE.7000005@codeaurora.org> <20150814004206.GU26614@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50971 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993AbbHNDJM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2015 23:09:12 -0400
In-Reply-To: <20150814004206.GU26614@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-arm-msm@vger.kernel.org, lina.iyer@linaro.org, nrajan@codeaurora.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

[]..
>>>> Also, I don't like having a subnode in DT. Why can't we use the
>>>> same node as the GCC node and create a virtual child device here
>>>> for tsens? We can assign the same of_node that this platform
>>>> device has so that DT keeps working correctly.
>>
>> So the current driver looks up data based on compatible strings.
>
> The tsens device is always the same piece of hardware. The only

Well, not always. The one in 8960 does need additional initializations,
requires you to save/restore context as it can be powered off
not being in an always powered on domain etc.

> thing that's changing is the qfprom data and the number of
> sensors. So we should be looking at the qfprom compatible string

How? Tsens uses nvmem framework apis to read the qfprom atleast
in this series.

> to figure out how to interpret the qfprom data which would
> include the number of sensors and how the data is encoded.
>
>> So you suggesting to create a virtual child device for gcc and
>> associate the gcc DT node to it? (And have the tsens compatible
>> mentioned as part of the gcc DT node?)
>
> No. The driver should work just fine without having to
> interrogate the device's compatible string. If we still need the
> compatible check for some reason, then we can always match based
> on qcom,gcc-msm8960, qcom,gcc-apq8064, etc. But I don't see why

Thats not quite possible I guess. 2 drivers (gcc and tsens) matching
the same compatibles? Will it not just depend on which ends up being
the first match?

> we need to do that when we should be looking at what type of
> qfprom is connected so we can correctly parse the data.
