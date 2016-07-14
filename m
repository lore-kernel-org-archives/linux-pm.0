From: Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: [PATCH 0/5] scripts: AnalyzeSuspend v4.2
Date: Thu, 14 Jul 2016 14:09:24 -0700
Message-ID: <cover.1468530071.git.todd.e.brandt@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:43378 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750699AbcGNVJf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 14 Jul 2016 17:09:35 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, rafael.j.wysocki@intel.com, todd.e.brandt@intel.com, Todd Brandt <todd.e.brandt@linux.intel.com>

AnalyzeSuspend v4.2

  kprobe support for function tracing
  config file support in lieu of command line options
  advanced callgraph support for function debug
  dev mode for monitoring common sources of delay, e.g. msleep, udelay
  many bug fixes and formatting upgrades

Todd Brandt (5):
  AnalyzeSuspend v4.2 part1
  AnalyzeSuspend v4.2 part2
  AnalyzeSuspend v4.2 part3
  AnalyzeSuspend v4.2 part4
  AnalyzeSuspend v4.2 part5

 scripts/analyze_suspend.py | 3641 ++++++++++++++++++++++++++++++--------------
 1 file changed, 2474 insertions(+), 1167 deletions(-)

-- 
2.1.4

