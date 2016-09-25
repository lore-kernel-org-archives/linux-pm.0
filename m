From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] PM / devfreq: event: Remove unnecessary NULL test for to_devfreq_event(dev)
Date: Sun, 25 Sep 2016 20:16:28 +0800
Message-ID: <1474805788-30702-1-git-send-email-axel.lin@ingics.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
List-Id: linux-pm@vger.kernel.org

to_devfreq_event(dev) never returns NULL.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/devfreq/devfreq-event.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
index 9aea2c7..d0ae087 100644
--- a/drivers/devfreq/devfreq-event.c
+++ b/drivers/devfreq/devfreq-event.c
@@ -442,7 +442,7 @@ static ssize_t name_show(struct device *dev, struct device_attribute *attr,
 {
 	struct devfreq_event_dev *edev = to_devfreq_event(dev);
 
-	if (!edev || !edev->desc)
+	if (!edev->desc)
 		return -EINVAL;
 
 	return sprintf(buf, "%s\n", edev->desc->name);
@@ -454,7 +454,7 @@ static ssize_t enable_count_show(struct device *dev,
 {
 	struct devfreq_event_dev *edev = to_devfreq_event(dev);
 
-	if (!edev || !edev->desc)
+	if (!edev->desc)
 		return -EINVAL;
 
 	return sprintf(buf, "%d\n", edev->enable_count);
-- 
2.7.4
