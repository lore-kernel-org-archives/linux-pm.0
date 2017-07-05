From: Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: [PATCH 0/3] TOOLS: pm-graph v4.7
Date: Wed,  5 Jul 2017 14:42:54 -0700
Message-ID: <cover.1499290431.git.todd.e.brandt@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:58554 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751896AbdGEVnB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Jul 2017 17:43:01 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, rjw@rjwysocki.net
Cc: todd.e.brandt@linux.intel.com, todd.e.brandt@intel.com

Upgrade the pm-graph tools from v4.6 to v4.7

Todd Brandt (3):
  pm-graph: AnalyzeSuspend v4.7
  pm-graph: AnalyzeBoot v2.1
  pm-graph: package makefile and man pages

 tools/power/pm-graph/Makefile           |  19 +-
 tools/power/pm-graph/analyze_boot.py    | 586 +++++++++++++++++++++-----------
 tools/power/pm-graph/analyze_suspend.py | 534 ++++++++++++++++++++---------
 tools/power/pm-graph/bootgraph.8        |  61 +++-
 tools/power/pm-graph/sleepgraph.8       |  48 +--
 5 files changed, 852 insertions(+), 396 deletions(-)

-- 
2.11.0
