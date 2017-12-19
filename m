From: Sricharan R <sricharan@codeaurora.org>
Subject: [PATCH v5 00/15] Krait clocks + Krait CPUfreq
Date: Tue, 19 Dec 2017 21:24:45 +0530
Message-ID: <1513698900-10638-1-git-send-email-sricharan@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc: sricharan@codeaurora.org
List-Id: linux-pm@vger.kernel.org

[v5]
  * Addressed comments from Rob for bindings
  * Addressed comments from Viresh to use dev_pm_opp_set_prop_name, accordingly
    dropped patch #12 and corrected patch #11 from previous patch set in [4]
  * Converted to use #spdx tags for newly introduced files

Mostly a resend of the v3 posted by Stephen quite some time back [1]
except for few changes.
  Based on reading some feedback from list,
  * Dropped the patch "clk: Add safe switch hook" from v3 [2].
    Now this is taken care by patch#10 in this series only for Krait.
  * Dropped the path "clk: Avoid sending high rates to downstream
		      clocks during set_rate" from v3 [3].
  * Rebased on top of clk-next.
  * Dropped the DT update from the series. Will send seperately
  * Now with cpufreq-dt+opp supporting voltage scaling, registering the
    krait cpu supplies in DT should be sufficient. But one issue is,
    the qcom-cpufreq drivers reads the efuse and based on that registers
    the opp data and then registers the cpufreq-dt device. So when
    cpufreq-dt driver probes and registers the regulator to the OPP framework,
    it expects that the opp data for the device should not be registered before
    the regulator. Will send a RFC patch removing that check, to find out the
    right way of doing it.

These patches provide cpufreq scaling on devices with Krait CPUs.
In Krait CPU designs there's one PLL and two muxes per CPU, allowing
us to switch CPU frequencies independently.

				 secondary
	 +-----+                    +
	 | QSB |-------+------------|\
	 +-----+       |            | |-+
		       |    +-------|/  |
		       |    |       +   |
	 +-----+       |    |           |
	 | PLL |----+-------+           |   primary
	 +-----+    |  |                |     +
		    |  |                +-----|\       +------+
	 +-------+  |  |                      | \      |      |
	 | HFPLL |----------+-----------------|  |-----| CPU0 |
	 +-------+  |  |    |                 |  |     |      |
		    |  |    | +-----+         | /      +------+
		    |  |    +-| / 2 |---------|/
		    |  |      +-----+         +
		    |  |         secondary
		    |  |            +
		    |  +------------|\
		    |               | |-+
		    +---------------|/  |   primary
				    +   |     +
					+-----|\       +------+
	 +-------+                            | \      |      |
	 | HFPLL |----------------------------|  |-----| CPU1 |
	 +-------+          |                 |  |     |      |
			    | +-----+         | /      +------+
			    +-| / 2 |---------|/
			      +-----+         +

To support this in the common clock framework we model the muxes,
dividers, and PLLs as different clocks. CPUfreq only interacts
with the primary mux (farthest right in the diagram). When CPUfreq
sets a rate, the mux code finds the best parent that can provide the rate.
Due to the design, QSB and the top PLL are always a fixed rate and thus
only support one frequency each. These sources provide the lowest
frequencies for the CPUs. The HFPLLs are where we can make the CPU go
faster (GHz range). Sometimes we need to run the HFPLL twice as
fast and divide it by two to get a particular frequency.

When switching rates we can't leave the CPU clocked by the HFPLL because
we need to turn off the output of the PLL when changing its frequency.
This means we have to switch over to the secondary mux and use one of the
fixed sources. This is why we need something like the safe parent patch.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/332607.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/332615.html
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/332608.html
[4] https://lwn.net/Articles/740994/ 

Sricharan R (1):
  clk: qcom: Add safe switch hook for krait mux clocks

Stephen Boyd (14):
  ARM: Add Krait L2 register accessor functions
  clk: mux: Split out register accessors for reuse
  clk: qcom: Add support for High-Frequency PLLs (HFPLLs)
  clk: qcom: Add HFPLL driver
  devicetree: bindings: Document qcom,hfpll
  clk: qcom: Add MSM8960/APQ8064's HFPLLs
  clk: qcom: Add IPQ806X's HFPLLs
  clk: qcom: Add support for Krait clocks
  clk: qcom: Add KPSS ACC/GCC driver
  devicetree: bindings: Document qcom,kpss-gcc
  clk: qcom: Add Krait clock controller driver
  devicetree: bindings: Document qcom,krait-cc
  cpufreq: Add module to register cpufreq on Krait CPUs
  devicetree: bindings: Document qcom,pvs

 .../devicetree/bindings/arm/msm/qcom,kpss-acc.txt  |   7 +
 .../devicetree/bindings/arm/msm/qcom,kpss-gcc.txt  |  32 ++
 .../devicetree/bindings/arm/msm/qcom,pvs.txt       |  91 +++++
 .../devicetree/bindings/clock/qcom,hfpll.txt       |  46 +++
 .../devicetree/bindings/clock/qcom,krait-cc.txt    |  22 ++
 arch/arm/common/Kconfig                            |   3 +
 arch/arm/common/Makefile                           |   1 +
 arch/arm/common/krait-l2-accessors.c               |  48 +++
 arch/arm/include/asm/krait-l2-accessors.h          |  10 +
 drivers/clk/clk-mux.c                              |  75 ++--
 drivers/clk/qcom/Kconfig                           |  28 ++
 drivers/clk/qcom/Makefile                          |   5 +
 drivers/clk/qcom/clk-hfpll.c                       | 244 +++++++++++++
 drivers/clk/qcom/clk-hfpll.h                       |  45 +++
 drivers/clk/qcom/clk-krait.c                       | 126 +++++++
 drivers/clk/qcom/clk-krait.h                       |  41 +++
 drivers/clk/qcom/gcc-ipq806x.c                     |  82 +++++
 drivers/clk/qcom/gcc-msm8960.c                     | 172 +++++++++
 drivers/clk/qcom/hfpll.c                           |  96 +++++
 drivers/clk/qcom/kpss-xcc.c                        |  87 +++++
 drivers/clk/qcom/krait-cc.c                        | 397 +++++++++++++++++++++
 drivers/cpufreq/Kconfig.arm                        |   9 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/cpufreq-dt-platdev.c               |   3 +-
 drivers/cpufreq/qcom-cpufreq.c                     | 171 +++++++++
 include/dt-bindings/clock/qcom,gcc-msm8960.h       |   2 +
 include/linux/clk-provider.h                       |   9 +-
 27 files changed, 1822 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,pvs.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,hfpll.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
 create mode 100644 arch/arm/common/krait-l2-accessors.c
 create mode 100644 arch/arm/include/asm/krait-l2-accessors.h
 create mode 100644 drivers/clk/qcom/clk-hfpll.c
 create mode 100644 drivers/clk/qcom/clk-hfpll.h
 create mode 100644 drivers/clk/qcom/clk-krait.c
 create mode 100644 drivers/clk/qcom/clk-krait.h
 create mode 100644 drivers/clk/qcom/hfpll.c
 create mode 100644 drivers/clk/qcom/kpss-xcc.c
 create mode 100644 drivers/clk/qcom/krait-cc.c
 create mode 100644 drivers/cpufreq/qcom-cpufreq.c

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
