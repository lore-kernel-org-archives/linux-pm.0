From: Len Brown <lenb@kernel.org>
Subject: [git pull] ACPI & driver patches for 2.6.30-rc0
Date: Sun, 05 Apr 2009 03:00:19 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904050255340.24737@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_UtOxifu34SB5JG0X3W4Xeg)"
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, Linux Power Management List <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_UtOxifu34SB5JG0X3W4Xeg)
Content-type: TEXT/PLAIN; charset=ISO-8859-2
Content-transfer-encoding: 8BIT

Hi Linus,

please pull from: 

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release

As with every merge window, we're syncing Linux with the latest ACPICA,
and with the latest platform driver updates.  That and Bjorn doing some
Spring cleaning is pretty much the bulk of it.

The full log is just about 100K, so I'll reply to this message with that
in case it gets filtered from the list.

This will update the files shown below.

thanks!

--
Len Brown
Intel Open Source Technology Center


ps. individual patches are available on linux-acpi@vger.kernel.org
and a consolidated plain patch is available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.29/acpi-release-20090320-2.6.29.diff.gz

 Documentation/kernel-parameters.txt        |   16 +
 Documentation/laptops/acer-wmi.txt         |   10 +-
 Documentation/laptops/thinkpad-acpi.txt    |  144 ++++--
 MAINTAINERS                                |   10 +-
 arch/x86/kernel/acpi/boot.c                |   65 +++-
 arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c |   12 +
 arch/x86/kernel/cpu/cpufreq/longhaul.c     |    6 +-
 arch/x86/mm/srat_64.c                      |   30 ++
 drivers/acpi/Kconfig                       |  150 ++++---
 drivers/acpi/Makefile                      |   52 +-
 drivers/acpi/acpica/Makefile               |    4 +-
 drivers/acpi/acpica/acglobal.h             |   11 +-
 drivers/acpi/acpica/achware.h              |   12 +-
 drivers/acpi/acpica/aclocal.h              |   60 ++-
 drivers/acpi/acpica/acmacros.h             |    4 -
 drivers/acpi/acpica/acobject.h             |    1 -
 drivers/acpi/acpica/acpredef.h             |   41 +-
 drivers/acpi/acpica/actables.h             |    9 +-
 drivers/acpi/acpica/acutils.h              |   15 +
 drivers/acpi/acpica/dsinit.c               |   16 +-
 drivers/acpi/acpica/dsmthdat.c             |    2 +-
 drivers/acpi/acpica/dsobject.c             |    6 +-
 drivers/acpi/acpica/dsopcode.c             |   32 +--
 drivers/acpi/acpica/dsutils.c              |    2 +-
 drivers/acpi/acpica/dswexec.c              |    5 +-
 drivers/acpi/acpica/evevent.c              |   18 +-
 drivers/acpi/acpica/evgpe.c                |    7 +-
 drivers/acpi/acpica/evgpeblk.c             |   70 ++--
 drivers/acpi/acpica/evmisc.c               |   16 +-
 drivers/acpi/acpica/evregion.c             |    5 +-
 drivers/acpi/acpica/evrgnini.c             |   22 +-
 drivers/acpi/acpica/evxface.c              |    3 +-
 drivers/acpi/acpica/evxfevnt.c             |   24 +-
 drivers/acpi/acpica/evxfregn.c             |    3 +-
 drivers/acpi/acpica/exconfig.c             |   17 +-
 drivers/acpi/acpica/exconvrt.c             |   11 +-
 drivers/acpi/acpica/exdump.c               |   59 +--
 drivers/acpi/acpica/exfield.c              |   29 +-
 drivers/acpi/acpica/exfldio.c              |   14 +-
 drivers/acpi/acpica/exmisc.c               |   14 +-
 drivers/acpi/acpica/exoparg1.c             |   13 +-
 drivers/acpi/acpica/exoparg2.c             |    2 +-
 drivers/acpi/acpica/exoparg3.c             |    7 +-
 drivers/acpi/acpica/exprep.c               |    2 +-
 drivers/acpi/acpica/exregion.c             |    4 +-
 drivers/acpi/acpica/exresnte.c             |    8 +-
 drivers/acpi/acpica/exresolv.c             |    9 +-
 drivers/acpi/acpica/exresop.c              |   23 +-
 drivers/acpi/acpica/exstore.c              |   18 +-
 drivers/acpi/acpica/exstoren.c             |   29 +-
 drivers/acpi/acpica/exutils.c              |    2 +-
 drivers/acpi/acpica/hwacpi.c               |    9 +-
 drivers/acpi/acpica/hwgpe.c                |   21 +-
 drivers/acpi/acpica/hwregs.c               |  322 +++++++++----
 drivers/acpi/acpica/hwsleep.c              |  130 +++---
 drivers/acpi/acpica/hwvalid.c              |  258 ++++++++++
 drivers/acpi/acpica/hwxface.c              |  279 ++++-------
 drivers/acpi/acpica/nsaccess.c             |   54 +--
 drivers/acpi/acpica/nsalloc.c              |   24 +-
 drivers/acpi/acpica/nsdump.c               |   24 +-
 drivers/acpi/acpica/nseval.c               |    2 +-
 drivers/acpi/acpica/nsinit.c               |   19 +-
 drivers/acpi/acpica/nsload.c               |    4 +-
 drivers/acpi/acpica/nsobject.c             |   18 +-
 drivers/acpi/acpica/nsparse.c              |   10 +-
 drivers/acpi/acpica/nspredef.c             |   38 +-
 drivers/acpi/acpica/nssearch.c             |   14 +-
 drivers/acpi/acpica/nsutils.c              |   27 +-
 drivers/acpi/acpica/nswalk.c               |   12 +-
 drivers/acpi/acpica/nsxfeval.c             |   36 +-
 drivers/acpi/acpica/rscalc.c               |    7 +-
 drivers/acpi/acpica/rscreate.c             |   15 +-
 drivers/acpi/acpica/tbfadt.c               |  363 ++++++++------
 drivers/acpi/acpica/tbinstal.c             |   82 +++-
 drivers/acpi/acpica/tbutils.c              |  106 +++--
 drivers/acpi/acpica/tbxface.c              |   71 +--
 drivers/acpi/acpica/tbxfroot.c             |    4 +-
 drivers/acpi/acpica/utcopy.c               |   30 +-
 drivers/acpi/acpica/utdelete.c             |    6 +-
 drivers/acpi/acpica/uteval.c               |   98 +++--
 drivers/acpi/acpica/utglobal.c             |   17 +-
 drivers/acpi/acpica/utlock.c               |  175 +++++++
 drivers/acpi/acpica/utmisc.c               |    3 +-
 drivers/acpi/acpica/utmutex.c              |   23 +-
 drivers/acpi/acpica/utobject.c             |   11 +-
 drivers/acpi/battery.c                     |   29 +-
 drivers/acpi/bus.c                         |   15 +
 drivers/acpi/button.c                      |   77 +---
 drivers/acpi/debug.c                       |   19 +-
 drivers/acpi/dock.c                        |    3 +-
 drivers/acpi/ec.c                          |   39 +-
 drivers/acpi/fan.c                         |   20 +-
 drivers/acpi/glue.c                        |    6 +-
 drivers/acpi/internal.h                    |   43 ++
 drivers/acpi/numa.c                        |   46 ++-
 drivers/acpi/osl.c                         |    6 +-
 drivers/acpi/pci_irq.c                     |   18 +-
 drivers/acpi/pci_link.c                    |  147 ++----
 drivers/acpi/power.c                       |   12 +-
 drivers/acpi/proc.c                        |    7 +-
 drivers/acpi/processor_core.c              |   45 ++-
 drivers/acpi/processor_idle.c              |  124 ++----
 drivers/acpi/processor_perflib.c           |   46 +-
 drivers/acpi/processor_thermal.c           |   22 +-
 drivers/acpi/processor_throttling.c        |    8 +-
 drivers/acpi/sbs.c                         |   41 +-
 drivers/acpi/scan.c                        |   94 +++-
 drivers/acpi/sleep.c                       |   13 +-
 drivers/acpi/system.c                      |   64 ++-
 drivers/acpi/tables.c                      |   30 ++
 drivers/acpi/thermal.c                     |  539 ++++-----------------
 drivers/acpi/video.c                       |  336 ++++++++++---
 drivers/acpi/video_detect.c                |    3 +
 drivers/acpi/wakeup.c                      |    9 +-
 drivers/gpu/drm/i915/i915_dma.c            |    5 +-
 drivers/gpu/drm/i915/i915_drv.c            |    2 +-
 drivers/gpu/drm/i915/i915_drv.h            |    4 +-
 drivers/gpu/drm/i915/i915_opregion.c       |   65 +++-
 drivers/pci/pci-acpi.c                     |    4 +-
 drivers/platform/x86/Kconfig               |   35 ++
 drivers/platform/x86/Makefile              |    1 +
 drivers/platform/x86/acer-wmi.c            |   35 ++-
 drivers/platform/x86/dell-wmi.c            |  210 ++++++++
 drivers/platform/x86/hp-wmi.c              |   25 +
 drivers/platform/x86/intel_menlow.c        |   29 +-
 drivers/platform/x86/panasonic-laptop.c    |    9 +-
 drivers/platform/x86/sony-laptop.c         |  531 +++++++++++++++------
 drivers/platform/x86/tc1100-wmi.c          |    7 +-
 drivers/platform/x86/thinkpad_acpi.c       |  735 ++++++++++++++++++++--------
 drivers/pnp/pnpacpi/core.c                 |   23 +-
 drivers/power/power_supply_sysfs.c         |    2 +
 drivers/thermal/thermal_sys.c              |  356 +++++++++++++-
 include/acpi/acexcep.h                     |    6 +-
 include/acpi/acpi_bus.h                    |   18 +-
 include/acpi/acpi_drivers.h                |   33 +-
 include/acpi/acpiosxf.h                    |    4 -
 include/acpi/acpixf.h                      |   16 +-
 include/acpi/actbl.h                       |   74 ++--
 include/acpi/actbl1.h                      |    6 +-
 include/acpi/actypes.h                     |   18 +-
 include/acpi/processor.h                   |    4 +-
 include/acpi/video.h                       |   11 +
 include/linux/acpi.h                       |    1 +
 include/linux/power_supply.h               |    2 +
 include/linux/sonypi.h                     |    8 +
 include/linux/thermal.h                    |   48 ++-
 146 files changed, 4854 insertions(+), 2790 deletions(-)
 create mode 100644 drivers/acpi/acpica/hwvalid.c
 create mode 100644 drivers/acpi/acpica/utlock.c
 create mode 100644 drivers/acpi/internal.h
 create mode 100644 drivers/platform/x86/dell-wmi.c
 create mode 100644 include/acpi/video.h

through these commits:

Alan Cox (1):
      sony-laptop: Eliminate BKL in ioctls

Alessio Igor Bogani (2):
      sony-laptop: Kill the BKL
      sony-laptop: Fix some typos in log messages (Unabe/Unable)

Alexander Beregalov (1):
      sony-laptop should depend on RFKILL

Alexey Starikovskiy (3):
      ACPI: battery: add power_{now,avg} properties to power_class
      ACPI: EC: Separate delays for MSI hardware
      ACPI: EC: Always parse EC device

Andy Whitcroft (1):
      acer-wmi: Cleanup the failure cleanup handling

Anton Veretenenko (1):
      sony-laptop: Add FW specific hotkey events

Arjan van de Ven (1):
      ACPI: battery: asynchronous init

Bjorn Helgaas (23):
      ACPI: pci_link: clean up whitespace
      ACPI: pci_link: remove unnecessary casts and initializations
      ACPI: pci_link: remove unnecessary null pointer checks
      ACPI: pci_link: simplify list of link devices
      ACPI: PCI: use generic pci_swizzle_interrupt_pin()
      ACPI: update Kconfig help texts (no functional changes)
      ACPI: move private declarations to internal.h
      ACPI: skip DMI power state check when ACPI disabled
      ACPI: call acpi_scan_init() explicitly rather than as initcall
      ACPI: call acpi_ec_init() explicitly rather than as initcall
      ACPI: call acpi_power_init() explicitly rather than as initcall
      ACPI: call acpi_system_init() explicitly rather than as initcall
      ACPI: call acpi_debug_init() explicitly rather than as initcall
      ACPI: call init_acpi_device_notify() explicitly rather than as initcall
      ACPI: call acpi_sleep_proc_init() explicitly rather than as initcall
      ACPI: call acpi_wakeup_device_init() explicitly rather than as initcall
      ACPI: tidy up makefile
      ACPI: remove unused acpi_device_ops .lock and .scan methods
      ACPI: remove unused acpi_device_ops .shutdown method
      ACPI: remove unused acpi_bus_ops flags
      ACPI: support acpi_device_ops .notify methods
      ACPI: button: use .notify method instead of installing handler directly
      ACPI: processor: use .notify method instead of installing handler directly

Bob Moore (39):
      ACPICA: Add error check to debug object dump routine
      ACPICA: Allow OS override of all ACPI tables
      ACPICA: Remove extraneous parameter in table manager
      ACPICA: Add override for dynamic tables
      ACPICA: Update FADT flag definitions
      ACPICA: Update version to 20090123
      ACPICA: Split out PM1 status registers from the FADT
      ACPICA: Update comments in module header
      ACPICA: Fix writes to optional PM1B registers
      ACPICA: Remove extra write for acpi_hw_clear_acpi_status
      ACPICA: For PM1B registers, do not shift value read or written
      ACPICA: Fix parameter validation for acpi_read/write
      ACPICA: Remove redundant ACPI_BITREG_SLEEP_TYPE_B
      ACPICA: Add function to handle PM1 control registers
      ACPICA: Remove ACPI_GET_OBJECT_TYPE macro
      ACPICA: Conditionally compile acpi_set_firmware_waking_vector64
      ACPICA: Debug output: print result of _OSI invocations
      ACPICA: Debug output: decrease verbosity of DB_INFO debug level
      ACPICA: Formatting update - no functional changes
      ACPICA: Optimize ACPI register locking
      ACPICA: Rename ACPI bit register access functions
      ACPICA: Restructure bit register access functions
      ACPICA: Update table header print function
      ACPICA: Update version to 20090220
      ACPICA: Add manifest constants for bit register values
      ACPICA: Formatting update - no functional changes
      ACPICA: FADT: Fix extraneous length mismatch warning
      ACPICA: Fix AcpiWalkNamespace race condition with table unload
      ACPICA: Change handling of PM1 Status register ignored bit
      ACPICA: Preserve all PM control reserved and ignored bits
      ACPICA: New: I/O port protection
      ACPICA: Remove obsolete acpi_os_validate_address interface
      ACPICA: Remove unused code, no functional change
      ACPICA: Condense some protected ports
      ACPICA: Fix PCI configuration space port address range
      ACPICA: FADT: Favor 32-bit register addresses for compatibility
      ACPICA: FADT: Favor 32-bit FACS and DSDT addresses
      ACPICA: Fix index value in package warning message
      ACPICA: Update version to 20090320

Carlos Corbacho (2):
      acer-wmi: Blacklist Acer Aspire One
      acer-wmi: Update copyright notice & documentation

Dan Carpenter (1):
      dock: fix dereference after kfree()

Frans Pop (1):
      hp-wmi: notify of a potential docking state change on resume

Harald Jenny (1):
      sony-laptop: VGN-A317M hotkey support

Harald Welte (2):
      panasonic-laptop: Fix autoloading
      panasonic-laptop: use snprintf with PAGE_SIZE in sysfs attributes

Henrique de Moraes Holschuh (12):
      thinkpad-acpi: update copyright notices
      thinkpad-acpi: drop ibm-acpi alias
      thinkpad-acpi: documentation cleanup
      thinkpad-acpi: cleanup debug helpers
      thinkpad-acpi: add missing log levels
      thinkpad-acpi: add new debug helpers and warn of deprecated atts
      thinkpad-acpi: remove HKEY disable functionality
      thinkpad-acpi: restrict access to some firmware LEDs
      thinkpad-acpi: enhanced debugging messages for rfkill subdrivers
      thinkpad-acpi: enhanced debugging messages for the hotkey subdriver
      thinkpad-acpi: enhanced debugging messages for the fan subdriver
      thinkpad-acpi: rework brightness support

ISHIKAWA Mutsumi (1):
      sony-laptop: detect the ICH9 chipset as Type3

Jan Beulich (1):
      ACPI: constify tables in pci_irq.c

Jan Engelhardt (2):
      ACPI: constify VFTs (1/2)
      ACPI: constify VFTs (2/2)

Johannes Berg (1):
      toshiba-acpi: remove MAINTAINERS entry

Krzysztof Kosiñski (1):
      tc1100-wmi: Fix state reporting

Len Brown (4):
      ACPI: fix CONFIG_ACPI=n build
      ACPI: simplify processor lines in Makefile
      ACPI: get_throttling_state() cannot be larger than state_count
      video: build fix

Lin Ming (3):
      ACPICA: Check for non-zero address before being converted to GAS
      ACPICA: Clear PM register write-only bits on reading
      ACPI: cpufreq: use new bit register access function

Luca Tettamanti (1):
      ACPI: acpi_enforce_resource=strict by default

Matthew Garrett (10):
      thermal: use integers rather than strings for thermal values
      ACPI: move thermal trip handling to generic thermal layer
      sony-laptop: Add support for new Sony platform API
      sony-laptop: Enable EC on newer hardware
      sony-laptop: Add support for extra keyboard events
      sony-laptop: Add rfkill support on new models
      sony-laptop: Add support for extended hotkeys
      thermal: support forcing support for passive cooling
      ACPI: Populate DIDL before registering ACPI video device on Intel
      dell-wmi: new driver for hotkey control

Matthias Welwarsky (2):
      sony-laptop: new style events typo fixes
      sony-laptop: fix event reporting for new style events

Mattia Dongili (3):
      sony-laptop: merge Type4 into Type3
      sony-laptop: Make sony_pic_set_wwanpower not take mutexes
      sony-laptop: update copyright

Pallipadi, Venkatesh (1):
      ACPI: cap off P-state transition latency from buggy BIOSes

Rusty Russell (1):
      ACPI: simplify module_param namespace

Sergey Yanovich (1):
      sony-laptop: notify the hardware of a state change in wwanpower

Stanislaw Gruszka (1):
      ACPI: Avoid wiping out pr->performance during preregistering

Stephen Rothwell (1):
      ACPI: update thermal for bus_id removal

Suresh Siddha (2):
      x86, ACPI: add support for x2apic ACPI extensions
      ACPI: update x2apic comments

Thomas Renninger (1):
      ACPI: Remove R40e c-state blacklist

Witold Szczeponik (1):
      Enable PNPACPI _PSx Support, v3

Zhang Rui (9):
      ACPI: introduce sysfs I/F for dynamic tables
      ACPI video: check the return value of acpi_video_device_lcd_get_level_current
      ACPI video: check the return value of acpi_video_device_lcd_set_level
      ACPI video: support _BCL packages that don't export brightness levels when machine is on AC/Battery
      ACPI video: support reversed _BCL method in  ACPI video driver
      ACPI video: support _BQC/_BCL/_BCM methods that use index values
      ACPI video: support buggy BIOSes with _BCQ implemented
      ACPI video: add a warning message if _BQC is not found
      ACPI: update comment

Zhao Yakui (1):
      ACPI: suspend: Add the Pansonic CF51 box to the dmi check table

alex.shi (1):
      acpi: fix of pmtimer overflow that make Cx states time incorrect

--Boundary_(ID_UtOxifu34SB5JG0X3W4Xeg)--
