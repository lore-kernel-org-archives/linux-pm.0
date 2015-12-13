From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 0/2] tools/power turbostat: Fix TDP MSR bits and invalid parameters
Date: Sun, 13 Dec 2015 21:09:10 +0800
Message-ID: <cover.1450011064.git.yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:46734 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751098AbbLMNEU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 13 Dec 2015 08:04:20 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: len.brown@intel.com
Cc: rjw@rjwysocki.net, srinivas.pandruvada@intel.com, rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

[PATCH 1/2] is to fix the TDP MSRs bits calculation, which might bring
incorrect information to user.
[PATCH 2/2] is to fix invalid parameters passing to dump_cstate_pstate_config_info
and also fix some compiling problems.

Chen Yu (2):
  tools/power turbostat: bugfix: TDP MSRs print bits fixing
  tools/power turbostat: bugfix: fix several invalid parameters

 tools/power/x86/turbostat/turbostat.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

-- 
1.8.4.2

