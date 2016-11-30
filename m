From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 2/3] dev_pm_qos: Fix writing 'auto' to pm_qos_latency_tolerance_us
Date: Tue, 29 Nov 2016 17:11:51 -0800
Message-ID: <b5c73b8578e8b38a8bad849a1c670c773ba7ed7c.1480468027.git.luto@kernel.org>
References: <cover.1480468027.git.luto@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1480468027.git.luto@kernel.org>
In-Reply-To: <cover.1480468027.git.luto@kernel.org>
References: <cover.1480468027.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Andy Lutomirski <luto@kernel.org>
List-Id: linux-pm@vger.kernel.org

If it was already 'auto', then writing 'auto' again would
incorrectly fail.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/base/power/qos.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index 7f3646e459cb..6a1f2c7e01ea 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -856,7 +856,10 @@ int dev_pm_qos_update_user_latency_tolerance(struct device *dev, s32 val)
 		struct dev_pm_qos_request *req;
 
 		if (val < 0) {
-			ret = -EINVAL;
+			if (val == PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT)
+				ret = 0;
+			else
+				ret = -EINVAL;
 			goto out;
 		}
 		req = kzalloc(sizeof(*req), GFP_KERNEL);
-- 
2.9.3
