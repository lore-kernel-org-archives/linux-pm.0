Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8183BCD04
	for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2026 18:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786647147; cv=none; b=duLrmuisVl9X2FyCI4cFmE+ioTtDxg7kIHlKFzb0OLE2lvVM8rDfl/x4ctV99adrtCDkbB4tu/azDJtedXuYlbQKpKtk6Mboqqj+1qd0h8rKAuc0IpgenxRlNPqaDnLff7tAefd41v3TOVGxdDOYTXlqE7r7ucL1SVwgWg16TAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786647147; c=relaxed/simple;
	bh=W+ie+bBX+h8sWuMFti8GFhYHUpWWLpmVzKbTFUWFCQk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=SnepWcgbWkH4h1QvQrwqNsyMkDR7FN07roYog700GPe6y79UtEUKEYG/KCKrMG7P1+5yXX7zieGnDBxozDiKeEVXfNO2pvhQdpVRj/viBv7cwx93Qpb5t0a2mw6KeTWHHnBWEiIfRcanpA5kNN0loKvmFNhUOYGd9G5Iw0cx94o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GeR3BvCA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GeR3BvCA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3BC1F00A3D
	for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2026 18:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786647144;
	bh=RmmciqbalK1atmqi9hQzyON9o4LPwPnpghmENEiq9pI=;
	h=From:Date:Subject:To:Cc;
	b=GeR3BvCAv47yhvAZhpDD4kd1HA8/goo+96CNJ7c7JybMhxvUV7CTFaBm78vPvH+yI
	 XhevhmiBaZ69rs6x4zeKDtHTW1jyIW2HYqOFSU4PX9RGaex27zEO5GJHjwugIZSpju
	 hBuubyhfusxGgKXlfue4fatOMRvN7MRrxiHlNK81OdC4+N3fhqorK4wM+/8jNLgG19
	 2FMWMao1MfwuXVFMjly6cSOhPA1v2mbRbLQvZ1hLwQKEIPValgfocXfU7auXhATOnR
	 dr0U1BX0TY2e2rr6ums38odc8LIkB/BMRwt+IJXdeICsWsH/Hww9MrApLgU/IS4VS6
	 jDlQrSDQSz5jg==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5b0f19bea2fso131063e87.1
        for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2026 11:52:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrTAgX0gdPfkJDCbHSqm/hdZ95VtfnsYzI8H3EV+1ooddzdsIs3yDCn2WrLjw6ws6G12QIsCuMMWw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3WjVjnbu2CclPImQmhAH4jgbxqtwCNy0Fo1uM8l8KzJwA/QYz
	zkhu8aOUcJz/mIr70F54bRjwkSfcovz53NF2TNQaPNadrA0KXZGZdlWoXQn4q/P2QkyZd32oL3A
	Ge/zq+qjpVswiFMCrno8XoT84K5HbyNM=
X-Received: by 2002:a05:6512:61dc:20b0:5b2:b705:445a with SMTP id
 2adb3069b0e04-5b453f8c6d8mr1013283e87.45.1786647143097; Thu, 13 Aug 2026
 11:52:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 13 Aug 2026 20:52:00 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h7+MKn52LePu1qqJucAqGpJB3cHZu7Adccsy1TQEJ4rw@mail.gmail.com>
X-Gm-Features: AUfX_mxuCujcF-8mjtaWZsYh4HY8ltbuznroTh1zLT0Cl7-T3jWyL3r2ElaKVQ0
Message-ID: <CAJZ5v0h7+MKn52LePu1qqJucAqGpJB3cHZu7Adccsy1TQEJ4rw@mail.gmail.com>
Subject: [GIT PULL] ACPI support updates for 7.3-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

This goes early for your convenience.

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-7.3-rc1

with top-most commit 79ba234b396b0fdcb3a82dd8aa872348f4069aae

 Merge branch 'acpi-video'

on top of commit 075b74841bd0065a3bda3440873c747938e69b68

 Linux 7.2-rc6

to receive ACPI support updates for 7.3-rc1.

The most significant change here is the elimination of struct
acpi_driver that has no more users in the tree now along with some
documentation related to it, and a follow-up update to set the "no PM"
flag for all ACPI devices that are now only going to play the role of
other devices' "companions" (in analogy with DT nodes).

There is also a significant update of irqchip code related to ACPI done
in order to enable GICv5 IWB ACPI probe ordering detection on ARM, which
involves RISC-V interrupt controller management code refactoring to
extract generic code from it into the common ACPI IRQ code.

