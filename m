From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] More power management updates for v4.11-rc1
Date: Fri, 3 Mar 2017 02:00:02 +0100
Message-ID: <CAJZ5v0gOa4m9w95jARJdrnqBePJLRyr60sYj2XDnZtVXJrwf_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:34425 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751148AbdCCBC6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Mar 2017 20:02:58 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-extra-4.11-rc1

with top-most commit 9b5e9cb164ee93ae19c4c6593e8188a55481f78b

 Merge branches 'pm-cpuidle', 'pm-cpufreq' and 'pm-sleep'

on top of commit 02c3de1105228e367320e7fdeffbf511904f398c

 Merge tag 'pm-4.11-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive extra power management updates for v4.11-rc1.

These fix two bugs introduced by recent power management updates
(in the cpuidle menu governor and intel_pstate) and a few other
issues, clean up things and remove unused code.

Specifics:

 - Fix for a cpuidle menu governor problem that started to take an
   unnecessary spinlock after one of the recent updates and that
   did not play well with the RT patch (Rafael Wysocki).

 - Fix for the new intel_pstate operation mode switching feature
   added recently that did not reinitialize P-state limits properly
   when switching operation modes (Rafael Wysocki).

 - Removal of unused global notifiers from the PM QoS framework
   (Viresh Kumar).

 - Generic power domains framework update to make it handle
   asynchronous invocations of PM callbacks in the "noirq" phases
   of system suspend/hibernation correctly (Ulf Hansson).

 - Two hibernation core cleanups (Rafael Wysocki).

 - intel_idle cleanup related to the sysfs interface (Len Brown).

 - Off-by-one bug fix in the OPP (Operating Performance Points)
   framework (Andrzej Hajda).

 - OPP framework's documentation fix (Viresh Kumar).

 - cpufreq qoriq driver cleanup (Tang Yuantian).

 - Fixes for typos in comments in the device runtime PM framework
   (Christophe Jaillet).

Thanks!

---------------

Andrzej Hajda (1):
      PM / OPP: fix off-by-one bug in dev_pm_opp_get_max_volt_latency loop

Christophe Jaillet (1):
      PM / runtime: Fix some typos

Len Brown (1):
      intel_idle: stop exposing platform acronyms in sysfs

Rafael J. Wysocki (4):
      cpuidle: menu: Avoid taking spinlock for accessing QoS values
      PM / hibernate: Untangle power_down()
      PM / hibernate: Define pr_fmt() and use pr_*() instead of printk()
      cpufreq: intel_pstate: Fix limits issue with operation mode switching

Tang Yuantian (1):
      cpufreq: qoriq: clean up unused code

Ulf Hansson (3):
      PM / Domains: Move genpd_power_off() above genpd_power_on()
      PM / Domains: Rename is_async to one_dev_on for genpd_power_off()
      PM / Domains: Power off masters immediately in the power off sequence

Viresh Kumar (2):
      PM / QoS: Remove global notifiers
      PM / OPP: Documentation: Fix opp-microvolt in examples

---------------

 Documentation/devicetree/bindings/opp/opp.txt |  44 +++----
 Documentation/power/pm_qos_interface.txt      |  13 +-
 Documentation/power/runtime_pm.txt            |   6 +-
 drivers/base/power/domain.c                   | 178 ++++++++++++++------------
 drivers/base/power/opp/core.c                 |   3 +-
 drivers/base/power/qos.c                      |  53 +-------
 drivers/cpufreq/intel_pstate.c                |  65 ++++------
 drivers/cpufreq/qoriq-cpufreq.c               |   4 -
 drivers/cpuidle/governors/menu.c              |   2 +-
 drivers/idle/intel_idle.c                     | 172 ++++++++++++-------------
 include/linux/pm_qos.h                        |  15 +--
 kernel/power/hibernate.c                      |  93 +++++++-------
 12 files changed, 286 insertions(+), 362 deletions(-)
