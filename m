From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v10 00/10] cpuidle driver for QCOM SoCs: 8064, 8074, 8084
Date: Fri, 21 Nov 2014 11:03:47 -0700
Message-ID: <1416593037-27527-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

Changes since v9:
[ https://www.mail-archive.com/linux-arm-msm@vger.kernel.org/msg11714.html ]
- Address review comments on v9
Dependent patchsets - 
        https://lkml.org/lkml/2014/8/4/767
        http://www.spinics.net/lists/linux-arm-msm/msg10799.html
        http://www.spinics.net/lists/linux-arm-msm/msg10795.html

Changes since v8:
[ https://www.mail-archive.com/linux-arm-msm@vger.kernel.org/msg11473.html ]
- Flatten out the file structure - merge pm.c into spm.c after discussions
- Add a new function to set warm boot address, in scm-boot.c
- Support for 8064 (New)
- Tested on 8074, 8084. 8064 was tested with a WIP tree
- Address review comments from v8
- Looking into possiblility of  initializing the cpuidle device for a cpu,
only when the corresponding spm device is probed successfully.

Changes since v7:
[ https://www.mail-archive.com/linux-arm-msm@vger.kernel.org/msg11199.html ]
- Address review comments
- Tested on 8974 but not 8084
- WFI renamed to Standby
- Update commit text with original author and link to the downstream tree

Changes since v6:
[ https://www.mail-archive.com/linux-arm-msm@vger.kernel.org/msg11012.html ]
- SPM device nodes merged with existing SAW DT nodes
- SPM register information is handled within the driver
- Clean up from using 'msm' to 'qcom'
        - Shorten some enumerations as well
- Review comments from v6 addressed
- New: Support for 8084 SoC
        - Not tested. I do not have a board with this SoC, but the SPM
        configuration should be identical for WFI and SPC

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

8074/8084/8064 like any ARM SoC can do architectural clock gating, that helps save
on power, but not enough of leakage power.  Leakage power of the SoC can be
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
        ------> spm.c [SPM driver]
                |
                ------> scm-boot.c [SCM interface layer]
                        |
------------------------|--------------------------
(EL)                    Secure Monitor Code
                        |
                        |
                        wfi();
------------------------|--------------------------
(HW)                    [CPU] {clock gate}
                        |
                        -----> [SPM] {statemachine}


The patchset does the following -

- Introduce the SPM driver to control power to the core
- Add device bindings for 8974, 8084, 8064 CPU SPM devices
- Add cpuidle driver for QCOM cpus, using ARM generic idle state definitions.
- Add device bindings for 8974, 8084, 8064 idle-states - WFI and SPC

Thanks,
Lina

Lina Iyer (10):
  qom: scm: Move scm-boot files to drivers/soc/qcom/ and
    include/soc/qcom
  qcom: scm: Add SCM warmboot support for quad core SoCs
  qcom: spm: Add Subsystem Power Manager driver
  arm: dts: qcom: Add power-controller device node for 8074 Krait CPUs
  arm: dts: qcom: Add power-controller device node for 8084 Krait CPUs
  arm: dts: qcom: Update power-controller device node for 8064 Krait
    CPUs
  qcom: cpuidle: Add cpuidle driver for QCOM cpus
  arm: dts: qcom: Add idle states device nodes for 8074
  arm: dts: qcom: Add idle states device nodes for 8084
  arm: dts: qcom: Add idle state device nodes for 8064

 .../bindings/arm/msm/qcom,idle-state.txt           |  81 +++++
 .../devicetree/bindings/arm/msm/qcom,saw2.txt      |  31 +-
 arch/arm/boot/dts/qcom-apq8064.dtsi                |  37 ++-
 arch/arm/boot/dts/qcom-apq8084.dtsi                |  46 ++-
 arch/arm/boot/dts/qcom-msm8974.dtsi                |  46 ++-
 arch/arm/mach-qcom/Makefile                        |   1 -
 arch/arm/mach-qcom/platsmp.c                       |   2 +-
 drivers/cpuidle/Kconfig.arm                        |   7 +
 drivers/cpuidle/Makefile                           |   1 +
 drivers/cpuidle/cpuidle-qcom.c                     |  72 +++++
 drivers/soc/qcom/Kconfig                           |   8 +
 drivers/soc/qcom/Makefile                          |   3 +-
 .../arm/mach-qcom => drivers/soc/qcom}/scm-boot.c  |  33 +-
 drivers/soc/qcom/spm.c                             | 332 +++++++++++++++++++++
 include/soc/qcom/pm.h                              |  31 ++
 .../arm/mach-qcom => include/soc/qcom}/scm-boot.h  |   3 +-
 16 files changed, 712 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt
 create mode 100644 drivers/cpuidle/cpuidle-qcom.c
 rename {arch/arm/mach-qcom => drivers/soc/qcom}/scm-boot.c (63%)
 create mode 100644 drivers/soc/qcom/spm.c
 create mode 100644 include/soc/qcom/pm.h
 rename {arch/arm/mach-qcom => include/soc/qcom}/scm-boot.h (91%)

-- 
2.1.0