The rest is mostly fixes, including some fallout of the _OSC handling
rework in 7.0, ACPI CPPC library fixes, a workaround for registering
ACPI platform devices with overlapping I/O or memory resources, an ACPI
EC driver fix related to probe deferral on platforms using HW-reduced
ACPI, two ACPI battery driver fixes and a workaround for handling
model numbers with unprintable characters in it, probe error cleanup
and driver unload code path fixes, hardware error reporting fixes,
documentation fixes, and assorted code cleanups all over.

Specifics:

 - Eliminate struct acpi_driver whose users have all been converted to
   bind to platform devices or auxiliary devices and set the "no power
   management" flag for all struct acpi_device objects (Rafael Wysocki)

 - Avoid complaints regarding missing _OSC features on platforms where
   OSC_CAPABILITIES_MASK_ERROR is set in _OSC error bits even though all
   of the requested features are actually acknowledged (Rafael Wysocki)

 - Avoid printing confusing _OSC messages for non-PCIe host bridges
   without _OSC which is a valid configuration (Kazuma Kondo)

 - Use correct region struct for BERT region size check and properly
   map BERT and CCEL data to their ACPI tables (Thomas Renninger)

 - Add acpi_device_clear_deps(), refactor RISC-V interrupt controller
   management code to extract generic code from it into the common ACPI
   IRQ code, and enable GICv5 IWB ACPI probe ordering detection on ARM
   on top of that (Lorenzo Pieralisi)

 - Stop using acpi_device_name() in the PNP core, stop setting
   acpi_device_name/class() in the Xen variant of the ACPI PAD
   (Processor Aggregator Device) driver, and make the Loongarch
   laptop driver stop setting acpi_device_class() (Rafael Wysocki)

 - Fix issues related to the desired_perf register access in the ACPI
   CPPC library and update it to avoid unnecessary overhead (Christian
   Loehle)

 - Simplify acpi_get_pci_dev() with the help of a mutex guard, introduce
   acpi_dev_get_pci_dev() for code that has a struct ACPI device for
   which it wants to get the struct pci_dev pointer of the associated
   PCI device, and use it in the ACPI video bus driver (Rafael Wysocki)

 - Avoid registering platform devices with resource overlaps in the ACPI
   core device enumeration code (Rafael Wysocki)

 - Clean up the list of included header files in the NHLT table parser
   and validate the table and record lengths in the FPDT parser (Andy
   Shevchenko and Pengpeng Hou)

 - Unregister the cpufreq notifier on init failure in the ACPI processor
   driver (Can Peng)

 - Validate MADT IOAPIC entry bounds during IOAPIC hotplug lookup in the
   ACPI processor driver (Pengpeng Hou)

 - Avoid _REG disconnect on probe deferrals related to GPIO IRQ in the
   ACPI EC driver (Zhu Ling)

 - Update kerneldoc comments of two structures in the ACPI bus type code
   to use correct struct member names to avoid warnings (Randy Dunlap)

 - Use a correct function parameter name in kernel-doc in the ACPI fan
   driver (Randy Dunlap)

 - Update ACPI fan IDs to follow modern style and clean up header file
   inclusions in the ACPI fan driver (Andy Shevchenko)

 - Use devm_acpi_install_notify_handler() to replace a custom open-coded
   devres-based management of an ACPI notify handler in the ACPI fan
   driver (Rafael Wysocki)

 - Adjust charging status validation check in the ACPI battery driver to
   avoid incorrect status reporting (Rafael Wysocki)

 - Merge consecutive battery notifications in the ACPI battery driver to
   reduce the pressure on STA, _BST and _BIX/_BIF ACPI control methods
   and make that driver use kstrtoul() instead of sscanf("%lu\n") (Rong
   Zhang)

 - Sanitise model_number in the ACPI battery driver by dropping
   unprintable characters (Kate Hsuan)

 - Remove a node_set() call that is redundant from
   acpi_parse_memory_affinity() (Sang-Heon Jeon)

 - Prevent kernel-doc warnings by converting 2 function description
   comments to kernel-doc format (Randy Dunlap)

 - Fix docs build error in the ACPI admin-guide documentation (Randy
   Dunlap)

 - Replace __get_free_page() with kmalloc() in the code handling ACPI
   NVS memory during system suspend/resume (Mike Rapoport)

 - Fix card device cleanup on registration failure in the core PNP
   code (Yuho Choi)

 - Drop an unused assignment of pnp_device_id driver data (Uwe
   Kleine-K=C3=B6nig)

 - Clear driver_data on all paths that free acpi_pci_root in
   acpi_pci_root_add() (Chen Pei)

 - Add locking around evaluation of ACPI control methods in the ACPI TAD
   driver to avoid race conditions (Rafael Wysocki)

 - Handle repeated SEA error storms in APEI (Junhao He)

 - Fix ERST timeout unit conversion in APEI (Nirmoy Das)

 - Fix ARM section length accounting after header in the ACPI APEI GHES
   driver (TanZheng)

 - Mark ghes_in_nmi_spool_from_list() as maybe unused (Rui Qi)

 - Introduce helper function acpi_dev_is_video_device() and use it in
   the core ACPI device enumeration code, in the ACPI video bus driver,
   in the ACPI support code for I2C, in the PCI VGA driver, and in the
   x86 platform thinkpad_acpi driver (Andy Shevchenko)

 - Add a quirk to use the native backlight on Acer Nitro AN515-46 to the
   ACPI video bus driver (Marcos Paulo Medeiros)

 - Release PCI device reference after lookup in video_detect_portege_r100()
   in the ACPI video bus driver (Yuho Choi)

