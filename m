From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 1/4] cpupower: mperf monitor: Correct use of ! and &
Date: Tue, 22 Jul 2014 16:05:58 +0200
Message-ID: <1406037961-27190-2-git-send-email-trenn@suse.de>
References: <1406037961-27190-1-git-send-email-trenn@suse.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46133 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088AbaGVOHH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 22 Jul 2014 10:07:07 -0400
In-Reply-To: <1406037961-27190-1-git-send-email-trenn@suse.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Himangi Saraogi <himangi774@gmail.com>

From: Himangi Saraogi <himangi774@gmail.com>

In commit ae91d60ba88ef0bdb1b5e9b2363bd52fc45d2af7, a bug was fixed that
involved converting !x & y to !(x & y).  The code below shows the same
pattern, and thus should perhaps be fixed in the same way.

The Coccinelle semantic patch that makes this change is as follows:

// <smpl>
@@ expression E1,E2; @@
(
  !E1 & !E2
|
- !E1 & E2
+ !(E1 & E2)
)
// </smpl>

Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
---
 .../cpupower/utils/idle_monitor/mperf_monitor.c    |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
index 5650ab5..90a8c4f 100644
--- a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
@@ -237,7 +237,7 @@ static int init_maxfreq_mode(void)
 	unsigned long long hwcr;
 	unsigned long min;
 
-	if (!cpupower_cpu_info.caps & CPUPOWER_CAP_INV_TSC)
+	if (!(cpupower_cpu_info.caps & CPUPOWER_CAP_INV_TSC))
 		goto use_sysfs;
 
 	if (cpupower_cpu_info.vendor == X86_VENDOR_AMD) {
-- 
1.7.6.1

