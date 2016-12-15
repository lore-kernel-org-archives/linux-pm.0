From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 2/3] PM / devfreq: Fix the bug of devfreq_add_device when
 governor is NULL
Date: Thu, 15 Dec 2016 18:30:37 +0900
Message-ID: <1481794238-5005-3-git-send-email-cw00.choi@samsung.com>
References: <1481794238-5005-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1481794238-5005-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: rjw@rjwysocki.net, chanwoo@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch fixes the bug of devfreq_add_device(). The devfreq device must
have the default governor. If find_devfreq_governor() returns error,
devfreq_add_device() fail to add the devfreq instance.

Fixes: 1b5c1be2c88e ("PM / devfreq: map devfreq drivers to governor using name")
Cc: stable@vger.kernel.org
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index a324801d6a66..47206a21bb90 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -593,11 +593,16 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	list_add(&devfreq->node, &devfreq_list);
 
 	governor = find_devfreq_governor(devfreq->governor_name);
-	if (!IS_ERR(governor))
-		devfreq->governor = governor;
-	if (devfreq->governor)
-		err = devfreq->governor->event_handler(devfreq,
-					DEVFREQ_GOV_START, NULL);
+	if (IS_ERR(governor)) {
+		dev_err(dev, "%s: Unable to find governor for the device\n",
+			__func__);
+		err = PTR_ERR(governor);
+		goto err_init;
+	}
+
+	devfreq->governor = governor;
+	err = devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_START,
+						NULL);
 	if (err) {
 		dev_err(dev, "%s: Unable to start governor for the device\n",
 			__func__);
-- 
1.9.1
