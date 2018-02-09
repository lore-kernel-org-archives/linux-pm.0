From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/3] TOOLS: pm-graph v5.0
Date: Fri, 09 Feb 2018 12:59:34 +0100
Message-ID: <1899690.PnvvOhBOih@aspire.rjw.lan>
References: <cover.1517297999.git.todd.e.brandt@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:52001 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbeBIMBS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Feb 2018 07:01:18 -0500
In-Reply-To: <cover.1517297999.git.todd.e.brandt@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Todd Brandt <todd.e.brandt@linux.intel.com>
Cc: linux-pm@vger.kernel.org, todd.e.brandt@intel.com

Hi Todd,

On Tuesday, January 30, 2018 9:17:17 AM CET Todd Brandt wrote:
> Upgrade the pm-graph tools from v4.7 to v5.0
> 
> Todd Brandt (3):
>   pm-graph: config files and installer
>   pm-graph: AnalyzeBoot v2.2
>   pm-graph: AnalyzeSuspend v5.0
> 
>  tools/power/pm-graph/Makefile                      |   29 +-
>  tools/power/pm-graph/bootgraph.8                   |   18 +-
>  .../pm-graph/{analyze_boot.py => bootgraph.py}     |  219 ++-
>  tools/power/pm-graph/config/cgskip.txt             |   65 +
>  .../pm-graph/config/custom-timeline-functions.cfg  |  205 +++
>  tools/power/pm-graph/config/example.cfg            |  133 ++
>  tools/power/pm-graph/config/freeze-callgraph.cfg   |   94 ++
>  tools/power/pm-graph/config/freeze-dev.cfg         |   93 ++
>  tools/power/pm-graph/config/freeze.cfg             |   93 ++
>  tools/power/pm-graph/config/standby-callgraph.cfg  |   94 ++
>  tools/power/pm-graph/config/standby-dev.cfg        |   93 ++
>  tools/power/pm-graph/config/standby.cfg            |   93 ++
>  tools/power/pm-graph/config/suspend-callgraph.cfg  |   98 ++
>  tools/power/pm-graph/config/suspend-dev.cfg        |   93 ++
>  tools/power/pm-graph/config/suspend-x2-proc.cfg    |   93 ++
>  tools/power/pm-graph/config/suspend.cfg            |   93 ++
>  tools/power/pm-graph/sleepgraph.8                  |   47 +-
>  .../pm-graph/{analyze_suspend.py => sleepgraph.py} | 1625 ++++++++++++--------
>  18 files changed, 2575 insertions(+), 703 deletions(-)
>  rename tools/power/pm-graph/{analyze_boot.py => bootgraph.py} (85%)
>  create mode 100644 tools/power/pm-graph/config/cgskip.txt
>  create mode 100644 tools/power/pm-graph/config/custom-timeline-functions.cfg
>  create mode 100644 tools/power/pm-graph/config/example.cfg
>  create mode 100644 tools/power/pm-graph/config/freeze-callgraph.cfg
>  create mode 100644 tools/power/pm-graph/config/freeze-dev.cfg
>  create mode 100644 tools/power/pm-graph/config/freeze.cfg
>  create mode 100644 tools/power/pm-graph/config/standby-callgraph.cfg
>  create mode 100644 tools/power/pm-graph/config/standby-dev.cfg
>  create mode 100644 tools/power/pm-graph/config/standby.cfg
>  create mode 100644 tools/power/pm-graph/config/suspend-callgraph.cfg
>  create mode 100644 tools/power/pm-graph/config/suspend-dev.cfg
>  create mode 100644 tools/power/pm-graph/config/suspend-x2-proc.cfg
>  create mode 100644 tools/power/pm-graph/config/suspend.cfg
>  rename tools/power/pm-graph/{analyze_suspend.py => sleepgraph.py} (82%)
> 
> 

This is a major update, so I would prefer to queue it up for 4.17
to trying to squeeze it into 4.16 at this point.

Please let me know if that would be a problem.

Thanks,
Rafael
