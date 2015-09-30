From: Geliang Tang <geliangtang@163.com>
Subject: [PATCH] PM/hibernate: fix a comment typo
Date: Tue, 29 Sep 2015 20:36:58 -0700
Message-ID: <48afe60c70d67dfb4f8f832f5c634a5f179417b5.1443612115.git.geliangtang@163.com>
References: <4fb037c2ae2e494be58dc752483fb2f852a4cd70.1443612355.git.geliangtang@163.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from m12-18.163.com ([220.181.12.18]:52693 "EHLO m12-18.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752751AbbI3Dh5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 29 Sep 2015 23:37:57 -0400
In-Reply-To: <4fb037c2ae2e494be58dc752483fb2f852a4cd70.1443612355.git.geliangtang@163.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc: Geliang Tang <geliangtang@163.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Just fix a typo in a function name in kerneldoc comments.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 kernel/power/hibernate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 690f78f..b7342a2 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -733,7 +733,7 @@ int hibernate(void)
  * contents of memory is restored from the saved image.
  *
  * If this is successful, control reappears in the restored target kernel in
- * hibernation_snaphot() which returns to hibernate().  Otherwise, the routine
+ * hibernation_snapshot() which returns to hibernate().  Otherwise, the routine
  * attempts to recover gracefully and make the kernel return to the normal mode
  * of operation.
  */
-- 
1.9.1


