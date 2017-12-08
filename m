From: Sricharan R <sricharan@codeaurora.org>
Subject: Re: [PATCH v4 00/12] Krait clocks + Krait CPUfreq
Date: Fri, 8 Dec 2017 15:04:53 +0530
Message-ID: <e107cb2c-c334-fd5a-5a99-c994a4c512ab@codeaurora.org>
References: <1512725401-4944-1-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1512725401-4944-1-git-send-email-sricharan@codeaurora.org>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: mturquette@baylibre.com, sboyd@codeaurora.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

oops, got Mike's id wrong. Will just re-post fixing his id.

On 12/8/2017 2:59 PM, Sricharan R wrote:
> Mostly a resend of the v3 posted by Stephen quite some time back [1]
> except for few changes.
>   Based on reading some feedback from list,
>   * Dropped the patch "clk: Add safe switch hook" from v3 [2].
>     Now this is taken care by patch#10 in this series only for Krait.
>   * Dropped the path "clk: Avoid sending high rates to downstream
> 		      clocks during set_rate" from v3 [3].
>   * Rebased on top of clk-next.
>   * Dropped the DT update from the series. Will send seperately
>   * Now with cpufreq-dt+opp supporting voltage scaling, registering the
>     krait cpu supplies in DT should be sufficient. But one issue is,
>     the qcom-cpufreq drivers reads the efuse and based on that registers
>     the opp data and then registers the cpufreq-dt device. So when
>     cpufreq-dt driver probes and registers the regulator to the OPP framework,
>     it expects that the opp data for the device should not be registered before
>     the regulator. Will send a RFC patch removing that check, to find out the
>     right way of doing it.
> 
> These patches provide cpufreq scaling on devices with Krait CPUs.
> In Krait CPU designs there's one PLL and two muxes per CPU, allowing
> us to switch CPU frequencies independently.
> 
> 				 secondary
> 	 +-----+                    +
> 	 | QSB |-------+------------|\
> 	 +-----+       |            | |-+
> 		       |    +-------|/  |
> 		       |    |       +   |
> 	 +-----+       |    |           |
> 	 | PLL |----+-------+           |   primary
> 	 +-----+    |  |                |     +
> 		    |  |                +-----|\       +------+
> 	 +-------+  |  |                      | \      |      |
> 	 | HFPLL |----------+-----------------|  |-----| CPU0 |
> 	 +-------+  |  |    |                 |  |     |      |
> 		    |  |    | +-----+         | /      +------+
> 		    |  |    +-| / 2 |---------|/
> 		    |  |      +-----+         +
> 		    |  |         secondary
> 		    |  |            +
> 		    |  +------------|\
> 		    |               | |-+
> 		    +---------------|/  |   primary
> 				    +   |     +
> 					+-----|\       +------+
> 	 +-------+                            | \      |      |
> 	 | HFPLL |----------------------------|  |-----| CPU1 |
> 	 +-------+          |                 |  |     |      |
> 			    | +-----+         | /      +------+
> 			    +-| / 2 |---------|/
> 			      +-----+         +
> 
> To support this in the common clock framework we model the muxes,
> dividers, and PLLs as different clocks. CPUfreq only interacts
> with the primary mux (farthest right in the diagram). When CPUfreq
> sets a rate, the mux code finds the best parent that can provide the rate.
> Due to the design, QSB and the top PLL are always a fixed rate and thus
> only support one frequency each. These sources provide the lowest
> frequencies for the CPUs. The HFPLLs are where we can make the CPU go
> faster (GHz range). Sometimes we need to run the HFPLL twice as
> fast and divide it by two to get a particular frequency.
> 
> When switching rates we can't leave the CPU clocked by the HFPLL because
> we need to turn off the output of the PLL when changing its frequency.
> This means we have to switch over to the secondary mux and use one of the
> fixed sources. This is why we need something like the safe parent patch.
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/332607.html
> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/332615.html
> [3] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/332608.html
> 
> Sricharan R (2):
>   clk: qcom: Add safe switch hook for krait mux clocks
>   cpufreq: dt: Reintroduce independent_clocks platform data
> 
> Stephen Boyd (10):
>   ARM: Add Krait L2 register accessor functions
>   clk: mux: Split out register accessors for reuse
>   clk: qcom: Add support for High-Frequency PLLs (HFPLLs)
>   clk: qcom: Add HFPLL driver
>   clk: qcom: Add MSM8960/APQ8064's HFPLLs
>   clk: qcom: Add IPQ806X's HFPLLs
>   clk: qcom: Add support for Krait clocks
>   clk: qcom: Add KPSS ACC/GCC driver
>   clk: qcom: Add Krait clock controller driver
>   cpufreq: Add module to register cpufreq on Krait CPUs
> 
>  .../devicetree/bindings/arm/msm/qcom,kpss-acc.txt  |   7 +
>  .../devicetree/bindings/arm/msm/qcom,kpss-gcc.txt  |  28 ++
>  .../devicetree/bindings/arm/msm/qcom,pvs.txt       |  38 ++
>  .../devicetree/bindings/clock/qcom,hfpll.txt       |  40 ++
>  .../devicetree/bindings/clock/qcom,krait-cc.txt    |  22 ++
>  arch/arm/common/Kconfig                            |   3 +
>  arch/arm/common/Makefile                           |   1 +
>  arch/arm/common/krait-l2-accessors.c               |  58 +++
>  arch/arm/include/asm/krait-l2-accessors.h          |  20 +
>  drivers/clk/clk-mux.c                              |  75 ++--
>  drivers/clk/qcom/Kconfig                           |  28 ++
>  drivers/clk/qcom/Makefile                          |   5 +
>  drivers/clk/qcom/clk-hfpll.c                       | 253 +++++++++++++
>  drivers/clk/qcom/clk-hfpll.h                       |  54 +++
>  drivers/clk/qcom/clk-krait.c                       | 136 +++++++
>  drivers/clk/qcom/clk-krait.h                       |  51 +++
>  drivers/clk/qcom/gcc-ipq806x.c                     |  82 +++++
>  drivers/clk/qcom/gcc-msm8960.c                     | 172 +++++++++
>  drivers/clk/qcom/hfpll.c                           | 106 ++++++
>  drivers/clk/qcom/kpss-xcc.c                        |  96 +++++
>  drivers/clk/qcom/krait-cc.c                        | 406 +++++++++++++++++++++
>  drivers/cpufreq/Kconfig.arm                        |   9 +
>  drivers/cpufreq/Makefile                           |   1 +
>  drivers/cpufreq/cpufreq-dt.c                       |   7 +-
>  drivers/cpufreq/cpufreq-dt.h                       |   6 +
>  drivers/cpufreq/qcom-cpufreq.c                     | 204 +++++++++++
>  include/dt-bindings/clock/qcom,gcc-msm8960.h       |   2 +
>  include/linux/clk-provider.h                       |   9 +-
>  28 files changed, 1888 insertions(+), 31 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,pvs.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,hfpll.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
>  create mode 100644 arch/arm/common/krait-l2-accessors.c
>  create mode 100644 arch/arm/include/asm/krait-l2-accessors.h
>  create mode 100644 drivers/clk/qcom/clk-hfpll.c
>  create mode 100644 drivers/clk/qcom/clk-hfpll.h
>  create mode 100644 drivers/clk/qcom/clk-krait.c
>  create mode 100644 drivers/clk/qcom/clk-krait.h
>  create mode 100644 drivers/clk/qcom/hfpll.c
>  create mode 100644 drivers/clk/qcom/kpss-xcc.c
>  create mode 100644 drivers/clk/qcom/krait-cc.c
>  create mode 100644 drivers/cpufreq/qcom-cpufreq.c
> 

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus
