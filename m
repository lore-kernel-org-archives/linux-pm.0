From: Richard Cochran <rcochran@linutronix.de>
Subject: [PATCH 01/10] intel_idle: remove useless return from void function.
Date: Tue, 29 Mar 2016 15:15:53 +0200
Message-ID: <cb4c25aca454ee1a54f942108503667ecd4cd32a.1459257096.git.rcochran@linutronix.de>
References: <cover.1459257096.git.rcochran@linutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:54666 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755967AbcC2NQF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Mar 2016 09:16:05 -0400
In-Reply-To: <cover.1459257096.git.rcochran@linutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rt@linutronix.de, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org

Cc: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Richard Cochran <rcochran@linutronix.de>
---
 drivers/idle/intel_idle.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index ba947df..9d5ed32 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1260,8 +1260,6 @@ static void __exit intel_idle_exit(void)
 	__unregister_cpu_notifier(&cpu_hotplug_notifier);
 
 	cpu_notifier_register_done();
-
-	return;
 }
 
 module_init(intel_idle_init);
-- 
2.1.4

