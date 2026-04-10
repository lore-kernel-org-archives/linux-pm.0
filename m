Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08CF3D16F4
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 14:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775831268; cv=none; b=eBlkk6ARDlAl8aLd5ud1K6IFBCej2Lz+OhqAE6wPwlSwV2BwcxK/b6TK58+U4AA5grFph3vjuvfu8uck5V3tSZxF/8syDf3xl3xBwOZXayi80+/QuJreQOHNufAW/YO20MSlHaN53Ww3aZRUZyy6+4p61HYQWNJ1ecOErUej0cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775831268; c=relaxed/simple;
	bh=5OF6/4w4OAfRYl2jkechvWsUDuDKyomm4FcDklBAcZs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ec8PLtegZrfhpaI9mZfVOzTq8VRBF5g0hAfqsWy0EdpiJFk0o7R7hppFfLfA8PvuVBXtNP7qA/j3caZdrpb1iZwX8BVS5kW7uBc6ysREesiAqSz4BH73oqUcRFbrVuwprjlVa6KaJ9vgrOSUDENyqVn39mGHz8I067sI1P4sgZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCk6106c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCk6106c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876BEC19421
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 14:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775831268;
	bh=5OF6/4w4OAfRYl2jkechvWsUDuDKyomm4FcDklBAcZs=;
	h=From:Date:Subject:To:Cc:From;
	b=XCk6106cmcqvda/Wlw8Z94zd0+uy2lOL7ZxJ7OVtePWYsFx1mxIKY7Q2hv80kRzah
	 FAG1g+x4riFVivzvsYZY+V/mGlmOPyf+R5pAXPh4nOG3hN1R7/hBmYFPho47g0XW0z
	 NA9CXZyGCjTuIbHACNqWSm2n+xsQ1YlsRk6Pi6rlLyA2vjAu3DI2+fyzvm8wq3a7VN
	 hjLzyqqQEaj3UIbFn4Ei70KgtkkmTc/gLqubwAd7tl1ANMHNCYrA+nyW1vD5xCZGr1
	 xtCFGEBQIYgF+6TjF2Nnjj5v+LHe+tq+V+87RX+nA9MM2hTpECm8b35Wwbzkozch77
	 E90DR4qZhTz5g==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-682d981b025so1247463eaf.3
        for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 07:27:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAgxj6cBiS76CAOaqsrcVZ9D7mGZI17visJ4pHP0eTVStnaLZgBI1+j2/rNg3VaqyExz69sjQOZA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3naNgwiH9gGUuOdEwzi8FYW2td/NOtplxMtdoXXH/rBjwB7ZJ
	iS3uYPemxasHvjgEMtEDxmb5CAgWfSuOsV77qo0X7tQab/QK9cLLElY9okBn9GQKVibCRnwPX71
	WFpbwpJs2KmewPwul5wsF2MCPShK6cZY=
X-Received: by 2002:a05:6820:199b:b0:681:6a53:6662 with SMTP id
 006d021491bc7-68be5e56a57mr1513712eaf.13.1775831267653; Fri, 10 Apr 2026
 07:27:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 10 Apr 2026 16:27:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i9EjajGD55kAXtQz=NjvqT8ffcmEYS_dHoFvu901TjwA@mail.gmail.com>
X-Gm-Features: AQROBzAQ4cr0bU2BOWe-65L7XX_jjNVAHsKgnDvzktqeNPVPY2KBQNc1UZszAb4
Message-ID: <CAJZ5v0i9EjajGD55kAXtQz=NjvqT8ffcmEYS_dHoFvu901TjwA@mail.gmail.com>
Subject: [GIT PULL] ACPI support updates for v7.1-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

This goes early because I will be traveling next week.

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-7.1-rc1

with top-most commit 8e937866b425248fa375b2138c19c117a87c6be0

 Merge branch 'acpi-apei'

on top of commit 591cd656a1bf5ea94a222af5ef2ee76df029c1d2

 Linux 7.0-rc7

to receive ACPI support updates for 7.1-rc1.

These include an update of the CMOS RTC driver and the related ACPI
and x86 code that, among other things, switches it over to using the
platform device interface for device binding on x86 instead of the PNP
device driver interface (which allows the code in question to be
simplified quite a bit), a major update of the ACPI Time and Alarm
Device (TAD) driver adding an RTC class device interface to it, and
updates of core ACPI drivers that remove some unnecessary and not
really useful code from them.

Apart from that, two drivers are converted to using the platform driver
interface for device binding instead of the ACPI driver one, which is
slated for removal, support for the Performance Limited register is
added to the ACPI CPPC library and there are some janitorial updates
of it and the related cpufreq CPPC driver, the ACPI processor driver is
fixed and cleaned up, and NVIDIA vendor CPER record handler is added
to the APEI GHES code.

Also, the interface for obtaining a CPU UID from ACPI is consolidated
across architectures and used for fixing a problem with the PCI TPH
Steering Tag on ARM64, there are two updates related to ACPICA, a
minor ACPI OS Services Layer (OSL) update, and a few assorted updates
related to ACPI tables parsing.

Specifics:

 - Update maintainers information regarding ACPICA (Rafael Wysocki)

 - Replace strncpy() with strscpy_pad() in acpi_ut_safe_strncpy() (Kees
   Cook)

 - Trigger an ordered system power off after encountering a fatal error
   operator in AML (Armin Wolf)

 - Enable ACPI FPDT parsing on LoongArch (Xi Ruoyao)

 - Remove the temporary stop-gap acpi_pptt_cache_v1_full structure from
   the ACPI PPTT parser (Ben Horgan)

 - Add support for exposing ACPI FPDT subtables FBPT and S3PT (Nate
   DeSimone)

 - Address multiple assorted issues and clean up the code in the ACPI
   processor idle driver (Huisong Li)

 - Replace strlcat() in the ACPI processor idle drive with a better
   alternative (Andy Shevchenko)

 - Rearrange and clean up acpi_processor_errata_piix4() (Rafael Wysocki)

 - Move reference performance to capabilities and fix an uninitialized
   variable in the ACPI CPPC library (Pengjie Zhang)

 - Add support for the Performance Limited Register to the ACPI CPPC
   library (Sumit Gupta)

 - Add cppc_get_perf() API to read performance controls, extend
   cppc_set_epp_perf() for FFH/SystemMemory, and make the ACPI CPPC
   library warn on missing mandatory DESIRED_PERF register (Sumit Gupta)

 - Modify the cpufreq CPPC driver to update MIN_PERF/MAX_PERF in target
   callbacks to allow it to control performance bounds via standard
   scaling_min_freq and scaling_max_freq sysfs attributes and add sysfs
   documentation for the Performance Limited Register to it (Sumit Gupta)

 - Add ACPI support to the platform device interface in the CMOS RTC
   driver, make the ACPI core device enumeration code create a platform
   device for the CMOS RTC, and drop CMOS RTC PNP device support (Rafael
   Wysocki)

 - Consolidate the x86-specific CMOS RTC handling with the ACPI TAD
   driver and clean up the CMOS RTC ACPI address space handler (Rafael
   Wysocki)

 - Enable ACPI alarm in the CMOS RTC driver if advertised in ACPI FADT
   and allow that driver to work without a dedicated IRQ if the ACPI
   alarm is used (Rafael Wysocki)

 - Clean up the ACPI TAD driver in various ways and add an RTC class
   device interface, including both the RTC setting/reading and alarm
   timer support, to it (Rafael Wysocki)

 - Clean up the ACPI AC and ACPI PAD (processor aggregator device)
   drivers (Rafael Wysocki)

 - Rework checking for duplicate video bus devices and consolidate
   pnp.bus_id workarounds handling in the ACPI video bus driver (Rafael
   Wysocki)

 - Update the ACPI core device drivers to stop setting acpi_device_name()
   unnecessarily (Rafael Wysocki)

 - Rearrange code using acpi_device_class() in the ACPI core device
   drivers and update them to stop setting acpi_device_class()
   unnecessarily (Rafael Wysocki)

 - Define ACPI_AC_CLASS in one place (Rafael Wysocki)

 - Convert the ni903x_wdt watchdog driver and the xen ACPI PAD driver to
   bind to platform devices instead of ACPI devices (Rafael Wysocki)

 - Add devm_ghes_register_vendor_record_notifier(), use it in the PCI
   hisi driver, and Add NVIDIA vendor CPER record handler (Kai-Heng
   Feng)

 - Consolidate the interface for obtaining a CPU UID from ACPI across
   architectures and use it to address incorrect PCI TPH Steering Tag
   on ARM64 resulting from the invalid assumption that the ACPI
   Processor UID would always be the same as the corresponding logical
   CPU ID in Linux (Chengwen Feng)

Thanks!


---------------

Andy Shevchenko (1):
      ACPI: processor: idle: Replace strlcat() with better alternative

Armin Wolf (1):
      ACPI: OSL: Poweroff when encountering a fatal ACPI error

Ben Horgan (1):
      ACPI: PPTT: Remove duplicate structure, acpi_pptt_cache_v1_full

Chengwen Feng (8):
      arm64: acpi: Add acpi_get_cpu_uid() for unified ACPI CPU UID retrieval
      LoongArch: Add acpi_get_cpu_uid() for unified ACPI CPU UID retrieval
      RISC-V: ACPI: Add acpi_get_cpu_uid() for unified ACPI CPU UID retrieval
      x86/acpi: Add acpi_get_cpu_uid() for unified ACPI CPU UID retrieval
      ACPI: Centralize acpi_get_cpu_uid() declaration in include/linux/acpi.h
      perf: arm_cspmu: Switch to acpi_get_cpu_uid() from get_acpi_id_for_cpu()
      ACPI: PPTT: Use acpi_get_cpu_uid() and remove get_acpi_id_for_cpu()
      PCI/TPH: Pass ACPI Processor UID to Cache Locality _DSM

