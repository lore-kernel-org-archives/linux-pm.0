Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059A830C165
	for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 17:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781286524; cv=none; b=SDDElBGwI6noRyLNoqFn5m+BAR2ejg+tGoSRx8T9GqWhGCRjgHUsnojGFkTLgJy0b9TpiUwHzQpYzJXgsD9W10BRp8oqRh+HncPeC01XW/0wddEmx/oSGYuaMPzK96YiuMVtAR26nwxEOefk1SYAosXNdHP0L1zjWK/aOR4wKcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781286524; c=relaxed/simple;
	bh=pa9Ln7Mg1Jpz1M0648w+5WJwj+qcn+Fl8nL6ALDGjyE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=D6V+YhCM2Gk9/ly7FhSBFGCu9keNhGRQHmmuWjerWfg5iZEHL7i5ix09rxPICvKZpiYYZi2CidAxlVooCgccMNRkhFFYhhXLze6pT1xEM3lDFezNwqEbv/3X/D6vrC7+GeW5ndIthes4twUgCnCdCOWaWikgWG5bZzoZoep9GwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Je7bHH1l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Je7bHH1l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29791F00A3E
	for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 17:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781286522;
	bh=Cq1j5ZwPnwoAm/fY4M+K8cnb2rkNGdbG5s3Gh3ScygM=;
	h=From:Date:Subject:To:Cc;
	b=Je7bHH1lYpHxd609UEW6cOcOny1XC7mS7B3yMP2FERNv4ZGajjzs3GNuAByJ3rKPp
	 +W3wDWx2bIVB6YfJbpre6/XXnhyPmVa4oTiHxbWILbksGL8Yyzrz3KHBAs/h30LSZa
	 JSC59SHHdbmzyydqnV9U7fzoht0Y9s9KQOjXbt9ClKbH5pHkNHSODryQmzikohxTk0
	 6jbHzWlzx875dhQY7fhO0WGa4wYEpuVBp0bhet0OMZy+7zJVuSxjzgMOwyjBM9vWyF
	 +yEXva/zyQgJtcPq6DmsfWS59qTstT6NRSfebDGFFxUYqcjDiKuqghOggjnula58D/
	 Jf2tgnMKrEc5Q==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aa68d65d24so1208166e87.1
        for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 10:48:42 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy2mi2KqQcSyduj3qeRKfmW4aVBV6zp4pTao6rbkfej+fStGc/p
	olmKqI5MtjHoB0aKMLvOiv0ftqFClO9AB5GxynJfjFQDKce/+DVVcQE/SSMEtheC88s8v+Kr1xX
	nb0pQ093AGc7wk6n9GrkMgz0+AZY5XaA=
X-Received: by 2002:ac2:59c7:0:b0:5aa:6c7c:65d2 with SMTP id
 2adb3069b0e04-5ad2db29588mr871864e87.11.1781286521183; Fri, 12 Jun 2026
 10:48:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 12 Jun 2026 19:48:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iKw2Vso0t19pq-ktLFGsyiHK4t2D1wyYL+r=nUt0_ksA@mail.gmail.com>
X-Gm-Features: AVVi8Cf8thDP0PDO7E2W5NbpVztIeldalepqzs819fV3yTnB6pTHKn5gaTXqi4E
Message-ID: <CAJZ5v0iKw2Vso0t19pq-ktLFGsyiHK4t2D1wyYL+r=nUt0_ksA@mail.gmail.com>
Subject: [GIT PULL] Power management updates for 7.2-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

This goes early for your convenience.

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-7.2-rc1

with top-most commit 5ca48f6f2afc0a0c3f0584f95843451042ffc5ca

 Merge branches 'pm-sleep', 'pm-powercap' and 'pm-tools'

on top of commit 9716c086c8e8b141d35aa61f2e96a2e83de212a7

 Merge tag 'pm-7.1-rc8' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive power management updates for 7.2-rc1.

Over a half of the changes here are cpufreq updates that include
core modifications, fixes of the old-style governors, new hardware
support in drivers, assorded driver fixes and cleanups, and the
removal of one driver (AMD Elan SC4*).

Apart from that, the intel_idle driver will now be able to avoid
exposing redundant C-states if PC6 is disabled and there are new
sysctl knobs for device suspend/resume watchdog timeouts, hibernation
gets built-in LZ4 support for image compression and there is the usual
collection of assorted fixes and cleanups.

Specifics:

 - Fix a race between cpufreq suspend and CPU hotplug during system
   shutdown (Tianxiang Chen)

 - Avoid redundant target() calls for unchanged limits and fix a typo
   in a comment in the cpufreq core (Viresh Kumar)

 - Fix concurrency issues related to sysfs attributes access that affect
   cpufreq governors using the common governor code (Zhongqiu Han)

 - Simplify frequency limit handling in the conservative cpufreq
   governor (Lifeng Zheng)

 - Fix descriptions of the conservative governor freq_step tunable and
   the ondemand governor sampling_down_factor tunable in the cpufreq
   documentation (Pengjie Zhang)

 - Fix use-after-free and double free during _OSC evaluation in the PCC
   cpufreq driver (Yuho Choi)

 - Rework the handling of policy min and max frequency values in the
   cpufreq core to allow drivers to specify special initial values for
   the scaling_min_freq and scaling_max_freq sysfs attributes (Pierre
   Gondois)

 - Add cpufreq scaling support for Qualcomm Shikra SoC (Taniya Das,
   Imran Shaik).

 - Improve the warning message on HWP-disabled hybrid processors printed
   by the intel_pstate driver and sync policy->cur during CPU offline in
   it (Yohei Kojima, Fushuai Wang)

 - Drop cpufreq support for AMD Elan SC4* (Sean Young)

 - Minor fixes for cpufreq drivers (Krzysztof Kozlowski, Akashdeep Kaur,
   Hans Zhang, Guangshuo Li, Xueqin Luo)

 - Clean up dead dependencies on X86 in the cpufreq Kconfig (Julian
   Braha)

 - Allow the intel_idle driver to avoid exposing C-states that are
   redundant when PC6 is disabled (Artem Bityutskiy)

 - Fix memory leak and a potential race in the OPP core (Abdun Nihaal,
   Di Shen)

 - Mark Rust OPP methods as inline (Nicol=C3=A1s Antinori)

 - Fix misc device registration failure path in the PM QoS core (Yuho
   Choi)

 - Add sysctl interface for DPM watchdog timeouts (Tzung-Bi Shih)

 - Use complete() instead of complete_all() in device_pm_sleep_init() to
   avoid a false-positive warning from lockdep_assert_RT_in_threaded_ctx()
   when CONFIG_PROVE_RAW_LOCK_NESTING is enabled (Jiakai Xu)

 - Use a flexible array for CRC uncompressed buffers during hibernation
   image saving (Rosen Penev)

 - Make the LZ4 algorithm available for hibernation compression (l1rox3)

 - Move the preallocate_image() call during hibernation after the
   "prepare" phase of the "freeze" transition (Matthew Leach)

 - Fix a memory leak in rapl_add_package_cpuslocked() in the intel_rapl
   power capping driver and use sysfs_emit() in cpumask_show() in that
   driver (Sumeet Pawnikar, Yury Norov)

 - Fix ValueError when parsing incomplete device properties in the
   pm-graph utility (Gongwei Li)

There were two merge conflicts of the cpufreq changes with the tip tree
in linux-next:

https://lore.kernel.org/lkml/ahRZy0wqaUFv6xO9@sirena.org.uk/
https://lore.kernel.org/lkml/aiAs8hIzpPzvCjw5@sirena.org.uk/

Thanks!


---------------

Abdun Nihaal (1):
      OPP: of: Fix potential memory leak in opp_parse_supplies()

Akashdeep Kaur (1):
      cpufreq: ti: Add EPROBE_DEFER for K3 SoCs

Artem Bityutskiy (3):
      intel_idle: Add constants for MSR_PKG_CST_CONFIG_CONTROL
      intel_idle: Introduce a helper for checking PC6
      intel_idle: Drop C-states redundant when PC6 is disabled

Di Shen (1):
      OPP: Fix race between OPP addition and lookup

Fushuai Wang (1):
      cpufreq: intel_pstate: Sync policy->cur during CPU offline

Gongwei Li (1):
      PM: tools: pm-graph: fix ValueError when parsing incomplete
device properties

Guangshuo Li (1):
      cpufreq: qcom-cpufreq-hw: Fix possible double free

Hans Zhang (2):
      cpufreq/amd-pstate: Use FIELD_MODIFY()
      cpufreq: apple-soc: Use FIELD_MODIFY()

Imran Shaik (1):
      dt-bindings: cpufreq: Document Qualcomm Shikra SoC EPSS

Jiakai Xu (1):
      PM: sleep: Use complete() in device_pm_sleep_init()

Julian Braha (1):
      cpufreq: clean up dead dependencies on X86 in Kconfig

Krzysztof Kozlowski (1):
      cpufreq: qcom: Unify user-visible "Qualcomm" name

Lifeng Zheng (1):
      cpufreq: conservative: Simplify frequency limit handling

Matthew Leach (1):
      PM: hibernate: call preallocate_image() after freeze prepare

Nicol=C3=A1s Antinori (1):
      opp: rust: mark OPP methods as inline