The ACPI IRQ code updates included here had a merge conflict with the risc-=
v
tree in linux-next as per

https://lore.kernel.org/lkml/anSH5R8s3L_Br-Zw@sirena.org.uk/

Thanks!


---------------

Andy Shevchenko (9):
      ACPI: utils: Introduce acpi_dev_is_video_device() helper
      ACPI: scan: Convert to use acpi_dev_is_video_device() helper
      ACPI: video: Convert to use acpi_dev_is_video_device() helper
      i2c: acpi: Convert to use acpi_dev_is_video_device() helper
      PCI/VGA: Convert to use acpi_dev_is_video_device() helper
      platform/x86: thinkpad_acpi: Convert to use
acpi_dev_is_video_device() helper
      ACPI: fan: Don't use "proxy" headers
      ACPI: fan: Update ACPI fan IDs to follow modern style
      ACPI: NHLT: Remove always included kconfig.h

Can Peng (1):
      ACPI: processor: Unregister cpufreq notifier on init failure

Chen Pei (1):
      ACPI: PCI: Clear driver_data on all paths that free the acpi_pci_root

Christian Loehle (6):
      ACPI: CPPC: Reject desired_perf reads on _CPC revision 4+
      ACPI: CPPC: Skip desired_perf read in cppc_get_perf()
      ACPI: CPPC: Stop reading desired_perf in cppc_get_perf()
      ACPI: CPPC: Avoid unnecessary reads for full-width writes
      ACPI: CPPC: Avoid locking standalone full-width registers
      ACPI: CPPC: Evaluate performance-control PCC use once

Junhao He (1):
      ACPI: APEI: Handle repeated SEA error storms

Kate Hsuan (1):
      ACPI: battery: Sanitise model_number by dropping unprintable characte=
rs

Kazuma Kondo (1):
      ACPI: PCI: Avoid misleading _OSC messages for non-PCIe host
bridges without _OSC

Lorenzo Pieralisi (7):
      ACPI: Add acpi_device_clear_deps() helper function
      ACPI: RISC-V: Fix riscv_acpi_irq_get_dep() loop termination
      ACPI: RISC-V: Check acpi_get_handle() status in riscv_acpi_add_prt_de=
p()
      ACPI: RISC-V: Fix riscv_acpi_add_prt_dep() loop handling
      ACPI: irq: Move RISC-V interrupt controllers autodep to ACPI IRQ code
      ACPI/IORT: Implement ACPI infrastructure to enable GICv5 IWB
probe deferral
      irqchip/gic-v5: Enable GICv5 IWB ACPI probe ordering detection

Marcos Paulo Medeiros (1):
      ACPI: video: force native backlight on Acer Nitro AN515-46

Mike Rapoport (Microsoft) (1):
      ACPI: NVS: replace __get_free_page() with kmalloc()

Nirmoy Das (1):
      ACPI: APEI: Fix ERST timeout unit conversion

Pengpeng Hou (2):
      ACPI: FPDT: validate table and record lengths
      ACPI: processor: validate MADT IOAPIC entry bounds

Rafael J. Wysocki (14):
      ACPI: bus: Eliminate struct acpi_driver
      ACPI: scan: Set power.no_pm for all struct acpi_device objects
      ACPI: fan: Use devm_acpi_install_notify_handler()
      platform/loongarch: laptop: Stop setting acpi_device_class()
      ACPI: PAD: xen: Stop setting acpi_device_name/class()
      PNP: ACPI: Stop using acpi_device_name()
      ACPI: PCI: Use a mutex guard to simplify acpi_get_pci_dev()
      ACPI: PCI: Introduce acpi_dev_get_pci_dev()
      ACPI: video: Drop backlight parent device reference later
      ACPI: video: Use acpi_dev_get_pci_dev() instead of acpi_get_pci_dev()
      ACPI: battery: Adjust charging status validation check
      ACPI: bus: Avoid confusing complaints regarding missing _OSC features
      ACPI: TAD: Add locking around AML evaluations
      ACPI: scan: Avoid registering platform devices with resource overlaps

