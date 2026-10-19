Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792430185;
	b=Ptp7jHBsJIWUGxA+N5ISZ52qLhVGzDmqH04yH4jAupJIdSneMifGZp9zi6jAdGj+MkG+
	 jBV2z20kKE2phiMTCUCDakhdWE+qC9oYhQ8Qa39xpyCO91bhxFAAfSDMcsF7I3HxzezgB
	 vR4us3pQjaVcjGPXHaQEyWsBWVXCt7WVYC0dKwGZs1rRgrLwbrK49Si0MWCC25FAK5MHR
	 ymiqKm5yur2mza6bu6pkA/LAi7KFBaQSevV+KQFGDMLTw+K72lsmE/EIOACO/8yOoZol5
	 M8BrvXoIAg8n+2CvnVmatsHmDq4XB3Z5l3YpHNqdsqNnSqH7NQA/y2vg9fU6cU0Fi1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792430185;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=KNa6QG02xEev42zPjltRAwPkeMqt+7DOP605rGMyNeQ=;
	b=hVijXa7uJdtyIPwJm2M3qhsJwxzFajzEDaDzRyXxAbWWiKzhM61iqWplHaQNSaJqASag
	 gacqgMvyBupwReI0Lly3KYt+/iJO6n1yE9GsUeZCuHB3fT+3gma0mVxuurqH6gWihd2xn
	 UpvOrHzXg2TKEmMdj3JqrWz+LwkbKgIt3XjSZTNJzhdJajnhLeHRO9nG17Gt9iBrYMwbR
	 bZJfZOORtvnpHt0pbDwmA+NNvYSFRf5fs9h9sSyO1iWsHMbX9Ht0tsdd6vEcciNIsc3xC
	 tcTwg9ta7nMR6D7chB1bREVzVhNU3aZZSuHlSZvbKOQNYtEBxBiFFKfA8VgdnGouEKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cNzP8CTy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F73C606A31D
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 17:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cNzP8CTy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C151F000C4
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 17:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792430184;
	bh=KNa6QG02xEev42zPjltRAwPkeMqt+7DOP605rGMyNeQ=;
	h=From:Date:Subject:To:Cc;
	b=cNzP8CTyOlFS5CqNIP9HntvRI6WnFhUJn6ghPFUZF3uEaRR/wI/jO836mzTis5dMP
	 6mY08N3JGWlUtrAomP3RrZ8jv9oyJE/uhnp38JDEgIrJttOe0jZ5C+1rEsCDNZ6tzy
	 0mz4/bl65fDBqjMaHE3RMW6JydAJFxXchNDGRsiPK/u9ZqBk5alP3JafXW8FB5/ypM
	 JILELYO1ET8/XNELPPisLBOsHIYss4xz3uEfysEND+ZEgAysFBDRycg6NMTM0qb4Mj
	 IOUVjniL/b9RRjRpohcYxWepDiJpAdroPnmsjSCam7mIyAbDhfe0JX7Ibmw2bSZrcM
	 eFn/w+061il6A==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5be4a2d94adso1905985e87.0
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 10:16:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxH/JyzxqeDNp9s84xNH59eFP/4fc7aOGJHPMsBUZizSU6QDk+dUNmw0j9TN06Q5mUVkwl7KzoSog==@vger.kernel.org
X-Gm-Message-State: AFq9FYLZ86laorC+5xOCGYNaLah0pl+oW6027g/9tX64DJh54oafPwA4
	Th+loiEyuD5APDQXIXeJqbtebtx5TP16ueKofgpircNiTRP/8wo9D0AwYc66oWZps/D/+uv2VRA
	axKlAuo/ygbxEMJFbchd6MlAJ379rjVE=
X-Received: by 2002:a05:6512:1389:b0:5be:3cd0:e511 with SMTP id
 2adb3069b0e04-5be50a8f541mr2685108e87.47.1792430182297; Mon, 19 Oct 2026
 10:16:22 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 19 Oct 2026 19:14:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jh159XME50-=dm7s7-HbE_kffbhbze-fDPi7RE+pepLg@mail.gmail.com>
X-Gm-Features: AclHuK-PfNz2MwKIeB4nJVBC5ma_8DiXQ3upIwBSnriK1rSv79z3kvTkuWjiG4c
Message-ID: <CAJZ5v0jh159XME50-=dm7s7-HbE_kffbhbze-fDPi7RE+pepLg@mail.gmail.com>
Subject: [GIT PULL] ACPI support updates for 7.4-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-7.4-rc1

