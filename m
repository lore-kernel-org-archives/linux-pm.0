From: Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: [PATCH 0/3] TOOLS: pm-graph v4.6
Date: Fri,  7 Apr 2017 11:05:34 -0700
Message-ID: <cover.1491587995.git.todd.e.brandt@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:38574 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932863AbdDGSFj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 7 Apr 2017 14:05:39 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, rjw@rjwysocki.net
Cc: arjan@linux.intel.com, len.brown@intel.com, todd.e.brandt@intel.com, todd.e.brandt@linux.intel.com

The pm-graph package includes two tools: bootgraph and sleepgraph. The
sleepgraph tool is just analyze_suspend.py renamed for brevity. Sleepgraph
focuses on suspend/resume performance in all low power modes. Bootgraph
focuses on boot time performance. Both use dmesg and ftrace as inputs for
analysis and debug.

Todd Brandt (3):
  AnalyzeSuspend v4.6
  AnalyzeBoot v2.0
  pm-graph package files

 tools/power/pm-graph/Makefile                      |  28 +
 tools/power/pm-graph/analyze_boot.py               | 824 ++++++++++++++++++
 .../power/pm-graph}/analyze_suspend.py             | 916 +++++++++++----------
 tools/power/pm-graph/bootgraph.8                   | 132 +++
 tools/power/pm-graph/sleepgraph.8                  | 243 ++++++
 5 files changed, 1722 insertions(+), 421 deletions(-)
 create mode 100644 tools/power/pm-graph/Makefile
 create mode 100755 tools/power/pm-graph/analyze_boot.py
 rename {scripts => tools/power/pm-graph}/analyze_suspend.py (91%)
 create mode 100644 tools/power/pm-graph/bootgraph.8
 create mode 100644 tools/power/pm-graph/sleepgraph.8

-- 
2.7.4
