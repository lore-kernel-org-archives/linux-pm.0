From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1] KNL divide by zero
Date: Thu, 15 Oct 2015 12:34:20 -0700
Message-ID: <1444937661-9519-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:28094 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752069AbbJOTe6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 15 Oct 2015 15:34:58 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kristen.c.accardi@intel.com, rafael.j.wysocki@intel.com, len.brown@intel.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

v1:
Fix bug for not reenabling interrupts

v0:
base version

Srinivas Pandruvada (1):
  cpufreq: intel_pstate: divide by zero on Knights Landing (KNL)

 drivers/cpufreq/intel_pstate.c | 5 +++++
 1 file changed, 5 insertions(+)

-- 
1.9.3

