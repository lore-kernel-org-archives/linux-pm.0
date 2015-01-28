From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 0/2] sysfs additions for intel_pstate
Date: Wed, 28 Jan 2015 15:03:26 -0800
Message-ID: <1422486208-14367-1-git-send-email-kristen@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:34165 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755330AbbA2B2v (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 28 Jan 2015 20:28:51 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org

Add sysfs interface to expose hardware turbo information to user space.

Kristen Carlson Accardi (2):
  intel_pstate: expose turbo range to sysfs
  intel_pstate: Add num_pstates to sysfs

 Documentation/cpu-freq/intel-pstate.txt |  8 ++++++++
 drivers/cpufreq/intel_pstate.c          | 31 +++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

-- 
1.9.3

