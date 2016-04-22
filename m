From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH 10/11] arm64: tegra: Add clock properties on cpu0 for
 Tegra210
Date: Fri, 22 Apr 2016 14:36:50 +0100
Message-ID: <571A28F2.5070203@nvidia.com>
References: <1461321071-6431-1-git-send-email-pchiu@nvidia.com>
 <1461321071-6431-11-git-send-email-pchiu@nvidia.com>
 <571A0E95.9040203@nvidia.com> <20160422132325.GN9047@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:2774 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125AbcDVNg5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Apr 2016 09:36:57 -0400
In-Reply-To: <20160422132325.GN9047@ulmo.ba.sec>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Penny Chiu <pchiu@nvidia.com>, swarren@wwwdotorg.org, gnurou@gmail.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, mturquette@baylibre.com, sboyd@codeaurora.org, linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org, linux-pwm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org


On 22/04/16 14:23, Thierry Reding wrote:
> * PGP Signed by an unknown key
> 
> On Fri, Apr 22, 2016 at 12:44:21PM +0100, Jon Hunter wrote:
>> Hi Penny,
>>
>> On 22/04/16 11:31, Penny Chiu wrote:
>>> Add clocks, clock-names, and clock-latency into cpu0 node.
>>> These properties will be used by cpufreq driver.
>>>
>>> Signed-off-by: Penny Chiu <pchiu@nvidia.com>
>>> ---
>>>  arch/arm64/boot/dts/nvidia/tegra210.dtsi | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
>>> index 204d9cd..1a85857 100644
>>> --- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
>>> +++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
>>> @@ -782,6 +782,12 @@
>>>  			device_type = "cpu";
>>>  			compatible = "arm,cortex-a57";
>>>  			reg = <0>;
>>> +			clocks = <&tegra_car TEGRA210_CLK_CCLK_G>,
>>> +				 <&tegra_car TEGRA210_CLK_PLL_X>,
>>> +				 <&tegra_car TEGRA210_CLK_PLL_P_OUT4>,
>>> +				 <&dfll>;
>>> +			clock-names = "cpu_g", "pll_x", "pll_p", "dfll";
>>> +			clock-latency = <300000>;
>>>  		};
>>>  
>>>  		cpu@1 {
>>>
>>
>> Can you include a patch with this series to update the binding
>> documentation for the nvidia,tegra124-cpufreq.txt? I think that although
>> there is no specific nvidia,tegra210-cpufreq compatible string the
>> documentation should state that both tegra124 and tegra210 are supported
>> so it is clear.
>>
>> Also I see the above binding no longer includes the "cpu_lp" for
>> tegra210 which I understand we don't use here. However, the binding
>> documentation should reflect this. Having said that, looking at the
>> driver it appears the "cpu_lp" clock is not even used for tegra124. I
>> wonder if we should drop this from the binding documentation and the
>> tegra124.dtsi altogether?
>>
>> What about the "vdd-cpu-supply" property? Don't we need this?
> 
> For some reason that seems to have moved into the clock@70110000 node.

Yes I saw that. I surprised that the cpufreq driver would probe without
this, unless I am missing something ...

Jon
