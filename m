From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH v4 0/5] Devfreq cooling device
Date: Fri, 14 Aug 2015 18:56:55 +0100
Message-ID: <1439575020-3447-1-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, cw00.choi@samsung.com, rufus.hamade@imgtec.com, Javi Merino <javi.merino@arm.com>
List-Id: linux-pm@vger.kernel.org

This series introduces a devfreq cooling device in the thermal
framework.  Devfreq is used for DVFS for devices other than the CPUs.
With a devfreq cooling device, the thermal framework can throttle them
to control temperature.  The cooling device has the power extensions,
so it can be used by all governors in the thermal framework, including
the power allocator governor.

Changes since v3:
  - Made devfreq_update_stats() a static inline function
  - Add dev_pm_get_voltage_always() to get the voltage even for
    disabled OPPs
  - Don't rely on freq_table from the devfreq->profile being present
    and create our own
  - Don't use devm_k* to allocate memory
  - Move struct devfreq_cooling_register to devfreq_cooling.c

Javi Merino (4):
  PM / devfreq: cache the last call to get_dev_status()
  PM / OPP: add a function to get the voltage for disabled OPPs
  devfreq_cooling: add trace information
  PM / devfreq: drop comment about thermal setting max_freq

=C3=98rjan Eide (1):
  thermal: Add devfreq cooling

 drivers/base/power/opp.c                  |  37 ++
 drivers/devfreq/devfreq.c                 |   6 +-
 drivers/devfreq/governor_simpleondemand.c |  33 +-
 drivers/thermal/Kconfig                   |  10 +
 drivers/thermal/Makefile                  |   3 +
 drivers/thermal/devfreq_cooling.c         | 547 ++++++++++++++++++++++=
++++++++
 include/linux/devfreq.h                   |  15 +
 include/linux/devfreq_cooling.h           |  72 ++++
 include/linux/pm_opp.h                    |   7 +
 include/trace/events/thermal.h            |  53 +++
 10 files changed, 765 insertions(+), 18 deletions(-)
 create mode 100644 drivers/thermal/devfreq_cooling.c
 create mode 100644 include/linux/devfreq_cooling.h

--=20
1.9.1
