From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH 0/2] Fixes for cpu cooling
Date: Mon, 17 Aug 2015 19:21:41 +0100
Message-ID: <1439835703-16470-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46393 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751181AbbHQSWP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 17 Aug 2015 14:22:15 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Javi Merino <javi.merino@arm.com>

Commit c36cf0717631 ("thermal: cpu_cooling: implement the power
cooling device API") introduced two bugs: a call to kcalloc() (that
might sleep) under RCU and not freeing the allocation when it's no
longer needed.  This series fixes both issues.

Javi Merino (2):
  thermal: cpu_cooling: don't call kcalloc() under rcu_read_lock
  thermal: cpu_cooling: free power table on error or when unregistering

 drivers/thermal/cpu_cooling.c | 52 ++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 21 deletions(-)

-- 
1.9.1

