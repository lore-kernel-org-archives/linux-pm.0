Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D5ED138;
	Tue, 12 Dec 2023 05:48:07 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C852143D;
	Tue, 12 Dec 2023 05:48:53 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.82.227])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CD9863F738;
	Tue, 12 Dec 2023 05:48:05 -0800 (PST)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Subject: [PATCH v2 7/8] thermal/sysfs: Update governors when the 'weight' has changed
Date: Tue, 12 Dec 2023 13:48:43 +0000
Message-Id: <20231212134844.1213381-8-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231212134844.1213381-1-lukasz.luba@arm.com>
References: <20231212134844.1213381-1-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support governors update when the thermal instance's weight has changed.
This allows to adjust internal state for the governor.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/thermal_sysfs.c | 9 +++++++++
 include/linux/thermal.h         | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index df85df7d4a88..9afa2e2b76b9 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -957,6 +957,14 @@ weight_show(struct device *dev, struct device_attribute *attr, char *buf)
 	return sprintf(buf, "%d\n", instance->weight);
 }
 
+static void handle_weight_update(struct thermal_zone_device *tz)
+{
+	if (!tz->governor || !tz->governor->update_tz)
+		return;
+
+	tz->governor->update_tz(tz, THERMAL_INSTANCE_WEIGHT_UPDATE);
+}
+
 ssize_t weight_store(struct device *dev, struct device_attribute *attr,
 		     const char *buf, size_t count)
 {
@@ -974,6 +982,7 @@ ssize_t weight_store(struct device *dev, struct device_attribute *attr,
 	/* Don't race with governors using the 'weight' value */
 	mutex_lock(&tz->lock);
 	instance->weight = weight;
+	handle_weight_update(tz);
 	mutex_unlock(&tz->lock);
 
 	return count;
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 9fd0d3fb234a..24176f075fbf 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -52,6 +52,7 @@ enum thermal_notify_event {
 	THERMAL_TABLE_CHANGED, /* Thermal table(s) changed */
 	THERMAL_EVENT_KEEP_ALIVE, /* Request for user space handler to respond */
 	THERMAL_INSTANCE_LIST_UPDATE, /* List of thermal instances changed */
+	THERMAL_INSTANCE_WEIGHT_UPDATE, /* Thermal instance weight changed */
 };
 
 /**
-- 
2.25.1

