From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] thermal/intel_powerclamp: pr_err()/pr_info() strings should end with newlines
Date: Mon,  9 Oct 2017 17:21:07 +0530
Message-ID: <277b8d12fc6980ec2ffd039a872f681ec0e49c19.1507549738.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37823 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751068AbdJILwc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Oct 2017 07:52:32 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

pr_err()/pr_info() messages should end with a new-line to avoid
other messages being concatenated.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/thermal/intel_powerclamp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
index d718cd1..4540e89 100644
--- a/drivers/thermal/intel_powerclamp.c
+++ b/drivers/thermal/intel_powerclamp.c
@@ -675,13 +675,13 @@ static int __init powerclamp_probe(void)
 {
 
 	if (!x86_match_cpu(intel_powerclamp_ids)) {
-		pr_err("CPU does not support MWAIT");
+		pr_err("CPU does not support MWAIT\n");
 		return -ENODEV;
 	}
 
 	/* The goal for idle time alignment is to achieve package cstate. */
 	if (!has_pkg_state_counter()) {
-		pr_info("No package C-state available");
+		pr_info("No package C-state available\n");
 		return -ENODEV;
 	}
 
-- 
1.9.1
