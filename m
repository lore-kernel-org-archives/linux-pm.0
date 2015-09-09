From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] PM / wakeup: wakeup_source_create: use kstrdup_const
Date: Wed,  9 Sep 2015 23:42:06 +0200
Message-ID: <1441834926-14121-1-git-send-email-linux@rasmusvillemoes.dk>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:33323 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862AbbIIVmS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Sep 2015 17:42:18 -0400
Received: by lbcjc2 with SMTP id jc2so13267438lbc.0
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2015 14:42:16 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Using kstrdup_const allows us to save a little runtime memory (and a
string copy) in the common case where name is a string literal.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/base/power/wakeup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 51f15bc15774..332e607e0030 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -91,7 +91,7 @@ struct wakeup_source *wakeup_source_create(const char *name)
 	if (!ws)
 		return NULL;
 
-	wakeup_source_prepare(ws, name ? kstrdup(name, GFP_KERNEL) : NULL);
+	wakeup_source_prepare(ws, name ? kstrdup_const(name, GFP_KERNEL) : NULL);
 	return ws;
 }
 EXPORT_SYMBOL_GPL(wakeup_source_create);
@@ -154,7 +154,7 @@ void wakeup_source_destroy(struct wakeup_source *ws)
 
 	wakeup_source_drop(ws);
 	wakeup_source_record(ws);
-	kfree(ws->name);
+	kfree_const(ws->name);
 	kfree(ws);
 }
 EXPORT_SYMBOL_GPL(wakeup_source_destroy);
-- 
2.1.3

