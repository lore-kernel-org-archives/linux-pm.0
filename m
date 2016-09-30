From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: [PATCH] coredump: fix unfreezable coredumping task
Date: Fri, 30 Sep 2016 11:50:34 +0300
Message-ID: <1475225434-3753-1-git-send-email-aryabinin@virtuozzo.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-db5eur01on0058.outbound.protection.outlook.com ([104.47.2.58]:56761
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751099AbcI3LYU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 30 Sep 2016 07:24:20 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexander Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Oleg Nesterov <oleg@redhat.com>
Cc: linux-pm@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Andrey Ryabinin <aryabinin@virtuozzo.com>, stable@vger.kernel.org

It could be not possible to freeze coredumping task when it waits
for 'core_state->startup' completion, because threads are frozen
in get_signal() before they got a chance to complete 'core_state->startup'.

Use freezer_do_not_count() to tell freezer to ignore coredumping
task while it waits for core_state->startup completion.

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: stable@vger.kernel.org
---
 fs/coredump.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index 281b768..eb9c92c 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1,6 +1,7 @@
 #include <linux/slab.h>
 #include <linux/file.h>
 #include <linux/fdtable.h>
+#include <linux/freezer.h>
 #include <linux/mm.h>
 #include <linux/stat.h>
 #include <linux/fcntl.h>
@@ -423,7 +424,9 @@ static int coredump_wait(int exit_code, struct core_state *core_state)
 	if (core_waiters > 0) {
 		struct core_thread *ptr;
 
+		freezer_do_not_count();
 		wait_for_completion(&core_state->startup);
+		freezer_count();
 		/*
 		 * Wait for all the threads to become inactive, so that
 		 * all the thread context (extended register state, like
-- 
2.7.3

