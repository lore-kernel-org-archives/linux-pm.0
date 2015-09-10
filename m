From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH v6 0/5] Devfreq cooling device
Date: Thu, 10 Sep 2015 18:09:27 +0100
Message-ID: <1441904972-5809-1-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, cw00.choi@samsung.com, edubezval@gmail.com, Javi Merino <javi.merino@arm.com>
List-Id: linux-pm@vger.kernel.org

This series introduces a devfreq cooling device in the thermal
framework.  Devfreq is used for DVFS for devices other than the CPUs.
With a devfreq cooling device, the thermal framework can throttle them
to control temperature.  The cooling device has the power extensions,
so it can be used by all governors in the thermal framework, including
the power allocator governor.

Changes since v5:
  - s/enable_disable_opps()/partition_enable_opps()
  - Check the state in devfreq_cooling_state2power()
  - Make the printing of the dynamic power table a dev_dbg printk
  - Remove the warning of simple ondemand devfreq governor from the
    code and document it in the Kconfig entry.
  - Change the name of the cooling device to thermal-devfreq-X
  - s/EXPORT_SYMBOL/EXPORT_SYMBOL_GPL/
  - Use a simple dynamic power model if no dynamic power model is
    supplied.

Changes since v4:
  - Don't introduce a new function in the OPP library and instead fix
    dev_pm_opp_get_voltage() as suggested by Viresh Kumar
  - Don't allocate memory under RCU
  - Don't call dev_pm_opp_enable/disable under RCU
  - Generate the frequency table even if the power extensions were
    not provided

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
  PM / OPP: get the voltage for all OPPs
  devfreq_cooling: add trace information
  PM / devfreq: drop comment about thermal setting max_freq

=C3=98rjan Eide (1):
  thermal: Add devfreq cooling

 drivers/base/power/opp.c                  |   4 +-
 drivers/devfreq/devfreq.c                 |   6 +-
 drivers/devfreq/governor_simpleondemand.c |  33 +-
 drivers/thermal/Kconfig                   |  14 +
 drivers/thermal/Makefile                  |   3 +
 drivers/thermal/devfreq_cooling.c         | 569 ++++++++++++++++++++++=
++++++++
 include/linux/devfreq.h                   |  15 +
 include/linux/devfreq_cooling.h           |  81 +++++
 include/trace/events/thermal.h            |  53 +++
 9 files changed, 758 insertions(+), 20 deletions(-)
 create mode 100644 drivers/thermal/devfreq_cooling.c
 create mode 100644 include/linux/devfreq_cooling.h

--=20
1.9.1
