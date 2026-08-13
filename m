Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27C3345749
	for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2026 18:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786647313; cv=none; b=eamJOdEIeTvg1TD6JFV+YWXpfxSrXaAwCt/LDgaue8kLoYPI/f0TqSl1/5KP2neZstdUB1nY2G5TY4wjWwCnJC/t7xX7YwoadBvU6uKbyyzFDlVxY3Y+/DploCiHa7dB77taEj7kHWcvpvV1UTj4vz2OeWLKKqHOrD6jbNTxEu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786647313; c=relaxed/simple;
	bh=r6YZelZflPmwo1my6xomMZrvN5OUAf2/21jqke8+lSw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=H8IsjrowSkrdzU1K5f1PwYmViAUkNbnSiNbFSmfjCBlqEv3bkurYJBIhMP6/KI0d4LLLzH05mAkRKBk+BushEQ9gqNeWS4gbnbtRl1wqBaEfpQLxYjRTFLfc4mLwGdhGxaYZ5MRlMdj97v98cjEbwoweMmWzUKPG/fb71NBcWFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bggx6VdR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bggx6VdR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C7D1F00A3F
	for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2026 18:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786647311;
	bh=tYNXI+5F1veCG8/PD3UExy9U7eR6FD7ac1ipao7kgwk=;
	h=From:Date:Subject:To:Cc;
	b=bggx6VdRsFkEckpHFJuce+Glq01wsqFyOSAciSTeya9jmNmxra77uBylCjVFrGTrm
	 TrhCYjZ50BrbDGGiqO6PEiymltkxaVR/yBmnjlkKtknKxzKJ9yw3QSUs72jcG0RO+q
	 jIo6m2z6n829JDpiFEkOQPTG4HblDC/Gb21+J6jT9b3fyKkcRLkU8yifs0i8GqWQEK
	 1WFLCaC1KIT4yucoZQesbirHHJoheLjxbb8HYq3hJUYcSzGxF4SqkrNYMUK9ayfQtn
	 kpvzGphsLOT++8iuny5rb/RIGASOWUlKmXxJd8b4jfC7vJasK96IrwpFQzMgGNb7GA
	 utlRm8GaFJhsw==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aec201b582so153700e87.1
        for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2026 11:55:11 -0700 (PDT)
X-Gm-Message-State: AOJu0YwPfGaK1VyP8oTCOWoH6LLqrNCVoguZM1+NUWzePWZJVFMz911I
	hsUD4/WAVUtgQV4YjKGhZufYr6gpvfXUIurYNgkR/pL8P3u71iXIlqOc2jejQq5HkXgDYd6TnuD
	PnngMOqKRf/k9Swp8vvZjvX3x0uf1O44=
X-Received: by 2002:a05:6512:155a:10b0:5b0:1b78:4962 with SMTP id
 2adb3069b0e04-5b453f8de0fmr896072e87.50.1786647310015; Thu, 13 Aug 2026
 11:55:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 13 Aug 2026 20:54:47 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j=dZ8UjEDYjKs3WosMy=H8p8YwPdB-NRWu3qMUb9KCQQ@mail.gmail.com>
X-Gm-Features: AUfX_mySFA-FyWf9gELpOBNaA4xaJ50sl5iA_07nrpxWGs5SVZJEgxomFMfCh0U
Message-ID: <CAJZ5v0j=dZ8UjEDYjKs3WosMy=H8p8YwPdB-NRWu3qMUb9KCQQ@mail.gmail.com>
Subject: [GIT PULL] Power management updates for 7.3-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mario Limonciello <superm1@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

This goes early for your convenience.

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-7.3-rc1

with top-most commit 7544a367adc1ce5e9cc62315b4c32dc72b509451

 Merge branches 'pm-sleep', 'pm-runtime', 'pm-powercap' and 'pm-tools'

on top of commit 075b74841bd0065a3bda3440873c747938e69b68

 Linux 7.2-rc6

to receive power management updates for 7.3-rc1.

As it has been the case for quite some time, this set of changes is
dominated by cpufreq updates including intel-pstate and amd-pstate
driver updates, minor fixes and cleanups of other assorted cpufreq
drivers, schedutil governor updates, fixes of the Rust bindings, new
hardware support (IPQ5210 in qcom-nvmem), and some updates of self
tests related to cpufreq.

The second largest group of changes are cpuidle updates consisting of
intel_idle driver updates and ACPI processor idle driver updates, both
mostly related to ACPI _LPI support.

There are also updates related to system sleep, mostly in the
hibernation core code, two operating performance points (OPP) updates,
one runtime PM framework update, one power capping update, and some
tools updates including the addition of ACPI CPPC support to cpupower.

