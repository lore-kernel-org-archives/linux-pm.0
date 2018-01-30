From: Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: [PATCH 0/3] TOOLS: pm-graph v5.0
Date: Tue, 30 Jan 2018 00:17:17 -0800
Message-ID: <cover.1517297999.git.todd.e.brandt@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:31326 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751510AbeA3IRW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 30 Jan 2018 03:17:22 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, rjw@rjwysocki.net
Cc: todd.e.brandt@linux.intel.com, todd.e.brandt@intel.com

Upgrade the pm-graph tools from v4.7 to v5.0

Todd Brandt (3):
  pm-graph: config files and installer
  pm-graph: AnalyzeBoot v2.2
  pm-graph: AnalyzeSuspend v5.0

 tools/power/pm-graph/Makefile                      |   29 +-
 tools/power/pm-graph/bootgraph.8                   |   18 +-
 .../pm-graph/{analyze_boot.py => bootgraph.py}     |  219 ++-
 tools/power/pm-graph/config/cgskip.txt             |   65 +
 .../pm-graph/config/custom-timeline-functions.cfg  |  205 +++
 tools/power/pm-graph/config/example.cfg            |  133 ++
 tools/power/pm-graph/config/freeze-callgraph.cfg   |   94 ++
 tools/power/pm-graph/config/freeze-dev.cfg         |   93 ++
 tools/power/pm-graph/config/freeze.cfg             |   93 ++
 tools/power/pm-graph/config/standby-callgraph.cfg  |   94 ++
 tools/power/pm-graph/config/standby-dev.cfg        |   93 ++
 tools/power/pm-graph/config/standby.cfg            |   93 ++
 tools/power/pm-graph/config/suspend-callgraph.cfg  |   98 ++
 tools/power/pm-graph/config/suspend-dev.cfg        |   93 ++
 tools/power/pm-graph/config/suspend-x2-proc.cfg    |   93 ++
 tools/power/pm-graph/config/suspend.cfg            |   93 ++
 tools/power/pm-graph/sleepgraph.8                  |   47 +-
 .../pm-graph/{analyze_suspend.py => sleepgraph.py} | 1625 ++++++++++++--------
 18 files changed, 2575 insertions(+), 703 deletions(-)
 rename tools/power/pm-graph/{analyze_boot.py => bootgraph.py} (85%)
 create mode 100644 tools/power/pm-graph/config/cgskip.txt
 create mode 100644 tools/power/pm-graph/config/custom-timeline-functions.cfg
 create mode 100644 tools/power/pm-graph/config/example.cfg
 create mode 100644 tools/power/pm-graph/config/freeze-callgraph.cfg
 create mode 100644 tools/power/pm-graph/config/freeze-dev.cfg
 create mode 100644 tools/power/pm-graph/config/freeze.cfg
 create mode 100644 tools/power/pm-graph/config/standby-callgraph.cfg
 create mode 100644 tools/power/pm-graph/config/standby-dev.cfg
 create mode 100644 tools/power/pm-graph/config/standby.cfg
 create mode 100644 tools/power/pm-graph/config/suspend-callgraph.cfg
 create mode 100644 tools/power/pm-graph/config/suspend-dev.cfg
 create mode 100644 tools/power/pm-graph/config/suspend-x2-proc.cfg
 create mode 100644 tools/power/pm-graph/config/suspend.cfg
 rename tools/power/pm-graph/{analyze_suspend.py => sleepgraph.py} (82%)

-- 
2.14.1
