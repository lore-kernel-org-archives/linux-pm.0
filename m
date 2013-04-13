From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: PM+ACPI material for v3.10
Date: Sat, 13 Apr 2013 09:38:08 +0200
Message-ID: <51690B60.1050205@linaro.org>
References: <3222400.G8tzcaWZXV@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:40900 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999Ab3DMHiO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 13 Apr 2013 03:38:14 -0400
Received: by mail-wg0-f52.google.com with SMTP id n12so3353569wgh.7
        for <linux-pm@vger.kernel.org>; Sat, 13 Apr 2013 00:38:12 -0700 (PDT)
In-Reply-To: <3222400.G8tzcaWZXV@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "horms@verge.net.au" <horms@verge.net.au>, Kevin Hilman <khilman@deeprootsystems.com>, Magnus Damm <magnus.damm@gmail.com>

On 04/13/2013 02:17 AM, Rafael J. Wysocki wrote:
> Hi All,
>=20
> As some of you already know, I will be traveling through Apr. 20 and =
I'm not
> going to take any new material for v3.10 from now onwards until I'm b=
ack.
>=20
> The summary of my current queue is appended and quite frankly I don't=
 see any
> compelling reasons to add anything more to it at the moment (except f=
or fixes,
> if any).  That said, if you really really need/want some new stuff (o=
r generally
> something that is not a fix) to go into it, you may try to convince m=
e, but
> that will cost you a beverage of my choice if successful.  So you hav=
e been
> warned.

:)

=46or me it is ok to wait but there some patches, that should be taken
from the last series I sent because they are fixes:

http://www.spinics.net/lists/arm-kernel/msg237936.html
http://www.spinics.net/lists/arm-kernel/msg237938.html
http://www.spinics.net/lists/arm-kernel/msg237939.html

They don't have a ack yet.

Kevin ? Magnus ?

Thanks
  -- Daniel



