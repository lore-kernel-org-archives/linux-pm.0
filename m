From: Sricharan R <sricharan@codeaurora.org>
Subject: Re: [PATCH v5 15/15] devicetree: bindings: Document qcom,pvs
Date: Wed, 20 Dec 2017 12:11:54 +0530
Message-ID: <62ac9ad8-2b96-476d-c07f-315c646e2cff@codeaurora.org>
References: <1513698900-10638-1-git-send-email-sricharan@codeaurora.org>
 <1513698900-10638-16-git-send-email-sricharan@codeaurora.org>
 <20171220032614.GQ19815@vireshk-i7>
 <b0d8147a-46e1-0787-ae37-9c1ef957d190@codeaurora.org>
 <20171220062712.GV19815@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20171220062712.GV19815@vireshk-i7>
Content-Language: en-US
Sender: linux-clk-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Viresh,

On 12/20/2017 11:57 AM, Viresh Kumar wrote:
> On 20-12-17, 11:55, Sricharan R wrote:
>>>> +		opp-1400000000 {
>>>> +			opp-hz = /bits/ 64 <1400000000>;
>>>> +			opp-microvolt-speed0-pvs0-v0 = <1250000>;
>>>
>>> Why speed0 and v0 in all the names ?
>>>
>>
>>  Ya, all the three (speed, pvs and version) are read from efuse. So all the three
>>  can vary.
> 
> Okay, so may be in the example you should have a mix of all the
> combinations to show how these things work ? You only showed values
> for a single efuse configuration currently.
> 

 Ha ok. Will add other examples as well.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