Pengjie Zhang (2):
      cpufreq: Documentation: fix sampling_down_factor range
      cpufreq: Documentation: fix conservative governor freq_step descripti=
on

Pierre Gondois (4):
      cpufreq: Extract cpufreq_policy_init_qos() function
      cpufreq: Set default policy->min/max values for all drivers
      cpufreq: Remove driver default policy->min/max init
      cpufreq: Use policy->min/max init as QoS request

Rosen Penev (1):
      PM: hibernate: Use flexible array for CRC uncompressed buffers

Sean Young (1):
      cpufreq: elanfreq: Drop support for AMD Elan SC4*

Sumeet Pawnikar (1):
      powercap: intel_rapl: Fix memory leak in rapl_add_package_cpuslocked(=
)

Taniya Das (1):
      cpufreq: qcom: Add cpufreq scaling support for Qualcomm Shikra SoC

Tianxiang Chen (1):
      cpufreq: Fix hotplug-suspend race during reboot

Tzung-Bi Shih (1):
      PM: dpm_watchdog: Add sysctl interface for DPM watchdog timeouts

Viresh Kumar (2):
      cpufreq: Fix typo in comment
      cpufreq: Avoid redundant target() calls for unchanged limits

Xueqin Luo (1):
      cpufreq: cppc: mask Desired_Excursion when autonomous selection is en=
abled

Yohei Kojima (1):
      cpufreq: intel_pstate: Improve warning message on HWP-disabled hybrid=
 CPUs

Yuho Choi (2):
      cpufreq: pcc: fix use-after-free and double free in _OSC evaluation
      PM: QoS: Fix misc device registration unwind

Yury Norov (1):
      powercap: intel_rapl: Use sysfs_emit() in cpumask_show()

Zhongqiu Han (2):
      cpufreq: governor: Fix data races on per-CPU idle/nice baselines
      cpufreq: governor: Fix stale prev_cpu_nice spike when enabling
ignore_nice_load

l1rox3 (1):
      PM: hibernate: make LZ4 available for hibernation compression

---------------

 Documentation/admin-guide/kernel-parameters.txt    |   4 -
 Documentation/admin-guide/pm/cpufreq.rst           |   6 +-
 Documentation/cpu-freq/cpu-drivers.rst             |   9 +-
 .../bindings/cpufreq/qcom,shikra-epss.yaml         |  96 +++++++++
 drivers/base/power/main.c                          |  67 +++++-
 drivers/cpufreq/Kconfig.arm                        |   2 +-
 drivers/cpufreq/Kconfig.x86                        |  20 +-
 drivers/cpufreq/Makefile                           |   1 -
 drivers/cpufreq/amd-pstate.c                       |  40 ++--
 drivers/cpufreq/apple-soc-cpufreq.c                |   6 +-
 drivers/cpufreq/cppc_cpufreq.c                     |  34 +++-
 drivers/cpufreq/cpufreq-nforce2.c                  |   4 +-
 drivers/cpufreq/cpufreq.c                          | 101 ++++++---
 drivers/cpufreq/cpufreq_conservative.c             |  12 +-
 drivers/cpufreq/cpufreq_governor.c                 |  42 ++--
 drivers/cpufreq/elanfreq.c                         | 226 -----------------=
----
 drivers/cpufreq/freq_table.c                       |   7 +-
 drivers/cpufreq/gx-suspmod.c                       |   2 +-
 drivers/cpufreq/intel_pstate.c                     |  15 +-
 drivers/cpufreq/pcc-cpufreq.c                      |  12 +-
 drivers/cpufreq/pxa3xx-cpufreq.c                   |   5 +-
 drivers/cpufreq/qcom-cpufreq-hw.c                  |  24 ++-
 drivers/cpufreq/sh-cpufreq.c                       |   6 +-
 drivers/cpufreq/ti-cpufreq.c                       |  10 +
 drivers/cpufreq/virtual-cpufreq.c                  |   5 +-
 drivers/idle/intel_idle.c                          | 104 +++++++---
 drivers/opp/core.c                                 |   5 +-
 drivers/opp/of.c                                   |   3 +-
 drivers/powercap/intel_rapl_common.c               |   5 +-
 include/linux/cpufreq.h                            |   5 +-
 kernel/power/Kconfig                               |   1 +
 kernel/power/hibernate.c                           |  46 +----
 kernel/power/qos.c                                 |  11 +-
 kernel/power/swap.c                                |  13 +-
 rust/kernel/opp.rs                                 |   3 +
 tools/power/pm-graph/sleepgraph.py                 |   2 +-
 36 files changed, 493 insertions(+), 461 deletions(-)
