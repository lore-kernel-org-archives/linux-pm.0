Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2B5405C49
	for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 17:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781286083; cv=none; b=qJIzrzDyiQBTaHJ1zU/+Rk5KgeA53t+fGuT6N4Gg/q1EJJbRiUYTpyzxr9bgBAZhWa+tWk/fILVawtWhKafYyFmG5gnAX9pbZxSAUe6BOjVtpt8IOajCYM14mllZQ5MBoj60LRlfy1gXgGZAP/BNboQHGaVR/AkhM+vKNvT6c3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781286083; c=relaxed/simple;
	bh=d9jPJifz4hAKw+SYOfOd18PCixk8ZeN/GEGO1BIKFn8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=aNyv8a2fUbTeX6BJJ7mQ0qWGln97Our0jtrMOlE+zqTuRAeIaJRCS9IGmKFGafmTVZVf5zKJnR/ltaxTseS/dAGHfdxxjk9aFanbrrgCr5nMr2mp4MzuoX31W2n7zGtkfG93eyTONLQpL9ErBTVni/o1j92gcXx+PuBiweUPdzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZIpOdOC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZIpOdOC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196B71F00A3A
	for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 17:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781286081;
	bh=a7rzPO/ehFDp404FL0EfUXMd4z06a2t8oLlGkxHLWHE=;
	h=From:Date:Subject:To:Cc;
	b=WZIpOdOCAwTpj7TylCqfmL5CwFm8iKfueTXI9MnEodFgaHHhf2kkoDhUeiT4jiSxH
	 aia1GY30vPfDasLaVqf1k8mk29vh2uxmFMj+7IaGWHwieLdNZgT0THmHHhH0s1pL9r
	 g796YZmp6RRjy+8BCu5jQkjDqUBnGOJI5/G6sXrupwqkbz4j8ZcLfO634NIX580idv
	 bUneVPxTatzo2KPjRvUjtC9q8q/CfSU+nal4/5QLchyeSNGmptMoDmDsgjyFJ5ieLj
	 QnL0BvdXujgVJJJiCh4M8iDl8IpHM1zryvSAzsQcN0IL+2n+6n/5ocXzNexnf0smpO
	 m6pbCpMpRSeXA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aa63daf2a5so737460e87.3
        for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 10:41:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+9wiG18t2WQhM/lW34SSiN1gPt9A4D/CAKk6VoJcxb1vRQrnb+hPvfHgmvULI1b0pIPSQReeMlNw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHlvWKEcb6PAgRr9zRc7zEEptJtnDZsZ1CTQkTxNJmNqcouPzM
	noQ2bvxjrmYjJ7p/w1dWrtBR3XOlzmnHXfuUGh4rAMxg0mJqcDjMsrwL0+ajxwG/8o8w/x61jKU
	ZkP9vTYSO6/96ibExVG4hmF1pJc5xw2w=
X-Received: by 2002:a05:6512:3409:b0:5ad:1b59:fd74 with SMTP id
 2adb3069b0e04-5ad2db2458fmr1315859e87.1.1781286079487; Fri, 12 Jun 2026
 10:41:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 12 Jun 2026 19:41:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h-9HOj9ar1sa2oeJ1SJQ-CbtTj03EyLpuhpQOPHa2fSA@mail.gmail.com>
X-Gm-Features: AVVi8CdbylZLJyBRMjr_f8UTupYDsKNvnIQHo7O5HwhvcoeRouDpDooiREZJI6o
Message-ID: <CAJZ5v0h-9HOj9ar1sa2oeJ1SJQ-CbtTj03EyLpuhpQOPHa2fSA@mail.gmail.com>
Subject: [GIT PULL] ACPI support updates for 7.2-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

This goes early for your convenience.

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-7.2-rc1

with top-most commit 615f90d3b1b7900d591a9162793f616b051f07b8

 Merge branches 'acpi-processor', 'acpi-cppc' and 'acpi-pci'

on top of commit 4549871118cf616eecdd2d939f78e3b9e1dddc48

 Linux 7.1-rc7

to receive ACPI support updates for 7.2-rc1.

