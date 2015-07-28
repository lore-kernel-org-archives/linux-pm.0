From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH v3 0/3] Devfreq cooling device
Date: Tue, 28 Jul 2015 16:17:49 +0100
Message-ID: <1438096672-10867-1-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59975 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751181AbbG1PSJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 28 Jul 2015 11:18:09 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: cw00.choi@samsung.com, Javi Merino <javi.merino@arm.com>

This series introduces a devfreq cooling device in the thermal
framework.  Devfreq is used for DVFS for devices other than the CPUs.
With a devfreq cooling device, the thermal framework can throttle them
to control temperature.  The cooling device has the power extensions,
so it can be used by all governors in the thermal framework, including
the power allocator governor.

Changes since v2:
  - Use the opp library to enable/disable opps instead of exporting
    devfreq_set_{max,min}
  - Use idr API to get a unique name for each devfreq cooling device
    registered.
Changes since v1:
  - Rename devfreq_qos_set_[max|min] to devfreq_set_[max|min] as
    suggested by MyungJoo Ham
  - Calculate devfreq load in the tracepoint so that it only happens
    when the trace is enabled.  Thanks Steven Rostedt.

Javi Merino (2):
  PM / devfreq: cache the last call to get_dev_status()
  devfreq_cooling: add trace information

=C3=98rjan Eide (1):
  thermal: Add devfreq cooling

 drivers/devfreq/devfreq.c                 |   5 +
 drivers/devfreq/governor_simpleondemand.c |  33 ++-
 drivers/thermal/Kconfig                   |  10 +
 drivers/thermal/Makefile                  |   3 +
 drivers/thermal/devfreq_cooling.c         | 472 ++++++++++++++++++++++=
++++++++
 include/linux/devfreq.h                   |   8 +
 include/linux/devfreq_cooling.h           |  93 ++++++
 include/trace/events/thermal.h            |  53 ++++
 8 files changed, 662 insertions(+), 15 deletions(-)
 create mode 100644 drivers/thermal/devfreq_cooling.c
 create mode 100644 include/linux/devfreq_cooling.h

--=20
1.9.1

