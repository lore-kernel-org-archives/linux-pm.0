From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH v2 0/4] Devfreq cooling device
Date: Mon, 13 Jul 2015 18:33:54 +0100
Message-ID: <1436808838-23391-1-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58787 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751451AbbGMReU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 13 Jul 2015 13:34:20 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Javi Merino <javi.merino@arm.com>

This series introduces a devfreq cooling device in the thermal
framework.  Devfreq is used for DVFS for devices other than the CPUs.
With a devfreq cooling device, the thermal framework can throttle them
to control temperature.  The cooling device has the power extensions,
so it can be used by all governors in the thermal framework, including
the power allocator governor.

Changes since v1:
  - Rename devfreq_qos_set_[max|min] to devfreq_set_[max|min] as
    suggested by MyungJoo Ham
  - Calculate devfreq load in the tracepoint so that it only happens
    when the trace is enabled.  Thanks Steven Rostedt.

Javi Merino (2):
  PM / devfreq: cache the last call to get_dev_status()
  devfreq_cooling: add trace information

=C3=98rjan Eide (2):
  PM / devfreq: Add function to set max/min frequency
  thermal: Add devfreq cooling

 drivers/devfreq/devfreq.c                 |  77 ++++--
 drivers/devfreq/governor_simpleondemand.c |  33 +--
 drivers/thermal/Kconfig                   |  10 +
 drivers/thermal/Makefile                  |   3 +
 drivers/thermal/devfreq_cooling.c         | 394 ++++++++++++++++++++++=
++++++++
 include/linux/devfreq.h                   |  20 ++
 include/linux/devfreq_cooling.h           |  90 +++++++
 include/trace/events/thermal.h            |  53 ++++
 8 files changed, 641 insertions(+), 39 deletions(-)
 create mode 100644 drivers/thermal/devfreq_cooling.c
 create mode 100644 include/linux/devfreq_cooling.h

--=20
1.9.1

