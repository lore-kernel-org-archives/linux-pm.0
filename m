From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [RFC v2 12/12] ARM64: dts: Define CPU power domain for MSM8916
Date: Tue, 1 Mar 2016 12:41:49 -0700
Message-ID: <20160301194149.GP1440@linaro.org>
References: <1455310238-8963-1-git-send-email-lina.iyer@linaro.org>
 <1455310238-8963-13-git-send-email-lina.iyer@linaro.org>
 <20160226195035.GA28849@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160226195035.GA28849@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 26 2016 at 12:50 -0700, Stephen Boyd wrote:
>On 02/12, Lina Iyer wrote:
>> @@ -101,6 +105,27 @@
>>  		};
>>  	};
>>
>> +	CPU_PD: cpu-pd@0 {
>> +		#power-domain-cells = <0>;
>> +		power-states = <&CLUSTER_RET>, <&CLUSTER_PWR_DWN>;
>
>Why isn't this part of the psci node? PSCI is the node that's
>providing the code/logic for the power domain.
>
I like that idea too. 
Lorenzo, what do you think?

>> +	};
>> +
>> +	pd-power-states {
>> +		CLUSTER_RET: power-state@1 {
>> +			state-param = <0x1000010>;
>> +			entry-latency-us = <500>;
>> +			exit-latency-us = <500>;
>> +			residency-us = <2000>;
>> +		 };
>> +
>> +		CLUSTER_PWR_DWN: power-state@2 {
>> +			state-param = <0x1000030>;
>> +			entry-latency-us = <2000>;
>> +			exit-latency-us = <2000>;
>> +			residency-us = <6000>;
>> +		};
>> +	};
>> +
>
>And I would expect these to be put somewhere inside the power
>domain provider as well? Is this documented somewhere?
>
Not yet, they will be, when it is submitted. This the glue patch that I
use on top of Axel's series to read domain states from DT, instead of
defining with the driver.

I have to discuss with Ulf, as to who is submitting that patch.

Thanks,
Lina

>>  	psci {
>>  		compatible = "arm,psci-1.0";
>>  		method = "smc";
>
>-- 
>Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
>a Linux Foundation Collaborative Project
