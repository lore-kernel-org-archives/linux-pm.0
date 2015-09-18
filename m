From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management and ACPI updates for v4.3-rc2
Date: Sat, 19 Sep 2015 00:06:05 +0200
Message-ID: <CAJZ5v0hcL8PvJotx2A2JBLERQ=kkWMT9pA0q4EyXUm25sdeE6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm+acpi-4.3-rc2

to receive power management and ACPI material for v4.3-rc2 with
top-most commit 0f40314b81b765c26202cde33523e35809adbe9b

 Merge branch 'acpi-bus'

on top of commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f

 Linux 4.3-rc1

Included are: a somewhat late devfreq update which however is mostly
fixes and cleanups with one new thing only (the PPMUv2 support on
Exynos5433), an ACPI cpufreq driver fixup and two ACPI core cleanups
related to preprocessor directives.

Specifics:

 - Fix a memory allocation size in the devfreq core (Xiaolong Ye).

 - Fix a mistake in the exynos-ppmu DT binding (Javier Martinez
   Canillas).

 - Add support for PPMUv2 ((Platform Performance Monitoring Unit
   version 2.0) on the Exynos5433 SoCs (Chanwoo Choi).

 - Fix a type casting bug in the Exynos PPMU code (MyungJoo Ham).

 - Assorted devfreq code cleanups and optimizations (Javi Merino,
   MyungJoo Ham, Viresh Kumar).

 - Fix up the ACPI cpufreq driver to use a more lightweight way
   to get to its private data in the ->get() callback (Rafael J
   Wysocki).

 - Fix a CONFIG_ prefix bug in one of the ACPI drivers and make
   the ACPI subsystem use IS_ENABLED() instead of #ifdefs in
   function bodies (Sudeep Holla).

Thanks!


---------------

Chanwoo Choi (2):
      PM / devfreq: exynos-ppmu: Add the support of PPMUv2 for Exynos5433
      PM / devfreq: exynos-ppmu: Update documentation to support PPMUv2

Javi Merino (2):
      PM / devfreq: cache the last call to get_dev_status()
      PM / devfreq: drop comment about thermal setting max_freq

Javier Martinez Canillas (1):
      PM / devfreq: event: Remove incorrect property in exynos-ppmu DT binding

MyungJoo Ham (3):
      PM / devfreq: exynos-ppmu: bit-wise operation bugfix.
      PM / devfreq: comments for get_dev_status usage updated
      PM / devfreq: tegra: Update governor to use devfreq_update_stats()

Rafael J. Wysocki (1):
      cpufreq: acpi-cpufreq: Use cpufreq_cpu_get_raw() in ->get()

Sudeep Holla (2):
      ACPI: int340x_thermal: add missing CONFIG_ prefix
      ACPI: Eliminate CONFIG_.*{, _MODULE} #ifdef in favor of IS_ENABLED()

Viresh Kumar (1):
      PM / devfreq: Drop unlikely before IS_ERR(_OR_NULL)

Xiaolong Ye (1):
      PM / devfreq: Fix incorrect type issue.

---------------

 drivers/acpi/bus.c                        | 12 ++++-------
 drivers/acpi/int340x_thermal.c            |  9 ++++-----
 drivers/cpufreq/acpi-cpufreq.c            |  3 +--
 drivers/cpufreq/cpufreq.c                 |  4 ++--
 drivers/devfreq/devfreq.c                 | 12 +++++------
 drivers/devfreq/event/exynos-ppmu.c       |  3 ++-
 drivers/devfreq/governor_simpleondemand.c | 33 +++++++++++++++++--------------
 drivers/devfreq/tegra-devfreq.c           |  8 +++++---
 include/acpi/button.h                     |  4 ++--
 include/acpi/video.h                      |  2 +-
 include/linux/cpufreq.h                   |  5 +++++
 include/linux/devfreq.h                   | 24 +++++++++++++++++++++-
 12 files changed, 73 insertions(+), 46 deletions(-)
