From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] PM / devfreq: Remove unnecessary NULL check before kfree
Date: Sun, 12 Nov 2017 02:27:39 -0600
Message-ID: <20171112082739.GA20464@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: linux-pm@vger.kernel.org

NULL check before freeing functions like kfree is not needed.

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/devfreq/devfreq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 78fb496..21164a9 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -672,8 +672,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 
 	device_unregister(&devfreq->dev);
 err_dev:
-	if (devfreq)
-		kfree(devfreq);
+	kfree(devfreq);
 err_out:
 	return ERR_PTR(err);
 }
-- 
2.7.4
