From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v6 0/5] QCOM 8074 cpuidle driver
Date: Tue, 23 Sep 2014 17:51:16 -0600
Message-ID: <1411516281-58328-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: galak@codeaurora.org, sboyd@codeaurora.org, daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@linaro.org, msivasub@codeaurora.org, lorenzo.pieralisi@arm.com, linux-pm@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

Changes since v5:
[ https://www.mail-archive.com/linux-arm-msm@vger.kernel.org/msg10559.html ]
- Merge spm-devices.c and spm.c into one file and one patch
	- Simplify implementation of the driver.
	- Update documentation mapping the DT properties with corresponding
	  SPM register information.
- Removed scm-boot changes for quad core warmboot, its has been pulled in.

Changes since v4:
[ https://www.mail-archive.com/linux-arm-msm@vger.kernel.org/msg10327.html ]
- Update to the v8 of ARM generic idle states patches
- Use platform device model for cpuidle-qcom
- Clean up msm-pm.c to remove unnecessary include files and functions
- Update commit text and documentation for all idle states
- Remove scm-boot relocate patch from this series, submitted earlier
[ https://www.mail-archive.com/linux-arm-msm@vger.kernel.org/msg10518.html ]

Changes since v3:
[ https://www.mail-archive.com/linux-arm-msm@vger.kernel.org/msg10288.html ]
- Fix CONFIG_QCOM_PM Kconfig as bool
- More clean ups in spm.c and spm-devices.c
	- Removed and re-organized data structures to make initialization simple
	- Remove export of sequence flush functions
	- Updated commit text
	- Comments for use of barriers.
- Rebase on top of 3.17-rc1

Changes since v2:
[ https://www.mail-archive.com/linux-arm-msm@vger.kernel.org/msg10148.html ]
- Prune all the drivers to support basic WFI and power down cpuidle
  functionality. Remove debug code.
- Integrate KConfig changes into the drivers' patches.
- Use Lorenzo's ARM idle-states patches as the basis for reading cpuidle
  c-states from DT.
  [ http://marc.info/?l=linux-pm&m=140794514812383&w=2 ]
- Incorporate review comments
- Rebase on top of 3.16

Changes since v1/RFC:
[ https://www.mail-archive.com/linux-arm-msm@vger.kernel.org/msg10065.html ]
- Remove hotplug from the patch series. Will submit it separately.
- Fix SPM drivers per the review comments
- Modify patch sequence to compile SPM drivers independent of msm-pm, so as to
  allow wfi() calls to use SPM even without SoC interface driver.

8074 like any ARM SoC can do architectural clock gating, that helps save on
power, but not enough of leakage power.  Leakage power of the SoC can be
further reduced by turning off power to the core. To aid this, every core (cpu
and L2) is accompanied by a Sub-system Power Manager (SPM), that can be
configured to indicate the low power mode, the core would be put into and the
SPM programs the peripheral h/w accordingly to enter low power and turn off the
power rail to the core.

The idle invocation hierarchy - 

	CPUIDLE
	|
	cpuidle-qcom.c [CPUIdle driver]
	|
	------>	msm-pm.c [SoC Interface layer for QCOM chipsets]
		|
		------> spm.c [SPM driver]
		|
		------> scm-boot.c [SCM interface layer]		
			|
------------------------|--------------------------
(EL)			Secure Monitor Code
			|
			|
			wfi(); 
------------------------|--------------------------
(HW)			[CPU] {clock gate}
			|
			-----> [SPM] {statemachine}
			

The patchset does the following -

- Introduce the SPM driver to control power to the core. The SPM h/w IP works
in conjunction with the Krait CPU/L2. When the core executes WFI instruction,
the core is clockgated and the SPM state machine takes over and powers the core
down. An interrupt from GIC, resumes the SPM state machine which brings the cpu
out of the low power mode.

- Add the device tree configuration for each of the SPM nodes. There is one for
each cpu. There is one for each cpu.

- Introduce the SoC driver interface layer to configure SPM per the core's idle
 state. To power down the cpu core, the SPM h/w needs to be set up correctly
to power down the core, when the core executes WFI. Linux is expected to call
into Secure Monitor to power down the core. At reset, the core will start in
seure mode and will be returned back to Linux. 

- Add CPUIDLE driver for QCOM cpus. The cpuidle driver uses the SoC interface
layer to configure the SPM to allow Krait to be powered down. The cpuidle driver
is based on ARM idle-state framework for cpuidle drivers.

- Provide device configuration for 8074 SoC. Current support is for WFI and
standalone power collapse, which powers only the core independent of the
other cores and caches.

Thanks,
Lina

Lina Iyer (5):
  qcom: spm: Add Subsystem Power Manager driver
  arm: dts: qcom: Add SPM device bindings for 8974
  qcom: msm-pm: Add cpu low power mode functions
  qcom: cpuidle: Add cpuidle driver for QCOM cpus
  arm: dts: qcom: Add idle states device nodes for 8974

 .../bindings/arm/msm/qcom,idle-state.txt           |  72 ++++
 Documentation/devicetree/bindings/arm/msm/spm.txt  |  43 +++
 arch/arm/boot/dts/qcom-msm8974-pm.dtsi             |  69 ++++
 arch/arm/boot/dts/qcom-msm8974.dtsi                |  30 +-
 drivers/cpuidle/Kconfig.arm                        |   7 +
 drivers/cpuidle/Makefile                           |   1 +
 drivers/cpuidle/cpuidle-qcom.c                     |  89 +++++
 drivers/soc/qcom/Kconfig                           |   8 +
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/msm-pm.c                          | 106 ++++++
 drivers/soc/qcom/spm.c                             | 388 +++++++++++++++++++++
 include/soc/qcom/pm.h                              |  31 ++
 include/soc/qcom/spm.h                             |  38 ++
 13 files changed, 879 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt
 create mode 100644 Documentation/devicetree/bindings/arm/msm/spm.txt
 create mode 100644 arch/arm/boot/dts/qcom-msm8974-pm.dtsi
 create mode 100644 drivers/cpuidle/cpuidle-qcom.c
 create mode 100644 drivers/soc/qcom/msm-pm.c
 create mode 100644 drivers/soc/qcom/spm.c
 create mode 100644 include/soc/qcom/pm.h
 create mode 100644 include/soc/qcom/spm.h

-- 
1.9.1
