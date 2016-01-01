From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v2 0/2] cpufreq: powernv: Redesign the presentation of throttle notification
Date: Sat,  2 Jan 2016 03:51:52 +0530
Message-ID: <1451686914-3761-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp07.in.ibm.com ([125.16.236.7]:39197 "EHLO
	e28smtp07.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbcAAWWn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Jan 2016 17:22:43 -0500
Received: from localhost
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <shilpa.bhat@linux.vnet.ibm.com>;
	Sat, 2 Jan 2016 03:52:40 +0530
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, pc@us.ibm.com, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

In POWER8, OCC(On-Chip-Controller) can throttle the frequency of the
CPU when the chip crosses its thermal and power limits. Currently,
powernv-cpufreq driver detects and reports this event as a console
message. Some boxes may not sustain the max turbo frequency in all
conditions and can be throttled frequently. This can lead to the
flooding of console with throttle messages. So this patchset aims to
redesign the presentation of this event via sysfs counters and
tracepoints. 

This patchset will add a perf trace point "power:powernv_throttle" and
sysfs throttle counter stats in /sys/devices/system/cpu/cpufreq/chipN.

Shilpasri G Bhat (2):
  cpufreq: powernv/tracing: Add powernv_throttle tracepoint
  cpufreq: powernv: Redesign the presentation of throttle notification

 drivers/cpufreq/powernv-cpufreq.c | 247 +++++++++++++++++++++++++++++++-------
 include/trace/events/power.h      |  22 ++++
 kernel/trace/power-traces.c       |   1 +
 3 files changed, 227 insertions(+), 43 deletions(-)

-- 
1.9.3