with top-most commit 84c4409e8566549d0f21f25e2bac9327dc279d23

 Merge branches 'acpi-pcc', 'acpi-numa', 'acpi-pfrut', 'acpi-misc' and 'pnp=
'

on top of commit 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907

 Linux 7.3-rc7

to receive ACPI support updates for 7.4-rc1.

The most significant change here is the rework of the core ACPI device
enumeration code to avoid initializing ACPI power management prematurely
for devices with unmet dependencies.  This essentially is a problem fix,
but it requires taking PCI device enumeration ordering into account among
other things, so it is far from straightforward.  There was an attempt to
do this in the 7.3 time frame that had to be reverted, so this time it is
done much more carefully.

There is also an ACPI thermal control update rearranging the code to
register thermal class cooling devices under specific parents, which is
visible in sysfs.  This helps to figure out what is represented by those
devices much more easily, but it also allows the binding of cooling devices
to trip points in thermal zones to be adjusted so it need not rely on
specific cooling device data usage in thermal drivers.

From the number of commits perspective, the most visible part is the one
replacing acpi_get_first_physical_node() with acpi_bus_get_primary_device()
everywhere and dropping the former that was inherently racy and generally
unsafe to use.  Fortunately, the maintainers involved responded timely and
all of that could be done within one development cycle.

This material had a merge conflict in linux-next with the sound tree as
per https://lore.kernel.org/lkml/as5jp0sHNb9GeYY5@sirena.org.uk/

Another quite visible part is Dave Jiang's series fixing multiple
issues reported by Sashiko in the ACPI APEI support code with a PCI
AER improvement on top.  It took several iterations of this to make
Sashiko happy and the code in question should be much more robust going
forward.

One other thing worth mentioning separately is that the ACPI bus type
is now going to be registered as a "companion" one and it will not be
possible to register a driver binding directly to a struct acpi_device.
All of the existing users of those drivers in the tree were converted to
platform drivers in the previous cycles, so this is just a final step in
a longer journey.

Apart from the above, there are many fixes, mostly in drivers, with a
noticeable exception of a fix in the code binding devices to their
ACPI companions, new IOVT IOMMU support in ACPICA, new _Ixx object support
for suspend-to-idle on x86, multiple new quirks, mostly related to unused
ACPI power resources and backlight handling, and assorted cleanups.