Huisong Li (7):
      ACPI: processor: idle: Remove redundant cstate check in
acpi_processor_power_init
      ACPI: processor: idle: Move max_cstate update out of the loop
      ACPI: processor: idle: Remove redundant static variable and
rename cstate check function
      ACPI: processor: idle: Reset power_setup_done flag on
initialization failure
      ACPI: processor: idle: Fix NULL pointer dereference in hotplug path
      cpuidle: Extract and export no-lock variants of
cpuidle_unregister_device()
      ACPI: processor: idle: Reset cpuidle on C-state list changes

Jingkai Tan (1):
      ACPI: processor: idle: Add missing bounds check in flatten_lpi_states()

Kai-Heng Feng (3):
      ACPI: APEI: GHES: Add devm_ghes_register_vendor_record_notifier()
      PCI: hisi: Use devm_ghes_register_vendor_record_notifier()
      ACPI: APEI: GHES: Add NVIDIA vendor CPER record handler

Kees Cook (1):
      ACPICA: Replace strncpy() with strscpy_pad() in acpi_ut_safe_strncpy()

Nate DeSimone (2):
      ACPI: FPDT: expose FBPT and S3PT subtables via sysfs
      Documentation: ABI: add FBPT and S3PT entries to sysfs-firmware-acpi

Pengjie Zhang (2):
      ACPI: CPPC: Move reference performance to capabilities
      ACPI: CPPC: Fix uninitialized ref variable in cppc_get_perf_caps()

Rafael J. Wysocki (37):
      ACPI: x86: cmos_rtc: Clean up address space handler driver
      ACPI: x86: cmos_rtc: Improve coordination with ACPI TAD driver
      ACPI: x86: cmos_rtc: Create a CMOS RTC platform device
      ACPI: x86/rtc-cmos: Use platform device for driver binding
      ACPI: PNP: Drop CMOS RTC PNP device support
      x86: rtc: Drop PNP device check
      rtc: cmos: Drop PNP device support
      ACPI: TAD/x86: cmos_rtc: Consolidate address space handler setup
      ACPI: AC: Get rid of unnecessary declarations
      ACPI: PAD: Rearrange notify handler installation and removal
      driver core: auxiliary bus: Introduce dev_is_auxiliary()
      ACPI: video: Rework checking for duplicate video bus devices
      ACPI: video: Consolidate pnp.bus_id workarounds handling
      ACPI: driver: Do not set acpi_device_name() unnecessarily
      ACPI: event: Redefine acpi_notifier_call_chain()
      ACPI: driver: Avoid using pnp.device_class for netlink handling
      ACPI: driver: Do not set acpi_device_class() unnecessarily
      ACPI: AC: Define ACPI_AC_CLASS in one place
      rtc: cmos: Enable ACPI alarm if advertised in ACPI FADT
      rtc: cmos: Do not require IRQ if ACPI alarm is used
      ACPI: TAD: Create one attribute group
      ACPI: TAD: Support RTC without wakeup
      ACPI: TAD: Use __free() for cleanup in time_store()
      ACPI: TAD: Rearrange RT data validation checking
      ACPI: TAD: Clear unused RT data in acpi_tad_set_real_time()
      ACPI: TAD: Add RTC class device interface
      ACPI: TAD: Update the driver description comment
      ACPI: TAD: Use dev_groups in struct device_driver
      ACPI: TAD: Use DC wakeup only if AC wakeup is supported
      ACPI: processor: Rearrange and clean up acpi_processor_errata_piix4()
      ACPI: TAD: Split three functions to untangle runtime PM handling
      ACPI: TAD: Relocate two functions
      ACPI: TAD: Split acpi_tad_rtc_read_time()
      ACPI: TAD: Add alarm support to the RTC class device interface
      ACPI: PAD: xen: Convert to a platform driver
      watchdog: ni903x_wdt: Convert to a platform driver
      ACPICA: Update maintainers information

Sumit Gupta (8):
      ACPI: CPPC: Add cppc_get_perf() API to read performance controls
      ACPI: CPPC: Warn on missing mandatory DESIRED_PERF register
      ACPI: CPPC: Extend cppc_set_epp_perf() for FFH/SystemMemory
      cpufreq: CPPC: Update cached perf_ctrls on sysfs write
      cpufreq: cppc: Update MIN_PERF/MAX_PERF in target callbacks
      ACPI: CPPC: add APIs and sysfs interface for perf_limited
      cpufreq: CPPC: Add sysfs documentation for perf_limited
      ACPI: CPPC: Check cpc_read() return values consistently