> ---------------
>=20
> Alexandru Gheorghiu (2):
>       ACPI / acpi_pad: Used PTR_RET
>       ACPI: Use resource_size() in osl.c
>=20
> Amit Daniel Kachhap (3):
>       cpufreq: exynos: Add cpufreq driver for exynos5440
>       cpufreq: exynos: Remove error return even if no soc is found
>       arm: exynos: Enable OPP library support for exynos5440
>=20
> Andrei Epure (1):
>       ACPI: replace kmalloc+memcpy with kmemdup
>=20
> Andy Shevchenko (5):
>       ACPI: suppress compiler warnings in button.c
>       ACPI: suppress compiler warnings in processor_throttling.c
>       ACPI: suppress compiler warning in battery.c
>       ACPI: suppress compiler warning in container.c
>       ACPI / LPSS: make code less confusing for reader
>=20
> Bob Moore (19):
>       ACPICA: Resource Mgr: Prevent infinite loops in resource walks
>       ACPICA: Update error/debug messages for fixed events
>       ACPICA: Add parens within macros around parameter names
>       ACPICA: Update for ACPI 5 hardware-reduced feature
>       ACPICA: Regression fix: reinstate safe exit macros
>       ACPICA: Add macros to exception code definitions
>       ACPICA: Add exception descriptions to exception info table
>       ACPICA: Remove trailing comma in enum declarations
>       ACPICA: Add mechanism for early object repairs on a per-name ba=
sis
>       ACPICA: Split object conversion functions to a new file
>       ACPICA: Disassembler: Add warnings for unresolved control metho=
ds
>       ACPICA: Object repair: Allow 0-length packages for variable-len=
gth packages
>       ACPICA: Update version to 20130214
>       ACPICA: Predefine names: Add allowed argument types to master i=
nfo table
>       ACPICA: Improve error message for Index() operator
>       ACPICA: Remove FORCE_DELETE option for global reference count m=
echanism
>       ACPICA: Fix a format string for 64-bit generation
>       ACPICA: Add a lock to the internal object reference count mecha=
nism
>       ACPICA: Update version to 20130328
>=20
> Colin Ian King (4):
>       ACPI / fan: avoid null pointer deference error
>       ACPI / processor_thermal: avoid null pointer deference error
>       ACPICA: Fix a typo in an error message
>       ACPICA: Fix a typo in a function header, no functional change
>=20
> Daniel Lezcano (18):
>       cpuidle : handle clockevent notify from the cpuidle framework
>       cpuidle / omap4 : use CPUIDLE_FLAG_TIMER_STOP flag
>       cpuidle / imx6 : use CPUIDLE_FLAG_TIMER_STOP flag
>       cpuidle / ux500 : use CPUIDLE_FLAG_TIMER_STOP flag
>       cpuidle / kirkwood: remove redundant Kconfig option
>       timer: move enum definition out of ifdef section
>       cpuidle: initialize the broadcast timer framework
>       cpuidle: ux500: remove timer broadcast initialization
>       cpuidle: OMAP4: remove timer broadcast initialization
>       cpuidle: imx6: remove timer broadcast initialization
>       ARM: shmobile: pm: fix init sections
>       ARM: shmobile: cpuidle: remove useless WFI function
>       ARM: tegra2: cpuidle: change driver initialization
>       ARM: tegra: cpuidle: remove useless initialization
>       ARM: davinci: cpuidle: fix wrong enter function
>       ARM: omap3: cpuidle: enable time keeping
>       POWERPC: pseries: cpuidle: use time keeping flag
>       ARM: omap3: cpuidle: enable time keeping
>=20
> Danny Baumann (3):
>       ACPI / video: Fix brightness control initialization for some la=
ptops.
>       ACPI / video: Make logic a little easier to understand.
>       ACPI / video: Fix applying indexed initial brightness value.
>=20
> Gustavo Maciel Dias Vieira (1):
>       ACPI video: ignore BIOS backlight value for HP dm4
>=20
> Jacob Shin (2):
>       cpufreq: ondemand: allow custom powersave_bias_target handler t=
o be registered
>       cpufreq: AMD "frequency sensitivity feedback" powersave bias fo=
r ondemand governor
>=20
> Jung-uk Kim (4):
>       ACPICA: Fix a couple warnings detected on FreeBSD build
>       ACPICA: Fix a long-standing bug in local cache
>       ACPICA: Add macros to access pointer to next object in the desc=
riptor list
>       ACPICA: _OSI Support: handle any errors from acpi_os_acquire_mu=
tex()
>=20
> Linn Crosetto (1):
>       ACPICA: FADT: Remove extraneous warning for very large GPE regi=
sters
>=20
> Lv Zheng (5):
>       ACPICA: Update RASF table definition
>       ACPICA: iASL/Disassembler: Add support for VRTC table
>       ACPICA: iASL/Disassembler: Add support for MTMR table
>       ACPICA: Return object repair: Add string-to-unicode conversion
>       ACPICA: Return object repair: Add resource template repairs
>=20
> Mats Fagerstrom (1):
>       cpufreq: dbx500: Round to closest available freq
>=20
> Namhyung Kim (2):
>       cpufreq: conservative: Break out earlier on the lowest frequenc=
y
>       cpufreq: conservative: Fix relation when decreasing frequency
>=20
> Nathan Zimmer (2):
>       cpufreq: Convert the cpufreq_driver_lock to a rwlock
>       cpufreq: convert cpufreq_driver to using RCU
>=20
> Nishanth Menon (2):
>       PM / OPP: add documentation to RCU head in struct opp
>       cpufreq: OMAP: instantiate omap-cpufreq as a platform_driver
>=20
> Paul Bolle (2):
>       acpi: remove reference to ACPI_HOTPLUG_IO
>       ACPI: remove "config ACPI_DEBUG_FUNC_TRACE"
>=20
> Rafael J. Wysocki (12):
>       ACPI / scan: Introduce acpi_scan_match_handler()
>       ACPI / scan: Introduce common code for ACPI-based device hotplu=
g
>       ACPI / container: Use common hotplug code
>       ACPI / scan: Introduce acpi_scan_handler_matching()
>       ACPI / hotplug: Introduce user space interface for hotplug prof=
iles
>       ACPI / container: Use hotplug profile user space interface
>       ACPI / scan: Make memory hotplug driver use struct acpi_scan_ha=
ndler
>       ACPI / hotplug: Make acpi_hotplug_profile_ktype static
>       ACPI / scan: Add special handler for Intel Lynxpoint LPSS devic=
es
>       ACPI / LPSS: Add support for exposing LTR registers to user spa=
ce
>       ACPI / PM: Fix potential problem in acpi_device_get_power()
>       ACPI / PM: Expose lists of device wakeup power resources to use=
r space
>=20
> Santosh Shilimkar (5):
>       ARM: OMAP4: CPUidle: Avoid double idle driver registration
>       ARM: OMAP: CPUidle: Unregister drivere on device registration f=
ailure
>       ARM: OMAP4: CPUidle: Make C-state description field more precis=
e
>       ARM: OMAP4+: CPUidle: Deprecate use of omap4_mpuss_read_prev_co=
ntext_state()
>       ARM: OMAP4+: CPUidle: Consolidate idle driver for OMAP5 support
>=20
> Silviu-Mihai Popescu (2):
>       cpuidle: kirkwood: fix coccicheck warnings
>       cpufreq: kirkwood: fix coccicheck warnings
>=20
> Srinivas Pandruvada (1):
>       cpufreq / intel_pstate: Optimize intel_pstate_set_policy
>=20
> Stratos Karafotis (4):
>       cpufreq: governors: Calculate iowait time only when necessary
>       cpufreq: conservative: Fix sampling_down_factor functionality
>       cpufreq: conservative: Fix the logic in frequency decrease chec=
king
>       cpufreq: conservative: Use an inline function to evaluate freq_=
target
>=20
> Tang Chen (1):
>       ACPICA: Fix for some comments/headers
>=20
> Toshi Kani (6):
>       ACPI: Remove acpi_pci_bind_root() definition
>       ACPI: Remove acpi_device dependency in acpi_device_set_id()
>       ACPI: Update PNPID set/free interfaces
>       ACPI: Update PNPID match handling for notify
>       ACPI: Update _OST handling for notify
>       ACPI: Verify device status after eject
>=20
> Ulf Hansson (3):
>       PM / Runtime: Asyncronous idle|suspend devices at system resume
>       PM / Runtime: Asyncronous idle|suspend parent devices at remova=
l
>       PM / Runtime: Improve prepare handling at system suspend for ge=
npd
>=20
> Viresh Kumar (31):
>       cpufreq: Add per policy governor-init/exit infrastructure
>       cpufreq: governor: Implement per policy instances of governors
>       cpufreq: governor: Set MIN_LATENCY_MULTIPLIER to 20
>       cpufreq: ondemand: Don't update sample_type if we don't evaluat=
e load again
>       cpufreq: governors: Avoid unnecessary per cpu timer interrupts
>       cpufreq: cpu0: Fix mistake in Documentation example
>       cpufreq: Documentation: Fix cpufreq_frequency_table name
>       cpufreq: cpufreq-cpu0: No need to check cpu number in init()
>       cpufreq: cpufreq-cpu0: Call CPUFREQ_POSTCHANGE notifier for fai=
lure cases too
>       cpufreq: Notify all policy->cpus in cpufreq_notify_transition()
>       cpufreq: Don't check if cpu is online/offline for cpufreq callb=
acks
>       cpufreq: drivers: don't check range of target freq in .target()
>       cpufreq: drivers: Remove unnecessary assignments of policy-> me=
mbers
>       cpufreq: ARM big LITTLE: Add generic cpufreq driver and its DT =
glue
>       cpufreq: ARM: Arrange drivers in alphabetical order
>       cpufreq: tegra: Move driver to drivers/cpufreq
>       cpufreq: davinci: move cpufreq driver to drivers/cpufreq
>       cpufreq: pxa3xx: move cpufreq driver to drivers/cpufreq
>       cpufreq: pxa2xx: move cpufreq driver to drivers/cpufreq
>       cpufreq: integrator: move cpufreq driver to drivers/cpufreq
>       cpufreq: sa11x0: move cpufreq driver to drivers/cpufreq
>       cpufreq: AVR32: move cpufreq driver to drivers/cpufreq
>       cpufreq: blackfin: move cpufreq driver to drivers/cpufreq
>       cpufreq: cris: move cpufreq driver to drivers/cpufreq
>       cpufreq: ia64: move cpufreq driver to drivers/cpufreq
>       cpufreq: mips: move cpufreq driver to drivers/cpufreq
>       cpufreq: sh: move cpufreq driver to drivers/cpufreq
>       cpufreq: unicore2: move cpufreq driver to drivers/cpufreq
>       cpufreq: sparc: move cpufreq driver to drivers/cpufreq
>       cpufreq: powerpc/platforms/cell: move cpufreq driver to drivers=
/cpufreq
>       cpufreq: Call __cpufreq_governor() with correct policy->cpus ma=
sk
>=20
> Yasuaki Ishimatsu (2):
>       ACPI / memhotplug: set info->enabled for memory present at boot=
 time
