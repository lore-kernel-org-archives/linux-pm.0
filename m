From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH v5 08/11] arm: dts: qcom: Add #power-domain-cells property
Date: Fri, 24 Apr 2015 16:30:04 +0530
Message-ID: <553A2234.2070004@codeaurora.org>
References: <1429017137-20218-1-git-send-email-rnayak@codeaurora.org>	<1429017137-20218-9-git-send-email-rnayak@codeaurora.org> <CAPDyKFoph2TQeSS6XE_UpOPHiZy5tRZWFvUSqccv7rjtHOprsg@mail.gmail.com> <553A2106.1030102@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:35618 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754487AbbDXLAK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Apr 2015 07:00:10 -0400
In-Reply-To: <553A2106.1030102@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Mike Turquette <mturquette@linaro.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Georgi Djakov <georgi.djakov@linaro.org>, svarbanov@mm-sol.com, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, sviau@codeaurora.org


On 04/24/2015 04:25 PM, Rajendra Nayak wrote:
> On 04/24/2015 03:15 PM, Ulf Hansson wrote:
>> On 14 April 2015 at 15:12, Rajendra Nayak <rnayak@codeaurora.org> wrote:
>>> msm8974 has gcc and mmcc nodes, and apq8084 has a gcc node which
>>> implement gdsc powerdomains. Add the #power-domain-cells property
>>> to them.
>>>
>>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>>> ---
>>>   arch/arm/boot/dts/qcom-apq8084.dtsi | 1 +
>>>   arch/arm/boot/dts/qcom-msm8974.dtsi | 2 ++
>>>   2 files changed, 3 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
>>>
>>> index 1f130bc..55c281c 100644
>>> --- a/arch/arm/boot/dts/qcom-apq8084.dtsi
>>> +++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
>>> @@ -183,6 +183,7 @@
>>>                          compatible = "qcom,gcc-apq8084";
>>>                          #clock-cells = <1>;
>>>                          #reset-cells = <1>;
>>> +                       #power-domain-cells = <1>;
>>
>> So the PM domain will be apart of the clock-controller. That's a bit
>> odd, but I guess the hardware is like that!?
>
> Yes, the gdscs are all part of GCC controller.

correction. and other clock controllers too, like MMCC.
