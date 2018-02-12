From: Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: Re: [PATCH 0/3] TOOLS: pm-graph v5.0
Date: Mon, 12 Feb 2018 07:54:53 -0800
Message-ID: <1518450893.4841.0.camel@linux.intel.com>
References: <cover.1517297999.git.todd.e.brandt@linux.intel.com>
         <1899690.PnvvOhBOih@aspire.rjw.lan>
Reply-To: todd.e.brandt@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:23312 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933202AbeBLPyz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 12 Feb 2018 10:54:55 -0500
In-Reply-To: <1899690.PnvvOhBOih@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, todd.e.brandt@intel.com

On Fri, 2018-02-09 at 12:59 +0100, Rafael J. Wysocki wrote:
> Hi Todd,
> 
> On Tuesday, January 30, 2018 9:17:17 AM CET Todd Brandt wrote:
> > Upgrade the pm-graph tools from v4.7 to v5.0
> > 
> > Todd Brandt (3):
> >   pm-graph: config files and installer
> >   pm-graph: AnalyzeBoot v2.2
> >   pm-graph: AnalyzeSuspend v5.0
> > 
> >  tools/power/pm-graph/Makefile                      |   29 +-
> >  tools/power/pm-graph/bootgraph.8                   |   18 +-
> >  .../pm-graph/{analyze_boot.py => bootgraph.py}     |  219 ++-
> >  tools/power/pm-graph/config/cgskip.txt             |   65 +
> >  .../pm-graph/config/custom-timeline-functions.cfg  |  205 +++
> >  tools/power/pm-graph/config/example.cfg            |  133 ++
> >  tools/power/pm-graph/config/freeze-callgraph.cfg   |   94 ++
> >  tools/power/pm-graph/config/freeze-dev.cfg         |   93 ++
> >  tools/power/pm-graph/config/freeze.cfg             |   93 ++
> >  tools/power/pm-graph/config/standby-callgraph.cfg  |   94 ++
> >  tools/power/pm-graph/config/standby-dev.cfg        |   93 ++
> >  tools/power/pm-graph/config/standby.cfg            |   93 ++
> >  tools/power/pm-graph/config/suspend-callgraph.cfg  |   98 ++
> >  tools/power/pm-graph/config/suspend-dev.cfg        |   93 ++
> >  tools/power/pm-graph/config/suspend-x2-proc.cfg    |   93 ++
> >  tools/power/pm-graph/config/suspend.cfg            |   93 ++
> >  tools/power/pm-graph/sleepgraph.8                  |   47 +-
> >  .../pm-graph/{analyze_suspend.py => sleepgraph.py} | 1625
> > ++++++++++++--------
> >  18 files changed, 2575 insertions(+), 703 deletions(-)
> >  rename tools/power/pm-graph/{analyze_boot.py => bootgraph.py}
> > (85%)
> >  create mode 100644 tools/power/pm-graph/config/cgskip.txt
> >  create mode 100644 tools/power/pm-graph/config/custom-timeline-
> > functions.cfg
> >  create mode 100644 tools/power/pm-graph/config/example.cfg
> >  create mode 100644 tools/power/pm-graph/config/freeze-
> > callgraph.cfg
> >  create mode 100644 tools/power/pm-graph/config/freeze-dev.cfg
> >  create mode 100644 tools/power/pm-graph/config/freeze.cfg
> >  create mode 100644 tools/power/pm-graph/config/standby-
> > callgraph.cfg
> >  create mode 100644 tools/power/pm-graph/config/standby-dev.cfg
> >  create mode 100644 tools/power/pm-graph/config/standby.cfg
> >  create mode 100644 tools/power/pm-graph/config/suspend-
> > callgraph.cfg
> >  create mode 100644 tools/power/pm-graph/config/suspend-dev.cfg
> >  create mode 100644 tools/power/pm-graph/config/suspend-x2-proc.cfg
> >  create mode 100644 tools/power/pm-graph/config/suspend.cfg
> >  rename tools/power/pm-graph/{analyze_suspend.py => sleepgraph.py}
> > (82%)
> > 
> > 
> 
> This is a major update, so I would prefer to queue it up for 4.17
> to trying to squeeze it into 4.16 at this point.
> 
> Please let me know if that would be a problem.

No that's ok, sorry for the size.
> 
> Thanks,
> Rafael
> 
