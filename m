From: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH v3 00/15] Tegra124 CL-DVFS / DFLL clocksource, plus cpufreq
Date: Tue, 19 Aug 2014 06:33:10 +0300
Message-ID: <1408419205-10048-1-git-send-email-tuomas.tynkkynen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org, Prashant Gaikwad <pgaikwad@nvidia.com>, Mike Turquette <mturquette@linaro.org>, Vince Hsu <vinceh@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Viresh Kumar <viresh.kumar@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thierry Reding <thierry.reding@gmail.com>, Tuomas Tynkkynen <ttynkkynen@nvidia.com>, Paul Walmsley <pwalmsley@nvidia.com>
List-Id: linux-pm@vger.kernel.org

From: Tuomas Tynkkynen <ttynkkynen@nvidia.com>

v3 changes:
- Fix incorrect order of arguments to dfll_scale_dvco_rate
- Fix accidental commas at end-of-statement to semicolons
- Some cpufreq changes:
    - rename cpufreq-tegra to cpufreq-tegra20
    - have separate Kconfig entries for Tegra20/Tegra124 support
    - use 'select GENERIC_CPUFREQ_CPU0', not depends
    - support unbinding of the platform device
        - requires adding the vdd_cpu regulator to the DT so
          the old voltage can be restored when switching to PLLX
    - allocate a state structure instead of globals
    - use of_match_machine()
    - various style nits fixed

The cpufreq part is dependant on the of_match_machine() series.

Original cover letter:

This series implements the DFLL/CL-DVFS clock source for the fast CPU
cluster on Tegra124, and a cpufreq driver that uses the DFLL for
clocking the CPU. Most of this is based on Paul Walmsley's public patch
set from December 2013, which is available at
http://comments.gmane.org/gmane.linux.ports.tegra/15273

The DFLL clock hardware is a voltage-controlled oscillator plus
control logic that compares the generated output clock with a
51 MHz reference clock, and can make decisions to either lower
or raise the DFLL voltage to keep the output rate close to the
software-requested rate. The voltage changes are done by
communicating with an off-chip PMIC via either I2C or PWM.
As the DFLL oscillator is powered via the CPU rail, using
the DFLL as the CPU clocksource also gives us dynamic CPU
voltage scaling.

This series has been tested on the Jetson TK1 (Rev C). Porting this to
the Venice2 should be simple, though do note that it does not have
active cooling.

Thanks,
Tuomas


Paul Walmsley (1):
  clk: tegra: Add DFLL DVCO reset control for Tegra124

Tuomas Tynkkynen (14):
  clk: tegra: Add binding for the Tegra124 DFLL clocksource
  clk: tegra: Add library for the DFLL clock source (open-loop mode)
  clk: tegra: Add closed loop support for the DFLL
  clk: tegra: Add functions for parsing CVB tables
  clk: tegra: Add Tegra124 DFLL clocksource platform driver
  clk: tegra: Save/restore CCLKG_BURST_POLICY on suspend
  clk: tegra: Add the DFLL as a possible parent of the cclk_g clock
  ARM: tegra: Add the DFLL to Tegra124 device tree
  ARM: tegra: Enable the DFLL on the Jetson TK1
  cpufreq: tegra124: Add device tree bindings
  cpufreq: tegra: Rename tegra-cpufreq to tegra20-cpufreq
  cpufreq: Add cpufreq driver for Tegra124
  ARM: tegra: Add entries for cpufreq on Tegra124
  ARM: tegra: Add CPU regulator to the Jetson TK1 device tree

 .../bindings/clock/nvidia,tegra124-dfll.txt        |   69 +
 .../bindings/cpufreq/tegra124-cpufreq.txt          |   44 +
 arch/arm/boot/dts/tegra124-jetson-tk1.dts          |   12 +-
 arch/arm/boot/dts/tegra124.dtsi                    |   33 +-
 arch/arm/mach-tegra/Kconfig                        |    1 +
 drivers/clk/tegra/Makefile                         |    3 +
 drivers/clk/tegra/clk-dfll.c                       | 1735 ++++++++++++++++++++
 drivers/clk/tegra/clk-dfll.h                       |   55 +
 drivers/clk/tegra/clk-tegra-super-gen4.c           |    4 +-
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c         |  165 ++
 drivers/clk/tegra/clk-tegra124.c                   |   61 +
 drivers/clk/tegra/clk.h                            |    3 +
 drivers/clk/tegra/cvb.c                            |  133 ++
 drivers/clk/tegra/cvb.h                            |   67 +
 drivers/cpufreq/Kconfig.arm                        |   14 +-
 drivers/cpufreq/Makefile                           |    3 +-
 drivers/cpufreq/tegra124-cpufreq.c                 |  206 +++
 .../cpufreq/{tegra-cpufreq.c => tegra20-cpufreq.c} |    0
 18 files changed, 2601 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
 create mode 100644 Documentation/devicetree/bindings/cpufreq/tegra124-cpufreq.txt
 create mode 100644 drivers/clk/tegra/clk-dfll.c
 create mode 100644 drivers/clk/tegra/clk-dfll.h
 create mode 100644 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
 create mode 100644 drivers/clk/tegra/cvb.c
 create mode 100644 drivers/clk/tegra/cvb.h
 create mode 100644 drivers/cpufreq/tegra124-cpufreq.c
 rename drivers/cpufreq/{tegra-cpufreq.c => tegra20-cpufreq.c} (100%)

-- 
1.8.1.5
