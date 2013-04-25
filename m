From: liguang <lig.fnst@cn.fujitsu.com>
Subject: [PATCH] drivers: idle: comment DEBUG
Date: Thu, 25 Apr 2013 15:00:27 +0800
Message-ID: <1366873227-920-1-git-send-email-lig.fnst@cn.fujitsu.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:32297 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753207Ab3DYHCn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 25 Apr 2013 03:02:43 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, liguang <lig.fnst@cn.fujitsu.com>

seems we should comment DEBUG as above comment said:
"/* un-comment DEBUG to enable pr_debug() statements */"

now, pr_debug is already enabled as DEBUG been defined.

Signed-off-by: liguang <lig.fnst@cn.fujitsu.com>
---
 drivers/idle/intel_idle.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 5d66750..9618586 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -51,7 +51,7 @@
  */
 
 /* un-comment DEBUG to enable pr_debug() statements */
-#define DEBUG
+/* #define DEBUG */
 
 #include <linux/kernel.h>
 #include <linux/cpuidle.h>
-- 
1.7.2.5

