From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v4 0/2] driver: thermal: Move some drivers into subdirs
Date: Fri, 07 Dec 2018 16:51:18 +0800
Message-ID: <1544172678.29332.23.camel@intel.com>
References: <cover.1544165234.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1544165234.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>, linux-kernel@vger.kernel.org
Cc: edubezval@gmail.com, sfr@canb.auug.org.au, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

applied. But please do remember to send the patches to linux-pm mailing
list next time so that I can catch them via patchwork.

thanks,
rui

On 五, 2018-12-07 at 12:25 +0530, Amit Kucheria wrote:
> (Apologies for the build failure. My scripts to enable these configs
> and
> build-test them failed. They've been fixed now)
> 
> Move the various drivers for Intel platforms into their own subdir.
> Also
> consolidate Qualcomm drivers into the qcom subdir.
> 
> This cleans up the directory making it easier to find things.
> 
> There is no great time to send patches that move files around. So
> here's an
> attempt to sneak it into 4.21 before everything else.
> 
> This was generated and compile-tested against 4.20-rc4. If you would
> like
> me to try again a bit later, I'm happy to do so.
> 
> Changes since v3:
> - Fix build failure on QCOM_SPMI_TEMP_ALARM
> 
> Changes since v2:
> - Rebased on top of 4.20-rc4
> 
> Changes since v1:
> - Removed a stray character that snuck into the Makefile
> - Added Acks
> - Rebased to v4.19-rc6
> 
> 
> Amit Kucheria (2):
>   drivers: thermal: Move various drivers for intel platforms into a
>     subdir
>   drivers: thermal: Move QCOM_SPMI_TEMP_ALARM into the qcom subdir
> 
>  drivers/thermal/Kconfig                       | 94 +--------------
> ----
>  drivers/thermal/Makefile                      | 10 +-
>  drivers/thermal/intel/Kconfig                 | 77 +++++++++++++++
>  drivers/thermal/intel/Makefile                | 12 +++
>  .../{ => intel}/int340x_thermal/Kconfig       |  0
>  .../{ => intel}/int340x_thermal/Makefile      |  0
>  .../int340x_thermal/acpi_thermal_rel.c        |  0
>  .../int340x_thermal/acpi_thermal_rel.h        |  0
>  .../int340x_thermal/int3400_thermal.c         |  0
>  .../int340x_thermal/int3402_thermal.c         |  0
>  .../int340x_thermal/int3403_thermal.c         |  0
>  .../int340x_thermal/int3406_thermal.c         |  0
>  .../int340x_thermal/int340x_thermal_zone.c    |  0
>  .../int340x_thermal/int340x_thermal_zone.h    |  0
>  .../processor_thermal_device.c                |  0
>  .../{ => intel}/intel_bxt_pmic_thermal.c      |  0
>  .../thermal/{ => intel}/intel_pch_thermal.c   |  0
>  .../thermal/{ => intel}/intel_powerclamp.c    |  0
>  .../{ => intel}/intel_quark_dts_thermal.c     |  0
>  .../thermal/{ => intel}/intel_soc_dts_iosf.c  |  0
>  .../thermal/{ => intel}/intel_soc_dts_iosf.h  |  0
>  .../{ => intel}/intel_soc_dts_thermal.c       |  0
>  .../{ => intel}/x86_pkg_temp_thermal.c        |  0
>  drivers/thermal/qcom/Kconfig                  | 11 +++
>  drivers/thermal/qcom/Makefile                 |  1 +
>  .../thermal/{ => qcom}/qcom-spmi-temp-alarm.c |  2 +-
>  26 files changed, 108 insertions(+), 99 deletions(-)
>  create mode 100644 drivers/thermal/intel/Kconfig
>  create mode 100644 drivers/thermal/intel/Makefile
>  rename drivers/thermal/{ => intel}/int340x_thermal/Kconfig (100%)
>  rename drivers/thermal/{ => intel}/int340x_thermal/Makefile (100%)
>  rename drivers/thermal/{ =>
> intel}/int340x_thermal/acpi_thermal_rel.c (100%)
>  rename drivers/thermal/{ =>
> intel}/int340x_thermal/acpi_thermal_rel.h (100%)
>  rename drivers/thermal/{ => intel}/int340x_thermal/int3400_thermal.c
> (100%)
>  rename drivers/thermal/{ => intel}/int340x_thermal/int3402_thermal.c
> (100%)
>  rename drivers/thermal/{ => intel}/int340x_thermal/int3403_thermal.c
> (100%)
>  rename drivers/thermal/{ => intel}/int340x_thermal/int3406_thermal.c
> (100%)
>  rename drivers/thermal/{ =>
> intel}/int340x_thermal/int340x_thermal_zone.c (100%)
>  rename drivers/thermal/{ =>
> intel}/int340x_thermal/int340x_thermal_zone.h (100%)
>  rename drivers/thermal/{ =>
> intel}/int340x_thermal/processor_thermal_device.c (100%)
>  rename drivers/thermal/{ => intel}/intel_bxt_pmic_thermal.c (100%)
>  rename drivers/thermal/{ => intel}/intel_pch_thermal.c (100%)
>  rename drivers/thermal/{ => intel}/intel_powerclamp.c (100%)
>  rename drivers/thermal/{ => intel}/intel_quark_dts_thermal.c (100%)
>  rename drivers/thermal/{ => intel}/intel_soc_dts_iosf.c (100%)
>  rename drivers/thermal/{ => intel}/intel_soc_dts_iosf.h (100%)
>  rename drivers/thermal/{ => intel}/intel_soc_dts_thermal.c (100%)
>  rename drivers/thermal/{ => intel}/x86_pkg_temp_thermal.c (100%)
>  rename drivers/thermal/{ => qcom}/qcom-spmi-temp-alarm.c (99%)
> 