Specifics:

 - Make the core ACPI device enumeration code stop attempting to
   initialize ACPI power management for devices before they are
   known to be present and functional (Rafael Wysocki)

 - Simplify and clean up the core ACPI device enumeration code on top of
   the previous adjustment and reduce debug noise coming from it (Rafael
   Wysocki)

 - Fix locking in the code binding devices to their ACPI companions,
   prevent it from replacing a valid ACPI companion pointer with NULL
   incidentally, improve its messaging (including debug noise
   reduction), and reduce its overhead by making it skip the cases in
   which no ACPI companion may exist early (Rafael Wysocki)

 - Reduce runtime memory footprint of struct acpi_device by rearranging
   fields in it (Andy Shevchenko)

 - Update the driver core to allow bus types without drivers to be
   registered as "companion bus types" without driver-related sysfs
   attributes and register the ACPI bus type as a companion one (Rafael
   Wysocki)

 - Use strscpy() instead of strcpy() in the ACPI sysfs interface (Ruslan
   Vagner)

 - Remove __meminitdata from hmat_adist_nb declaration preserving it
   even when CONFIG_MEMORY_HOTPLUG is not set to prevent notifier chain
   corruption in some cases (Alejandro Lucero)

 - Prevent a NULL pointer dereference when attempting to read the table
   length after a mapping bookkeeping failure during an initrd override
   invocation with permanent table mappings enabled (Slavin Liu)

 - Use for_each_populated_zone() in get_node_num() in the MRRM table
   pareser (Sang-Heon Jeon)

 - Use vsnprintf() in acpi_os_vprintf() to prevent memory corruption
   resulting from overly long diagnostic messages that may not fit into
   a static buffer used by ACPICA and may be produced by a malformed
   ACPI table (Vlatko Kosturjak)

 - Ignore leading root scope prefix in string _UID match to allow AMD
   IOMMU matching to work as expected in some cases (Mario Limonciello)

 - Adjust message printing macros for ACPI objects to use dev_fmt() for
   more consistency with the analogous dev_*() macros (Rafael Wysocki)

 - Add _Ixx GPE wake indicator support to the x86 suspend-to-idle
   handling code (Saranya Gopal)

 - Clear driver_data before free in the ACPI PCI Link driver to prevent
   a dangling pointer from being used later (Jiale Yao)

 - Accumulate the queued flag across error sections of a CPER record in
   ghes_do_proc() to prevent it from being cleared by a later section or
   entry that does not queue memory-failure work (Breno Leitao)

 - Map a raw PCI AER Capability image field by field to prevent
   information loss from occurring while processing it (Dave Jiang)

 - Update a stale driver source reference in the ACPI APEI EINJ driver
   documentation (Prabhakar Pujeri)

 - Reject CPER records with an out-of-range error_data_length or an
   error status block length wrapping a u32 in the EFI CPER driver (Dave
   Jiang)

 - Address multiple assorted issues in the ACPI extlog driver (Dave
   Jiang)

 - Address two issues related to CXL in the ACPI APEI GHES driver (Dave
   Jiang)

 - Read only validated fields in cper_mem_err_pack() (Dave Jiang)

 - Validate memory error section length before payload access, prevent
   writes past array bounds from occurring and sanitize software
   metadata in the ACPI APEI GHES driver (Dave Jiang)

 - Make cxl_cper_handle_prot_err() static (Dave Jiang)

 - Add IOVT IOMMU support to ACPICA (Bibo Mao)

 - Fix PCC OperationRegion command offsets in ACPICA (Sudeep Holla)

 - Fix memory leak in acpi_ds_create_field() related to the handling of
   internal_pcc_buffer allocations (Breno Leitao)

 - Fix memory leak due to leftover devm_kcalloc() argument in the ACPI
   fan driver (Rafael Wysocki)

 - Fix backlight unregistration ordering in the ACPI video bus device
   driver (Rafael Wysocki)

 - Update the thermal core to allow the registration of thermal class
   cooling devices under specific parents and convert the ACPI fan,
   ACPI processor, and ACPI video bus device drivers to do so (Rafael
   Wysocki)

 - Adjust the ACPI thermal zone driver to use thermal class cooling
   device parent information for binding cooling devices to trip points
   in thermal zones (Rafael Wysocki)

 - Use cooling device data that is a better match for a given driver
   instead of a struct acpi_device pointer that had to be used for
   this purpose previously in the ACPI fan and processor drivers (Rafael
   Wysocki)

 - Fix acpi_thermal_guess_offset() in the ACPI thermal zone driver for
   thermal zone devices with a 273.0=C2=B0K offset (Hans de Goede)

 - Define a free for ACPI objects allocated by ACPICA helpers and use
   it to simplify AML error handling in the ACPI fan driver (Rafael
   Wysocki)

 - Switch over the users of acpi_get_first_physical_node(), that
   was inherently racy and therefore not really safe to use, to use
   its replacement acpi_bus_get_primary_device(), and eliminate the
   former (Rafael Wysocki)

 - Add !CONFIG_ACPI stubs for acpi_find_child_device() and
   acpi_device_uid() (Mario Limonciello and Robin Murphy)

 - Fix bogus cycle count values on systems without _BIX in the ACPI
   battery driver (Armin Wolf)

 - Fix NULL pointer dereference on allocation failure and report
   relative state of charge as CAPACITY in the ACPI SBS driver (Itay
   Shem-tov and Guangshuo Li)

 - Add lid_init_state quirk for Razer Blade Stealth 13 (Early 2020)
   RZ09-0310 to the ACPI button driver (Ian Gallagher)

 - Add new quirks to force the native backlight on Dell OptiPlex AIO
   7410 35W and Acer Nitro AN515-58 in the ACPI video bus device
   driver (Chitransh Mandhaniya and Dirga Yuza)

 - Fix the shared memory signature handling in the ACPI PCC address
   space handler, free the PCC mailbox channel on operation region
   deactivation, and avoid unnecessary repeated computations of the
   PCC operation region command timeout (Sudeep Holla)

 - Fix a log message typo in the ACPI NUMA support code (Hemanth Selam)

 - Zero-initialize capability query result in the ACPI Platform Firmware
   Runtime Update and Telemetry driver to avoid disclosure of kernel
   stack data to user space (Karl Mehltretter)

 - Replace the remaining built-in/module check for CONFIG_ACPI_WMI in a
   header file with IS_ENABLED() macro (Lalit Shankar Chowdhury)

 - Retry probing battery docks after hotplug in the ACPI docking station
   driver to avoid missing ACPI add notifications (Vibhor Goel)

 - Detach device after resource transition failure in pnp_device_probe()
   to avoid blocking later manual PNP configuration attempts (Myeonghun
   Pak)

