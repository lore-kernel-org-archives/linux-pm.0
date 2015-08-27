From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH v5 0/5] Devfreq cooling device
Date: Thu, 27 Aug 2015 11:55:46 +0100
Message-ID: <1440672951-7002-1-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48163 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751444AbbH0K4Y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 27 Aug 2015 06:56:24 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, cw00.choi@samsung.com, rufus.hamade@imgtec.com, edubezval@gmail.com, Javi Merino <javi.merino@arm.com>

This series introduces a devfreq cooling device in the thermal
framework.  Devfreq is used for DVFS for devices other than the CPUs.
With a devfreq cooling device, the thermal framework can throttle them
to control temperature.  The cooling device has the power extensions,
so it can be used by all governors in the thermal framework, including
the power allocator governor.

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
 drivers/thermal/Kconfig                   |  11 +
 drivers/thermal/Makefile                  |   3 +
 drivers/thermal/devfreq_cooling.c         | 552 ++++++++++++++++++++++=
++++++++
 include/linux/devfreq.h                   |  15 +
 include/linux/devfreq_cooling.h           |  72 ++++
 include/trace/events/thermal.h            |  53 +++
 9 files changed, 729 insertions(+), 20 deletions(-)
 create mode 100644 drivers/thermal/devfreq_cooling.c
 create mode 100644 include/linux/devfreq_cooling.h

--=20
1.9.1

