From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v6 2/5] arm: dts: qcom: Add SPM device bindings for 8974
Date: Wed, 24 Sep 2014 11:23:45 -0600
Message-ID: <20140924172345.GE422@ilina-mac>
References: <1411516281-58328-1-git-send-email-lina.iyer@linaro.org>
 <1411516281-58328-3-git-send-email-lina.iyer@linaro.org>
 <5422621E.2050509@smartplayin.com>
 <20140924134939.GA422@ilina-mac>
 <5422FD8D.8080307@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5422FD8D.8080307@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Pramod Gurav <pramod.gurav@smartplayin.com>, galak@codeaurora.org, daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@linaro.org, msivasub@codeaurora.org, lorenzo.pieralisi@arm.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 24 2014 at 11:21 -0600, Stephen Boyd wrote:
>On 09/24/14 06:49, Lina Iyer wrote:
>> On Wed, Sep 24 2014 at 00:14 -0600, Pramod Gurav wrote:
>>> Hi Lina,
>>>
>>> On Wednesday 24 September 2014 05:21 AM, Lina Iyer wrote:
>>>> Add SPM device bindings for QCOM 8974 based cpus. SPM is the sub-system
>>>> power manager and controls the logic around the cores (cpu and L2).
>>>>
>>>> Each core has an instance of SPM and controls only that core. Each cpu
>>>> SPM is configured to support WFI and SPC (standalone-power collapse).
>>>>
>>>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>>>> ---
>>>>  arch/arm/boot/dts/qcom-msm8974-pm.dtsi | 69
>>>> ++++++++++++++++++++++++++++++++++
>>>>  arch/arm/boot/dts/qcom-msm8974.dtsi    | 10 +++--
>>>>  2 files changed, 75 insertions(+), 4 deletions(-)
>>>>  create mode 100644 arch/arm/boot/dts/qcom-msm8974-pm.dtsi
>>>
>>> <snip>
>>>
>>>> +};
>>>> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi
>>>> b/arch/arm/boot/dts/qcom-msm8974.dtsi
>>>> index 69dca2a..0580bc2 100644
>>>> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
>>>> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
>>>> @@ -14,7 +14,7 @@
>>>>          #size-cells = <0>;
>>>>          interrupts = <1 9 0xf04>;
>>>>
>>>> -        cpu@0 {
>>>> +        CPU0: cpu@0 {
>>> Lina, Stephen boyd has sent some DT change for krait-cpufreq which also
>>> renames this node to "cpu0: cpu@0". If you both could sync up and agree
>>> on a common naming('cpu0' with caps or not caps) for this node.
>>>
>> Sure. Will work with Stephen on that.
>>
>
>This doesn't seem like a big deal. I imagine Kumar can resolve the
>conflict if the two patches merge at the same time.
>
I can use the lower case names, if thats common. I see that being used
for referring to <&acc> in that file, but ofcourse <&L2> exists as well.
Any preference?

>-- 
>Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
>hosted by The Linux Foundation
>
