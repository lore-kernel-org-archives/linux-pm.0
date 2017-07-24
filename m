From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC][PATCH] thunderbolt: icm: Ignore mailbox errors in icm_suspend()
Date: Tue, 25 Jul 2017 01:31 +0200
Message-ID: <4063610.TqANq0McE8@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:45661 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753330AbdGXXi5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jul 2017 19:38:57 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Andreas Noever <andreas.noever@gmail.com>, Michael Jamet <michael.jamet@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

On one of my test machines nhi_mailbox_cmd() called from icm_suspend()
times out and returnes an error which then is propagated to the
caller and causes the entire system suspend to be aborted which isn't
very useful.

Instead of aborting system suspend, print the error into the log
and continue.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thunderbolt/icm.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/thunderbolt/icm.c
===================================================================
--- linux-pm.orig/drivers/thunderbolt/icm.c
+++ linux-pm/drivers/thunderbolt/icm.c
@@ -904,7 +904,14 @@ static int icm_driver_ready(struct tb *t
 
 static int icm_suspend(struct tb *tb)
 {
-	return nhi_mailbox_cmd(tb->nhi, NHI_MAILBOX_SAVE_DEVS, 0);
+	int ret;
+
+	ret = nhi_mailbox_cmd(tb->nhi, NHI_MAILBOX_SAVE_DEVS, 0);
+	if (ret)
+		tb_info(tb, "Ignoring mailbox command error (%d) in %s\n",
+			ret, __func__);
+
+	return 0;
 }
 
 /*
