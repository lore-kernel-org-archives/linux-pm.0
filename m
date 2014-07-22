From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 0/4] tools/power/cpupower latest fixes
Date: Tue, 22 Jul 2014 16:05:57 +0200
Message-ID: <1406037961-27190-1-git-send-email-trenn@suse.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46131 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088AbaGVOHC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 22 Jul 2014 10:07:02 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Thomas Renninger <trenn@suse.de>

These are fixes for the cpupower utility I received lately.

Rafael: Would be great if you can queue them in your pm tree.

Thanks,

         Thomas

Himangi Saraogi (1):
  cpupower: mperf monitor: Correct use of ! and &

Peter Senna Tschudin (1):
  cpupower: Remove redundant error check

Rickard Strandqvist (1):
  tools: power: cpupower: bench: parse.c: Fix several minor errors

Thomas Renninger (1):
  cpupower: Adjust MAINTAINERS file

 MAINTAINERS                                        |    2 +-
 tools/power/cpupower/bench/parse.c                 |   39 +++++++++++---------
 tools/power/cpupower/utils/cpufreq-set.c           |   11 +++---
 .../cpupower/utils/idle_monitor/mperf_monitor.c    |    2 +-
 4 files changed, 28 insertions(+), 26 deletions(-)

-- 
1.7.6.1

