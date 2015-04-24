From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v5 08/11] arm: dts: qcom: Add #power-domain-cells property
Date: Fri, 24 Apr 2015 17:43:46 +0200
Message-ID: <CAPDyKFrUhx-_EHzR=j+tHUUDJPJb1Qw9d4eMV30_z2E-a9r=oA@mail.gmail.com>
References: <1429017137-20218-1-git-send-email-rnayak@codeaurora.org>
	<1429017137-20218-9-git-send-email-rnayak@codeaurora.org>
	<CAPDyKFoph2TQeSS6XE_UpOPHiZy5tRZWFvUSqccv7rjtHOprsg@mail.gmail.com>
	<553A2106.1030102@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <553A2106.1030102@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Mike Turquette <mturquette@linaro.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Georgi Djakov <georgi.djakov@linaro.org>, svarbanov@mm-sol.com, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, sviau@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On 24 April 2015 at 12:55, Rajendra Nayak <rnayak@codeaurora.org> wrote:
> On 04/24/2015 03:15 PM, Ulf Hansson wrote:
>>
>> On 14 April 2015 at 15:12, Rajendra Nayak <rnayak@codeaurora.org> wrote:
>>>
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
>>> diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi
>>> b/arch/arm/boot/dts/qcom-apq8084.dtsi
>>> index 1f130bc..55c281c 100644
>>> --- a/arch/arm/boot/dts/qcom-apq8084.dtsi
>>> +++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
>>> @@ -183,6 +183,7 @@
>>>                          compatible = "qcom,gcc-apq8084";
>>>                          #clock-cells = <1>;
>>>                          #reset-cells = <1>;
>>> +                       #power-domain-cells = <1>;
>>
>>
>> So the PM domain will be apart of the clock-controller. That's a bit
>> odd, but I guess the hardware is like that!?
>
>
> Yes, the gdscs are all part of GCC controller.
>
>>
>> Anyway, what I fail to understand from this patchset is who will be
>> the actual consumer of the PM domain? In other words, what devices
>> will hold the below property in its DT node?
>>
>> power_domains = <phandle index>;
>>
>> This is needed for genpd to have the device at probe time, attached to
>> its PM domain.
>
>
> Any device which belongs to the collapsible power domain (gdsc)
> Examples are graphics, camera, video encode/decode block (venus) etc

Then I expect those drivers to deploy runtime PM (if not already) and
thus gdsc's PM domain will come into play.

But how will that relate to the GCC controller?

For example when the gdsc's PM domain is about to be powered off,
since all the devices within it has be runtime PM suspended. What
happens with the GCC controller then?

Kind regards
Uffe
