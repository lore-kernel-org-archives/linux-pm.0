From: "Alex A. Mihaylov" <minimumlaw@rambler.ru>
Subject: [PATCH 4/4] Fix W1 slave exchange with second device on probe step
Date: Thu, 25 May 2017 20:47:21 +0300
Message-ID: <20170525174721.3245-5-minimumlaw@rambler.ru>
References: <20170525174639.3191-1-minimumlaw@rambler.ru>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from huan4.mail.rambler.ru ([81.19.78.110]:59018 "EHLO
        huan4.mail.rambler.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S970064AbdEYRrf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 May 2017 13:47:35 -0400
In-Reply-To: <20170525174639.3191-1-minimumlaw@rambler.ru>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Evgeniy Polyakov <zbr@ioremap.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: "Alex A. Mihaylov" <minimumlaw@rambler.ru>

Signed-off-by: Alex A. Mihaylov <minimumlaw@rambler.ru>
---
 drivers/w1/w1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index 90a3d93..5b8b976 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -731,6 +731,7 @@ int w1_attach_slave_device(struct w1_master *dev, struct w1_reg_num *rn)
 	memcpy(&sl->reg_num, rn, sizeof(sl->reg_num));
 	atomic_set(&sl->refcnt, 1);
 	atomic_inc(&sl->master->refcnt);
+	dev->slave_count++;
 
 	/* slave modules need to be loaded in a context with unlocked mutex */
 	mutex_unlock(&dev->mutex);
@@ -750,11 +751,11 @@ int w1_attach_slave_device(struct w1_master *dev, struct w1_reg_num *rn)
 
 	sl->family = f;
 
-
 	err = __w1_attach_slave_device(sl);
 	if (err < 0) {
 		dev_err(&dev->dev, "%s: Attaching %s failed.\n", __func__,
 			 sl->name);
+		dev->slave_count--;
 		w1_family_put(sl->family);
 		atomic_dec(&sl->master->refcnt);
 		kfree(sl);
@@ -762,7 +763,6 @@ int w1_attach_slave_device(struct w1_master *dev, struct w1_reg_num *rn)
 	}
 
 	sl->ttl = dev->slave_ttl;
-	dev->slave_count++;
 
 	memcpy(msg.id.id, rn, sizeof(msg.id));
 	msg.type = W1_SLAVE_ADD;
-- 
2.8.4 (Apple Git-73)
