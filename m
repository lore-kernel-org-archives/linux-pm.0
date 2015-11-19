From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 2/6] PM / devfreq: event: Fix the error and warning from
 script/checkpatch.pl
Date: Thu, 19 Nov 2015 17:17:46 +0900
Message-ID: <1447921070-6045-3-git-send-email-cw00.choi@samsung.com>
References: <1447921070-6045-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1447921070-6045-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch just fixes following error and warning by using
scripts/checkpatch.pl.

- Follwoing issue from checkpatch.pl:
ERROR: space prohibited before that close parenthesis ')'
+	if (count < 0 ) {

WARNING: line over 80 characters
+	ptr = devres_alloc(devm_devfreq_event_release, sizeof(*ptr), GFP_KERNEL);

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq-event.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
index f51de879b2be..38bf144ca147 100644
--- a/drivers/devfreq/devfreq-event.c
+++ b/drivers/devfreq/devfreq-event.c
@@ -270,7 +270,7 @@ int devfreq_event_get_edev_count(struct device *dev)
 
 	count = of_property_count_elems_of_size(dev->of_node, "devfreq-events",
 						sizeof(u32));
-	if (count < 0 ) {
+	if (count < 0) {
 		dev_err(dev,
 			"failed to get the count of devfreq-event in %s node\n",
 			dev->of_node->full_name);
@@ -395,7 +395,8 @@ struct devfreq_event_dev *devm_devfreq_event_add_edev(struct device *dev,
 {
 	struct devfreq_event_dev **ptr, *edev;
 
-	ptr = devres_alloc(devm_devfreq_event_release, sizeof(*ptr), GFP_KERNEL);
+	ptr = devres_alloc(devm_devfreq_event_release, sizeof(*ptr),
+				GFP_KERNEL);
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
 
-- 
1.9.1
