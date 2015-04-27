From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH v5 08/11] arm: dts: qcom: Add #power-domain-cells property
Date: Mon, 27 Apr 2015 15:03:16 +0530
Message-ID: <553E025C.5060106@codeaurora.org>
References: <1429017137-20218-1-git-send-email-rnayak@codeaurora.org>	<1429017137-20218-9-git-send-email-rnayak@codeaurora.org>	<CAPDyKFoph2TQeSS6XE_UpOPHiZy5tRZWFvUSqccv7rjtHOprsg@mail.gmail.com>	<553A2106.1030102@codeaurora.org>	<CAPDyKFrUhx-_EHzR=j+tHUUDJPJb1Qw9d4eMV30_z2E-a9r=oA@mail.gmail.com>	<553D9FB4.6060107@codeaurora.org> <CAPDyKFq1KH7bzRh4+cdoDNJPJKtzbcUbvFDRAbD7g-dEPWSm=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFq1KH7bzRh4+cdoDNJPJKtzbcUbvFDRAbD7g-dEPWSm=w@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Mike Turquette <mturquette@linaro.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Georgi Djakov <georgi.djakov@linaro.org>, svarbanov@mm-sol.com, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, sviau@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On 04/27/2015 01:22 PM, Ulf Hansson wrote:
> On 27 April 2015 at 04:32, Rajendra Nayak <rnayak@codeaurora.org> wrote:
>> On 04/24/2015 09:13 PM, Ulf Hansson wrote:
>>>
>>> On 24 April 2015 at 12:55, Rajendra Nayak <rnayak@codeaurora.org> wrote:
>>>>
>>>> On 04/24/2015 03:15 PM, Ulf Hansson wrote:
>>>>>
>>>>>
>>>>> On 14 April 2015 at 15:12, Rajendra Nayak <rnayak@codeaurora.org> wrote:
>>>>>>
>>>>>>
>>>>>> msm8974 has gcc and mmcc nodes, and apq8084 has a gcc node which
>>>>>> implement gdsc powerdomains. Add the #power-domain-cells property
>>>>>> to them.
>>>>>>
>>>>>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>>>>>> ---
>>>>>>     arch/arm/boot/dts/qcom-apq8084.dtsi | 1 +
>>>>>>     arch/arm/boot/dts/qcom-msm8974.dtsi | 2 ++
>>>>>>     2 files changed, 3 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi
>>>>>> b/arch/arm/boot/dts/qcom-apq8084.dtsi
>>>>>> index 1f130bc..55c281c 100644
>>>>>> --- a/arch/arm/boot/dts/qcom-apq8084.dtsi
>>>>>> +++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
>>>>>> @@ -183,6 +183,7 @@
>>>>>>                            compatible = "qcom,gcc-apq8084";
>>>>>>                            #clock-cells = <1>;
>>>>>>                            #reset-cells = <1>;
>>>>>> +                       #power-domain-cells = <1>;
>>>>>
>>>>>
>>>>>
>>>>> So the PM domain will be apart of the clock-controller. That's a bit
>>>>> odd, but I guess the hardware is like that!?
>>>>
>>>>
>>>>
>>>> Yes, the gdscs are all part of GCC controller.
>>>>
>>>>>
>>>>> Anyway, what I fail to understand from this patchset is who will be
>>>>> the actual consumer of the PM domain? In other words, what devices
>>>>> will hold the below property in its DT node?
>>>>>
>>>>> power_domains = <phandle index>;
>>>>>
>>>>> This is needed for genpd to have the device at probe time, attached to
>>>>> its PM domain.
>>>>
>>>>
>>>>
>>>> Any device which belongs to the collapsible power domain (gdsc)
>>>> Examples are graphics, camera, video encode/decode block (venus) etc
>>>
>>>
>>> Then I expect those drivers to deploy runtime PM (if not already) and
>>> thus gdsc's PM domain will come into play.
>>
>>
>> Most of these drivers aren;t upstream yet. And one of the reasons I am
>> trying to get gdsc support upstream is so these drivers can then be
>> pushed upstream, with runtime support.
>
> That's great news! I am happy to help reviewing, if you like.
>
>>
>>>
>>> But how will that relate to the GCC controller?
>>>
>>> For example when the gdsc's PM domain is about to be powered off,
>>> since all the devices within it has be runtime PM suspended. What
>>> happens with the GCC controller then?
>>
>>
>> I don;t seem to completely understand what you are asking. Are you
>> asking if the GCC controller itself is part of a collapsible power
>> domain?
>
> Yes. Sorry for being a bit vague...
>
> If the gdsc's PM domain is powered off, what happens with the GCC's clocks?

The clocks need to be turned off explicitly. So for a device to be
functional the driver would turn the power switch on, and then enable
the needed clocks and the other way around when the device is no
longer needed and can be turned off.

>
> Kind regards
> Uffe
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
