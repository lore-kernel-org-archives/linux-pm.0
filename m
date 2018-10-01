From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v1 0/2] driver: thermal: Move some drivers into subdirs
Date: Mon, 1 Oct 2018 16:54:26 +0200
Message-ID: <71d28a39-dcd2-2217-57b3-b2c3e6b77ec2@linaro.org>
References: <cover.1538141538.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1538141538.git.amit.kucheria@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>, linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, edubezval@gmail.com, mka@chromium.org, rui.zhang@intel.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 28/09/2018 18:36, Amit Kucheria wrote:
> Move the various drivers for Intel platforms into their own subdir. Also
> consolidate Qualcomm drivers into the qcom subdir.
> 
> This cleans up the directory making it easier to find things.
> 
> There is no great time to send patches that move files around, but I'm told
> that towards the end is nicer. So here's an attempt to sneak it into 4.20
> after everything else and hoping that these files won't change after
> 4.19-rc4. :-) 
> 
> This was compile-tested and generated against 4.19-rc4. If you would like
> me to try another time, I'm happy to do so.

I think it is a good idea organize the drivers per vendor directories.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


> Amit Kucheria (2):
>   drivers: thermal: Move various drivers for intel platforms into a
>     subdir
>   drivers: thermal: Move QCOM_SPMI_TEMP_ALARM into the qcom subdir
> 
>  drivers/thermal/Kconfig                       | 94 +------------------
>  drivers/thermal/Makefile                      | 10 +-
>  drivers/thermal/intel/Kconfig                 | 77 +++++++++++++++
>  drivers/thermal/intel/Makefile                | 12 +++
>  .../{ => intel}/int340x_thermal/Kconfig       |  0
>  .../{ => intel}/int340x_thermal/Makefile      |  0
>  .../int340x_thermal/acpi_thermal_rel.c        |  0
>  .../int340x_thermal/acpi_thermal_rel.h        |  0
>  .../int340x_thermal/int3400_thermal.c         |  0
>  .../int340x_thermal/int3402_thermal.c         |  0
>  .../int340x_thermal/int3403_thermal.c         |  0
>  .../int340x_thermal/int3406_thermal.c         |  0
>  .../int340x_thermal/int340x_thermal_zone.c    |  0
>  .../int340x_thermal/int340x_thermal_zone.h    |  0
>  .../processor_thermal_device.c                |  0
>  .../{ => intel}/intel_bxt_pmic_thermal.c      |  0
>  .../thermal/{ => intel}/intel_pch_thermal.c   |  0
>  .../thermal/{ => intel}/intel_powerclamp.c    |  0
>  .../{ => intel}/intel_quark_dts_thermal.c     |  0
>  .../thermal/{ => intel}/intel_soc_dts_iosf.c  |  0
>  .../thermal/{ => intel}/intel_soc_dts_iosf.h  |  0
>  .../{ => intel}/intel_soc_dts_thermal.c       |  0
>  .../{ => intel}/x86_pkg_temp_thermal.c        |  0
>  drivers/thermal/qcom/Kconfig                  | 11 +++
>  drivers/thermal/qcom/Makefile                 |  1 +
>  .../thermal/{ => qcom}/qcom-spmi-temp-alarm.c |  0
>  26 files changed, 107 insertions(+), 98 deletions(-)
>  create mode 100644 drivers/thermal/intel/Kconfig
>  create mode 100644 drivers/thermal/intel/Makefile
>  rename drivers/thermal/{ => intel}/int340x_thermal/Kconfig (100%)
>  rename drivers/thermal/{ => intel}/int340x_thermal/Makefile (100%)
>  rename drivers/thermal/{ => intel}/int340x_thermal/acpi_thermal_rel.c (100%)
>  rename drivers/thermal/{ => intel}/int340x_thermal/acpi_thermal_rel.h (100%)
>  rename drivers/thermal/{ => intel}/int340x_thermal/int3400_thermal.c (100%)
>  rename drivers/thermal/{ => intel}/int340x_thermal/int3402_thermal.c (100%)
>  rename drivers/thermal/{ => intel}/int340x_thermal/int3403_thermal.c (100%)
>  rename drivers/thermal/{ => intel}/int340x_thermal/int3406_thermal.c (100%)
>  rename drivers/thermal/{ => intel}/int340x_thermal/int340x_thermal_zone.c (100%)
>  rename drivers/thermal/{ => intel}/int340x_thermal/int340x_thermal_zone.h (100%)
>  rename drivers/thermal/{ => intel}/int340x_thermal/processor_thermal_device.c (100%)
>  rename drivers/thermal/{ => intel}/intel_bxt_pmic_thermal.c (100%)
>  rename drivers/thermal/{ => intel}/intel_pch_thermal.c (100%)
>  rename drivers/thermal/{ => intel}/intel_powerclamp.c (100%)
>  rename drivers/thermal/{ => intel}/intel_quark_dts_thermal.c (100%)
>  rename drivers/thermal/{ => intel}/intel_soc_dts_iosf.c (100%)
>  rename drivers/thermal/{ => intel}/intel_soc_dts_iosf.h (100%)
>  rename drivers/thermal/{ => intel}/intel_soc_dts_thermal.c (100%)
>  rename drivers/thermal/{ => intel}/x86_pkg_temp_thermal.c (100%)
>  rename drivers/thermal/{ => qcom}/qcom-spmi-temp-alarm.c (100%)
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