Thanks!


---------------

Alejandro Lucero (1):
      ACPI: HMAT: preserve hmat_adist_nb notifier block

Andy Shevchenko (1):
      ACPI: bus: Reduce runtime memory footprint of struct acpi_device

Armin Wolf (1):
      ACPI: battery: Fix bogus cycle count values on systems without _BIX

Bibo Mao (1):
      ACPICA: actbl2.h: Add bit constants of the Flags field in the
IOVT IOMMU structure

Breno Leitao (2):
      ACPICA: Fix memory leak in acpi_ds_create_field()
      ACPI: APEI: accumulate the queued flag across error sections

Chitransh Mandhaniya (1):
      ACPI: video: force native backlight on Dell OptiPlex AIO 7410 35W

Dave Jiang (14):
      efi/cper: Reject CPER records with an out-of-range error_data_length
      efi/cper: Reject an error status block length that wraps a u32
      ACPI: extlog: Validate elog record length before walking sections
      ACPI: extlog: Defer CXL protocol error handling to avoid lock inversi=
on
      ACPI: extlog: Avoid populating software AER metadata from raw
hardware buffer
      ACPI: extlog: Validate PCIe error section length before payload acces=
s
      ACPI: extlog: Fix CONFIG_ACPI_APEI_PCIEAER guard typo
      ACPI: APEI: GHES: Bound CXL event record copy to the firmware
section length
      ACPI: APEI: GHES: Validate CXL protocol error section length
before RAS cap copy
      efi/cper: Read only validated fields in cper_mem_err_pack()
      ACPI: APEI: GHES: Validate memory error section length before
payload access
      ACPI: APEI: GHES: Bound AER info copy and sanitize software metadata
      cxl/ras: Make cxl_cper_handle_prot_err() static
      PCI/AER: Map a raw AER Capability image field by field

Dirga Yuza (1):
      ACPI: video: add backlight=3Dnative DMI quirk on Acer Nitro AN515-58

Guangshuo Li (1):
      ACPI: SBS: Fix NULL pointer dereference on allocation failure

Hakan Abay (1):
      ACPI: PM: Add unused power resource quirk for Casper Excalibur G900

Hans de Goede (1):
      ACPI: thermal: Fix acpi_thermal_guess_offset() for device with a
273.0=C2=B0K offset

Hemanth Selam (1):
      ACPI: NUMA: fix typo in log message

Ian Gallagher (1):
      ACPI: button: Add lid_init_state quirk for Razer Blade Stealth
13 (Early 2020) RZ09-0310

Itay Shem-tov (1):
      ACPI: SBS: report relative state of charge as CAPACITY

Jiale Yao (1):
      ACPI: PCI: pci_link: clear driver_data before free

Karl Mehltretter (1):
      ACPI: pfr_update: zero-initialize capability query result

Krittikun Wongnin (1):
      ACPI: PM: Add Acer Aspire A515-53G to
dmi_leave_unused_power_resources_on[]

Lalit Shankar Chowdhury (1):
      ACPI: WMI: use IS_ENABLED() to simplify built-in or module check

Mario Limonciello (2):
      ACPI: utils: Ignore leading root scope prefix in string _UID match
      ACPI: Add stub for acpi_find_child_device()

Matthias Dittrich (1):
      ACPI: PM: Add quirk for Acer Swift 3 SF314-56G (MX250)

Myeonghun Pak (1):
      PNP: Detach device after resource transition failure

Prabhakar Pujeri (1):
      Documentation: ACPI: EINJ: Update stale driver source reference

Rafael J. Wysocki (41):
      ACPI: scan: Drop useless and noisy debug statement
      ACPI: PM: Drop parent state update from acpi_device_get_power()
      ACPI: scan: Stop calling acpi_bus_init_power() early
      ACPI: PM: Move acpi_bus_init_power() declaration to internal header f=
