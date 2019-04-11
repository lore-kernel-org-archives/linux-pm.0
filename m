From: Sibi Sankar <sibis@codeaurora.org>
Subject: Re: [PATCH RFC 0/9] Add CPU based scaling support to Passive governor
Date: Thu, 11 Apr 2019 12:32:00 +0530
Message-ID: <08c3cff8c39e3d82e044db93e992da72@codeaurora.org>
References: <20190328152822.532-1-sibis@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190328152822.532-1-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, andy.gross@linaro.org, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org, georgi.djakov@linaro.org
Cc: bjorn.andersson@linaro.org, david.brown@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, rnayak@codeaurora.org, cw00.choi@samsung.com, linux-pm@vger.kernel.org, evgreen@chromium.org, daidavid1@codeaurora.org, dianders@chromium.org
List-Id: linux-pm@vger.kernel.org

On 2019-03-28 20:58, Sibi Sankar wrote:
> This RFC series aims to add cpu based scaling support to the passive
> governor and scale DDR with a generic interconnect bandwidth based
> devfreq driver on SDM845 SoC. This series achieves similar 
> functionality
> to Georgi's Patch series (https://patchwork.kernel.org/cover/10850817/)
> and can be used with MSM8916/MSM8996/QCS404 SoCs.
> 
> [patches 1,6 - Add and export export helpers to get avg/peak bandwidth 
> and
>  update voltage of an disabled opp respectively]
> 
> [patch 3 - Adds cpu based scaling support to passive governor]
> To achieve this, it listens to CPU frequency transition notifiers
> to keep itself up to date on the current CPU frequency.
> To decide the frequency of the device, the governor depends one of
> the following:
> * Constructs a CPU frequency to device frequency mapping table from
>   required-opps property of the devfreq device's opp_table
> * Scales the device frequency in proportion to the CPU frequency by
>   performing interpolation.

Had a discussion with Viresh and Georgi,
Viresh pointed out cpu based scaling can
be done in a better way by placing the
required-opps in the cpu opp table and
with some changes in the core so dropping
the idea of cpufreq integration into passive
governor for now.

> 
> [patch 7 - Parses and updates opps from the frequency/voltage read from
>  the look up tables]
> 
> The patch series depends on opp-bw-MBs bindings introduced in:
> https://patchwork.kernel.org/cover/10850817/
> 
> Saravana Kannan (2):
>   PM / devfreq: Add cpu based scaling support to passive_governor
>   PM / devfreq: Add devfreq driver for interconnect bandwidth voting
> 
> Sibi Sankar (7):
>   OPP: Add and export helpers to get avg/peak bw
>   OPP: Export a number of helpers to prevent code duplication
>   dt-bindings: devfreq: Add bindings for devfreq dev-icbw driver
>   OPP: Add and export helper to update voltage
>   cpufreq: qcom: Add support to update cpu node's OPP tables
>   arm64: dts: qcom: sdm845: Add cpu OPP tables
>   arm64: dts: qcom: sdm845: Add nodes for icbw driver and opp tables
> 
>  .../devicetree/bindings/devfreq/icbw.txt      | 146 +++++++++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi          | 262 +++++++++++++++++
>  drivers/cpufreq/qcom-cpufreq-hw.c             |  29 +-
>  drivers/devfreq/Kconfig                       |  19 ++
>  drivers/devfreq/Makefile                      |   1 +
>  drivers/devfreq/devfreq_icbw.c                | 132 +++++++++
>  drivers/devfreq/governor_passive.c            | 276 +++++++++++++++++-
>  drivers/opp/core.c                            | 100 +++++++
>  drivers/opp/of.c                              |  13 +-
>  include/linux/devfreq.h                       |  43 ++-
>  include/linux/pm_opp.h                        |  35 +++
>  11 files changed, 1044 insertions(+), 12 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/icbw.txt
>  create mode 100644 drivers/devfreq/devfreq_icbw.c

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
