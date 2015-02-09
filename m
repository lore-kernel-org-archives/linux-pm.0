From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH 1/2] ab8500_fg: match return type of  wait_for_completion_timeout
Date: Mon,  9 Feb 2015 12:20:45 -0500
Message-ID: <1423502445-31264-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.osadl.org ([62.245.132.105]:44242 "EHLO www.osadl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932308AbbBIRZ1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 9 Feb 2015 12:25:27 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>

return type of wait_for_completion_timeout is unsigned long not int. as
timeout is used for wait_for_completion_timeout exclusively here its
type is simply changed to unsigned long.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Patch was only compile tested with u8500_defconfig + CONFIG_AB8500_BM=y

Patch is against 3.19.0-rc7 (localversion-next is -next-20150209)

 drivers/power/ab8500_fg.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/ab8500_fg.c b/drivers/power/ab8500_fg.c
index c908658..eee4493 100644
--- a/drivers/power/ab8500_fg.c
+++ b/drivers/power/ab8500_fg.c
@@ -622,7 +622,7 @@ int ab8500_fg_inst_curr_finalize(struct ab8500_fg *di, int *res)
 	u8 low, high;
 	int val;
 	int ret;
-	int timeout;
+	unsigned long timeout;
 
 	if (!completion_done(&di->ab8500_fg_complete)) {
 		timeout = wait_for_completion_timeout(
@@ -716,7 +716,7 @@ fail:
 int ab8500_fg_inst_curr_blocking(struct ab8500_fg *di)
 {
 	int ret;
-	int timeout;
+	unsigned long timeout;
 	int res = 0;
 
 	ret = ab8500_fg_inst_curr_start(di);
-- 
1.7.10.4