These update the ACPICA code in the kernel to upstream version 20260408,
introduce support for devres-based management of ACPI notify handlers
and update some core ACPI device drivers on top of that (which includes
some fixes and cleanups), add _DEP support for PCI/CXL roots and Intel
CVS devices, fix a couple of assorted issues and clean up code:

 - Fix multiple issues related to probe, removal and missing NVDIMM
   device notifications in the ACPI NFIT driver (Rafael Wysocki)

 - Add support for devres-based management of ACPI notify handlers to
   the ACPI core (Rafael Wysocki)

 - Switch multiple core ACPI device drivers (including the ACPI PAD,
   ACPI video bus, ACPI HED, ACPI thermal zone, ACPI AC, ACPI battery,
   and ACPI NFIT drivers) over to using devres-based resource management
   during probe (Rafael Wysocki)

 - Replace mutex_lock/unlock() with guard()/scoped_guard() in the ACPI
   PMIC driver (Maxwell Doose)

 - Fix message kref handling in the dead device path of the ACPI IPMI
   address space handler (Yuho Choi)

 - Use sysfs_emit() in idlecpus_show() in the ACPI processor aggregator
   device (PAD) driver (Yury Norov)

 - Clean up device_id_scheme initialization in the ACPI video bus driver
   (Jean-Ralph Aviles)

 - Clean up lid handling in the ACPI button driver and
   acpi_button_probe(), reorganize installing and removing event
   handlers in that driver and switch it over to using devres-based
   resource management during probe (Rafael Wysocki)

 - Add support for the Legacy Virtual Register (LVR) field in I2C serial
   bus resource descriptors to ACPICA (Akhil R)

 - Fix multiple issues related to bounds checks, input validation,
   use-after-free, and integer overflow checks in the AML interpreter
   in ACPICA (ikaros)

 - Update the copyright year to 2026 in ACPICA files and make minor
   changes related to ACPI 6.6 support (Pawel Chmielewski)

 - Remove spurious precision from format used to dump parse trees in
   ACPICA (David Laight)

 - Add modern standby DSM GUIDs to ACPICA header files (Daniel Schaefer)

 - Fix FADT 32/64X length mismatch warning in ACPICA (Abdelkader Boudih)

 - Update D3hot/cold device power states definitions in ACPICA header
   files (Aymeric Wibo)

 - Fix NULL pointer dereference in acpi_ns_custom_package() (Weiming
   Shi)

 - Update ACPICA version to 20260408 (Saket Dumbre)

 - Add cpuidle driver check in acpi_processor_register_idle_driver() to
   avoid evaluating _CST unnecessarily (Tony W Wang-oc)

 - Suppress UBSAN warning caused by field misuse during PCC-based
   register access in the ACPI CPPC library (Jeremy Linton)

 - Add support for CPPC v4 to the ACPI CPPC library (Sumit Gupta)

 - Update the ACPI device enumeration code to honor _DEP for ACPI0016
   PCI/CXL host bridges and make the ACPI PCI root driver clear _DEP
   dependencies for PCI roots that have become operational (Chen Pei)

Thanks!


---------------

Abdelkader Boudih (1):
      ACPICA: Fix FADT 32/64X length mismatch warning

Akhil R (5):
      ACPICA: Add LVR to acrestyp.h
      ACPICA: Fetch LVR I2C resource descriptor
      ACPICA: Change LVR to 8 bit value
      ACPICA: Mention the LVR bits
      ACPICA: fix I2C LVR item count in the conversion table

Aymeric Wibo (1):
      ACPICA: actypes: Distinguish between D3hot/cold

Chen Pei (2):
      ACPI: PCI: Clear _DEP dependencies after PCI root bridge attach
      ACPI: scan: Honor _DEP for ACPI0016 PCI/CXL host bridge

Daniel Schaefer (1):
      ACPICA: Add modern standby DSM GUIDs

David Laight (1):
      ACPICA: Remove spurious precision from format used to dump parse trees

Jean-Ralph Aviles (1):
      ACPI: video: Do not initialise device_id_scheme directly

Jeremy Linton (1):
      ACPI: CPPC: Suppress UBSAN warning caused by field misuse

Maxwell Doose (1):
      ACPI: PMIC: Replace mutex_lock/unlock() with guard()/scoped_guard()

Miguel Vadillo (1):
      ACPI: scan: Honor _DEP for Intel CVS devices

Pawel Chmielewski (2):
      ACPICA: actbl2.h: ACPI 6.6: Updates for MADT MPWakeup
      ACPICA: Update the copyright year to 2026

Rafael J. Wysocki (37):
      ACPI: bus: Introduce devm_acpi_install_notify_handler()
      ACPI: NFIT: core: Use devm_acpi_install_notify_handler()
      ACPI: AC: Switch over to devres-based resource management
      ACPI: battery: Switch over to devres-based resource management
      ACPI: HED: Refine guarding against adding a second instance
      ACPI: HED: Switch over to devres-based resource management
      ACPI: thermal: Switch over to devres-based resource management
      ACPI: PAD: Rearrange acpi_pad_notify()
      ACPI: PAD: Pass struct device pointer to acpi_pad_notify()
      ACPI: PAD: Fix teardown ordering in acpi_pad_remove()
      ACPI: PAD: Switch over to devres-based resource management
      ACPI: video: Reduce the number of auxiliary device dereferences
      ACPI: video: Rearrange probe and remove code
      ACPI: video: Use devm action for video bus object cleanup
      ACPI: video: Use devm action for freeing video devices
      ACPI: video: Use devm for video->entry and backlight cleanup
      ACPI: video: Switch over to devres-based resource management
      ACPI: button: Fix lid_device value leak past driver removal
      ACPI: button: Pass ACPI handle to acpi_lid_evaluate_state()
      ACPI: button: Improve warning message regarding lid state
      ACPI: button: Use bool for representing boolean values
      ACPI: button: Eliminate ternary operator from acpi_lid_evaluate_state()
      ACPI: button: Change return type of two functions to void
      ACPI: button: Eliminate redundant conditional statement
      ACPI: button: Use local pointer to platform device dev field in probe
      ACPI: button: Rework device verification during probe
      ACPI: button: Drop redundant variable from acpi_button_probe()
      ACPI: button: Merge two switch () statements in acpi_button_probe()
      ACPI: button: Clean up adding and removing lid procfs interface
      ACPI: button: Use string literals for generating netlink messages
      ACPI: button: Reorganize installing and removing event handlers
      ACPI: button: Switch over to devres-based resource management
      ACPI: bus: Clean up devm_acpi_install_notify_handler()
      ACPI: NFIT: core: Fix possible NULL pointer dereference
      ACPI: NFIT: core: Fix acpi_nfit_init() error cleanup
      ACPI: NFIT: core: Eliminate redundant local variable
      ACPI: NFIT: core: Fix possible deadlock and missing notifications

Saket Dumbre (1):
      ACPICA: Update version to 20260408

Sumit Gupta (1):
      ACPI: CPPC: Add support for CPPC v4

Tony W Wang-oc (1):
      ACPI: processor: Add cpuidle driver check in
acpi_processor_register_idle_driver()

Weiming Shi (1):
      ACPICA: Fix NULL pointer dereference in acpi_ns_custom_package()

Yuho Choi (1):
      ACPI: IPMI: Fix message kref handling on dead device

Yury Norov (1):
      ACPI: PAD: Use sysfs_emit() in idlecpus_show()

ikaros (14):
      ACPICA: Fix condition check in acpi_ps_parse_loop()
      ACPICA: Add alias node support in namespace handling
      ACPICA: Fix use-after-free in acpi_ds_terminate_control_method()
      ACPICA: validate byte_count in acpi_ps_get_next_package_length()
      ACPICA: add boundary checks in acpi_ps_get_next_field()
      ACPICA: Prevent adding invalid references
      ACPICA: Fix integer overflow in acpi_ex_opcode_3A_1T_1R() (mid_op)
      ACPICA: Improve argument parsing in acpi_ps_get_next_simple_arg()
      ACPICA: validate handler object type in two places
      ACPICA: Add validation for node in acpi_ns_build_normalized_path()
      ACPICA: Enhance buffer validation in acpi_ut_walk_aml_resources()
      ACPICA: Enhance OEM ID and Table ID validation in acpi_ex_load_table_op()
      ACPICA: Add package limit checks in parser functions
      ACPICA: add boundary checks in two places

---------------

 drivers/acpi/ac.c                                  |  37 +-
 drivers/acpi/acpi_ipmi.c                           |   2 +-
 drivers/acpi/acpi_pad.c                            |  38 +-
 drivers/acpi/acpi_video.c                          | 139 ++++---
 drivers/acpi/acpica/acapps.h                       |   4 +-
 drivers/acpi/acpica/accommon.h                     |   2 +-
 drivers/acpi/acpica/acconvert.h                    |   2 +-
 drivers/acpi/acpica/acdebug.h                      |   2 +-
 drivers/acpi/acpica/acdispat.h                     |   2 +-
 drivers/acpi/acpica/acevents.h                     |   2 +-
 drivers/acpi/acpica/acglobal.h                     |   2 +-
 drivers/acpi/acpica/achware.h                      |   2 +-
 drivers/acpi/acpica/acinterp.h                     |   2 +-
 drivers/acpi/acpica/aclocal.h                      |   3 +-
 drivers/acpi/acpica/acmacros.h                     |   2 +-
 drivers/acpi/acpica/acnamesp.h                     |   2 +-
 drivers/acpi/acpica/acobject.h                     |   2 +-
 drivers/acpi/acpica/acopcode.h                     |   2 +-
 drivers/acpi/acpica/acparser.h                     |   2 +-
 drivers/acpi/acpica/acpredef.h                     |   2 +-
 drivers/acpi/acpica/acresrc.h                      |   2 +-
 drivers/acpi/acpica/acstruct.h                     |   2 +-
 drivers/acpi/acpica/actables.h                     |   2 +-
 drivers/acpi/acpica/acutils.h                      |   2 +-
 drivers/acpi/acpica/amlcode.h                      |   2 +-
 drivers/acpi/acpica/amlresrc.h                     |   2 +-
 drivers/acpi/acpica/dbhistry.c                     |   2 +-
 drivers/acpi/acpica/dsargs.c                       |   2 +-
 drivers/acpi/acpica/dscontrol.c                    |   2 +-
 drivers/acpi/acpica/dsdebug.c                      |   2 +-
 drivers/acpi/acpica/dsfield.c                      |   2 +-
 drivers/acpi/acpica/dsinit.c                       |   2 +-
 drivers/acpi/acpica/dsmethod.c                     |  45 +-
 drivers/acpi/acpica/dsobject.c                     |   2 +-
 drivers/acpi/acpica/dsopcode.c                     |   2 +-
 drivers/acpi/acpica/dspkginit.c                    |   2 +-
 drivers/acpi/acpica/dswexec.c                      |   2 +-
 drivers/acpi/acpica/dswload.c                      |   2 +-
 drivers/acpi/acpica/dswload2.c                     |   2 +-
 drivers/acpi/acpica/dswscope.c                     |   2 +-
 drivers/acpi/acpica/dswstate.c                     |   2 +-
 drivers/acpi/acpica/evevent.c                      |   2 +-
 drivers/acpi/acpica/evglock.c                      |   2 +-
 drivers/acpi/acpica/evgpe.c                        |   2 +-
 drivers/acpi/acpica/evgpeblk.c                     |   2 +-
 drivers/acpi/acpica/evgpeinit.c                    |   2 +-
 drivers/acpi/acpica/evgpeutil.c                    |   2 +-
 drivers/acpi/acpica/evhandler.c                    |  13 +-
 drivers/acpi/acpica/evmisc.c                       |   2 +-
 drivers/acpi/acpica/evregion.c                     |   2 +-
 drivers/acpi/acpica/evrgnini.c                     |   2 +-
 drivers/acpi/acpica/evxface.c                      |   2 +-
 drivers/acpi/acpica/evxfevnt.c                     |   2 +-
 drivers/acpi/acpica/evxfgpe.c                      |   2 +-
 drivers/acpi/acpica/evxfregn.c                     |   2 +-
 drivers/acpi/acpica/exconcat.c                     |   2 +-
 drivers/acpi/acpica/exconfig.c                     |  28 +-
 drivers/acpi/acpica/exconvrt.c                     |   2 +-
 drivers/acpi/acpica/excreate.c                     |   2 +-
 drivers/acpi/acpica/exdebug.c                      |   2 +-
 drivers/acpi/acpica/exdump.c                       |   2 +-
 drivers/acpi/acpica/exfield.c                      |   2 +-
 drivers/acpi/acpica/exfldio.c                      |   2 +-
 drivers/acpi/acpica/exmisc.c                       |   2 +-
 drivers/acpi/acpica/exmutex.c                      |   2 +-
 drivers/acpi/acpica/exnames.c                      |   2 +-
 drivers/acpi/acpica/exoparg1.c                     |   2 +-
 drivers/acpi/acpica/exoparg2.c                     |   2 +-
 drivers/acpi/acpica/exoparg3.c                     |   4 +-
 drivers/acpi/acpica/exoparg6.c                     |   2 +-
 drivers/acpi/acpica/exprep.c                       |   2 +-
 drivers/acpi/acpica/exregion.c                     |   2 +-
 drivers/acpi/acpica/exresnte.c                     |   2 +-
 drivers/acpi/acpica/exresolv.c                     |   2 +-
 drivers/acpi/acpica/exresop.c                      |   2 +-
 drivers/acpi/acpica/exserial.c                     |   2 +-
 drivers/acpi/acpica/exstore.c                      |   2 +-
 drivers/acpi/acpica/exstoren.c                     |   2 +-
 drivers/acpi/acpica/exstorob.c                     |   2 +-
 drivers/acpi/acpica/exsystem.c                     |   2 +-
 drivers/acpi/acpica/extrace.c                      |   2 +-
 drivers/acpi/acpica/exutils.c                      |   2 +-
 drivers/acpi/acpica/hwacpi.c                       |   2 +-
 drivers/acpi/acpica/hwesleep.c                     |   2 +-
 drivers/acpi/acpica/hwgpe.c                        |   2 +-
 drivers/acpi/acpica/hwsleep.c                      |   2 +-
 drivers/acpi/acpica/hwtimer.c                      |   2 +-
 drivers/acpi/acpica/hwvalid.c                      |   2 +-
 drivers/acpi/acpica/hwxface.c                      |   2 +-
 drivers/acpi/acpica/hwxfsleep.c                    |   2 +-
 drivers/acpi/acpica/nsarguments.c                  |   2 +-
 drivers/acpi/acpica/nsconvert.c                    |   2 +-
 drivers/acpi/acpica/nsdump.c                       |   2 +-
 drivers/acpi/acpica/nsdumpdv.c                     |   2 +-
 drivers/acpi/acpica/nsinit.c                       |   2 +-
 drivers/acpi/acpica/nsload.c                       |   2 +-
 drivers/acpi/acpica/nsnames.c                      |   6 +
 drivers/acpi/acpica/nsobject.c                     |   6 +
 drivers/acpi/acpica/nsparse.c                      |   2 +-
 drivers/acpi/acpica/nspredef.c                     |   2 +-
 drivers/acpi/acpica/nsprepkg.c                     |   9 +-
 drivers/acpi/acpica/nsrepair.c                     |   2 +-
 drivers/acpi/acpica/nsrepair2.c                    |   2 +-
 drivers/acpi/acpica/nsutils.c                      |   2 +-
 drivers/acpi/acpica/nswalk.c                       |   2 +-
 drivers/acpi/acpica/nsxfname.c                     |   6 +-
 drivers/acpi/acpica/psargs.c                       | 136 ++++++-
 drivers/acpi/acpica/psloop.c                       |  32 +-
 drivers/acpi/acpica/psobject.c                     |   2 +-
 drivers/acpi/acpica/psopcode.c                     |   2 +-
 drivers/acpi/acpica/psopinfo.c                     |   2 +-
 drivers/acpi/acpica/psparse.c                      |  16 +-
 drivers/acpi/acpica/psscope.c                      |   2 +-
 drivers/acpi/acpica/pstree.c                       |   2 +-
 drivers/acpi/acpica/psutils.c                      |   2 +-
 drivers/acpi/acpica/pswalk.c                       |   6 +-
 drivers/acpi/acpica/psxface.c                      |   2 +-
 drivers/acpi/acpica/rsserial.c                     |   7 +-
 drivers/acpi/acpica/tbdata.c                       |   2 +-
 drivers/acpi/acpica/tbfadt.c                       |   5 +-
 drivers/acpi/acpica/tbfind.c                       |   2 +-
 drivers/acpi/acpica/tbinstal.c                     |   2 +-
 drivers/acpi/acpica/tbprint.c                      |   2 +-
 drivers/acpi/acpica/tbutils.c                      |   2 +-
 drivers/acpi/acpica/tbxface.c                      |   2 +-
 drivers/acpi/acpica/tbxfload.c                     |   2 +-
 drivers/acpi/acpica/tbxfroot.c                     |   2 +-
 drivers/acpi/acpica/utaddress.c                    |   2 +-
 drivers/acpi/acpica/utalloc.c                      |   2 +-
 drivers/acpi/acpica/utascii.c                      |   2 +-
 drivers/acpi/acpica/utbuffer.c                     |   2 +-
 drivers/acpi/acpica/utcache.c                      |   2 +-
 drivers/acpi/acpica/utcksum.c                      |   2 +-
 drivers/acpi/acpica/utcopy.c                       |  12 +-
 drivers/acpi/acpica/utdebug.c                      |   2 +-
 drivers/acpi/acpica/utdecode.c                     |   2 +-
 drivers/acpi/acpica/uteval.c                       |   2 +-
 drivers/acpi/acpica/utglobal.c                     |   2 +-
 drivers/acpi/acpica/uthex.c                        |   2 +-
 drivers/acpi/acpica/utids.c                        |   2 +-
 drivers/acpi/acpica/utinit.c                       |   2 +-
 drivers/acpi/acpica/utlock.c                       |   2 +-
 drivers/acpi/acpica/utobject.c                     |   2 +-
 drivers/acpi/acpica/utosi.c                        |   2 +-
 drivers/acpi/acpica/utpredef.c                     |   2 +-
 drivers/acpi/acpica/utprint.c                      |   2 +-
 drivers/acpi/acpica/utresrc.c                      |  30 ++
 drivers/acpi/acpica/uttrack.c                      |   2 +-
 drivers/acpi/acpica/utuuid.c                       |   2 +-
 drivers/acpi/acpica/utxface.c                      |   2 +-
 drivers/acpi/acpica/utxfinit.c                     |   2 +-
 drivers/acpi/battery.c                             |  75 ++--
 drivers/acpi/bus.c                                 |  67 +++
 drivers/acpi/button.c                              | 452 +++++++++++----------
 drivers/acpi/cppc_acpi.c                           |  34 +-
 drivers/acpi/hed.c                                 |  25 +-
 drivers/acpi/nfit/core.c                           | 102 +++--
 drivers/acpi/pci_root.c                            |   4 +
 drivers/acpi/pmic/intel_pmic.c                     |  37 +-
 drivers/acpi/processor_idle.c                      |   9 +
 drivers/acpi/scan.c                                |   6 +-
 drivers/acpi/thermal.c                             |  53 +--
 include/acpi/acbuffer.h                            |   2 +-
 include/acpi/acconfig.h                            |   2 +-
 include/acpi/acexcep.h                             |   2 +-
 include/acpi/acnames.h                             |   2 +-
 include/acpi/acoutput.h                            |   2 +-
 include/acpi/acpi.h                                |   2 +-
 include/acpi/acpi_bus.h                            |   2 +
 include/acpi/acpiosxf.h                            |   2 +-
 include/acpi/acpixf.h                              |   4 +-
 include/acpi/acrestyp.h                            |   3 +-
 include/acpi/actbl.h                               |   2 +-
 include/acpi/actbl1.h                              |   2 +-
 include/acpi/actbl2.h                              |   4 +-
 include/acpi/actbl3.h                              |   2 +-
 include/acpi/actypes.h                             |   8 +-
 include/acpi/acuuid.h                              |   7 +-
 include/acpi/cppc_acpi.h                           |   8 +-
 include/acpi/platform/acenv.h                      |   2 +-
 include/acpi/platform/acenvex.h                    |   2 +-
 include/acpi/platform/acgcc.h                      |   2 +-
 include/acpi/platform/acgccex.h                    |   2 +-
 include/acpi/platform/aclinux.h                    |   2 +-
 include/acpi/platform/aclinuxex.h                  |   2 +-
 include/acpi/platform/aczephyr.h                   |   2 +-
 tools/power/acpi/common/cmfsize.c                  |   2 +-
 tools/power/acpi/common/getopt.c                   |   2 +-
 .../acpi/os_specific/service_layers/oslinuxtbl.c   |   2 +-
 .../acpi/os_specific/service_layers/osunixdir.c    |   2 +-
 .../acpi/os_specific/service_layers/osunixmap.c    |   2 +-
 .../acpi/os_specific/service_layers/osunixxf.c     |   2 +-
 tools/power/acpi/tools/acpidump/acpidump.h         |   2 +-
 tools/power/acpi/tools/acpidump/apdump.c           |   2 +-
 tools/power/acpi/tools/acpidump/apfiles.c          |   2 +-
 tools/power/acpi/tools/acpidump/apmain.c           |   2 +-
 196 files changed, 1109 insertions(+), 687 deletions(-)
