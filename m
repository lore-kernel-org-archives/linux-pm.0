From: Sriram Dash <dash.sriram@gmail.com>
Subject: [PATCH 4/4] base: power: runtime.c: Fixed a typo error
Date: Wed, 27 May 2015 00:13:47 +0530
Message-ID: <1432665827-24786-1-git-send-email-dash.sriram@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33640 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542AbbEZSn5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 May 2015 14:43:57 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, trivial@kernel.org, dashsriram <dash.sriram@gmail.com>

From: dashsriram <dash.sriram@gmail.com>

Fixed a typo error in the file

Signed-off-by: Sriram Dash <dash.sriram@gmail.com>
---
 drivers/base/power/runtime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 5070c4f..7597741 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -178,7 +178,7 @@ static int dev_memalloc_noio(struct device *dev, void *data)
  *     resume/suspend callback of any one of its ancestors(or the
  *     block device itself), the deadlock may be triggered inside the
  *     memory allocation since it might not complete until the block
- *     device becomes active and the involed page I/O finishes. The
+ *     device becomes active and the invoked page I/O finishes. The
  *     situation is pointed out first by Alan Stern. Network device
  *     are involved in iSCSI kind of situation.
  *
-- 
2.4.1

