From: Sricharan R <sricharan@codeaurora.org>
Subject: Re: [PATCH v10 00/14] Krait clocks + Krait CPUfreq
Date: Thu, 28 Jun 2018 09:59:13 +0530
Message-ID: <410263b4-9434-ed49-626d-2a14efe350f0@codeaurora.org>
References: <1529415925-28915-1-git-send-email-sricharan@codeaurora.org>
 <a58c2d2c-64d1-7223-dc98-8f749397375d@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a58c2d2c-64d1-7223-dc98-8f749397375d@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Escande <thierry.escande@linaro.org>
Cc: robh@kernel.org, viresh.kumar@linaro.org, mark.rutland@arm.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, ctatlor97@gmail.com
List-Id: linux-pm@vger.kernel.org

Hi Thierry,

On 6/27/2018 3:01 PM, Thierry Escande wrote:
> Hi Sricharan,
> 
> On 19/06/2018 15:45, Sricharan R wrote:
>> Sricharan R (2):
>>    clk: qcom: Add safe switch hook for krait mux clocks
>>    dt-bindings: cpufreq: Document operating-points-v2-krait-cpu
>>
>> Stephen Boyd (12):
>>    ARM: Add Krait L2 register accessor functions
>>    clk: qcom: Add support for High-Frequency PLLs (HFPLLs)
>>    clk: qcom: Add HFPLL driver
>>    dt-bindings: clock: Document qcom,hfpll
>>    clk: qcom: Add MSM8960/APQ8064's HFPLLs
>>    clk: qcom: Add IPQ806X's HFPLLs
>>    clk: qcom: Add support for Krait clocks
>>    clk: qcom: Add KPSS ACC/GCC driver
>>    dt-bindings: arm: Document qcom,kpss-gcc
>>    clk: qcom: Add Krait clock controller driver
>>    dt-bindings: clock: Document qcom,krait-cc
>>    cpufreq: Add module to register cpufreq on Krait CPUs
> 
> Tested on apq8064 (db600c).
> 
> Tested-By: Thierry Escande <thierry.escande@linaro.org>
> 

  Thanks for testing this !!
  I Will try to merge the kryo cpu-freq and this one if that looks neat.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
