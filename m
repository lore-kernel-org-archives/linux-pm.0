From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 1/3] dev_pm_qos: Improve sysfs pm_qos_latency_tolerance validation
Date: Tue, 29 Nov 2016 17:11:50 -0800
Message-ID: <9f642daf2787251258336c4ce93b1d3090afd590.1480468027.git.luto@kernel.org>
References: <cover.1480468027.git.luto@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1480468027.git.luto@kernel.org>
In-Reply-To: <cover.1480468027.git.luto@kernel.org>
References: <cover.1480468027.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Andy Lutomirski <luto@kernel.org>
List-Id: linux-pm@vger.kernel.org

Negative values are special.  Don't let users write them directly.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/base/power/sysfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index a7b46798c81d..33b4b902741a 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -263,7 +263,11 @@ static ssize_t pm_qos_latency_tolerance_store(struct device *dev,
 	s32 value;
 	int ret;
 
-	if (kstrtos32(buf, 0, &value)) {
+	if (kstrtos32(buf, 0, &value) == 0) {
+		/* Users can't write negative values directly */
+		if (value < 0)
+			return -EINVAL;
+	} else {
 		if (!strcmp(buf, "auto") || !strcmp(buf, "auto\n"))
 			value = PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT;
 		else if (!strcmp(buf, "any") || !strcmp(buf, "any\n"))
-- 
2.9.3
