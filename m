From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [GIT PULL] Thermal management updates for v3.10-rc1
Date: Thu, 09 May 2013 11:45:21 +0800
Message-ID: <1368071121.2062.29.camel@rzhang1-mobl4>
References: <1368029785.2076.7.camel@rzhang1-mobl4>
	 <CA+55aFws4kr8gdFxRbLzXR=EMw8p1uhrZicyjvqtQm+VumRixg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:51819 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753353Ab3EIDp1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 8 May 2013 23:45:27 -0400
In-Reply-To: <CA+55aFws4kr8gdFxRbLzXR=EMw8p1uhrZicyjvqtQm+VumRixg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>

Hi, Linus,

On Wed, 2013-05-08 at 15:22 -0700, Linus Torvalds wrote:
> On Wed, May 8, 2013 at 9:16 AM, Zhang Rui <rui.zhang@intel.com> wrote:
> > Hi, Linus,
> >
> > The following changes since commit
> > 3912a677f68f6084e0a7b6a1a29310ac1b083713:
> 
> Hmm? You used to give human-readable explanations too. Please?
> 
sure. sorry about that.

Hi, Linus,

Please pull from the git repository at

  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git next

to receive Thermal management updates for v3.10 with top-most commit
de6558dc964f6a3243218f17d8032ad810864e2b:

  Merge branch 'MAINTAINERS-update' of .git into next

on top of commit 3912a677f68f6084e0a7b6a1a29310ac1b083713:

  Merge tag 'pinctrl-fixes-for-v3.9' of
git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl

The most important one is to build thermal core and governor and cpu
cooling code into one module. This fixes a regression that thermal core
does not work if it is built as module, since 3.7. I'll backport them to
stable kernel once those changes are in upstream.

The largest batch is the thermal kernel-doc & coding style
updates/cleanups from Eduardo.

Highlights:

- build all thermal framework code into one module to fix a regression
that thermal does not work if it is built as module.

- Marvell Armada 370/XP thermal sensor driver

- thermal core/cpu cooling kernel-doc & coding style updates/cleanups.

- Add Eduardo Valentin as thermal sub-maintainer, both in mailing list
and patchwork. He will help me on arm thermal drivers.

thanks,
rui

----------------------------------------------------------------

Amit Daniel Kachhap (1):
      thermal: exynos: Adapt to temperature emulation core thermal
framework

Andrew Bresticker (1):
      thermal: step_wise: set throttle target within thermal instance
limits

Arnd Bergmann (1):
      Thermal: exynos: remove unnecessary header inclusions

Axel Lin (2):
      thermal: db8500: Fix checking return value of
thermal_zone_device_register
      thermal: db8500: Fix missing mutex_unlock() in probe error paths

Dan Carpenter (1):
      Thermal: cpufreq cooling: endian bug in cpufreq_get_max_state()

Eduardo Valentin (46):
      thermal: add a warning for temperature emulation feature
      thermal: introduce thermal_zone_get_zone_by_name helper function
      thermal: expose thermal_zone_get_temp API
      MAINTAINERS: Add Thermal subsystem co-maintainer
      MAINTAINERS: Add patchwork entry for Thermal subsystem
      MAINTAINERS: update thermal entry by adding file cpu_cooling.h
      thermal: cpu_cooling: remove unused headers
      thermal: cpu_cooling: fix kernel_doc for cpufreq_cooling_device
      thermal: cpu_cooling: use EXPORT_SYMBOL_GPL
      thermal: cpu_cooling: remove compiler warning
      thermal: cpu_cooling: fix kernel doc for is_cpufreq_valid
      thermal: cpu_cooling: add documentation for get_property
      thermal: cpu_cooling: document cpufreq_get_cooling_level
      thermal: cpu_cooling: improve documentation for get_cpu_frequency
      thermal: cpu_cooling: update documentation for
cpufreq_apply_cooling
      thermal: cpu_cooling: update documentation for
cpufreq_thermal_notifier
      thermal: cpu_cooling: update Kconfig entry
      thermal: cpu_cooling: update documentation for
cpufreq_get_max_state
      thermal: cpu_cooling: update documentation for
cpufreq_get_cur_state
      thermal: cpu_cooling: update documentation for
cpufreq_set_cur_state
      thermal: cpu_cooling: update kernel-doc for
cpufreq_cooling_register
      thermal: cpu_cooling: update kernel-doc comment for
