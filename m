From: Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: Re: [PATCH 0/5] scripts: AnalyzeSuspend v4.2
Date: Thu, 14 Jul 2016 14:33:18 -0700
Message-ID: <1468531998.15887.4.camel@linux.intel.com>
References: <cover.1468530071.git.todd.e.brandt@linux.intel.com>
	 <CAJZ5v0gSrwcBC-A-g6Pf_eMJ904zZdRkB591w844bwU6pL8qEQ@mail.gmail.com>
Reply-To: todd.e.brandt@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:57973 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750876AbcGNVdU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 14 Jul 2016 17:33:20 -0400
In-Reply-To: <CAJZ5v0gSrwcBC-A-g6Pf_eMJ904zZdRkB591w844bwU6pL8qEQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rafael Wysocki <rafael.j.wysocki@intel.com>, todd.e.brandt@intel.com

On Thu, 2016-07-14 at 23:22 +0200, Rafael J. Wysocki wrote:
> On Thu, Jul 14, 2016 at 11:09 PM, Todd Brandt
> <todd.e.brandt@linux.intel.com> wrote:
> > AnalyzeSuspend v4.2
> >
> >   kprobe support for function tracing
> >   config file support in lieu of command line options
> >   advanced callgraph support for function debug
> >   dev mode for monitoring common sources of delay, e.g. msleep, udelay
> >   many bug fixes and formatting upgrades
> >
> > Todd Brandt (5):
> >   AnalyzeSuspend v4.2 part1
> >   AnalyzeSuspend v4.2 part2
> >   AnalyzeSuspend v4.2 part3
> >   AnalyzeSuspend v4.2 part4
> >   AnalyzeSuspend v4.2 part5
> >
> >  scripts/analyze_suspend.py | 3641 ++++++++++++++++++++++++++++++--------------
> >  1 file changed, 2474 insertions(+), 1167 deletions(-)
> >
> > --
> 
> Can you please tell me what specifically goes into each of the patches?

It's just a 5 way splitdiff on the original patch, it seems it was too
large to be accepted on the mailing list as a single patch, so I broke
it into 5 ~1000 line pieces. The patch is just meant to upgrade the
kernel analyze_suspend version from 3.0 to 4.2. 

Someone suggested that I do a pull request, but I don't want the
analyze_suspend git log included in the kernel git log, so I'm just
describing the changes by version number in the kernel git log.

When you include the patch just set it to be a single commit message.

> 
> Thanks,
> Rafael


