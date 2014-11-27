From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v13 00/10] cpuidle driver for QCOM SoCs: 8064, 8074, 8084
Date: Thu, 27 Nov 2014 09:53:03 +0100
Message-ID: <5476E66F.2080209@linaro.org>
References: <1417065854-37745-1-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:61497 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754464AbaK0IxH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Nov 2014 03:53:07 -0500
Received: by mail-wi0-f175.google.com with SMTP id l15so15026854wiw.8
        for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2014 00:53:06 -0800 (PST)
In-Reply-To: <1417065854-37745-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org


Lina,

a night for me has passed and I have in the meantime 3 new versions of=20
the patchset obviously done in the hurry and not tested.

=46urthermore the change log fails to give the details, "Address review=
=20
comments on spm.c" is just a clue and when I look at the spm.c code all=
=20
the comments where not addressed.

Please, have a look at the "static bool cpuidle_drv_init;", remove it=20
and look closely at the idle callbacks error handling in the cpuidle dr=
iver.

Thanks

   -- Daniel




On 11/27/2014 06:24 AM, Lina Iyer wrote:
> Dependent patchsets -
>          https://lkml.org/lkml/2014/8/4/767
>          http://www.spinics.net/lists/linux-arm-msm/msg10799.html
>          http://www.spinics.net/lists/linux-arm-msm/msg10795.html
>
> Changes since v12:
> - Minor fixes
> - Added Reviewed-by
>
> Changes since v11:
> - Address review comments on spm.c
> - Commenting style fixes
> - Added Reviewed-by
>
> Changes since v10:
> [ https://www.mail-archive.com/devicetree@vger.kernel.org/msg51880.ht=
ml ]
> - Address review comments
> - Added Acked-by and Reviewed-by
>
> Changes since v9:
> [ https://www.mail-archive.com/linux-arm-msm@vger.kernel.org/msg11714=
=2Ehtml ]
> - Address review comments on v9
>
> Changes since v8:
> [ https://www.mail-archive.com/linux-arm-msm@vger.kernel.org/msg11473=
=2Ehtml ]
> - Flatten out the file structure - merge pm.c into spm.c after discus=
sions
> - Add a new function to set warm boot address, in scm-boot.c
> - Support for 8064 (New)
> - Tested on 8074, 8084. 8064 was tested with a WIP tree
> - Address review comments from v8
> - Looking into possiblility of  initializing the cpuidle device for a=
 cpu,
