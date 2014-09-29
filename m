From: Pramod Gurav <pramod.gurav@smartplayin.com>
Subject: Re: [PATCH v7 0/7] QCOM 8974 and 8084 cpuidle driver
Date: Mon, 29 Sep 2014 17:51:42 +0530
Message-ID: <54294ED6.9030105@smartplayin.com>
References: <1411779495-39724-1-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1411779495-39724-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org
List-Id: linux-pm@vger.kernel.org

Hi Lina,

Thanks for the patches. Tested these patches on my Dragonboard APQ8074
and with cpuidle tests from Linaro. They all pass.

And the proper names of the cpuidle state (wfi and spc) are also
reflecting in sysfs.

Tested-by: pramod.gurav@smartplayin.com.

Thanks
Pramod
On Saturday 27 September 2014 06:28 AM, Lina Iyer wrote:
> Changes since v6:
> [ https://www.mail-archive.com/linux-arm-msm@vger.kernel.org/msg11012.html ]
> - SPM device nodes merged with existing SAW DT nodes
> - SPM register information is handled within the driver
> - Clean up from using 'msm' to 'qcom'
> 	- Shorten some enumerations as well
> - Review comments from v6 addressed
> - New: Support for 8084 SoC
> 	- Not tested. I do not have a board with this SoC, but the SPM
> 	configuration should be identical for WFI and SPC
> 
> Changes since v5:
> [ https://www.mail-archive.com/linux-arm-msm@vger.kernel.org/msg10559.html ]
> - Merge spm-devices.c and spm.c into one file and one patch
> 	- Simplify implementation of the driver.
> 	- Update documentation mapping the DT properties with corresponding
> 	  SPM register information.
> - Removed scm-boot changes for quad core warmboot, its has been pulled in.
> 
> Changes since v4:
> [ https://www.mail-archive.com/linux-arm-msm@vger.kernel.org/msg10327.html ]
> - Update to the v8 of ARM generic idle states patches
> - Use platform device model for cpuidle-qcom
> - Clean up msm-pm.c to remove unnecessary include files and functions
> - Update commit text and documentation for all idle states
> - Remove scm-boot relocate patch from this series, submitted earlier
> [ https://www.mail-archive.com/linux-arm-msm@vger.kernel.org/msg10518.html ]
> 
> Changes since v3:
> [ https://www.mail-archive.com/linux-arm-msm@vger.kernel.org/msg10288.html ]
> - Fix CONFIG_QCOM_PM Kconfig as bool
> - More clean ups in spm.c and spm-devices.c
> 	- Removed and re-organized data structures to make initialization simple
> 	- Remove export of sequence flush functions
> 	- Updated commit text
> 	- Comments for use of barriers.
> - Rebase on top of 3.17-rc1
> 
> Changes since v2:
> [ https://www.mail-archive.com/linux-arm-msm@vger.kernel.org/msg10148.html ]
> - Prune all the drivers to support basic WFI and power down cpuidle
>   functionality. Remove debug code.
> - Integrate KConfig changes into the drivers' patches.
> - Use Lorenzo's ARM idle-states patches as the basis for reading cpuidle
>   c-states from DT.
>   [ http://marc.info/?l=linux-pm&m=140794514812383&w=2 ]
> - Incorporate review comments
> - Rebase on top of 3.16
> 
> Changes since v1/RFC:
> [ https://www.mail-archive.com/linux-arm-msm@vger.kernel.org/msg10065.html ]
> - Remove hotplug from the patch series. Will submit it separately.
> - Fix SPM drivers per the review comments
> - Modify patch sequence to compile SPM drivers independent of msm-pm, so as to
>   allow wfi() calls to use SPM even without SoC interface driver.
> 
> 8074/8084 like any ARM SoC can do architectural clock gating, that helps save
> on power, but not enough of leakage power.  Leakage power of the SoC can be
> further reduced by turning off power to the core. To aid this, every core (cpu
> and L2) is accompanied by a Sub-system Power Manager (SPM), that can be
> configured to indicate the low power mode, the core would be put into and the
> SPM programs the peripheral h/w accordingly to enter low power and turn off the
> power rail to the core.
> 
> The idle invocation hierarchy - 
> 
> 	CPUIDLE
> 	|
> 	cpuidle-qcom.c [CPUIdle driver]
> 	|
> 	------>	pm.c [SoC Interface layer for QCOM chipsets]
> 		|
> 		------> spm.c [SPM driver]
> 		|
> 		------> scm-boot.c [SCM interface layer]		
> 			|
> ------------------------|--------------------------
> (EL)			Secure Monitor Code
> 			|
> 			|
> 			wfi(); 
> ------------------------|--------------------------
> (HW)			[CPU] {clock gate}
> 			|
> 			-----> [SPM] {statemachine}
> 			
> 
> The patchset does the following -
> 
> - Introduce the SPM driver to control power to the core
> 
> - Add device bindings for 8974 CPU SPM devices 
> 
> - Add device bindings for 8084 CPU SPM devices
> 
> - Introduce the SoC interface layer to configure SPM per the core's idle state.
> 
> - Add CPUIDLE driver for QCOM cpus, using ARM generic idle state definitions.
> 
> - Add device bindings for 8974 idle-states - WFI and SPC
> 
> - Add device bindings for 8084 idle-states - WFI and SPC
> 
> Thanks,
> Lina
> 
> 
> 
> Lina Iyer (7):
>   qcom: spm: Add Subsystem Power Manager driver
>   arm: dts: qcom: Add SPM device bindings for 8974
>   arm: dts: qcom: Add SPM device bindings for 8084
>   qcom: pm: Add cpu low power mode functions
>   qcom: cpuidle: Add cpuidle driver for QCOM cpus
>   arm: dts: qcom: Add idle states device nodes for 8974
>   arm: dts: qcom: Add idle states device nodes for 8084
> 
>  .../bindings/arm/msm/qcom,idle-state.txt           |  72 +++++++
>  .../devicetree/bindings/arm/msm/qcom,saw2.txt      |  10 +-
>  arch/arm/boot/dts/qcom-apq8084.dtsi                |  46 ++++-
>  arch/arm/boot/dts/qcom-msm8974.dtsi                |  46 ++++-
>  drivers/cpuidle/Kconfig.arm                        |   7 +
>  drivers/cpuidle/Makefile                           |   1 +
>  drivers/cpuidle/cpuidle-qcom.c                     |  89 +++++++++
>  drivers/soc/qcom/Kconfig                           |   8 +
>  drivers/soc/qcom/Makefile                          |   1 +
>  drivers/soc/qcom/pm.c                              | 109 +++++++++++
>  drivers/soc/qcom/spm.c                             | 216 +++++++++++++++++++++
>  include/soc/qcom/pm.h                              |  26 +++
>  include/soc/qcom/spm.h                             |  35 ++++
>  13 files changed, 658 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt
>  create mode 100644 drivers/cpuidle/cpuidle-qcom.c
>  create mode 100644 drivers/soc/qcom/pm.c
>  create mode 100644 drivers/soc/qcom/spm.c
>  create mode 100644 include/soc/qcom/pm.h
>  create mode 100644 include/soc/qcom/spm.h
> 