>       ACPI / memhotplug: Remove info->failed bit
>=20
> Yinghai Lu (2):
>       ACPI: Set length even for TYPE_END_TAG acpi resource
>       PCI / ACPI: Don't query OSC support with all possible controls
>=20
> Zhang Rui (2):
>       PM / sleep: add TEST_PLATFORM support for freeze state
>       PM / sleep: invalidate TEST_CPUS and TEST_CORE support for free=
ze state
>=20
> jhbird.choi@samsung.com (1):
>       cpufreq: Fix unsigned variable being checked for negative value
>=20
> ---------------
>=20
>  Documentation/ABI/testing/sysfs-devices-lpss_ltr        |   44 +
>  .../ABI/testing/sysfs-devices-power_resources_wakeup    |   13 +
>  Documentation/ABI/testing/sysfs-firmware-acpi           |   26 +
>  Documentation/cpu-freq/cpu-drivers.txt                  |    9 +-
>  Documentation/cpu-freq/governors.txt                    |   27 +
>  .../devicetree/bindings/cpufreq/arm_big_little_dt.txt   |   65 ++
>  .../devicetree/bindings/cpufreq/cpufreq-cpu0.txt        |    2 +-
>  .../devicetree/bindings/cpufreq/cpufreq-exynos5440.txt  |   28 +
>  MAINTAINERS                                             |   11 +
>  arch/arm/Kconfig                                        |   25 -
>  arch/arm/configs/kirkwood_defconfig                     |    1 -
>  arch/arm/mach-davinci/Makefile                          |    1 -
>  arch/arm/mach-davinci/cpuidle.c                         |    8 +-
>  arch/arm/mach-exynos/Kconfig                            |    2 +
>  arch/arm/mach-imx/cpufreq.c                             |    8 +-
>  arch/arm/mach-imx/cpuidle-imx6q.c                       |   23 +-
>  arch/arm/mach-integrator/Makefile                       |    1 -
>  arch/arm/mach-omap2/common.h                            |    5 -
>  arch/arm/mach-omap2/cpuidle34xx.c                       |   11 +-
>  arch/arm/mach-omap2/cpuidle44xx.c                       |   71 +-
>  arch/arm/mach-omap2/omap-mpuss-lowpower.c               |   14 -
>  arch/arm/mach-omap2/pm.c                                |    9 +
>  arch/arm/mach-pxa/Makefile                              |    6 -
>  arch/arm/mach-pxa/include/mach/generic.h                |    1 +
>  arch/arm/mach-s3c24xx/cpufreq.c                         |    8 +-
>  arch/arm/mach-sa1100/Kconfig                            |   26 +-
>  arch/arm/mach-sa1100/Makefile                           |    3 -
>  arch/arm/mach-sa1100/include/mach/generic.h             |    1 +
>  arch/arm/mach-shmobile/cpuidle.c                        |   12 +-
>  arch/arm/mach-shmobile/pm-sh7372.c                      |    4 +-
>  arch/arm/mach-tegra/Makefile                            |    1 -
>  arch/arm/mach-tegra/cpuidle-tegra114.c                  |    1 -
>  arch/arm/mach-tegra/cpuidle-tegra20.c                   |   41 +-
>  arch/arm/mach-tegra/cpuidle-tegra30.c                   |    1 -
>  arch/arm/mach-ux500/cpuidle.c                           |   25 +-
>  arch/avr32/Kconfig                                      |   13 -
>  arch/avr32/configs/atngw100_defconfig                   |    2 +-
>  arch/avr32/configs/atngw100_evklcd100_defconfig         |    2 +-
>  arch/avr32/configs/atngw100_evklcd101_defconfig         |    2 +-
>  arch/avr32/configs/atngw100_mrmt_defconfig              |    2 +-
>  arch/avr32/configs/atngw100mkii_defconfig               |    2 +-
>  arch/avr32/configs/atngw100mkii_evklcd100_defconfig     |    2 +-
>  arch/avr32/configs/atngw100mkii_evklcd101_defconfig     |    2 +-
>  arch/avr32/configs/atstk1002_defconfig                  |    2 +-
>  arch/avr32/configs/atstk1003_defconfig                  |    2 +-
>  arch/avr32/configs/atstk1004_defconfig                  |    2 +-
>  arch/avr32/configs/atstk1006_defconfig                  |    2 +-
>  arch/avr32/configs/favr-32_defconfig                    |    2 +-
>  arch/avr32/configs/hammerhead_defconfig                 |    2 +-
>  arch/avr32/configs/mimc200_defconfig                    |    2 +-
>  arch/avr32/mach-at32ap/Makefile                         |    1 -
>  arch/blackfin/mach-common/Makefile                      |    1 -
>  arch/cris/arch-v32/mach-a3/Makefile                     |    1 -
>  arch/cris/arch-v32/mach-fs/Makefile                     |    1 -
>  arch/ia64/Kconfig                                       |    6 +-
>  arch/ia64/kernel/Makefile                               |    1 -
>  arch/ia64/kernel/cpufreq/Kconfig                        |   29 -
>  arch/ia64/kernel/cpufreq/Makefile                       |    2 -
>  arch/mips/Kconfig                                       |    9 +-
>  arch/mips/kernel/Makefile                               |    2 -
>  arch/mips/kernel/cpufreq/Kconfig                        |   41 -
>  arch/mips/kernel/cpufreq/Makefile                       |    5 -
>  arch/powerpc/platforms/cell/Kconfig                     |   26 +-
>  arch/powerpc/platforms/cell/Makefile                    |    3 -
>  arch/powerpc/platforms/pasemi/cpufreq.c                 |    5 +-
>  arch/powerpc/platforms/powermac/cpufreq_32.c            |   14 +-
>  arch/powerpc/platforms/powermac/cpufreq_64.c            |    5 +-
>  arch/powerpc/platforms/pseries/processor_idle.c         |   35 +-
>  arch/sh/Kconfig                                         |   18 -
>  arch/sh/kernel/Makefile                                 |    1 -
>  arch/sparc/Kconfig                                      |   23 -
>  arch/sparc/kernel/Makefile                              |    3 -
>  arch/unicore32/kernel/Makefile                          |    1 -
>  arch/x86/include/asm/cpufeature.h                       |    1 +
>  arch/x86/kernel/cpu/scattered.c                         |    3 +-
>  drivers/acpi/Kconfig                                    |   13 +-
>  drivers/acpi/Makefile                                   |    1 +
>  drivers/acpi/acpi_lpss.c                                |  292 +++++
>  drivers/acpi/acpi_memhotplug.c                          |  328 +----=
-
>  drivers/acpi/acpi_pad.c                                 |    2 +-
>  drivers/acpi/acpi_platform.c                            |   40 +-
>  drivers/acpi/acpica/Makefile                            |    2 +
>  drivers/acpi/acpica/acglobal.h                          |    5 +-
>  drivers/acpi/acpica/aclocal.h                           |   29 +-
>  drivers/acpi/acpica/acmacros.h                          |    6 +-
>  drivers/acpi/acpica/acnamesp.h                          |   29 +-
>  drivers/acpi/acpica/acpredef.h                          | 1305 +++++=
+++++++++++-------
>  drivers/acpi/acpica/acutils.h                           |   28 +-
>  drivers/acpi/acpica/dsutils.c                           |   10 +-
>  drivers/acpi/acpica/dswexec.c                           |    2 +-
>  drivers/acpi/acpica/evevent.c                           |   12 +-
>  drivers/acpi/acpica/evgpe.c                             |    6 +-
>  drivers/acpi/acpica/evsci.c                             |    4 +-
>  drivers/acpi/acpica/evxface.c                           |   21 +-
>  drivers/acpi/acpica/evxfevnt.c                          |   12 +
>  drivers/acpi/acpica/exoparg2.c                          |   11 +-
>  drivers/acpi/acpica/exprep.c                            |    4 +-
>  drivers/acpi/acpica/exutils.c                           |    4 +-
>  drivers/acpi/acpica/hwacpi.c                            |   20 +-
>  drivers/acpi/acpica/nsconvert.c                         |  443 +++++=
+++
>  drivers/acpi/acpica/nseval.c                            |   26 +-
>  drivers/acpi/acpica/nspredef.c                          |  213 +---
>  drivers/acpi/acpica/nsprepkg.c                          |   10 +-
>  drivers/acpi/acpica/nsrepair.c                          |  381 +++--=
--
>  drivers/acpi/acpica/nsrepair2.c                         |   16 +-
>  drivers/acpi/acpica/nsutils.c                           |    8 +-
>  drivers/acpi/acpica/psargs.c                            |    2 +-
>  drivers/acpi/acpica/rscalc.c                            |    6 +
>  drivers/acpi/acpica/rsdump.c                            |    8 +
>  drivers/acpi/acpica/rslist.c                            |    8 +
>  drivers/acpi/acpica/rsxface.c                           |    8 +-
>  drivers/acpi/acpica/tbfadt.c                            |    4 +
>  drivers/acpi/acpica/tbxface.c                           |   22 +-
>  drivers/acpi/acpica/utaddress.c                         |    4 +-
>  drivers/acpi/acpica/utcache.c                           |   18 +-
>  drivers/acpi/acpica/utdelete.c                          |   96 +-
>  drivers/acpi/acpica/utexcep.c                           |   26 +-
>  drivers/acpi/acpica/utglobal.c                          |    2 +
>  drivers/acpi/acpica/utmutex.c                           |    9 +-
>  drivers/acpi/acpica/utosi.c                             |   26 +-
>  drivers/acpi/acpica/utpredef.c                          |  399 +++++=
++
>  drivers/acpi/acpica/utxface.c                           |   17 +-
>  drivers/acpi/battery.c                                  |    2 +-
>  drivers/acpi/bus.c                                      |    5 +-
>  drivers/acpi/button.c                                   |    1 +
>  drivers/acpi/container.c                                |  152 +--
>  drivers/acpi/device_pm.c                                |   39 +-
>  drivers/acpi/fan.c                                      |    8 +-
>  drivers/acpi/internal.h                                 |   21 +-
>  drivers/acpi/osl.c                                      |    2 +-
>  drivers/acpi/pci_link.c                                 |    1 +
>  drivers/acpi/pci_root.c                                 |    4 +-
>  drivers/acpi/power.c                                    |   60 +-
>  drivers/acpi/processor_thermal.c                        |   24 +-
>  drivers/acpi/processor_throttling.c                     |    3 +-
>  drivers/acpi/scan.c                                     |  531 +++++=
+---
>  drivers/acpi/sysfs.c                                    |   66 ++
>  drivers/acpi/video.c                                    |  110 +-
>  drivers/acpi/video_detect.c                             |   25 +-
>  drivers/base/power/domain.c                             |    6 +-
>  drivers/base/power/generic_ops.c                        |    2 +-
>  drivers/base/power/main.c                               |    2 +-
>  drivers/base/power/opp.c                                |    1 +
>  drivers/base/power/runtime.c                            |    2 +-
>  drivers/clk/x86/Makefile                                |    2 +-
>  drivers/clk/x86/clk-lpss.c                              |   99 --
>  drivers/clk/x86/clk-lpss.h                              |   36 -
>  drivers/clk/x86/clk-lpt.c                               |   40 +-
>  drivers/cpufreq/Kconfig                                 |   89 ++
>  drivers/cpufreq/Kconfig.arm                             |  147 ++-
>  drivers/cpufreq/Kconfig.powerpc                         |   18 +
>  drivers/cpufreq/Kconfig.x86                             |   17 +
>  drivers/cpufreq/Makefile                                |   41 +-
>  drivers/cpufreq/acpi-cpufreq.c                          |   11 +-
>  drivers/cpufreq/amd_freq_sensitivity.c                  |  148 +++
>  drivers/cpufreq/arm_big_little.c                        |  282 +++++
>  drivers/cpufreq/arm_big_little.h                        |   40 +
>  drivers/cpufreq/arm_big_little_dt.c                     |   92 ++
>  .../cpufreq.c =3D> drivers/cpufreq/at32ap-cpufreq.c       |    5 +-
>  .../cpufreq.c =3D> drivers/cpufreq/blackfin-cpufreq.c     |   79 +-
>  drivers/cpufreq/cpufreq-cpu0.c                          |   31 +-
>  drivers/cpufreq/cpufreq-nforce2.c                       |   11 +-
>  drivers/cpufreq/cpufreq.c                               |  402 +++++=
--
>  drivers/cpufreq/cpufreq_conservative.c                  |  244 +++--
>  drivers/cpufreq/cpufreq_governor.c                      |  291 +++--
>  drivers/cpufreq/cpufreq_governor.h                      |  128 ++-
>  drivers/cpufreq/cpufreq_ondemand.c                      |  363 ++++-=
--
>  .../cpufreq.c =3D> drivers/cpufreq/cris-artpec3-cpufreq.c |   20 +-
>  .../cpufreq.c =3D> drivers/cpufreq/cris-etraxfs-cpufreq.c |   17 +-
>  .../cpufreq.c =3D> drivers/cpufreq/davinci-cpufreq.c      |   35 +-
>  drivers/cpufreq/dbx500-cpufreq.c                        |   22 +-
>  drivers/cpufreq/e_powersaver.c                          |   11 +-
>  drivers/cpufreq/elanfreq.c                              |   10 +-
>  drivers/cpufreq/exynos-cpufreq.c                        |    9 +-
>  drivers/cpufreq/exynos5440-cpufreq.c                    |  478 +++++=
++++
>  drivers/cpufreq/gx-suspmod.c                            |   11 +-
>  .../cpufreq/ia64-acpi-cpufreq.c                         |   23 +-
>  drivers/cpufreq/imx6q-cpufreq.c                         |   12 +-
>  .../cpu.c =3D> drivers/cpufreq/integrator-cpufreq.c       |    8 +-
>  drivers/cpufreq/intel_pstate.c                          |   21 +-
>  drivers/cpufreq/kirkwood-cpufreq.c                      |   18 +-
>  drivers/cpufreq/longhaul.c                              |   18 +-
>  .../mips/kernel =3D> drivers}/cpufreq/loongson2_cpufreq.c |   11 +-
>  drivers/cpufreq/maple-cpufreq.c                         |    5 +-
>  drivers/cpufreq/omap-cpufreq.c                          |   34 +-
>  drivers/cpufreq/p4-clockmod.c                           |   13 +-
>  drivers/cpufreq/pcc-cpufreq.c                           |    5 +-
>  drivers/cpufreq/powernow-k6.c                           |   12 +-
>  drivers/cpufreq/powernow-k7.c                           |   10 +-
>  drivers/cpufreq/powernow-k8.c                           |   19 +-
>  .../cbe_cpufreq.c =3D> drivers/cpufreq/ppc_cbe_cpufreq.c  |    8 +-
>  .../cbe_cpufreq.h =3D> drivers/cpufreq/ppc_cbe_cpufreq.h  |    4 +-
>  .../cpufreq/ppc_cbe_cpufreq_pervasive.c                 |    2 +-
>  .../cpufreq/ppc_cbe_cpufreq_pmi.c                       |    2 +-
>  .../cpufreq/pxa2xx-cpufreq.c                            |    7 +-
>  .../cpufreq/pxa3xx-cpufreq.c                            |   10 +-
>  drivers/cpufreq/s3c2416-cpufreq.c                       |    5 +-
>  drivers/cpufreq/s3c64xx-cpufreq.c                       |    7 +-
>  drivers/cpufreq/s5pv210-cpufreq.c                       |    5 +-
>  .../cpu-sa1100.c =3D> drivers/cpufreq/sa1100-cpufreq.c    |    8 +-
>  .../cpu-sa1110.c =3D> drivers/cpufreq/sa1110-cpufreq.c    |    8 +-
>  drivers/cpufreq/sc520_freq.c                            |   10 +-
>  .../sh/kernel/cpufreq.c =3D> drivers/cpufreq/sh-cpufreq.c |   22 +-
>  .../cpufreq/sparc-us2e-cpufreq.c                        |   19 +-
>  .../cpufreq/sparc-us3-cpufreq.c                         |   19 +-
>  drivers/cpufreq/spear-cpufreq.c                         |    7 +-
>  drivers/cpufreq/speedstep-centrino.c                    |   28 +-
>  drivers/cpufreq/speedstep-ich.c                         |   12 +-
>  drivers/cpufreq/speedstep-smi.c                         |    5 +-
>  .../cpu-tegra.c =3D> drivers/cpufreq/tegra-cpufreq.c      |   17 +-
>  .../cpu-ucv2.c =3D> drivers/cpufreq/unicore2-cpufreq.c    |    7 +-
>  drivers/cpuidle/Kconfig                                 |    6 -
>  drivers/cpuidle/Makefile                                |    2 +-
>  drivers/cpuidle/cpuidle-kirkwood.c                      |    6 +-
>  drivers/cpuidle/cpuidle.c                               |    9 +
>  drivers/cpuidle/driver.c                                |   31 +-
>  drivers/gpu/drm/i915/intel_opregion.c                   |    4 +-
>  drivers/platform/x86/sony-laptop.c                      |    3 +-
>  drivers/pnp/pnpacpi/rsparser.c                          |    1 +
>  include/acpi/acexcep.h                                  |  461 ++++-=
---
>  include/acpi/acoutput.h                                 |   53 +-
>  include/acpi/acpi_bus.h                                 |   33 +-
>  include/acpi/acpi_drivers.h                             |    1 -
>  include/acpi/acpixf.h                                   |    2 +-
>  include/acpi/actbl2.h                                   |   47 +
>  include/acpi/actbl3.h                                   |   55 +-
>  include/acpi/actypes.h                                  |    1 -
>  include/linux/acpi.h                                    |    4 +-
>  include/linux/clockchips.h                              |   32 +-
>  include/linux/cpufreq.h                                 |   21 +-
>  include/linux/cpuidle.h                                 |    3 +
>  include/linux/platform_data/clk-lpss.h                  |   18 +
>  kernel/power/suspend.c                                  |   22 +-
>  233 files changed, 6750 insertions(+), 3532 deletions(-)
>=20
>=20
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