Specifics:

 - Minor fixes and cleanups in assorted cpufreq drivers (Dan Carpenter,
   Guru Das Srinagesh, Haoxiang Li, Karl Mehltretter, Sasha Finkelstein,
   and Pan Chuang)

 - Fix cpufreq table creation and bios_limits() callback in the Rust
   bindings (Priya Bala Govindasamy)

 - Add IPQ5210 support to qcom-nvmem driver (Varadarajan Narayanan)

 - Adjust the .adjust_perf() cpufreq driver callback to allow the
   maximum performance value to be passed to drivers and update the
   intel_pstate driver to use it (Rafael Wysocki)

 - Set policy->cur to the actual requested frequency in the intel_pstate
   driver when the performance policy is used (Rafael Wysocki)

 - Simplify HWP handling on Broadwell processors in intel_pstate (Rafael
   Wysocki)

 - Fix setting minimum P-state at init time in intel_pstate (Rafael
   Wysocki)

 - Consolidate frequency values computation in intel_pstate and clean up
   code in that driver (Rafael Wysocki)

 - Add missing kernel-doc descriptions for structure and union members
   in the amd-pstate driver (David Vernet)

 - Handle missing policy in dynamic EPP callbacks in the amd-pstate
   driver (EDAMAMEX)

 - Introduce EXPORT_SYMBOL_FOR_PSTATE_UT() to export amd-pstate driver
   symbols to the amd-pstate-ut subdriver (K Prateek Nayak)

 - Add dynamic EPP as an "energy_performance_preference" mode in
   amd-pstate, remove the "amd_dynamic_epp" kernel command line option
   and the "dynamic_epp" sysfs attribute, and update the dynamic_epp
   documentation accordingly (K Prateek Nayak)

 - Add unit tests for CPPC Performance Priority and the "dynamic" EPP
   mode in the amd-pstate driver (K Prateek Nayak)

 - Set min_limit_freq based on bios_min_perf in amd-pstate and remove
   the defensive check for bios_min_perf from it (K Prateek Nayak)

 - Fix EPP return type and handle errors in amd-pstate during
   initialization, toggle auto_sel in active mode on shared memory
   systems, and cache the firmware programmed EPP value (Marco Scardovi)

 - Skip tests in amd-pstate-ut if the amd-pstate driver is not in active
   use (Qianheng Peng)

 - Replace sprintf() with sysfs_emit() in sysfs show in the cpufreq
   schedutil governor and fix a self-contradictory comment in
   sugov_iowait_apply() (Zhongqiu Han)

 - Fix the usage example for the sampling_rate tunable of the ondemand
   cpufreq governor in admin-guide (wangxiaodong)

 - Avoid using deep idle states during initialization in the intel_idle
   driver to work around device handling issues (Rafael Wysocki)

 - Fix and refactor the ACPI processor driver code related to ACPI _LPI
   support and add ACPI _LPI support to intel_idle based on that ACPI
   processor driver update (Rafael Wysocki)

 - Backup and restore governor for cpufreq sptests (Yiwei Lin)

 - Remove unnecessary sudo from quick_shuffle() and remove unused local
   variables from switch_show_governor() in cpufreq selftests (Jinseok
   Kim)

 - Rename the PM core module parameter prefix to "pm" and allow the PM
   transition (DPM) watchdog to be disabled by default (Tzung-Bi Shih)

 - Fix off-by-one in wakelocks number limit check in the system sleep
   sysfs interface (Haowen Tu)

 - Remove kernel-doc markings from helper descriptions in the core
   hibernation code (Adi Nata)

 - Use %pe to print error pointer values in the hibernation core (Ronan
   Marchal)

 - Fix memory leak in snapshot_write_next() error path (Malaya Kumar
   Rout)

 - Delay allocating and linking the next swap_map_page in the
   hibernation image saving code until another image page actually
   needs to be recorded (Haesung Kim)

 - Fix cleanup ordering around scope-based pointers in OPP (Gregor
   Herburger).

 - Use clk_get_optional() for optional clocks in OPP (Praveen Talari).

 - Stop setting runtime_error on runtime resume callback failures to
   allow drivers to recover from resume issues (Praveen Talari)

 - Handle PMU registration failure during probe in the intel_rapl_tpmi
   driver (Sumeet Pawnikar)

 - Avoid optional imports in intel_pstate_tracer unless they are really
   needed (Yousef Alhouseen)

 - Add generic CPPC performance display to the cpupower utility, build
   and call CPPC information on non-AMD processors, make cpupower print
   kernel and hardware frequency information, and add libm to cpupower
   for generic CPPC view (Jeremy Linton)

 - Remove conditional return with no effect from cpupower (Sang-Heon
   Jeon)

Thanks!


---------------

