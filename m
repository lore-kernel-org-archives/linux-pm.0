From: Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: [PATCH 0/3] AnalyzeSuspend v4.5
Date: Wed, 14 Dec 2016 10:37:04 -0800
Message-ID: <cover.1481740176.git.todd.e.brandt@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:26466 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753119AbcLNShN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 14 Dec 2016 13:37:13 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: todd.e.brandt@intel.com, rjw@rjwysocki.net, rafael.j.wysocki@intel.com, Todd Brandt <todd.e.brandt@linux.intel.com>

This patch series updates the tool from v4.2 to v4.5. The patches
can be combined into a single commit for brevity.

Todd Brandt (3):
  AnalyzeSuspend v4.3
  AnalyzeSuspend v4.4
  AnalyzeSuspend v4.5

 scripts/analyze_suspend.py | 1928 ++++++++++++++++++++++++++------------------
 1 file changed, 1132 insertions(+), 796 deletions(-)

-- 
2.1.4

