From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH v3 00/13] Krait clocks + Krait CPUfreq
Date: Fri, 20 Mar 2015 23:45:19 -0700
Message-ID: <1426920332-9340-1-git-send-email-sboyd@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

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

I plan to submit the DTS changes through arm-soc, but I've included everything
here to make it easier to pick things up for testing, etc. If anything can be
picked up right now it would be better to reduce the churn over time as
other pieces settle. Some things are not done, but I'm posting this now
to get it out there and because the clock framework patches needed some rework
due to recent changes.

Changes since v2:
 * Switched to cpufreq-dt
 * Ported over PVS binding
 * Stripped out cpu logical map to make modules work
 * Dropped patches that merged upstream

Changes since v1:
 * Added IPQ and APQ8064 support
 * Switched to cpufreq-generic
 * Added OPP parsing from DT (need to write binding though)
 * New patches to make clk-generic.c go away
  * Made mux and divider reusable for non-MMIO devices
  * Added a mux_determine_rate_closest (not sure if this is really needed)
  * Added unregistration of muxes
 * New patch to avoid sending high frequencies down to devices using clocks

TODO:
 * Add Krait regulator voltage scaling (not strictly necessary)
 * Add some thermal awareness
 * Use efuse/eeprom API instead of hardcoding the location in the driver
 * Figure out how to express number of CPUs without relying on linux's
   concept of number of CPUs and logical CPU mapping
 * Trim down the probe code for krait-cc so that we just register clocks
   and don't enable or set rates

Stephen Boyd (13):
  ARM: Add Krait L2 register accessor functions
  clk: mux: Split out register accessors for reuse
  clk: Avoid sending high rates to downstream clocks during set_rate
  clk: Add safe switch hook
  clk: qcom: Add support for High-Frequency PLLs (HFPLLs)
  clk: qcom: Add HFPLL driver
  clk: qcom: Add MSM8960/APQ8064's HFPLLs
  clk: qcom: Add IPQ806X's HFPLLs
  clk: qcom: Add support for Krait clocks
  clk: qcom: Add KPSS ACC/GCC driver
  clk: qcom: Add Krait clock controller driver
  cpufreq: Add module to register cpufreq on Krait CPUs
  ARM: dts: qcom: Add necessary DT data for Krait cpufreq

 .../devicetree/bindings/arm/msm/qcom,kpss-acc.txt  |   7 +
 .../devicetree/bindings/arm/msm/qcom,kpss-gcc.txt  |  28 ++
 .../devicetree/bindings/arm/msm/qcom,pvs.txt       |  38 +++
 .../devicetree/bindings/clock/qcom,hfpll.txt       |  40 +++
 .../devicetree/bindings/clock/qcom,krait-cc.txt    |  22 ++
 arch/arm/boot/dts/qcom-apq8064.dtsi                | 230 ++++++++++++++
 arch/arm/boot/dts/qcom-msm8960.dtsi                |  49 +++
 arch/arm/boot/dts/qcom-msm8974.dtsi                | 311 +++++++++++++++++-
 arch/arm/common/Kconfig                            |   3 +
 arch/arm/common/Makefile                           |   1 +
 arch/arm/common/krait-l2-accessors.c               |  58 ++++
 arch/arm/include/asm/krait-l2-accessors.h          |  20 ++
 drivers/clk/clk-mux.c                              |  76 +++--
 drivers/clk/clk.c                                  |  95 ++++--
 drivers/clk/qcom/Kconfig                           |  28 ++
 drivers/clk/qcom/Makefile                          |   5 +
 drivers/clk/qcom/clk-hfpll.c                       | 253 +++++++++++++++
 drivers/clk/qcom/clk-hfpll.h                       |  54 ++++
 drivers/clk/qcom/clk-krait.c                       | 166 ++++++++++
 drivers/clk/qcom/clk-krait.h                       |  49 +++
 drivers/clk/qcom/gcc-ipq806x.c                     |  83 +++++
 drivers/clk/qcom/gcc-msm8960.c                     | 172 ++++++++++
 drivers/clk/qcom/hfpll.c                           | 109 +++++++
 drivers/clk/qcom/kpss-xcc.c                        |  95 ++++++
 drivers/clk/qcom/krait-cc.c                        | 352 +++++++++++++++++++++
 drivers/cpufreq/Kconfig.arm                        |   9 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/qcom-cpufreq.c                     | 204 ++++++++++++
 include/dt-bindings/clock/qcom,gcc-msm8960.h       |   2 +
 include/linux/clk-provider.h                       |  10 +-
 30 files changed, 2515 insertions(+), 55 deletions(-)
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
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
