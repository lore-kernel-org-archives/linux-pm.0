Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182EF3CFF62
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 14:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775831108; cv=none; b=sf+Ms3mJBZByWNoJbdP5CFswQ9jCra2wuZ9Oe7h3uy0e7Ii6BQ5sMw0JjX7+nuwJglSabSbcHI+5RR8myyJs0q1LKNZ5CAK6hpqvshzC5SxBKVkNZIQhIeUfUPJjZB93PF/MQvpII+E9xbrzPmLaeTmtqoZWgNudarxXQ7eWNCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775831108; c=relaxed/simple;
	bh=y8VQHiooRk5naz9DwNFSj8KAIHoQijEO39T9x9CrqC8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=PxS4P7GmIVEoSh/CvQovekBhnLjq2SofvKdC7Zzb0ITxwQ3AIYUWEiWXmjY/vuYAEZbpWnHae0/r6PoXoxBIC3oxvZpD8XDemm4kQ3u8a3aDsGm7qHTG6XAaAMaxEYWkG7PMmch2VOhtxtreCns1IE90W1IZB94tNw+/dKmyOlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDE1ZdnD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDE1ZdnD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4C0C2BC87
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 14:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775831107;
	bh=y8VQHiooRk5naz9DwNFSj8KAIHoQijEO39T9x9CrqC8=;
	h=From:Date:Subject:To:Cc:From;
	b=lDE1ZdnDxP4FQpj+MvVetcjs3eMj9RBK2zM7xTDe4xPapso4mTvqgUdA85kKL282c
	 syZcP9ahHQkl+1lEGtlapZc7oFaJ1dq+5TY5Vtb/wH72voHrsF5kaA7UkiLF3jvqK4
	 V/Lg9fYFpXRgJm4uX/KOoHtY/dSXMrbWcZt1rY/CiwSC7DpX7cJbH4etur5DAwSL6J
	 RDzJutfYSuMWdkkEz2t8c2MBDxWcKgV7Lh/1dQ4AaudFdg9WNsz1tpzYjcQuaiVRf3
	 cKIp1yteHzUB4hYPCDRl39mN2sict9Wd37ERnuvTyz3XIcPqm8f3uONvREPzeNT357
	 4xmM+JfMIaQhg==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d86eb7c854so1069096a34.3
        for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 07:25:07 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzcvn4BociaT5I/Se0WkBHiP8QffiD1DTNHPXsKZKx6SdQkCv4c
	FAe2MtIw20+Y07f4Ndi3sw5yDQslNE8G0yotuVW2LlY+Rl5XI4IXcWWIL1WwMreXxwA6pRyVfRZ
	hFYqtVmIFOUoUzhg4ubW0bEu9JWxR+x8=
X-Received: by 2002:a05:6820:4b15:b0:679:97ac:2cc3 with SMTP id
 006d021491bc7-68be643039dmr1767680eaf.22.1775831106940; Fri, 10 Apr 2026
 07:25:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 10 Apr 2026 16:24:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gdx4Gy3j2NBUtC+z3X7ZJ+GDg-R27pJ5AkZk7j8-36TQ@mail.gmail.com>
X-Gm-Features: AQROBzAqELjyI8CtxVGS7-VJAc2synRCvGTQULLHc4ENnuPAdwKlfCnGN3Ri36s
Message-ID: <CAJZ5v0gdx4Gy3j2NBUtC+z3X7ZJ+GDg-R27pJ5AkZk7j8-36TQ@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v7.1-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Shuah Khan <shuah@kernel.org>, "Chanwoo Choi (samsung.com)" <chanwoo@kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

This goes early because I will be traveling next week.

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-7.1-rc1

with top-most commit d923f70e37310fe613883a3a4c2ea2f31246253b

 Merge branch 'pm-devfreq'

on top of commit 591cd656a1bf5ea94a222af5ef2ee76df029c1d2

 Linux 7.0-rc7

to receive power management updates for 7.1-rc1.

Once again, cpufreq is the most active development area, mostly because
of the new feature additions and documentation updates in the amd-pstate
driver, but there are also changes in the cpufreq core related to boost
support and other assorted updates elsewhere.

Next up are power capping changes due to the major cleanup of the Intel
RAPL driver.

On the cpuidle front, a new C-states table for Intel Panther Lake is
added to the intel_idle driver, the stopped tick handling in the menu
and teo governors is updated, and there are a couple of cleanups.

Apart from the above, support for Tegra114 is added to devfreq and
there are assorted cleanups of that code, there are also two updates
of the operating performance points (OPP) library, two minor updates
related to hibernation, and cpupower utility man pages updates and
cleanups.