Xi Ruoyao (1):
      ACPI: tables: Enable FPDT on LoongArch

---------------

 Documentation/ABI/testing/sysfs-devices-system-cpu |  18 +
 Documentation/ABI/testing/sysfs-firmware-acpi      |   6 +
 Documentation/PCI/tph.rst                          |   4 +-
 Documentation/admin-guide/kernel-parameters.txt    |   8 +
 MAINTAINERS                                        |   8 +-
 arch/arm64/include/asm/acpi.h                      |  17 +-
 arch/arm64/kernel/acpi.c                           |  30 ++
 arch/loongarch/include/asm/acpi.h                  |   5 -
 arch/loongarch/kernel/acpi.c                       |   9 +
 arch/riscv/include/asm/acpi.h                      |   4 -
 arch/riscv/kernel/acpi.c                           |  16 +
 arch/riscv/kernel/acpi_numa.c                      |   9 +-
 arch/x86/include/asm/cpu.h                         |   1 -
 arch/x86/include/asm/smp.h                         |   1 -
 arch/x86/kernel/acpi/boot.c                        |  20 +
 arch/x86/kernel/rtc.c                              |  21 +-
 arch/x86/xen/enlighten_hvm.c                       |   5 +-
 drivers/acpi/Kconfig                               |   2 +-
 drivers/acpi/ac.c                                  |  31 +-
 drivers/acpi/acpi_fpdt.c                           |  28 ++
 drivers/acpi/acpi_memhotplug.c                     |   4 -
 drivers/acpi/acpi_pad.c                            |  28 +-
 drivers/acpi/acpi_pnp.c                            |  22 +-
 drivers/acpi/acpi_processor.c                      |  31 +-
 drivers/acpi/acpi_tad.c                            | 492 ++++++++++++++-------
 drivers/acpi/acpi_video.c                          | 100 ++---
 drivers/acpi/acpica/utnonansi.c                    |   3 +-
 drivers/acpi/apei/Kconfig                          |  14 +
 drivers/acpi/apei/Makefile                         |   1 +
 drivers/acpi/apei/ghes-nvidia.c                    | 149 +++++++
 drivers/acpi/apei/ghes.c                           |  18 +
 drivers/acpi/battery.c                             |   9 +-
 drivers/acpi/button.c                              |  11 +-
 drivers/acpi/cppc_acpi.c                           | 293 ++++++++++--
 drivers/acpi/ec.c                                  |   6 -
 drivers/acpi/event.c                               |   7 +-
 drivers/acpi/osl.c                                 |  19 +-
 drivers/acpi/pci_link.c                            |   4 -
 drivers/acpi/pci_root.c                            |   9 +-
 drivers/acpi/power.c                               |   4 -
 drivers/acpi/pptt.c                                |  81 ++--
 drivers/acpi/processor_driver.c                    |  22 +-
 drivers/acpi/processor_idle.c                      |  82 ++--
 drivers/acpi/riscv/rhct.c                          |   7 +-
 drivers/acpi/sbs.c                                 |   4 -
 drivers/acpi/sbshc.c                               |   6 -
 drivers/acpi/thermal.c                             |  13 +-
 drivers/acpi/x86/cmos_rtc.c                        |  86 ++--
 drivers/base/auxiliary.c                           |  10 +
 drivers/cpufreq/cppc_cpufreq.c                     | 104 ++++-
 drivers/cpuidle/cpuidle.c                          |  22 +-
 drivers/gpu/drm/amd/include/amd_acpi.h             |   2 -
 drivers/gpu/drm/radeon/radeon_acpi.c               |   2 -
 drivers/pci/controller/pcie-hisi-error.c           |  12 +-
 drivers/pci/tph.c                                  |  16 +-
 drivers/perf/arm_cspmu/arm_cspmu.c                 |   6 +-
 drivers/platform/x86/hp/hp-wmi.c                   |   2 -
 drivers/platform/x86/lenovo/wmi-capdata.c          |   1 -
 drivers/rtc/rtc-cmos.c                             | 143 ++----
 drivers/watchdog/ni903x_wdt.c                      |  27 +-
 drivers/xen/xen-acpi-pad.c                         |  23 +-
 include/acpi/acpi_bus.h                            |  14 +-
 include/acpi/cppc_acpi.h                           |  22 +-
 include/acpi/ghes.h                                |  11 +
 include/acpi/processor.h                           |   2 -
 include/linux/acpi.h                               |  21 +
 include/linux/auxiliary_bus.h                      |   2 +
 include/linux/cpuidle.h                            |   2 +
 include/linux/pci-tph.h                            |   4 +-
 69 files changed, 1450 insertions(+), 766 deletions(-)
