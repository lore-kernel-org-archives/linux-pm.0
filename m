From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH v2 0/2] driver: thermal: Move some drivers into subdirs
Date: Fri, 23 Nov 2018 00:17:02 +0530
Message-ID: <CAHLCerNFabr5-+b8U=ouLBidGJo+e+aDVW9ZyOQy9edJB3cERw@mail.gmail.com>
References: <cover.1538638640.git.amit.kucheria@linaro.org> <CAHLCerMaJKaXD0pTdtMCK6C__WW-pXQ0AfY9L26dDT56szvz6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHLCerMaJKaXD0pTdtMCK6C__WW-pXQ0AfY9L26dDT56szvz6A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Matthias Kaehlcke <mka@chromium.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Oct 26, 2018 at 2:21 PM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> Hi Rui,
>
> On Thu, Oct 4, 2018 at 1:22 PM Amit Kucheria <amit.kucheria@linaro.org> wrote:
> >
> > Move the various drivers for Intel platforms into their own subdir. Also
> > consolidate Qualcomm drivers into the qcom subdir.
> >
> > This cleans up the directory making it easier to find things.
>
> Any comments on these changes?

Rui? Eduardo?

> > There is no great time to send patches that move files around, but I'm told
> > that towards the end of the merge window is nicer. So here's an attempt to
> > sneak it into 4.20 after everything else and hoping that these files won't
> > change after 4.19-rc6. :-)
> >
> > This was generated and compile-tested against 4.19-rc6. If you would like
> > me to try again a bit later, I'm happy to do so.
> >
> > Changes since v1:
> > - Removed a stray character that snuck into the Makefile
> > - Added Acks
> > - Rebased to v4.19-rc6
> >
> > Amit Kucheria (2):
> >   drivers: thermal: Move various drivers for intel platforms into a
> >     subdir
> >   drivers: thermal: Move QCOM_SPMI_TEMP_ALARM into the qcom subdir
> >
> >  drivers/thermal/Kconfig                       | 94 +------------------
> >  drivers/thermal/Makefile                      | 10 +-
> >  drivers/thermal/intel/Kconfig                 | 77 +++++++++++++++
> >  drivers/thermal/intel/Makefile                | 12 +++
> >  .../{ => intel}/int340x_thermal/Kconfig       |  0
> >  .../{ => intel}/int340x_thermal/Makefile      |  0
> >  .../int340x_thermal/acpi_thermal_rel.c        |  0
> >  .../int340x_thermal/acpi_thermal_rel.h        |  0
> >  .../int340x_thermal/int3400_thermal.c         |  0
> >  .../int340x_thermal/int3402_thermal.c         |  0
> >  .../int340x_thermal/int3403_thermal.c         |  0
> >  .../int340x_thermal/int3406_thermal.c         |  0
> >  .../int340x_thermal/int340x_thermal_zone.c    |  0
> >  .../int340x_thermal/int340x_thermal_zone.h    |  0
> >  .../processor_thermal_device.c                |  0
> >  .../{ => intel}/intel_bxt_pmic_thermal.c      |  0
> >  .../thermal/{ => intel}/intel_pch_thermal.c   |  0
> >  .../thermal/{ => intel}/intel_powerclamp.c    |  0
> >  .../{ => intel}/intel_quark_dts_thermal.c     |  0
> >  .../thermal/{ => intel}/intel_soc_dts_iosf.c  |  0
> >  .../thermal/{ => intel}/intel_soc_dts_iosf.h  |  0
> >  .../{ => intel}/intel_soc_dts_thermal.c       |  0
> >  .../{ => intel}/x86_pkg_temp_thermal.c        |  0
> >  drivers/thermal/qcom/Kconfig                  | 11 +++
> >  drivers/thermal/qcom/Makefile                 |  1 +
> >  .../thermal/{ => qcom}/qcom-spmi-temp-alarm.c |  0
> >  26 files changed, 107 insertions(+), 98 deletions(-)
> >  create mode 100644 drivers/thermal/intel/Kconfig
> >  create mode 100644 drivers/thermal/intel/Makefile
> >  rename drivers/thermal/{ => intel}/int340x_thermal/Kconfig (100%)
> >  rename drivers/thermal/{ => intel}/int340x_thermal/Makefile (100%)
> >  rename drivers/thermal/{ => intel}/int340x_thermal/acpi_thermal_rel.c (100%)
> >  rename drivers/thermal/{ => intel}/int340x_thermal/acpi_thermal_rel.h (100%)
> >  rename drivers/thermal/{ => intel}/int340x_thermal/int3400_thermal.c (100%)
> >  rename drivers/thermal/{ => intel}/int340x_thermal/int3402_thermal.c (100%)
> >  rename drivers/thermal/{ => intel}/int340x_thermal/int3403_thermal.c (100%)
> >  rename drivers/thermal/{ => intel}/int340x_thermal/int3406_thermal.c (100%)
> >  rename drivers/thermal/{ => intel}/int340x_thermal/int340x_thermal_zone.c (100%)
> >  rename drivers/thermal/{ => intel}/int340x_thermal/int340x_thermal_zone.h (100%)
> >  rename drivers/thermal/{ => intel}/int340x_thermal/processor_thermal_device.c (100%)
> >  rename drivers/thermal/{ => intel}/intel_bxt_pmic_thermal.c (100%)
> >  rename drivers/thermal/{ => intel}/intel_pch_thermal.c (100%)
> >  rename drivers/thermal/{ => intel}/intel_powerclamp.c (100%)
> >  rename drivers/thermal/{ => intel}/intel_quark_dts_thermal.c (100%)
> >  rename drivers/thermal/{ => intel}/intel_soc_dts_iosf.c (100%)
> >  rename drivers/thermal/{ => intel}/intel_soc_dts_iosf.h (100%)
> >  rename drivers/thermal/{ => intel}/intel_soc_dts_thermal.c (100%)
> >  rename drivers/thermal/{ => intel}/x86_pkg_temp_thermal.c (100%)
> >  rename drivers/thermal/{ => qcom}/qcom-spmi-temp-alarm.c (100%)
> >
> > --
> > 2.17.1
> >