Specifics:

 - Update qcom-hw DT bindings to include Eliza hardware (Abel Vesa)

 - Update cpufreq-dt-platdev blocklist (Faruque Ansari)

 - Minor updates to driver and dt-bindings for Tegra (Thierry Reding,
   Rosen Penev)

 - Add MAINTAINERS entry for CPPC driver (Viresh Kumar)

 - Add support for new features: CPPC performance priority, Dynamic EPP,
   Raw EPP, and new unit tests for them to amd-pstate (Gautham Shenoy,
   Mario Limonciello)

 - Fix sysfs files being present when HW missing and broken/outdated
   documentation in the amd-pstate driver (Ninad Naik, Gautham Shenoy)

 - Pass the policy to cpufreq_driver->adjust_perf() to avoid using
   cpufreq_cpu_get() in the .adjust_perf() callback in amd-pstate which
   leads to a scheduling-while-atomic bug (K Prateek Nayak)

 - Clean up dead code in Kconfig for cpufreq (Julian Braha)

 - Remove max_freq_req update for pre-existing cpufreq policy and add a
   boost_freq_req QoS request to save the boost constraint instead of
   overwriting the last scaling_max_freq constraint (Pierre Gondois)

 - Embed cpufreq QoS freq_req objects in cpufreq policy so they all
   are allocated in one go along with the policy to simplify lifetime
   rules and avoid error handling issues (Viresh Kumar)

 - Use DMI max speed when CPPC is unavailable in the acpi-cpufreq
   scaling driver (Henry Tseng)

 - Switch policy_is_shared() in cpufreq to using cpumask_nth() instead
   of cpumask_weight() because the former is more efficient (Yury Norov)

 - Use sysfs_emit() in sysfs show functions for cpufreq governor
   attributes (Thorsten Blum)

 - Update intel_pstate to stop returning an error when "off" is written
   to its status sysfs attribute while the driver is already off (Fabio
   De Francesco)

 - Include current frequency in the debug message printed by
   __cpufreq_driver_target() (Pengjie Zhang)

 - Refine stopped tick handling in the menu cpuidle governor and
   rearrange stopped tick handling in the teo cpuidle governor (Rafael
   Wysocki)

 - Add Panther Lake C-states table to the intel_idle driver (Artem
   Bityutskiy)

 - Clean up dead dependencies on CPU_IDLE in Kconfig (Julian Braha)

 - Simplify cpuidle_register_device() with guard() (Huisong Li)

 - Use performance level if available to distinguish between rates in
   OPP debugfs (Manivannan Sadhasivam)

 - Fix scoped_guard in dev_pm_opp_xlate_required_opp() (Viresh Kumar)

 - Return -ENODATA if the snapshot image is not loaded (Alberto Garcia)

 - Remove inclusion of crypto/hash.h from hibernate_64.c on x86 (Eric
   Biggers)

 - Clean up and rearrange the intel_rapl power capping driver to make
   the respective interface drivers (TPMI, MSR, and MMOI) hold their
   own settings and primitives and consolidate PL4 and PMU support
   flags into rapl_defaults (Kuppuswamy Sathyanarayanan)

 - Correct kernel-doc function parameter names in the power capping core
   code (Randy Dunlap)

 - Remove unneeded casting for HZ_PER_KHZ in devfreq (Andy Shevchenko)

 - Use _visible attribute to replace create/remove_sysfs_files() in
   devfreq (Pengjie Zhang)

 - Add Tegra114 support to activity monitor device in tegra30-devfreq as
   a preparation to upcoming EMC controller support (Svyatoslav Ryhel)

 - Fix mistakes in cpupower man pages, add the boost and epp options to
   the cpupower-frequency-info man page, and add the perf-bias option to
   the cpupower-info man page (Roberto Ricci)

 - Remove unnecessary extern declarations from getopt.h in arguments
   parsing functions in cpufreq-set, cpuidle-info, cpuidle-set,
   cpupower-info, and cpupower-set utilities (Kaushlendra Kumar)

Thanks!


---------------

Abel Vesa (1):
      dt-bindings: cpufreq: qcom-hw: document Eliza cpufreq hardware

Alberto Garcia (1):
      PM: hibernate: return -ENODATA if the snapshot image is not loaded

Andy Shevchenko (1):
      PM / devfreq: Remove unneeded casting for HZ_PER_KHZ

Artem Bityutskiy (1):
      intel_idle: Add Panther Lake C-states table

Eric Biggers (1):
      PM: hibernate: x86: Remove inclusion of crypto/hash.h

Fabio M. De Francesco (1):
      cpufreq: intel_pstate: Allow repeated intel_pstate disable

Faruque Ansari (1):
      cpufreq: Add QCS8300 to cpufreq-dt-platdev blocklist

