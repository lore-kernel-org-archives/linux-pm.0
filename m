From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 3/3] PM / devfreq: fix mem leak in devfreq_add_device()
Date: Sat, 19 Jan 2019 11:04:54 -0500
Message-ID: <20190119160454.23151-3-tiny.windzz@gmail.com>
References: <20190119160454.23151-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190119160454.23151-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-pm@vger.kernel.org

'devfreq' is malloced in devfreq_add_device() and should be freed in
the error handling cases, otherwise it will cause memory leak.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/devfreq/devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 923889229a0b..fe6c157cb7e0 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -651,7 +651,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		mutex_unlock(&devfreq->lock);
 		err = set_freq_table(devfreq);
 		if (err < 0)
-			goto err_out;
+			goto err_dev;
 		mutex_lock(&devfreq->lock);
 	}
 
-- 
2.17.0