Adi Nata (1):
      PM: hibernate: Remove kernel-doc markings from helper descriptions

Dan Carpenter (1):
      cpufreq: spear: Fix an IS_ERR() vs NULL bug in spear1340_set_cpu_rate()

David Vernet (1):
      cpufreq/amd-pstate: Document missing kernel-doc members

EDAMAMEX (1):
      cpufreq/amd-pstate: handle missing policy in dynamic EPP callbacks

Gregor Herburger (1):
      OPP: Fix cleanup ordering

Guru Das Srinagesh (1):
      rust: rcpufreq_dt: use vertical import style

Haesung Kim (1):
      PM: hibernate: swap: defer linking the next map page

Haowen Tu (1):
      PM: sleep: Fix off-by-one in wakelocks number limit check

Haoxiang Li (1):
      cpufreq: apple-soc: Fix OPP table cleanup

Jeremy Linton (4):
      cpupower: Add generic CPPC performance display
      cpupower: Build and call CPPC information on non-AMD processors
      cpupower: Print kernel and hardware frequency information
      cpupower: Add libm to cpupower for generic CPPC view

Jinseok Kim (2):
      selftests/cpufreq: Remove unused local variables from
switch_show_governor()
      selftests/cpufreq: Remove unnecessary sudo from quick_shuffle()

K Prateek Nayak (9):
      cpufreq/amd-pstate: Set min_limit_freq based on bios_min_perf
      cpufreq/amd-pstate: Remove the defensive check for bios_min_perf
      cpufreq/amd-pstate: Extract platform profile to EPP conversion
into a helper
      cpufreq/amd-pstate: Add dynamic EPP as an
"energy_performance_preference" mode
      cpufreq/amd-pstate: Remove "amd_dynamic_epp" cmdline and
"dynamic_epp" sysfs
      Documentation/amd-pstate: Update dynamic_epp documentation with
new behavior
      cpufreq/amd-pstate: Reduce the scope of exported symbols
      cpufreq/amd-pstate-ut: Add unit test for "dynamic" EPP mode
      cpufreq/amd-pstate-ut: Add unit test for CPPC Performance Priority

Karl Mehltretter (2):
      cpufreq: imx6q: fix devres accumulation across driver rebind
      cpufreq: imx6q: fix out-of-bounds write when probed more than once

Malaya Kumar Rout (1):
      PM: hibernate: Fix memory leak in snapshot_write_next() error path

Marco Scardovi (3):
      cpufreq/amd-pstate: Fix EPP return type and handle errors during
initialization
      cpufreq/amd-pstate: Toggle auto_sel in active mode on shared
memory systems
      cpufreq/amd-pstate: Cache the firmware programmed EPP value

Pan Chuang (1):
      cpufreq: brcmstb-avs: Remove redundant dev_err()

Praveen Talari (2):
      PM: runtime: Only set runtime_error on suspend callback failures
      opp: Use clk_get_optional() to avoid leaving opp_table->clk as
an error pointer

Priya Bala Govindasamy (2):
      rust: cpufreq: Add CPUFREQ_TABLE_END as last table entry in
TableBuilder::to_table
      rust: cpufreq: Fix temporary write in Registration::bios_limit_callback

Qianheng Peng (1):
      cpufreq: amd-pstate-ut: Skip tests when amd-pstate driver is not active

Rafael J. Wysocki (28):
      cpufreq: intel_pstate: Rearrange checks in hybrid_get_cost()
      cpufreq: intel_pstate: Adjust the .adjust_perf() driver callback
      cpufreq: intel_pstate: Simplify HWP handling on Broadwell
      cpufreq: intel_pstate: Rename INTEL_PSTATE_HWP_BROADWELL
      cpufreq: intel_pstate: Fix setting minimum P-state at init time
      cpufreq: intel_pstate: Introduce intel_pstate_update_freq_limits()
      cpufreq: intel_pstate: Consolidate frequency values computation
      cpufreq: intel_pstate: Move two functions closer to callers
      ACPI: processor: idle: Expand _LPI package sanity checks
      ACPI: processor: idle: Ignore _LPI states with SYSTEMIO entry method
      ACPI: processor: idle: Unify debug in acpi_processor_evaluate_lpi()
      ACPI: processor: idle: Rearrange acpi_processor_evaluate_lpi()
      ACPI: processor: idle: Split acpi_processor_evaluate_lpi()
      ACPI: processor: idle: Introduce lpi_state_debug()
      ACPI: processor: idle: Rearrange acpi_processor_get_lpi_info()
      ACPI: processor: idle: Rework first-level _LPI states processing
      ACPI: processor: idle: Drop redundant _LPI presence checks
      ACPI: processor: idle: Rearrange loop in acpi_processor_get_lpi_info()
      ACPI: processor: idle: Rework flatten_lpi_states()
      ACPI: processor: idle: Introduce too_many_states() for _LPI
      ACPI: processor: idle: Introduce acpi_processor_extract_lpi_info()
      ACPI: processor: idle: Relocate acpi_processor_extract_lpi_info()
      ACPI: processor: idle: Add switch for strict _LPI processing
      intel_idle: Prepare for adding ACPI _LPI support
      intel_idle: Add ACPI _LPI support
      intel_idle: Update documentation after adding ACPI _LPI support
      cpufreq: intel_pstate: Adjust policy->cur in active mode to policy
      intel_idle: Avoid using deep idle states during initialization

