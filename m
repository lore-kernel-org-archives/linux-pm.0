From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 1/2] PM / devfreq: rk3399_dmc: Use the resource-managed
 function to add devfreq dev
Date: Wed, 26 Oct 2016 16:35:49 +0900
Message-ID: <1477467350-27059-2-git-send-email-cw00.choi@samsung.com>
References: <1477467350-27059-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1477467350-27059-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch uses the resource-managed to add the devfreq device.
This function will make it easy to handle the devfreq device.

- struct devfreq *devm_devfreq_add_device(struct device *dev,
				  struct devfreq_dev_profile *profile,
				  const char *governor_name,
				  void *data);

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/rk3399_dmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index e24b73d66659..3f8f4381cd4a 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -436,7 +436,7 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 
 	rk3399_devfreq_dmc_profile.initial_freq = data->rate;
 
-	data->devfreq = devfreq_add_device(dev,
+	data->devfreq = devm_devfreq_add_device(dev,
 					   &rk3399_devfreq_dmc_profile,
 					   "simple_ondemand",
 					   &data->ondemand_data);
-- 
1.9.1