Gautham R. Shenoy (13):
      amd-pstate: Fix memory leak in amd_pstate_epp_cpu_init()
      amd-pstate: Update cppc_req_cached in fast_switch case
      amd-pstate: Make certain freq_attrs conditionally visible
      x86/cpufeatures: Add AMD CPPC Performance Priority feature.
      amd-pstate: Add support for CPPC_REQ2 and FLOOR_PERF
      amd-pstate: Add sysfs support for floor_freq and floor_count
      amd-pstate: Introduce a tracepoint trace_amd_pstate_cppc_req2()
      amd-pstate-ut: Add module parameter to select testcases
      amd-pstate-ut: Add a testcase to validate the visibility of
driver attributes
      Documentation/amd-pstate: List amd_pstate_hw_prefcore sysfs file
      Documentation/amd-pstate: List amd_pstate_prefcore_ranking sysfs file
      Documentation/amd-pstate: Add documentation for
amd_pstate_floor_{freq,count}
      MAINTAINERS: amd-pstate: Step down as maintainer, add Prateek as reviewer

Henry Tseng (1):
      cpufreq: acpi-cpufreq: use DMI max speed when CPPC is unavailable

Huisong Li (1):
      cpuidle: Simplify cpuidle_register_device() with guard()

Julian Braha (2):
      cpufreq: clean up dead code in Kconfig
      cpuidle: clean up dead dependencies on CPU_IDLE in Kconfig

K Prateek Nayak (2):
      cpufreq/amd-pstate: Pass the policy to amd_pstate_update()
      cpufreq: Pass the policy to cpufreq_driver->adjust_perf()

Kaushlendra Kumar (1):
      cpupower: remove extern declarations in cmd functions

Kuppuswamy Sathyanarayanan (18):
      powercap: intel_rapl: Add a symbol namespace for intel_rapl exports
      powercap: intel_rapl: Cleanup coding style
      powercap: intel_rapl: Remove unused TIME_WINDOW macros
      powercap: intel_rapl: Simplify rapl_compute_time_window_atom()
      powercap: intel_rapl: Use shifts for power-of-2 operations
      powercap: intel_rapl: Use GENMASK() and BIT() macros
      powercap: intel_rapl: Use unit conversion macros from units.h
      powercap: intel_rapl: Allow interface drivers to configure rapl_defaults
      powercap: intel_rapl: Move TPMI default settings into TPMI
interface driver
      thermal: intel: int340x: processor: Move RAPL defaults to MMIO driver
      powercap: intel_rapl: Remove unused AVERAGE_POWER primitive
      powercap: intel_rapl: Move MSR default settings into MSR interface driver
      powercap: intel_rapl: Remove unused macro definitions
      powercap: intel_rapl: Move primitive info to header for interface drivers
      powercap: intel_rapl: Move TPMI primitives to TPMI driver
      thermal: intel: int340x: processor: Move MMIO primitives to MMIO driver
      powercap: intel_rapl: Move MSR primitives to MSR driver
      powercap: intel_rapl: Consolidate PL4 and PMU support flags into
rapl_defaults

Manivannan Sadhasivam (1):
      OPP: debugfs: Use performance level if available to distinguish
between rates

Mario Limonciello (AMD) (7):
      cpufreq/amd-pstate: Add POWER_SUPPLY select for dynamic EPP
      cpufreq/amd-pstate: Cache the max frequency in cpudata
      cpufreq/amd-pstate: Add dynamic energy performance preference
      cpufreq/amd-pstate: add kernel command line to override dynamic epp
      cpufreq/amd-pstate: Add support for platform profile class
      cpufreq/amd-pstate: Add support for raw EPP writes
      cpufreq/amd-pstate-ut: Add a unit test for raw EPP

Ninad Naik (1):
      Documentation: amd-pstate: fix dead links in the reference section

Pengjie Zhang (2):
      cpufreq: Add debug print for current frequency in
__cpufreq_driver_target()
      PM / devfreq: use _visible attribute to replace
create/remove_sysfs_files()

Pierre Gondois (2):
      cpufreq: Remove max_freq_req update for pre-existing policy
      cpufreq: Add boost_freq_req QoS request

Rafael J. Wysocki (2):
      cpuidle: governors: menu: Refine stopped tick handling
      cpuidle: governors: teo: Rearrange stopped tick handling

Randy Dunlap (1):
      powercap: correct kernel-doc function parameter names

Roberto Ricci (4):
      cpupower-idle-info.1: fix short option names
      cpupower-frequency-info.1: use the proper name of the --perf option
      cpupower-frequency-info.1: document --boost and --epp options
      cpupower-info.1: describe the --perf-bias option

Rosen Penev (1):
      cpufreq: tegra194: remove COMPILE_TEST

Svyatoslav Ryhel (1):
      PM / devfreq: tegra30-devfreq: add support for Tegra114