Ronan Marchal (1):
      PM: hibernate: Use %pe to print error pointer values

Sang-Heon Jeon (1):
      cpupower: remove conditional return with no effect

Sasha Finkelstein (1):
      cpufreq: apple-soc: Calculate frequency as a 64-bit value

Sumeet Pawnikar (1):
      powercap: intel_rapl_tpmi: Handle PMU registration failure during probe

Tzung-Bi Shih (2):
      PM: sleep: Rename module parameters prefix to "pm"
      PM: sleep: Allow disabling DPM watchdog by default

Varadarajan Narayanan (1):
      cpufreq: qcom-nvmem: Add IPQ5210 support

Yiwei Lin (1):
      kselftest: cpufreq: Backup and restore governor for sptests

Yousef Alhouseen (1):
      tools/power: intel_pstate_tracer: avoid optional imports for help

Zhongqiu Han (2):
      cpufreq: schedutil: Fix self-contradictory comment in sugov_iowait_apply()
      cpufreq: schedutil: Replace sprintf() with sysfs_emit() in sysfs show

wangxiaodong (1):
      Documentation: admin-guide: cpufreq: fix sampling_rate example command

---------------

 Documentation/admin-guide/kernel-parameters.txt    |   7 +
 Documentation/admin-guide/pm/amd-pstate.rst        |  45 ++-
 Documentation/admin-guide/pm/cpufreq.rst           |   2 +-
 Documentation/admin-guide/pm/intel_idle.rst        |  54 ++--
 drivers/acpi/acpi_processor.c                      | 354 +++++++++++++++++++++
 drivers/acpi/processor_idle.c                      | 269 +---------------
 drivers/base/power/main.c                          |  14 +
 drivers/base/power/runtime.c                       |   6 +-
 drivers/cpufreq/amd-pstate-ut.c                    | 136 ++++++--
 drivers/cpufreq/amd-pstate.c                       | 270 ++++++++--------
 drivers/cpufreq/amd-pstate.h                       |  15 +
 drivers/cpufreq/apple-soc-cpufreq.c                |  38 +--
 drivers/cpufreq/brcmstb-avs-cpufreq.c              |   5 +-
 drivers/cpufreq/cpufreq-dt-platdev.c               |   1 +
 drivers/cpufreq/cpufreq.c                          |  14 +-
 drivers/cpufreq/imx6q-cpufreq.c                    |   6 +-
 drivers/cpufreq/intel_pstate.c                     | 170 +++++-----
 drivers/cpufreq/qcom-cpufreq-nvmem.c               |   8 +
 drivers/cpufreq/rcpufreq_dt.rs                     |  13 +-
 drivers/cpufreq/spear-cpufreq.c                    |   4 +-
 drivers/idle/intel_idle.c                          | 218 +++++++++++--
 drivers/opp/core.c                                 |  67 ++--
 drivers/powercap/intel_rapl_tpmi.c                 |   5 +-
 include/linux/acpi.h                               |  13 +
 include/linux/cpufreq.h                            |   2 +
 kernel/power/Kconfig                               |  10 +
 kernel/power/snapshot.c                            |  47 +--
 kernel/power/swap.c                                |  34 +-
 kernel/power/wakelock.c                            |   2 +-
 kernel/sched/cpufreq_schedutil.c                   |   8 +-
 rust/kernel/cpufreq.rs                             |  35 +-
 tools/power/cpupower/Makefile                      |   6 +-
 tools/power/cpupower/utils/cpufreq-info.c          |  11 +-
 tools/power/cpupower/utils/helpers/cppc.c          |  56 ++++
 tools/power/cpupower/utils/helpers/helpers.h       |   2 +
 tools/power/cpupower/utils/powercap-info.c         |   2 -
 .../x86/intel_pstate_tracer/intel_pstate_tracer.py |  18 +-
 tools/testing/selftests/cpufreq/governor.sh        |  26 +-
 tools/testing/selftests/cpufreq/special-tests.sh   |  18 +-
 39 files changed, 1274 insertions(+), 737 deletions(-)
