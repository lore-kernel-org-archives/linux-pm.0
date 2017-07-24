From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/3] TOOLS: pm-graph v4.7
Date: Mon, 24 Jul 2017 22:50:23 +0200
Message-ID: <187621464.ImEllgTIPt@aspire.rjw.lan>
References: <cover.1499290431.git.todd.e.brandt@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:61938 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753513AbdGXU6U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jul 2017 16:58:20 -0400
In-Reply-To: <cover.1499290431.git.todd.e.brandt@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Todd Brandt <todd.e.brandt@linux.intel.com>
Cc: linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, todd.e.brandt@intel.com

On Wednesday, July 05, 2017 02:42:54 PM Todd Brandt wrote:
> Upgrade the pm-graph tools from v4.6 to v4.7
> 
> Todd Brandt (3):
>   pm-graph: AnalyzeSuspend v4.7
>   pm-graph: AnalyzeBoot v2.1
>   pm-graph: package makefile and man pages
> 
>  tools/power/pm-graph/Makefile           |  19 +-
>  tools/power/pm-graph/analyze_boot.py    | 586 +++++++++++++++++++++-----------
>  tools/power/pm-graph/analyze_suspend.py | 534 ++++++++++++++++++++---------
>  tools/power/pm-graph/bootgraph.8        |  61 +++-
>  tools/power/pm-graph/sleepgraph.8       |  48 +--
>  5 files changed, 852 insertions(+), 396 deletions(-)
> 
> 

Series applied, thanks!
