From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH] cpufreq: fix comment about return value of cpufreq_register_driver()
Date: Sat, 20 Feb 2016 21:50:01 -0600
Message-ID: <1456026601-31282-1-git-send-email-ebiggers3@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:32958 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbcBUTfH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 21 Feb 2016 14:35:07 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Eric Biggers <ebiggers3@gmail.com>

The comment has been incorrect since commit 4dea5806d332
("cpufreq: return EEXIST instead of EBUSY for second registering").

Signed-off-by: Eric Biggers <ebiggers3@gmail.com>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index e979ec7..bfefc91 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2384,7 +2384,7 @@ EXPORT_SYMBOL_GPL(cpufreq_boost_enabled);
  * submitted by the CPU Frequency driver.
  *
  * Registers a CPU Frequency driver to this core code. This code
- * returns zero on success, -EBUSY when another driver got here first
+ * returns zero on success, -EEXIST when another driver got here first
  * (and isn't unregistered in the meantime).
  *
  */
-- 
2.7.1

