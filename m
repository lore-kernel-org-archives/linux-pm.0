From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/3] Intel Pstate: ACPI perf integration issues
Date: Mon,  9 Nov 2015 18:58:08 -0800
Message-ID: <1447124291-14059-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:48368 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751843AbbKJC7E (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 9 Nov 2015 21:59:04 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rafael.j.wysocki@intel.com, lenlenb@kernel.org
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Some minor fixes related to ACPI _PSS.
Main one is ignore _PSS and _PPC when HWP (hardware P state) is enabled.

Srinivas Pandruvada (3):
  cpufreq: intel_pstate: Don't use ACPI perf for HWP
  cpufreq: intel_pstate: wrong flag checking for no_acpi_perf
  cpufreq: intel_pstate: Fix the scaling of _PSS entry[0]

 drivers/cpufreq/intel_pstate.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

-- 
1.9.3