Randy Dunlap (4):
      docs: ACPI: DSD: motorcomm: fix docs build error
      ACPI: fan: Use correct function parameter name in kernel-doc
      ACPI: bus: Use correct struct member names
      ACPI: pmtmr: Convert to kernel-doc format

Rong Zhang (2):
      ACPI: battery: Merge consecutive battery notifications
      ACPI: battery: Use kstrtoul() over sscanf("%lu\n")

Rui Qi (1):
      ACPI: APEI: GHES: Mark ghes_in_nmi_spool_from_list() as maybe unused

Sang-Heon Jeon (1):
      ACPI: NUMA: remove redundant node_set() call

TanZheng (1):
      ACPI: APEI: GHES: fix ARM section length accounting after header

Thomas Renninger (2):
      ACPI: Use correct region struct for BERT region size check
      ACPI: sysfs: Properly map BERT and CCEL data to their ACPI tables

Uwe Kleine-K=C3=B6nig (The Capable Hub) (1):
      PNP: Drop unused assignment of pnp_device_id driver data

Yuho Choi (2):
      PNP: Fix card device cleanup on registration failure
      ACPI: video: Release PCI device reference after lookup

Zhu Ling (1):
      ACPI: EC: Avoid _REG disconnect on GPIO IRQ defer

---------------

 Documentation/driver-api/acpi/acpi-drivers.rst     |  80 ----------
 Documentation/driver-api/acpi/index.rst            |   1 -
 .../acpi/dsd/motorcomm-yt8xxx-phy.rst              |   5 +-
 arch/riscv/include/asm/acpi.h                      |   1 +
 drivers/acpi/acpi_fpdt.c                           |  53 ++++++-
 drivers/acpi/acpi_platform.c                       |  39 ++++-
 drivers/acpi/acpi_tad.c                            |  50 +++---
 drivers/acpi/acpi_video.c                          |  14 +-
 drivers/acpi/apei/erst.c                           |   2 +-
 drivers/acpi/apei/ghes.c                           |  16 +-
 drivers/acpi/arm64/iort.c                          |  22 ++-
 drivers/acpi/battery.c                             | 147 ++++++++++++++---=
-
 drivers/acpi/bus.c                                 | 152 ++---------------=
-
 drivers/acpi/cppc_acpi.c                           | 171 +++++++++++++++--=
---
 drivers/acpi/ec.c                                  |  40 +++--
 drivers/acpi/fan.h                                 |  27 ++--
 drivers/acpi/fan_core.c                            |  25 +--
 drivers/acpi/irq.c                                 | 172 +++++++++++++++++=
+++-
 drivers/acpi/numa/srat.c                           |   2 -
 drivers/acpi/nvs.c                                 |   4 +-
 drivers/acpi/pci_root.c                            |  47 +++---
 drivers/acpi/power.c                               |   1 -
 drivers/acpi/processor_core.c                      |  31 +++-
 drivers/acpi/processor_driver.c                    |   6 +
 drivers/acpi/riscv/irq.c                           | 141 +----------------
 drivers/acpi/scan.c                                |  22 +--
 drivers/acpi/sysfs.c                               |  11 +-
 drivers/acpi/utils.c                               |  17 ++
 drivers/acpi/video_detect.c                        |  21 ++-
 drivers/cpufreq/cppc_cpufreq.c                     |   2 +-
 drivers/i2c/i2c-core-acpi.c                        |  15 +-
 drivers/irqchip/irq-gic-v3.c                       |   2 +-
 drivers/irqchip/irq-gic-v5-iwb.c                   |   2 +
 drivers/irqchip/irq-gic-v5.c                       |  13 +-
 drivers/irqchip/irq-gic.c                          |   2 +-
 drivers/irqchip/irq-loongarch-cpu.c                |   2 +-
 drivers/irqchip/irq-riscv-intc.c                   |   3 +-
 drivers/pci/vgaarb.c                               |   4 +-
 drivers/platform/x86/lenovo/thinkpad_acpi.c        |   2 +-
 drivers/pnp/card.c                                 |  11 +-
 drivers/pnp/pnpacpi/core.c                         |   5 +-
 drivers/pnp/system.c                               |   6 +-
 drivers/xen/xen-acpi-pad.c                         |   5 -
 include/acpi/acpi_bus.h                            |  54 +------
 include/acpi/acpi_drivers.h                        |   9 +-
 include/acpi/cppc_acpi.h                           |   5 +-
 include/acpi/nhlt.h                                |   1 -
 include/linux/acpi.h                               |  14 +-
 include/linux/acpi_iort.h                          |   3 +-
 include/linux/acpi_pmtmr.h                         |  10 +-
 50 files changed, 807 insertions(+), 683 deletions(-)
