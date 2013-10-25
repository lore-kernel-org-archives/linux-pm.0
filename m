From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] devfreq: fix return value check in devfreq_init()
Date: Fri, 25 Oct 2013 21:52:16 +0800
Message-ID: <CAPgLHd9J4LL9SvxN1FeibN-gaCsoFu6o=PSGZDnzS4Ha1yN69w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ee0-f48.google.com ([74.125.83.48]:64404 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753949Ab3JYNwS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Oct 2013 09:52:18 -0400
Received: by mail-ee0-f48.google.com with SMTP id e50so1973318eek.35
        for <linux-pm@vger.kernel.org>; Fri, 25 Oct 2013 06:52:17 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: yongjun_wei@trendmicro.com.cn, linux-pm@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function create_freezable_workqueue() returns
NULL pointer not ERR_PTR(). The IS_ERR() test in the return value check
should be replaced with NULL test.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/devfreq/devfreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index c99c00d..22e5d2f 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -993,10 +993,10 @@ static int __init devfreq_init(void)
 	}
 
 	devfreq_wq = create_freezable_workqueue("devfreq_wq");
-	if (IS_ERR(devfreq_wq)) {
+	if (!devfreq_wq) {
 		class_destroy(devfreq_class);
 		pr_err("%s: couldn't create workqueue\n", __FILE__);
-		return PTR_ERR(devfreq_wq);
+		return -ENOMEM;
 	}
 	devfreq_class->dev_groups = devfreq_groups;
 