ile
      ACPI: scan: Combine two conditionals in acpi_bus_attach()
      ACPI: glue: Reduce debug noise from acpi_device_notify()
      ACPI: glue: Rework the success message in acpi_device_notify()
      ACPI: utils: Adjust message printing macros for ACPI objects
      ACPI: glue: Carry out companion lookup under bus_type_sem
      ACPI: glue: Rearrange acpi_bind_one() to avoid breakage
      ACPI: glue: Fix up and adjust acpi_unbind_one()
      ACPI: glue: Skip devices with no type in acpi_device_notify()
      ACPI: fan: Fix memory leak due to leftover devm_kcalloc() argument
      ACPI: video: Fix backlight unregistration ordering
      thermal: core: Introduce thermal_cooling_device_create()
      ACPI: processor: thermal: Use thermal_cooling_device_create()
      ACPI: video: Use thermal_cooling_device_create()
      ACPI: fan: Use thermal_cooling_device_create()
      ACPI: thermal: Use cooling device parent for thermal zone binding
      ACPI: processor: thermal: Use more suitable cooling device data
      ACPI: fan: Store ACPI device pointer in struct acpi_fan
      ACPI: fan: Use more suitable cooling device data
      ACPI: bus: Use acpi/acpi_bus.h without CONFIG_ACPI
      ACPI: amba: Switch to use acpi_bus_get_primary_device()
      platform/x86: yogabook: Switch to use acpi_bus_get_primary_device()
      platform/x86: serdev_helpers: Switch to use acpi_bus_get_primary_devi=
ce()
      platform/x86: x86-android-tablets: Use acpi_bus_get_primary_device()
      platform/x86: apple-gmux: Switch to use acpi_bus_get_primary_device()
      thunderbolt: Switch to use acpi_bus_get_primary_device()
      ASoC: amd: acp-es8336: Switch to use acpi_bus_get_primary_device()
      ASoC: amd: acp3x-es83xx: Switch to use acpi_bus_get_primary_device()
      ASoC: intel: boards: Switch to use acpi_bus_get_primary_device()
      ASoC: loongson: Switch to use acpi_bus_get_primary_device()
      ALSA: hda: aw88399: Switch to use acpi_bus_get_primary_device()
      ACPI: fan: Use __free() to simplify AML error handling
      driver core/ACPI: Introduce companion_bus_register()
      iommu/arm-smmu-v3: Switch to use acpi_bus_get_primary_device()
      ALSA: hda: cs35l41: Switch to use acpi_bus_get_primary_device()
      ALSA: hda: tas2781: Switch to use acpi_bus_get_primary_device()
      efi/dev-path-parser: Switch to use acpi_bus_get_primary_device()
      ACPI: bus: Drop acpi_get_first_physical_node()

Riwen Lu (1):
      ACPI: PM: sleep: Drop unused sleep_no_lps0 define

Robin Murphy (1):
      ACPI: bus: Provide !ACPI stub for acpi_device_uid()

Ruslan Vagner (1):
      ACPI: sysfs: use strscpy() instead of strcpy()

Sang-Heon Jeon (1):
      ACPI: MRRM: Use for_each_populated_zone() in get_node_num()

Saranya Gopal (1):
      ACPI: PM: s2idle: Add _Ixx GPE wake indicator support

Slavin Liu (1):
      ACPI: tables: handle failed initrd override mappings

Sudeep Holla (4):
      ACPICA: Fix PCC OperationRegion command offsets
      ACPI: PCC: Preserve shared memory signature in OpRegion handler
      ACPI: PCC: Free channel on OpRegion deactivation
      ACPI: PCC: Cache OpRegion command timeout

Vibhor Goel (1):
      ACPI: dock: Retry probing battery docks after hotplug

Vlatko Kosturjak (1):
      ACPI: OSL: Use vsnprintf() in acpi_os_vprintf()

---------------

 Documentation/firmware-guide/acpi/apei/einj.rst |   6 +-
 drivers/acpi/acpi_extlog.c                      |  52 +++++----
 drivers/acpi/acpi_mrrm.c                        |  14 +--
 drivers/acpi/acpi_pcc.c                         |  55 ++++++---
 drivers/acpi/acpi_video.c                       |  43 ++++---
 drivers/acpi/acpica/dsfield.c                   |   3 +-
 drivers/acpi/acpica/exfield.c                   |  11 +-
 drivers/acpi/apei/ghes.c                        |  85 +++++++++++---
 drivers/acpi/apei/ghes_helpers.c                |  18 ++-
 drivers/acpi/arm64/amba.c                       |   3 +-
 drivers/acpi/battery.c                          | 131 ++++++++++++++++++--=