Thierry Reding (2):
      dt-bindings: arm: nvidia: Document the Tegra238 CCPLEX cluster
      cpufreq: tegra194: Rename Tegra239 to Tegra238

Thorsten Blum (1):
      cpufreq: governor: Use sysfs_emit() in sysfs show functions

Viresh Kumar (3):
      OPP: Move break out of scoped_guard in dev_pm_opp_xlate_required_opp()
      cpufreq: Add MAINTAINERS entry for CPPC driver
      cpufreq: Allocate QoS freq_req objects with policy

Yury Norov (1):
      cpufreq: optimize policy_is_shared()

---------------

 Documentation/admin-guide/kernel-parameters.txt    |   7 +
 Documentation/admin-guide/pm/amd-pstate.rst        |  87 ++-
 .../arm/tegra/nvidia,tegra-ccplex-cluster.yaml     |   1 +
 .../bindings/cpufreq/cpufreq-qcom-hw.yaml          |   1 +
 MAINTAINERS                                        |  25 +-
 arch/x86/include/asm/cpufeatures.h                 |   2 +-
 arch/x86/include/asm/msr-index.h                   |   5 +
 arch/x86/kernel/cpu/scattered.c                    |   1 +
 arch/x86/power/hibernate_64.c                      |   2 -
 drivers/acpi/cppc_acpi.c                           |   3 +-
 drivers/cpufreq/Kconfig                            |   5 +-
 drivers/cpufreq/Kconfig.arm                        |   2 +-
 drivers/cpufreq/Kconfig.x86                        |  14 +
 drivers/cpufreq/acpi-cpufreq.c                     |  31 +-
 drivers/cpufreq/amd-pstate-trace.h                 |  35 ++
 drivers/cpufreq/amd-pstate-ut.c                    | 279 ++++++++-
 drivers/cpufreq/amd-pstate.c                       | 627 ++++++++++++++++++---
 drivers/cpufreq/amd-pstate.h                       |  37 +-
 drivers/cpufreq/cppc_cpufreq.c                     |  10 +-
 drivers/cpufreq/cpufreq-dt-platdev.c               |   1 +
 drivers/cpufreq/cpufreq.c                          |  85 ++-
 drivers/cpufreq/cpufreq_governor.h                 |   5 +-
 drivers/cpufreq/intel_pstate.c                     |   6 +-
 drivers/cpufreq/tegra194-cpufreq.c                 |   4 +-
 drivers/cpuidle/Kconfig                            |   2 +-
 drivers/cpuidle/Kconfig.mips                       |   2 +-
 drivers/cpuidle/Kconfig.powerpc                    |   2 -
 drivers/cpuidle/cpuidle.c                          |  12 +-
 drivers/cpuidle/governors/gov.h                    |   5 +
 drivers/cpuidle/governors/menu.c                   |  15 +-
 drivers/cpuidle/governors/teo.c                    |  81 ++-
 drivers/devfreq/devfreq.c                          | 108 ++--
 drivers/devfreq/tegra30-devfreq.c                  |  17 +-
 drivers/idle/intel_idle.c                          |  42 ++
 drivers/opp/core.c                                 |   2 +-
 drivers/opp/debugfs.c                              |  20 +-
 drivers/powercap/intel_rapl_common.c               | 565 ++-----------------
 drivers/powercap/intel_rapl_msr.c                  | 393 ++++++++++++-
 drivers/powercap/intel_rapl_tpmi.c                 | 101 ++++
 .../intel/int340x_thermal/processor_thermal_rapl.c |  81 +++
 include/acpi/cppc_acpi.h                           |   1 +
 include/linux/cpufreq.h                            |  11 +-
 include/linux/intel_rapl.h                         |  52 +-
 include/linux/powercap.h                           |   4 +-
 include/linux/units.h                              |   3 +
 kernel/power/user.c                                |   7 +-
 kernel/sched/cpufreq_schedutil.c                   |   5 +-
 rust/kernel/cpufreq.rs                             |  13 +-
 tools/arch/x86/include/asm/cpufeatures.h           |   2 +-
 tools/power/cpupower/man/cpupower-frequency-info.1 |   8 +-
 tools/power/cpupower/man/cpupower-idle-info.1      |   4 +-
 tools/power/cpupower/man/cpupower-info.1           |   9 +-
 tools/power/cpupower/utils/cpufreq-info.c          |   2 -
 tools/power/cpupower/utils/cpufreq-set.c           |   2 -
 tools/power/cpupower/utils/cpuidle-info.c          |   2 -
 tools/power/cpupower/utils/cpuidle-set.c           |   2 -
 tools/power/cpupower/utils/cpupower-info.c         |   2 -
 tools/power/cpupower/utils/cpupower-set.c          |   2 -
 58 files changed, 1951 insertions(+), 903 deletions(-)
