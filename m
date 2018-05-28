From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v14 1/2] cpufreq: Add Kryo CPU scaling driver
Date: Mon, 28 May 2018 10:33:38 +0530
Message-ID: <20180528050338.p4zg6a2v5fu3oxwe@vireshk-i7>
References: <1527252112-7015-1-git-send-email-ilialin@codeaurora.org>
 <1527252112-7015-2-git-send-email-ilialin@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1527252112-7015-2-git-send-email-ilialin@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilia Lin <ilialin@codeaurora.org>
Cc: ilia.lin@gmail.com, vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, robh@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 25-05-18, 15:41, Ilia Lin wrote:
> In Certain QCOM SoCs like apq8096 and msm8996 that have KRYO processors,
> the CPU frequency subset and voltage value of each OPP varies
> based on the silicon variant in use. Qualcomm Process Voltage Scaling Tables
> defines the voltage and frequency value based on the msm-id in SMEM
> and speedbin blown in the efuse combination.
> The qcom-cpufreq-kryo driver reads the msm-id and efuse value from the SoC
> to provide the OPP framework with required information.
> This is used to determine the voltage and frequency value for each OPP of
> operating-points-v2 table when it is parsed by the OPP framework.
> 
> Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> ---
>  MAINTAINERS                          |   7 ++
>  drivers/cpufreq/Kconfig.arm          |  10 ++
>  drivers/cpufreq/Makefile             |   1 +
>  drivers/cpufreq/cpufreq-dt-platdev.c |   3 +
>  drivers/cpufreq/qcom-cpufreq-kryo.c  | 212 +++++++++++++++++++++++++++++++++++
>  5 files changed, 233 insertions(+)
>  create mode 100644 drivers/cpufreq/qcom-cpufreq-kryo.c

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