-
 drivers/acpi/bus.c                              |  28 +----
 drivers/acpi/button.c                           |  12 ++
 drivers/acpi/device_pm.c                        |  77 +++++++++----
 drivers/acpi/dock.c                             |   9 ++
 drivers/acpi/fan.h                              |   2 +-
 drivers/acpi/fan_core.c                         | 147 ++++++++------------=
----
 drivers/acpi/fan_hwmon.c                        |   2 +-
 drivers/acpi/glue.c                             | 145 +++++++++++---------=
---
 drivers/acpi/internal.h                         |   1 +
 drivers/acpi/numa/hmat.c                        |   2 +-
 drivers/acpi/numa/srat.c                        |   2 +-
 drivers/acpi/osl.c                              |   2 +-
 drivers/acpi/pci_link.c                         |   1 +
 drivers/acpi/pfr_update.c                       |   2 +-
 drivers/acpi/power.c                            |  38 ++++++
 drivers/acpi/processor_driver.c                 |   6 +-
 drivers/acpi/processor_thermal.c                |  80 ++-----------
 drivers/acpi/sbs.c                              |   8 +-
 drivers/acpi/scan.c                             |  54 +++++----
 drivers/acpi/sleep.c                            |   1 -
 drivers/acpi/sysfs.c                            |   5 +-
 drivers/acpi/tables.c                           |   3 +
 drivers/acpi/thermal.c                          |  19 +--
 drivers/acpi/video_detect.c                     |  16 +++
 drivers/acpi/x86/s2idle.c                       |  29 +++++
 drivers/base/base.h                             |   2 +
 drivers/base/bus.c                              |  67 ++++++++---
 drivers/cxl/core/ras.c                          |   3 +-
 drivers/cxl/core/ras_rch.c                      |  27 ++---
 drivers/firmware/efi/cper.c                     |  51 ++++++--
 drivers/firmware/efi/dev-path-parser.c          |   4 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     |   2 +-
 drivers/pci/pcie/tlp.c                          |  88 ++++++++++++++
 drivers/platform/x86/lenovo/yogabook.c          |   4 +-
 drivers/platform/x86/serdev_helpers.h           |   3 +-
 drivers/platform/x86/x86-android-tablets/core.c |   4 +-
 drivers/pnp/driver.c                            |   4 +-
 drivers/thermal/thermal_core.c                  |  28 +++--
 drivers/thermal/thermal_core.h                  |   3 +-
 drivers/thermal/thermal_of.c                    |   2 +-
 drivers/thunderbolt/acpi.c                      |   5 +-
 include/acpi/acpi_bus.h                         |  43 +++++--
 include/acpi/actbl2.h                           |   7 ++
 include/acpi/ghes.h                             |   4 +
 include/acpi/processor.h                        |   6 +-
 include/cxl/event.h                             |   6 +-
 include/linux/acpi.h                            |  37 +++---
 include/linux/aer.h                             |   9 ++
 include/linux/apple-gmux.h                      |   2 +-
 include/linux/device/bus.h                      |   1 +
 include/linux/thermal.h                         |  19 ++-
 sound/hda/codecs/side-codecs/aw88399_hda.c      |   3 +-
 sound/hda/codecs/side-codecs/cs35l41_hda.c      |   3 +-
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c  |   3 +-
 sound/hda/codecs/side-codecs/tas2781_hda_spi.c  |   3 +-
 sound/soc/amd/acp-es8336.c                      |   2 +-
 sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.c   |   2 +-
 sound/soc/intel/boards/bytcht_es8316.c          |   4 +-
 sound/soc/intel/boards/bytcr_rt5640.c           |   4 +-
 sound/soc/intel/boards/bytcr_rt5651.c           |   4 +-
 sound/soc/intel/boards/cht_bsw_rt5645.c         |   5 +-
 sound/soc/intel/boards/sof_cirrus_common.c      |   2 +-
 sound/soc/intel/boards/sof_es8336.c             |   4 +-
 sound/soc/loongson/loongson_card.c              |   3 +-
 75 files changed, 997 insertions(+), 588 deletions(-)
