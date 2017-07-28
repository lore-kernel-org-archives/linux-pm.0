From: Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: Re: [PATCH 0/3] TOOLS: pm-graph v4.7
Date: Thu, 27 Jul 2017 20:37:10 -0700
Message-ID: <1501213030.6778.0.camel@linux.intel.com>
References: <cover.1499290431.git.todd.e.brandt@linux.intel.com>
         <187621464.ImEllgTIPt@aspire.rjw.lan>
Reply-To: todd.e.brandt@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:40315 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751577AbdG1DhL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 27 Jul 2017 23:37:11 -0400
In-Reply-To: <187621464.ImEllgTIPt@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, todd.e.brandt@intel.com

On Mon, 2017-07-24 at 22:50 +0200, Rafael J. Wysocki wrote:
> On Wednesday, July 05, 2017 02:42:54 PM Todd Brandt wrote:
> > Upgrade the pm-graph tools from v4.6 to v4.7
> > 
> > Todd Brandt (3):
> >   pm-graph: AnalyzeSuspend v4.7
> >   pm-graph: AnalyzeBoot v2.1
> >   pm-graph: package makefile and man pages
> > 
> >  tools/power/pm-graph/Makefile           |  19 +-
> >  tools/power/pm-graph/analyze_boot.py    | 586
> > +++++++++++++++++++++-----------
> >  tools/power/pm-graph/analyze_suspend.py | 534
> > ++++++++++++++++++++---------
> >  tools/power/pm-graph/bootgraph.8        |  61 +++-
> >  tools/power/pm-graph/sleepgraph.8       |  48 +--
> >  5 files changed, 852 insertions(+), 396 deletions(-)
> > 
> > 
> 
> Series applied, thanks!
> 

Thanks!
Also, I just did an accidental resend, please ignore it.