cpufreq_cooling_unregister
      thermal: cpu_cooling: use snprintf instead of sprintf
      thermal: cpu_cooling: remove not needed curl brackets
      thermal: cpu_cooling: remove unused symbols
      thermal: cpu_cooling: add needed header for cpu_cooling.h
      thermal: cpu_cooling: remove unused symbols on cpu_cooling.h
      thermal: use strlcpy instead of strcpy
      thermal: update driver license
      thermal: rename notify_thermal_framework to
thermal_notify_framework
      thermal: use EXPORT_SYMBOL_GPL
      thermal: update kernel-doc for thermal_zone_bind_cooling_device
      thermal: update kernel-doc for thermal_zone_unbind_cooling_device
      thermal: update kernel-doc for thermal_cooling_device_register
      thermal: update kernel-doc for create_trip_attrs
      thermal: update kernel-doc for thermal_zone_device_register
      thermal: cpu_cooling: remove trailing white spaces
      thermal: cpu_cooling: standardize end of function
      thermal: cpu_cooling: standardize comment style
      thermal: cpu_cooling: align on open parenthesis
      thermal: cpu_cooling: remove trailing blank line
      thermal: cpu_cooling: remove checkpatch.pl warning
      thermal: cpu_cooling: alignment improvements
      thermal: cpu_cooling: improve line breaking
      thermal: thermal_core: remove usage of IS_ERR_OR_NULL
      thermal: db8500_cpufreq_cooling: remove usage of IS_ERR_OR_NULL()

Ezequiel Garcia (5):
      thermal: Fix compiler warning
      thermal: kirkwood: Fix valid check for thermal register
      thermal: kirkwood: Fix thermal sensor formula
      thermal: dove: Fix thermal sensor formula
      thermal: Add driver for Armada 370/XP SoC thermal management

Kuninori Morimoto (2):
      thermal: rcar: tidyup registration failure case
      thermal: rcar: add pm_runtime_xxx() support

Laurent Navet [Mali] (1):
      drivers: thermal: cpu_cooling: fix checkpatch warning

Sachin Kamat (2):
      Thermal: exynos: Add clk_{un}prepare APIs
      Thermal: exynos: Add compatible string for exynos4412

Zhang Rui (14):
      Thermal: cpufreq cooling: fix parsing per_cpu
cpufreq_frequency_table
      Thermal: exynos: fix cooling state translation
      Thermal: rename thermal_sys.c to thermal_core.c
      Thermal: build thermal governors into thermal_sys module
      Thermal: build cpu_cooling code into thermal_sys module
      Merge branch 'thermal' of git://git.kernel.org/.../rzhang/linux
into next
      Merge branch 'eduardo-1' of .git into next
      Merge branch 'exynos-fix' of .git into next
      Merge branch 'thermal_core-doc-comments-update' of .git into next
      Merge branch 'cpu_cooling-doc-comments-update' of .git into next
      Thermal: update documentation for thermal_zone_device_register
      Merge branch 'thermal_core-doc-comments-update' of .git into next
      Merge branch 'cpu_cooling-doc-comments-update' of .git into next
      Merge branch 'MAINTAINERS-update' of .git into next

 .../devicetree/bindings/thermal/armada-thermal.txt |   22 ++
 Documentation/thermal/exynos_thermal_emulation     |    8 +-
 Documentation/thermal/sysfs-api.txt                |   28 +-
 MAINTAINERS                                        |    3 +
 drivers/thermal/Kconfig                            |   28 +-
 drivers/thermal/Makefile                           |   10 +-
 drivers/thermal/armada_thermal.c                   |  232
+++++++++++++++
 drivers/thermal/cpu_cooling.c                      |  295
++++++++++++++------
 drivers/thermal/db8500_cpufreq_cooling.c           |    2 +-
 drivers/thermal/db8500_thermal.c                   |   19 +-
 drivers/thermal/dove_thermal.c                     |    7 +-
 drivers/thermal/exynos_thermal.c                   |  198 +++++--------
 drivers/thermal/fair_share.c                       |   15 +-
 drivers/thermal/kirkwood_thermal.c                 |   12 +-
 drivers/thermal/rcar_thermal.c                     |   34 ++-
 drivers/thermal/step_wise.c                        |   26 +-
 drivers/thermal/{thermal_sys.c => thermal_core.c}  |  197 ++++++++++---
 drivers/thermal/thermal_core.h                     |   27 ++
 drivers/thermal/user_space.c                       |   15 +-
 include/linux/cpu_cooling.h                        |   25 +-
 include/linux/thermal.h                            |   15 +-
 21 files changed, 858 insertions(+), 360 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/thermal/armada-thermal.txt
 create mode 100644 drivers/thermal/armada_thermal.c
 rename drivers/thermal/{thermal_sys.c => thermal_core.c} (89%)


