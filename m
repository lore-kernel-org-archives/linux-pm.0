From: Philippe Loctaux <phil@philippeloctaux.com>
Subject: [PATCH] Kernel: Power: main.c: Cleaned up a comment block
Date: Mon,  7 Mar 2016 11:09:15 +0100
Message-ID: <1457345355-20102-1-git-send-email-phil@philippeloctaux.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from 7.mo2.mail-out.ovh.net ([188.165.48.182]:55989 "EHLO
	7.mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273AbcCGK0K (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Mar 2016 05:26:10 -0500
Received: from mail605.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo2.mail-out.ovh.net (Postfix) with SMTP id 5FE15100097E
	for <linux-pm@vger.kernel.org>; Mon,  7 Mar 2016 11:09:55 +0100 (CET)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Philippe Loctaux <phil@philippeloctaux.com>

Removed a * in the beginning of the block, and removed an unnecessary space.

Signed-off-by: Philippe Loctaux <phil@philippeloctaux.com>
---
 kernel/power/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index 2794697..d7386cb 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -288,11 +288,11 @@ static inline void pm_print_times_init(void) {}
 
 struct kobject *power_kobj;
 
-/**
+/*
  * state - control system sleep states.
  *
  * show() returns available sleep state labels, which may be "mem", "standby",
- * "freeze" and "disk" (hibernation).  See Documentation/power/states.txt for a
+ * "freeze" and "disk" (hibernation). See Documentation/power/states.txt for a
  * description of what they mean.
  *
  * store() accepts one of those strings, translates it into the proper
-- 
2.7.2

