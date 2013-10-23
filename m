From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH] intel_idle, use CPU_TASKS_FROZEN
Date: Wed, 23 Oct 2013 09:44:51 -0400
Message-ID: <1382535891-13240-1-git-send-email-prarit@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:29433 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751410Ab3JWNo5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 23 Oct 2013 09:44:57 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9NDiv3Y000723
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-pm@vger.kernel.org>; Wed, 23 Oct 2013 09:44:57 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>

Small fixup to use CPU_TASKS_FROZEN instead of 0xf.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
---
 drivers/idle/intel_idle.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index fa6964d..a54358f 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -390,7 +390,7 @@ static int cpu_hotplug_notify(struct notifier_block *n,
 	int hotcpu = (unsigned long)hcpu;
 	struct cpuidle_device *dev;
 
-	switch (action & 0xf) {
+	switch (action & ~CPU_TASKS_FROZEN) {
 	case CPU_ONLINE:
 
 		if (lapic_timer_reliable_states != LAPIC_TIMER_ALWAYS_RELIABLE)
-- 
1.7.9.3

