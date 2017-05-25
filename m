From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] PM / clock_ops: Delete an error message for a failed memory
 allocation in __pm_clk_add()
Date: Thu, 25 May 2017 21:35:24 +0200
Message-ID: <7665c16b-5f76-731b-abd0-476f8d90dd59@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 25 May 2017 21:28:10 +0200

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/base/power/clock_ops.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index 8e2e4757adcb..aa25ef4e6e5a 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -88,8 +88,6 @@ static int __pm_clk_add(struct device *dev, const char *con_id,
 	if (con_id) {
 		ce->con_id = kstrdup(con_id, GFP_KERNEL);
 		if (!ce->con_id) {
-			dev_err(dev,
-				"Not enough memory for clock connection ID.\n");
 			kfree(ce);
 			return -ENOMEM;
 		}
-- 
2.13.0
