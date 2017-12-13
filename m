From: Sricharan R <sricharan@codeaurora.org>
Subject: Re: [PATCH v4 08/12] clk: qcom: Add KPSS ACC/GCC driver
Date: Wed, 13 Dec 2017 17:12:37 +0530
Message-ID: <722ad6a1-2cf2-25ca-a62b-0a837ab4aa1d@codeaurora.org>
References: <1512726150-7204-1-git-send-email-sricharan@codeaurora.org>
 <1512726150-7204-9-git-send-email-sricharan@codeaurora.org>
 <20171212203813.f3fkjw4uvxm43yok@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:58482 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751853AbdLMLmo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Dec 2017 06:42:44 -0500
In-Reply-To: <20171212203813.f3fkjw4uvxm43yok@rob-hp-laptop>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: mturquette@baylibre.com, sboyd@codeaurora.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org

Hi Rob,

On 12/13/2017 2:08 AM, Rob Herring wrote:
> On Fri, Dec 08, 2017 at 03:12:26PM +0530, Sricharan R wrote:
>> From: Stephen Boyd <sboyd@codeaurora.org>
>>
>> The ACC and GCC regions present in KPSSv1 contain registers to
>> control clocks and power to each Krait CPU and L2. For CPUfreq
>> purposes probe these devices and expose a mux clock that chooses
>> between PXO and PLL8.
>>
>> Cc: <devicetree@vger.kernel.org>
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>> ---
>>  .../devicetree/bindings/arm/msm/qcom,kpss-acc.txt  |  7 ++
>>  .../devicetree/bindings/arm/msm/qcom,kpss-gcc.txt  | 28 +++++++
> 
> Please make bindings a separate patch.

 ok.

> 
>>  drivers/clk/qcom/Kconfig                           |  8 ++
>>  drivers/clk/qcom/Makefile                          |  1 +
>>  drivers/clk/qcom/kpss-xcc.c                        | 96 ++++++++++++++++++++++
>>  5 files changed, 140 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
>>  create mode 100644 drivers/clk/qcom/kpss-xcc.c
>>
>> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
>> index 1333db9..382a574 100644
>> --- a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
>> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
>> @@ -21,10 +21,17 @@ PROPERTIES
>>  		    the register region. An optional second element specifies
>>  		    the base address and size of the alias register region.
>>  
>> +- clock-output-names:
>> +	Usage: optional
>> +	Value type: <string>
>> +	Definition: Name of the output clock. Typically acpuX_aux where X is a
>> +		    CPU number starting at 0.
>> +
>>  Example:
>>  
>>  	clock-controller@2088000 {
>>  		compatible = "qcom,kpss-acc-v2";
>>  		reg = <0x02088000 0x1000>,
>>  		      <0x02008000 0x1000>;
>> +		clock-output-names = "acpu0_aux";
>>  	};
>> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
>> new file mode 100644
>> index 0000000..d1e12f1
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
>> @@ -0,0 +1,28 @@
>> +Krait Processor Sub-system (KPSS) Global Clock Controller (GCC)
>> +
>> +PROPERTIES
>> +
>> +- compatible:
>> +	Usage: required
>> +	Value type: <string>
>> +	Definition: should be one of:
>> +			"qcom,kpss-gcc"
> 
> Only one implementation?

 hmm, missed "qcom,kpss-acc-v1", will add that too.
 
Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus
