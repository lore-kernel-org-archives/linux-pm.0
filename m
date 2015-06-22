From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management and ACPI updates for v4.2-rc1
Date: Tue, 23 Jun 2015 01:04:27 +0200
Message-ID: <CAJZ5v0jNp01tEyUm3em-tMjs0oSM702XFAZcQ3D41honh-9n6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm+acpi-4.2-rc1

to receive power management and ACPI material for v4.2-rc1 with
top-most commit d461003574ebc862c2dae70c9e1ab32b1bf2cda1

 Merge branch 'pm-cpuidle'

on top of commit 0f57d86787d8b1076ea8f9cbdddda2a46d534a27

 Linux 4.1-rc8

The rework of backlight interface selection API from Hans de Goede
stands out from the number of commits and the number of affected
places perspective.  The cpufreq core fixes from Viresh Kumar are
quite significant too as far as the number of commits goes and
because they should reduce CPU online/offline overhead quite a bit
in the majority of cases.

>From the new featues point of view, the ACPICA update (to upstream
revision 20150515) adding support for new ACPI 6 material to ACPICA
is the one that matters the most as some new significant features
will be based on it going forward.  Also included is an update of the
ACPI device power management core to follow ACPI 6 (which in turn
reflects the Windows' device PM implementation), a PM core extension
to support wakeup interrupts in a more generic way and support for
the ACPI _CCA device configuration object.

The rest is mostly fixes and cleanups all over and some documentation
updates, including new DT bindings for Operating Performance Points.

There is one fix for a regression introduced in the 4.1 cycle, but it
adds quite a number of lines of code, it wasn't really ready before
Thursday and you were on vacation, so I refrained from pushing it
on the last minute for 4.1.

Specifics:

 - ACPICA update to upstream revision 20150515 including basic
   support for ACPI 6 features: new ACPI tables introduced by
   ACPI 6 (STAO, XENV, WPBT, NFIT, IORT), changes related to the
   other tables (DTRM, FADT, LPIT, MADT), new predefined names
   (_BTH, _CR3, _DSD, _LPI, _MTL, _PRR, _RDI, _RST, _TFP, _TSN),
   fixes and cleanups (Bob Moore, Lv Zheng).

 - ACPI device power management core code update to follow ACPI 6
   which reflects the ACPI device power management implementation
   in Windows (Rafael J Wysocki).

 - Rework of the backlight interface selection logic to reduce the
   number of kernel command line options and improve the handling
   of DMI quirks that may be involved in that and to make the
   code generally more straightforward (Hans de Goede).

 - Fixes for the ACPI Embedded Controller (EC) driver related to
   the handling of EC transactions (Lv Zheng).

 - Fix for a regression related to the ACPI resources management
   and resulting from a recent change of ACPI initialization code
   ordering (Rafael J Wysocki).

 - Fix for a system initialization regression related to ACPI
   introduced during the 3.14 cycle and caused by running the
   code that switches the platform over to the ACPI mode too
   early in the initialization sequence (Rafael J Wysocki).

 - Support for the ACPI _CCA device configuration object related
   to DMA cache coherence (Suravee Suthikulpanit).

 - ACPI/APEI fixes and cleanups (Jiri Kosina, Borislav Petkov).

 - ACPI battery driver cleanups (Luis Henriques, Mathias Krause).

 - ACPI processor driver cleanups (Hanjun Guo).

 - Cleanups and documentation update related to the ACPI device
   properties interface based on _DSD (Rafael J Wysocki).

 - ACPI device power management fixes (Rafael J Wysocki).

 - Assorted cleanups related to ACPI (Dominik Brodowski. Fabian
   Frederick, Lorenzo Pieralisi, Mathias Krause, Rafael J Wysocki).

 - Fix for a long-standing issue causing General Protection Faults
   to be generated occasionally on return to user space after resume
   from ACPI-based suspend-to-RAM on 32-bit x86 (Ingo Molnar).

 - Fix to make the suspend core code return -EBUSY consistently in
   all cases when system suspend is aborted due to wakeup detection
   (Ruchi Kandoi).

 - Support for automated device wakeup IRQ handling allowing drivers
   to make their PM support more starightforward (Tony Lindgren).

 - New tracepoints for suspend-to-idle tracing and rework of the
   prepare/complete callbacks tracing in the PM core (Todd E Brandt,
   Rafael J Wysocki).

 - Wakeup sources framework enhancements (Jin Qian).

 - New macro for noirq system PM callbacks (Grygorii Strashko).

 - Assorted cleanups related to system suspend (Rafael J Wysocki).

 - cpuidle core cleanups to make the code more efficient (Rafael J
   Wysocki).

 - powernv/pseries cpuidle driver update (Shilpasri G Bhat).

 - cpufreq core fixes related to CPU online/offline that should
   reduce the overhead of these operations quite a bit, unless the
   CPU in question is physically going away (Viresh Kumar, Saravana
   Kannan).

 - Serialization of cpufreq governor callbacks to avoid race
   conditions in some cases (Viresh Kumar).

 - intel_pstate driver fixes and cleanups (Doug Smythies, Prarit
   Bhargava, Joe Konno).

 - cpufreq driver (arm_big_little, cpufreq-dt, qoriq) updates (Sudeep
   Holla, Felipe Balbi, Tang Yuantian).

 - Assorted cleanups in cpufreq drivers and core (Shailendra Verma,
   Fabian Frederick, Wang Long).

 - New Device Tree bindings for representing Operating Performance
   Points (Viresh Kumar).

 - Updates for the common clock operations support code in the PM
   core (Rajendra Nayak, Geert Uytterhoeven).

 - PM domains core code update (Geert Uytterhoeven).

 - Intel Knights Landing support for the RAPL (Running Average Power
   Limit) power capping driver (Dasaratharaman Chandramouli).

 - Fixes related to the floor frequency setting on Atom SoCs in the
   RAPL power capping driver (Ajay Thomas).

 - Runtime PM framework documentation update (Ben Dooks).

 - cpupower tool fix (Herton R Krzesinski).

Thanks!


---------------

Ajay Thomas (1):
      powercap / RAPL: Floor frequency setting in Atom SoC

Ben Dooks (1):
      PM / runtime: add note about re-calling in during device probe()

Bob Moore (16):
      ACPICA: Additional dragon_fly BSD support.
      ACPICA: ACPI 6.0: Add support for STAO table.
      ACPICA: ACPI 6.0: Add support for new predefined names.
      ACPICA: ACPI 6.0: Add support for XENV table.
      ACPICA: Parser: Move a couple externals to the proper header.
      ACPICA: iASL: Enhance detection of non-ascii or corrupted input files.
      ACPICA: ACPI 6.0: Add support for WPBT table.
      ACPICA: ACPI 6.0: Add changes for FADT table.
      ACPICA: ACPI 6.0: Add changes for LPIT table.
      ACPICA: ACPI 6.0: Add changes for MADT table.
      ACPICA: iASL/disassembler - fix possible fault for -e option.
      ACPICA: acpi_help: Add option to display all known/supported ACPI tables.
      ACPICA: ACPI 6.0: Add support for NFIT table.
      ACPICA: Update version to 20150515.
      ACPICA: acpihelp: Update for new NFIT table GUIDs.
      ACPICA: Fix for ill-formed GUID strings for NFIT tables.

Borislav Petkov (4):
      GHES: Carve out error queueing in a separate function
      GHES: Carve out the panic functionality
      GHES: Panic right after detection
      GHES: Elliminate double-loop in the NMI handler

Dasaratharaman Chandramouli (1):
      powercap / RAPL: Support Knights Landing

Dominik Brodowski (2):
      ACPI / osl: use same type for acpi_predefined_names values as in
definition
      ACPI: fix kernel-parameters ordering in Documentation

Doug Smythies (3):
      intel_pstate: Add tsc collection and keep previous target pstate
      intel_pstate: change some inconsistent debug information
      intel_pstate: Force setting target pstate when required

Fabian Frederick (4):
      cpufreq: pxa: replace typedef pxa_freqs_t by structure
      cpufreq: pxa: make pxa_freqs arrays const
      PNP / ACPI: use u8 instead of int in acpi_resource_extended_irq context
      PNP / ACPI: use unsigned int in pnpacpi_encode_resources()

Felipe Balbi (1):
      cpufreq: dt: allow driver to boot automatically

Geert Uytterhoeven (3):
      PM / clk: Fix clock error check in __pm_clk_add()
      PM / Domains: Skip timings during syscore suspend/resume
      PM / clk: Print acquired clock name in addition to con_id

Grygorii Strashko (4):
      PM / sleep: Add macro to define common noirq system PM callbacks
      bus: omap_l3_noc: add missed callbacks for suspend-to-disk
      ARM: omap-device: use SET_NOIRQ_SYSTEM_SLEEP_PM_OPS
      leds / PM: fix hibernation on arm when gpio-led used with CPU led trigger

Hanjun Guo (8):
      ACPI / processor: Introduce invalid_logical_cpuid()
      Xen / ACPI / processor: use invalid_logical_cpuid()
      Xen / ACPI / processor: Remove unneeded NULL check
      ACPI / processor: remove cpu_index in acpi_processor_get_info()
      ACPI / processor: remove phys_id in acpi_processor_get_info()
      ACPI / processor: return specific error instead of -1
      ACPI / processor: Introduce invalid_phys_cpuid()
      ACPI / PCI: remove stale list_head in struct acpi_prt_entry

Hans de Goede (37):
      ACPI / video: Add enable_native_backlight quirk for MacbookPro12,1
      ACPI / video: Add a parameter to not register the backlight
sysfs interface
      apple_gmux: Use acpi_video_unregister_backlight instead of
acpi_video_unregister
      asus-wmi: Use acpi_video_unregister_backlight instead of
acpi_video_unregister
      samsung-laptop: Use acpi_video_unregister_backlight instead of
acpi_video_unregister
      apple-gmux: Stop using acpi_video_dmi_demote_vendor()
      acpi-video-detect: Remove the unused
acpi_video_dmi_demote_vendor() function
      acpi-video-detect: Make acpi_video_get_capabilities a private function
      acpi-video-detect: Move acpi_is_video_device() to acpi/scan.c
      acpi-video-detect: Move acpi_osi_is_win8 to osl.c
      acpi-video-detect: video: Make video_detect code part of the video module
      acpi-video-detect: Rewrite backlight interface selection logic
      acpi-video-detect: Unregister acpi_video backlight when dmi
quirks are added
      drm: i915: Port to new backlight interface selection API
      ACPI / video: Port to new backlight interface selection API
      ACPI / video: Move backlight notifier to video_detect.c
      ACPI / video: Move dmi_check_system from module_init to
acpi_video_register
      ACPI / video: Fix acpi_video _register vs _unregister_backlight race
      acer-wmi: Port to new backlight interface selection API
      apple-gmux: Port to new backlight interface selection API
      asus-laptop: Port to new backlight interface selection API
      asus-wmi: Port to new backlight interface selection API
      compal-laptop: Port to new backlight interface selection API
      dell-laptop: Port to new backlight interface selection API
      dell-wmi: Port to new backlight interface selection API
      eeepc-laptop: Port to new backlight interface selection API
      fujitsu-laptop: Port to new backlight interface selection API
      ideapad-laptop: Port to new backlight interface selection API
      intel-oaktrail: Port to new backlight interface selection API
      msi-laptop: Port to new backlight interface selection API
      msi-wmi: Port to new backlight interface selection API
      samsung-laptop: Port to new backlight interface selection API
      sony-laptop: Port to new backlight interface selection API
      thinkpad-acpi: Port to new backlight interface selection API
      toshiba-acpi: Port to new backlight interface selection API
      acpi-video-detect: Remove old API
      ACPI / video: Make acpi_video_unregister_backlight() private

Herton R. Krzesinski (1):
      cpupower: mperf monitor: fix output in MAX_FREQ_SYSFS mode

Ingo Molnar (1):
      x86: Load __USER_DS into DS/ES after resume

Jin Qian (2):
      PM / wakeup: validate wakeup source before activating it.
      PM / wakeup: add a dummy wakeup_source to record statistics

Jiri Kosina (1):
      GHES: Make NMI handler have a single reader

Joe Konno (1):
      intel_pstate: set BYT MSR with wrmsrl_on_cpu()

Lorenzo Pieralisi (1):
      ACPI / proc: make ACPI_PROCFS_POWER X86 only

Luis Henriques (3):
      ACPI / battery: abort initialization earlier if acpi_disabled
      ACPI / battery: drop useless return statements
      ACPI / battery: ensure acpi_battery_init() has finish

Lv Zheng (17):
      ACPI / EC: Update acpi_ec_is_gpe_raised() with new GPE status flag.
      ACPI / EC: Remove storming threashold enlarging quirk.
      ACPI / EC: Remove irqs_disabled() check.
      ACPI / EC: Fix and clean up register access guarding logics.
      ACPI / EC: Add module params for polling modes.
      ACPI / EC: Remove non-root-caused busy polling quirks.
      ACPICA: Divergence: Remove redundant definitions.
      ACPICA: Dispatcher: Fix a resource leak issue in
acpi_ds_auto_serialize_method().
      ACPICA: Hardware: Fix a resource leak issue in acpi_hw_build_pci_list().
      ACPICA: ACPI 6.0: Add ACPI_SUB_PTR().
      ACPICA: ACPI 6.0: Add support for IORT table.
      ACPICA: ACPI 6.0: Add changes for DRTM table.
      ACPI / EC: Cleanup transaction state transition.
      ACPI / EC: Convert event handling work queue into loop style.
      ACPI / EC: Add event clearing variation support.
      ACPI / EC: Fix EC_FLAGS_QUERY_HANDSHAKE platforms using new
event clearing timing.
      ACPI / EC: Fix a code coverity issue when QR_EC transactions are failed.

Mathias Krause (10):
      ACPI / video: constify ACPI and DMI id tables
      ACPI / AC: constify DMI system id table
      ACPI / battery: constify the offset tables
      ACPI / battery: minor tweaks to acpi_battery_units()
      ACPI / battery: mark DMI table as __initconst
      ACPI / LPSS: constify device descriptors
      ACPI / HED: constify ACPI device ids
      ACPI / processor: constify DMI system id table
      ACPI / scan: constify ACPI device ids
      ACPI: Constify ACPI device IDs in documentation

Prarit Bhargava (1):
      intel_pstate: Fix overflow in busy_scaled due to long delay

Rafael J. Wysocki (21):
      sched / idle: Move the default idle call code to a separate function
      cpuidle: Check the sign of index in cpuidle_reflect()
      sched / idle: Eliminate the "reflect" check from cpuidle_idle_call()
      ACPI / property: Refine consistency check for PRP0001
      ACPI / PM: Drop stale comment from acpi_power_transition()
      cpuidle: Fix the kerneldoc comment for cpuidle_enter_state()
      PM / sleep: Refine diagnostic messages in enter_state()
      PM / sleep: Fix symbol name in a comment in kernel/power/main.c
      sched / idle: Call idle_set_state() from cpuidle_enter_state()
      sched / idle: Call default_idle_call() from cpuidle_enter_state()
      cpuidle: Select a different state on tick_broadcast_enter() failures
      PM / tick: Add tracepoints for suspend-to-idle diagnostics
      ACPI / PM: Rework device power management to follow ACPI 6
      PM / sleep: Make suspend-to-idle-specific code depend on CONFIG_SUSPEND
      ACPI / property: Define a symbol for PRP0001
      ACPI / PM: Turn power resources on and off in the right order
during resume
      cpuidle: Do not use CPUIDLE_DRIVER_STATE_START in cpuidle.c
      ACPI / PM: Add missing pm_generic_complete() invocation
      ACPI / init: Switch over platform to the ACPI mode later
      ACPI / PNP: Avoid conflicting resource reservations
      ACPI / enumeration: Document the rules regarding the PRP0001 device ID

Rajendra Nayak (5):
      PM / clock_ops: Provide default runtime ops to users
      arm: keystone: remove boilerplate code and use USE_PM_CLK_RUNTIME_OPS
      arm: omap1: remove boilerplate code and use USE_PM_CLK_RUNTIME_OPS
      arm: davinci: remove boilerplate code and use USE_PM_CLK_RUNTIME_OPS
      drivers: sh: remove boilerplate code and use USE_PM_CLK_RUNTIME_OPS

Ruchi Kandoi (1):
      PM / sleep: Return -EBUSY from suspend_enter() on wakeup detection

Saravana Kannan (1):
      cpufreq: Track cpu managing sysfs kobjects separately

Shailendra Verma (3):
      cpufreq: Fix for typos in two comments
      cpufreq: nforce2: Fix typo in comment to function nforce2_init()
      cpufreq: gx-suspmod: Fix two typos in two comments

Shilpasri G Bhat (1):
      cpuidle: powernv/pseries: Auto-promotion of snooze to deeper idle state

Sudeep Holla (3):
      cpufreq: arm_big_little: check if the frequency is set correctly
      cpufreq: arm_big_little: remove unused cpu-cluster.<n> clock name
      cpufreq: arm_big_little: remove compile-time dependency on BIG_LITTLE

Suthikulpanit, Suravee (7):
      ACPI / scan: Parse _CCA and setup device coherency
      arm64 : Introduce support for ACPI _CCA object
      device property: Introduces device_dma_is_coherent()
      crypto: ccp - Unify coherency checking logic with device_dma_is_coherent()
      amd-xgbe: Unify coherency checking logic with device_dma_is_coherent()
      megaraid_sas: fix TRUE and FALSE re-define build error
      ufs: fix TRUE and FALSE re-define build error

Tang Yuantian (1):
      cpufreq: qoriq: optimize the CPU frequency switching time

Todd E Brandt (1):
      PM / sleep: trace_device_pm_callback coverage in dpm_prepare/complete

Tony Lindgren (3):
      PM / Runtime: Update last_busy in rpm_resume
      PM / Wakeirq: Add automated device wake IRQ handling
      PM / wakeirq: Fix typo in prototype for dev_pm_set_dedicated_wake_irq

Viresh Kumar (23):
      cpufreq: Add doc style comment about cpufreq_cpu_{get|put}()
      cpufreq: Merge __cpufreq_add_dev() and cpufreq_add_dev()
      cpufreq: Throw warning when we try to get policy for an invalid CPU
      cpufreq: Keep a single path for adding managed CPUs
      cpufreq: Clear policy->cpus even for the last CPU
      cpufreq: Create for_each_{in}active_policy()
      cpufreq: Don't clear cpufreq_cpu_data and policy list for
inactive policies
      cpufreq: Get rid of cpufreq_cpu_data_fallback
      cpufreq: Don't traverse all active policies to find policy for a cpu
      cpufreq: Manage governor usage history with 'policy->last_governor'
      cpufreq: Mark policy->governor = NULL for inactive policies
      cpufreq: Don't allow updating inactive policies from sysfs
      cpufreq: Stop migrating sysfs files on hotplug
      cpufreq: Initialize policy->kobj while allocating policy
      cpufreq: Call cpufreq_policy_put_kobj() from cpufreq_policy_free()
      cpufreq: Restart governor as soon as possible
      cpufreq: Remove cpufreq_update_policy()
      cpufreq: governor: register notifier from cs_init()
      cpufreq: governor: split cpufreq_governor_dbs()
      cpufreq: governor: Serialize governor callbacks
      PM / OPP: Add new bindings to address shortcomings of existing bindings
      PM / OPP: Allow multiple OPP tables to be passed via DT
      PM / OPP: Add binding for 'opp-suspend'

Wang Long (1):
      Documentation: cpufreq: delete duplicate description of sysfs
interface 'scaling_driver'

---------------

 Documentation/acpi/enumeration.txt                 |  57 +-
 Documentation/cpu-freq/user-guide.txt              |   2 -
 Documentation/devicetree/bindings/power/opp.txt    | 448 +++++++++++++++-
 Documentation/kernel-parameters.txt                |  62 +--
 Documentation/power/runtime_pm.txt                 |   6 +
 arch/arm/mach-davinci/pm_domain.c                  |  32 +-
 arch/arm/mach-keystone/pm_domain.c                 |  33 +-
 arch/arm/mach-omap1/pm_bus.c                       |  37 +-
 arch/arm/mach-omap2/omap_device.c                  |   7 +-
 arch/arm64/Kconfig                                 |   1 +
 arch/arm64/include/asm/dma-mapping.h               |  18 +-
 arch/arm64/mm/dma-mapping.c                        |  92 ++++
 arch/x86/kernel/acpi/wakeup_32.S                   |   6 +-
 drivers/acpi/Kconfig                               |   5 +-
 drivers/acpi/Makefile                              |   5 +-
 drivers/acpi/ac.c                                  |   2 +-
 drivers/acpi/acpi_lpss.c                           |  22 +-
 drivers/acpi/acpi_platform.c                       |   2 +-
 drivers/acpi/acpi_processor.c                      |  20 +-
 drivers/acpi/{video.c => acpi_video.c}             | 283 ++--------
 drivers/acpi/acpica/acdebug.h                      |   4 +-
 drivers/acpi/acpica/aclocal.h                      |  15 +
 drivers/acpi/acpica/acparser.h                     |   3 +
 drivers/acpi/acpica/acpredef.h                     |  45 +-
 drivers/acpi/acpica/acutils.h                      |   2 +-
 drivers/acpi/acpica/dsmethod.c                     |   5 +-
 drivers/acpi/acpica/hwpci.c                        |   9 +-
 drivers/acpi/acpica/nsprepkg.c                     |  13 +
 drivers/acpi/acpica/nsrepair.c                     |   2 +-
 drivers/acpi/acpica/psopinfo.c                     |   3 -
 drivers/acpi/acpica/utfileio.c                     |   9 +-
 drivers/acpi/acpica/uthex.c                        |   4 +-
 drivers/acpi/acpica/utxferror.c                    |  11 +-
 drivers/acpi/apei/ghes.c                           | 108 ++--
 drivers/acpi/battery.c                             |  48 +-
 drivers/acpi/bus.c                                 |  56 +-
 drivers/acpi/device_pm.c                           |  98 ++--
 drivers/acpi/ec.c                                  | 357 +++++++++----
 drivers/acpi/fan.c                                 |   5 +-
 drivers/acpi/glue.c                                |   5 +
 drivers/acpi/hed.c                                 |   2 +-
 drivers/acpi/internal.h                            |  11 +-
 drivers/acpi/osl.c                                 |  14 +-
 drivers/acpi/pci_irq.c                             |   1 -
 drivers/acpi/power.c                               |  45 +-
 drivers/acpi/processor_core.c                      |  10 +-
 drivers/acpi/processor_idle.c                      |   2 +-
 drivers/acpi/processor_pdc.c                       |   5 +-
 drivers/acpi/property.c                            |  54 +-
 drivers/acpi/resource.c                            | 160 ++++++
 drivers/acpi/scan.c                                | 147 ++++--
 drivers/acpi/utils.c                               |  15 +
 drivers/acpi/video_detect.c                        | 409 ++++++++-------
 drivers/base/power/Makefile                        |   2 +-
 drivers/base/power/clock_ops.c                     |  43 +-
 drivers/base/power/domain.c                        |  42 +-
 drivers/base/power/main.c                          |  14 +-
 drivers/base/power/power.h                         |  48 ++
 drivers/base/power/runtime.c                       |   6 +
 drivers/base/power/wakeirq.c                       | 273 ++++++++++
 drivers/base/power/wakeup.c                        | 146 ++++++
 drivers/base/property.c                            |  14 +
 drivers/bus/omap_l3_noc.c                          |   4 +-
 drivers/cpufreq/Kconfig.arm                        |   2 +-
 drivers/cpufreq/arm_big_little.c                   |  40 +-
 drivers/cpufreq/cpufreq-dt.c                       |   1 +
 drivers/cpufreq/cpufreq-nforce2.c                  |   2 +-
 drivers/cpufreq/cpufreq.c                          | 573 ++++++++++++---------
 drivers/cpufreq/cpufreq_conservative.c             |  28 +-
 drivers/cpufreq/cpufreq_governor.c                 | 345 +++++++------
 drivers/cpufreq/cpufreq_governor.h                 |  16 +-
 drivers/cpufreq/cpufreq_ondemand.c                 |   6 +-
 drivers/cpufreq/gx-suspmod.c                       |   4 +-
 drivers/cpufreq/intel_pstate.c                     |  72 +--
 drivers/cpufreq/pxa2xx-cpufreq.c                   |  20 +-
 drivers/cpufreq/qoriq-cpufreq.c                    |  32 +-
 drivers/cpuidle/cpuidle-powernv.c                  |  12 +
 drivers/cpuidle/cpuidle-pseries.c                  |  11 +
 drivers/cpuidle/cpuidle.c                          |  40 +-
 drivers/cpuidle/governors/menu.c                   |   4 +-
 drivers/crypto/ccp/ccp-platform.c                  |  60 +--
 drivers/gpu/drm/i915/intel_opregion.c              |  12 +-
 drivers/leds/led-class.c                           |   7 +-
 drivers/net/ethernet/amd/xgbe/xgbe-main.c          |  27 +-
 drivers/pci/pci-acpi.c                             |   2 +-
 drivers/platform/x86/Kconfig                       |  21 +-
 drivers/platform/x86/acer-wmi.c                    |  10 +-
 drivers/platform/x86/apple-gmux.c                  |   4 +-
 drivers/platform/x86/asus-laptop.c                 |   6 +-
 drivers/platform/x86/asus-wmi.c                    |  15 +-
 drivers/platform/x86/compal-laptop.c               |   4 +-
 drivers/platform/x86/dell-laptop.c                 |   8 +-
 drivers/platform/x86/dell-wmi.c                    |   3 +-
 drivers/platform/x86/eeepc-laptop.c                |   5 +-
 drivers/platform/x86/fujitsu-laptop.c              |   6 +-
 drivers/platform/x86/ideapad-laptop.c              |   3 +-
 drivers/platform/x86/intel_oaktrail.c              |   7 +-
 drivers/platform/x86/msi-laptop.c                  |   6 +-
 drivers/platform/x86/msi-wmi.c                     |   4 +-
 drivers/platform/x86/samsung-laptop.c              |  27 +-
 drivers/platform/x86/sony-laptop.c                 |   7 +-
 drivers/platform/x86/thinkpad_acpi.c               |   5 +-
 drivers/platform/x86/toshiba_acpi.c                |   7 +-
 drivers/pnp/pnpacpi/rsparser.c                     |  10 +-
 drivers/pnp/system.c                               |  35 +-
 drivers/powercap/intel_rapl.c                      |  51 +-
 drivers/scsi/megaraid/megaraid_sas_fp.c            |   8 +
 drivers/scsi/ufs/unipro.h                          |   8 +
 drivers/sh/pm_runtime.c                            |  47 +-
 drivers/xen/xen-acpi-cpuhotplug.c                  |  12 +-
 include/acpi/acpi_bus.h                            |  41 +-
 include/acpi/acpiosxf.h                            |   2 +-
 include/acpi/acpixf.h                              |   2 +-
 include/acpi/actbl.h                               |  17 +-
 include/acpi/actbl1.h                              | 176 ++++++-
 include/acpi/actbl2.h                              | 146 +++++-
 include/acpi/actbl3.h                              |  88 +++-
 include/acpi/actypes.h                             |   6 +-
 include/acpi/acuuid.h                              |  89 ++++
 include/acpi/platform/acenv.h                      |   3 +
 include/acpi/platform/acenvex.h                    |   3 +
 include/acpi/video.h                               |  21 +-
 include/linux/acpi.h                               |  69 ++-
 include/linux/cpufreq.h                            |   5 +-
 include/linux/cpuidle.h                            |  20 +-
 include/linux/pm.h                                 |  14 +
 include/linux/pm_clock.h                           |  10 +
 include/linux/pm_wakeirq.h                         |  51 ++
 include/linux/pm_wakeup.h                          |   9 +
 include/linux/property.h                           |   2 +
 include/linux/tick.h                               |  12 +-
 include/trace/events/power.h                       |  25 +-
 init/main.c                                        |   1 +
 kernel/power/main.c                                |   2 +-
 kernel/power/suspend.c                             |   8 +-
 kernel/sched/idle.c                                | 114 ++--
 kernel/time/tick-common.c                          |  17 +-
 .../cpupower/utils/idle_monitor/mperf_monitor.c    |   5 +-
 138 files changed, 4095 insertions(+), 1907 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
