From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH v5 11/11] arm64: dts: msm8996: Add thermal zones, tsens
 and qfprom nodes
Date: Thu, 05 May 2016 10:17:51 +0530
Message-ID: <572AD077.507@codeaurora.org>
References: <1460626319-14516-1-git-send-email-rnayak@codeaurora.org> <1460626319-14516-12-git-send-email-rnayak@codeaurora.org> <20160428000346.GE2590@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20160428000346.GE2590@localhost.localdomain>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rui.zhang@intel.com, sboyd@codeaurora.org, nrajan@codeaurora.org, lina.iyer@linaro.org, punit.agrawal@arm.com, Andy Gross <agross@codeaurora.org>
List-Id: linux-pm@vger.kernel.org


On 04/28/2016 05:33 AM, Eduardo Valentin wrote:
> On Thu, Apr 14, 2016 at 03:01:59PM +0530, Rajendra Nayak wrote:
>> Add thermal zones, tsens and qfprom nodes
>>
>> Cc: Andy Gross <agross@codeaurora.org>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> ---
>>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 92 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 92 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
>> index 0506fb8..4b36929 100644
>> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
>> @@ -97,6 +97,92 @@
>>  		};
>>  	};
>>  
>> +	thermal-zones {
>> +		cpu-thermal0 {
>> +			polling-delay-passive = <250>;
>> +			polling-delay = <1000>;
>> +
>> +			thermal-sensors = <&tsens0 3>;
>> +
>> +			trips {
>> +				cpu_alert0: trip@0 {
>> +					temperature = <75000>;
>> +					hysteresis = <2000>;
>> +					type = "passive";
>> +				};
>> +
>> +				cpu_crit0: trip@1 {
>> +					temperature = <110000>;
>> +					hysteresis = <2000>;
>> +					type = "critical";
>> +				};
> 
> 
> cooling devices?

We are still missing cpufreq support for these devices upstream

> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
