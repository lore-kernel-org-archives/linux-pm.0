From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v6 13/14] dt-bindings: cpufreq: Document
 operating-points-v2-kryo-cpu
Date: Tue, 15 May 2018 09:39:50 +0530
Message-ID: <20180515040950.otlennfyfvuujyfc@vireshk-i7>
References: <1526303520-5843-1-git-send-email-ilialin@codeaurora.org>
 <1526303520-5843-14-git-send-email-ilialin@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1526303520-5843-14-git-send-email-ilialin@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilia Lin <ilialin@codeaurora.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, mark.rutland@arm.com, nm@ti.com, lgirdwood@gmail.com, broonie@kernel.org, andy.gross@linaro.org, david.brown@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rnayak@codeaurora.org, amit.kucheria@linaro.org, nicolas.dechesne@linaro.org, celster@codeaurora.org, tfinkel@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On 14-05-18, 16:11, Ilia Lin wrote:
> In Certain Qualcomm Technologies, Inc. SoCs like apq8096 and msm8996
> that have KRYO processors, the CPU ferequencies subset and voltage value
> of each OPP varies based on the silicon variant in use.
> Qualcomm Technologies, Inc. Process Voltage Scaling Tables
> defines the voltage and frequency value based on the msm-id in SMEM
> and speedbin blown in the efuse combination.
> The qcom-cpufreq-kryo driver reads the msm-id and efuse value from the SoC
> to provide the OPP framework with required information.
> This is used to determine the voltage and frequency value for each OPP of
> operating-points-v2 table when it is parsed by the OPP framework.
> 
> This change adds documentation.
> 
> Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> ---
>  .../devicetree/bindings/opp/kryo-cpufreq.txt       | 680 +++++++++++++++++++++
>  1 file changed, 680 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/opp/kryo-cpufreq.txt

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