> only when the corresponding spm device is probed successfully.
>
> Changes since v7:
> [ https://www.mail-archive.com/linux-arm-msm@vger.kernel.org/msg11199=
=2Ehtml ]
> - Address review comments
> - Tested on 8974 but not 8084
> - WFI renamed to Standby
> - Update commit text with original author and link to the downstream =
tree
>
> Changes since v6:
> [ https://www.mail-archive.com/linux-arm-msm@vger.kernel.org/msg11012=
=2Ehtml ]
> - SPM device nodes merged with existing SAW DT nodes
> - SPM register information is handled within the driver
> - Clean up from using 'msm' to 'qcom'
>          - Shorten some enumerations as well
> - Review comments from v6 addressed
> - New: Support for 8084 SoC
>          - Not tested. I do not have a board with this SoC, but the S=
PM
>          configuration should be identical for WFI and SPC
>
> Changes since v5:
> [ https://www.mail-archive.com/linux-arm-msm@vger.kernel.org/msg10559=
=2Ehtml ]
> - Merge spm-devices.c and spm.c into one file and one patch
>          - Simplify implementation of the driver.
>          - Update documentation mapping the DT properties with corres=
ponding
>            SPM register information.
> - Removed scm-boot changes for quad core warmboot, its has been pulle=
d in.
>
> Changes since v4:
> [ https://www.mail-archive.com/linux-arm-msm@vger.kernel.org/msg10327=
=2Ehtml ]
> - Update to the v8 of ARM generic idle states patches
> - Use platform device model for cpuidle-qcom
> - Clean up msm-pm.c to remove unnecessary include files and functions
> - Update commit text and documentation for all idle states
> - Remove scm-boot relocate patch from this series, submitted earlier
> [ https://www.mail-archive.com/linux-arm-msm@vger.kernel.org/msg10518=
=2Ehtml ]
>
> Changes since v3:
> [ https://www.mail-archive.com/linux-arm-msm@vger.kernel.org/msg10288=
=2Ehtml ]
> - Fix CONFIG_QCOM_PM Kconfig as bool
> - More clean ups in spm.c and spm-devices.c
>          - Removed and re-organized data structures to make initializ=
ation simple
>          - Remove export of sequence flush functions
>          - Updated commit text
>          - Comments for use of barriers.
> - Rebase on top of 3.17-rc1
>
> Changes since v2:
> [ https://www.mail-archive.com/linux-arm-msm@vger.kernel.org/msg10148=
=2Ehtml ]
> - Prune all the drivers to support basic WFI and power down cpuidle
>    functionality. Remove debug code.
> - Integrate KConfig changes into the drivers' patches.
> - Use Lorenzo's ARM idle-states patches as the basis for reading cpui=
dle
>    c-states from DT.
>    [ http://marc.info/?l=3Dlinux-pm&m=3D140794514812383&w=3D2 ]
> - Incorporate review comments
> - Rebase on top of 3.16
>
> Changes since v1/RFC:
> [ https://www.mail-archive.com/linux-arm-msm@vger.kernel.org/msg10065=
=2Ehtml ]
> - Remove hotplug from the patch series. Will submit it separately.
> - Fix SPM drivers per the review comments
> - Modify patch sequence to compile SPM drivers independent of msm-pm,=
 so as to
>    allow wfi() calls to use SPM even without SoC interface driver.
>
> 8074/8084/8064 like any ARM SoC can do architectural clock gating, th=
at helps save
> on power, but not enough of leakage power.  Leakage power of the SoC =
can be
> further reduced by turning off power to the core. To aid this, every =
core (cpu
> and L2) is accompanied by a Sub-system Power Manager (SPM), that can =
be
> configured to indicate the low power mode, the core would be put into=
 and the
> SPM programs the peripheral h/w accordingly to enter low power and tu=
rn off the
> power rail to the core.
>
> The idle invocation hierarchy -
>
> CPUIDLE
>          |
>          cpuidle-qcom.c [CPUIdle driver]
>          |
>          ------> spm.c [SPM driver]
>                  |
>                  ------> scm-boot.c [SCM interface layer]
>                          |
> ------------------------|--------------------------
> (EL)                    Secure Monitor Code
>                          |
>                          |
>                          wfi();
> ------------------------|--------------------------
> (HW)                    [CPU] {clock gate}
>                          |
>                          -----> [SPM] {statemachine}
>
>
> The patchset does the following -
>
> - Introduce the SPM driver to control power to the core
> - Add device bindings for 8974, 8084, 8064 CPU SPM devices
> - Add cpuidle driver for QCOM cpus, using ARM generic idle state defi=
nitions.
> - Add device bindings for 8974, 8084, 8064 idle-states - WFI and SPC
>
> Thanks,
> Lina
>
>
>
>
> Lina Iyer (10):
>    qcom: scm: Move scm-boot files to drivers/soc/qcom/ and
>      include/soc/qcom
>    qcom: scm: Add SCM warmboot support for quad core SoCs
>    qcom: spm: Add Subsystem Power Manager driver
>    arm: dts: qcom: Add power-controller device node for 8074 Krait CP=
Us
>    arm: dts: qcom: Add power-controller device node for 8084 Krait CP=
Us
>    arm: dts: qcom: Update power-controller device node for 8064 Krait
>      CPUs
>    qcom: cpuidle: Add cpuidle driver for QCOM cpus
>    arm: dts: qcom: Add idle states device nodes for 8074
>    arm: dts: qcom: Add idle states device nodes for 8084
>    arm: dts: qcom: Add idle state device nodes for 8064
>
>   .../bindings/arm/msm/qcom,idle-state.txt           |  81 +++++
>   .../devicetree/bindings/arm/msm/qcom,saw2.txt      |  31 +-
>   arch/arm/boot/dts/qcom-apq8064.dtsi                |  36 ++-
>   arch/arm/boot/dts/qcom-apq8084.dtsi                |  46 ++-
>   arch/arm/boot/dts/qcom-msm8974.dtsi                |  46 ++-
>   arch/arm/mach-qcom/Makefile                        |   1 -
>   arch/arm/mach-qcom/platsmp.c                       |   2 +-
>   drivers/cpuidle/Kconfig.arm                        |   7 +
>   drivers/cpuidle/Makefile                           |   1 +
>   drivers/cpuidle/cpuidle-qcom.c                     |  78 +++++
>   drivers/soc/qcom/Kconfig                           |   8 +
>   drivers/soc/qcom/Makefile                          |   3 +-
>   .../arm/mach-qcom =3D> drivers/soc/qcom}/scm-boot.c  |  37 ++-
>   drivers/soc/qcom/spm.c                             | 327 ++++++++++=
+++++++++++
>   include/soc/qcom/pm.h                              |  31 ++
>   .../arm/mach-qcom =3D> include/soc/qcom}/scm-boot.h  |   3 +-
>   16 files changed, 716 insertions(+), 22 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,i=
dle-state.txt
>   create mode 100644 drivers/cpuidle/cpuidle-qcom.c
>   rename {arch/arm/mach-qcom =3D> drivers/soc/qcom}/scm-boot.c (59%)
>   create mode 100644 drivers/soc/qcom/spm.c
>   create mode 100644 include/soc/qcom/pm.h
>   rename {arch/arm/mach-qcom =3D> include/soc/qcom}/scm-boot.h (91%)
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

