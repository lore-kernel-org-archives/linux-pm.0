From: Sricharan R <sricharan@codeaurora.org>
Subject: Re: [PATCH v5 15/15] devicetree: bindings: Document qcom,pvs
Date: Wed, 20 Dec 2017 11:55:33 +0530
Message-ID: <b0d8147a-46e1-0787-ae37-9c1ef957d190@codeaurora.org>
References: <1513698900-10638-1-git-send-email-sricharan@codeaurora.org>
 <1513698900-10638-16-git-send-email-sricharan@codeaurora.org>
 <20171220032614.GQ19815@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20171220032614.GQ19815@vireshk-i7>
Content-Language: en-US
Sender: linux-clk-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Viresh,

On 12/20/2017 8:56 AM, Viresh Kumar wrote:
> On 19-12-17, 21:25, Sricharan R wrote:
>> +	cpu@0 {
>> +		compatible = "qcom,krait";
>> +		enable-method = "qcom,kpss-acc-v1";
>> +		device_type = "cpu";
>> +		reg = <0>;
>> +		qcom,acc = <&acc0>;
>> +		qcom,saw = <&saw0>;
>> +		clocks = <&kraitcc 0>;
>> +		clock-names = "cpu";
>> +		cpu-supply = <&smb208_s2a>;
>> +		operating-points-v2 = <&cpu_opp_table>;
>> +	};
>> +
>> +	qcom,pvs {
>> +		qcom,pvs-format-a;
>> +	};
> 
> Not sure what Rob is going to say on that :)
> 

 Yes. Would be good to know the best way.

>> +
>> +
>> +	cpu_opp_table: opp_table {
>> +		compatible = "operating-points-v2";
>> +
>> +		/*
>> +		 * Missing opp-shared property means CPUs switch DVFS states
>> +		 * independently.
>> +		 */
>> +
>> +		opp-1400000000 {
>> +			opp-hz = /bits/ 64 <1400000000>;
>> +			opp-microvolt-speed0-pvs0-v0 = <1250000>;
> 
> Why speed0 and v0 in all the names ?
> 

 Ya, all the three (speed, pvs and version) are read from efuse. So all the three
 can vary.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
