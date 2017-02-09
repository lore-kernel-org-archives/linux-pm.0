From: Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: [PATCH v2 0/4] AnalyzeSuspend v4.5
Date: Thu,  9 Feb 2017 13:06:56 -0800
Message-ID: <cover.1486674261.git.todd.e.brandt@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:20895 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752551AbdBIVIo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 Feb 2017 16:08:44 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: todd.e.brandt@intel.com, rjw@rjwysocki.net, rafael.j.wysocki@intel.com, Todd Brandt <todd.e.brandt@linux.intel.com>

This patch series updates the tool from v4.2 to v4.5. The patches
can be combined into a single commit for brevity.

Todd Brandt (4):
  AnalyzeSuspend v4.3
  AnalyzeSuspend v4.4
  AnalyzeSuspend v4.4
  AnalyzeSuspend: fix drag and zoom bug in javascript

 scripts/analyze_suspend.py | 1933 ++++++++++++++++++++++++++------------------
 1 file changed, 1135 insertions(+), 798 deletions(-)

-- 
2.1.4

