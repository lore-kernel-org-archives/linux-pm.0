From: Kapileshwar Singh <kapileshwar.singh@arm.com>
Subject: thermal: cpu_cooling: Power calculation when CPUs are hotplugged
Date: Mon, 16 Mar 2015 12:00:49 +0000
Message-ID: <1426507251-26613-1-git-send-email-kapileshwar.singh@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56216 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750736AbbCPMBG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 16 Mar 2015 08:01:06 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: edubezval@gmail.com, rui.zhang@intel.com, Javi.Merino@arm.com, Punit.Agrawal@arm.com, kapileshwar.singh@arm.com

The following patch series aims at correcting the requested power
calculation when CPUs are hotplugged out. These patches are based on
the "linus" branch of Eduardo's tree.

There is no need to update the cpu_dev pointer (cached) on the reception of a
policy CPU update notifier from cpufreq. This is not required as OPPs
can be ascertained even if the CPU is offline.

cpufreq_get_requested power ensures that a CPU is online before calculating
the frequency for the CPUs and returns the power as 0 if all the CPUs
are offline in the cooling device.

Regards,
KP

Changes in v2:

* Added the Fixes entry in "thermal: cpu_cooling: Remove cpu_dev update on policy"
* Using the correct mailserver config

