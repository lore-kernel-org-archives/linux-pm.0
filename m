Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id DED3D10A;
	Tue, 12 Dec 2023 05:48:05 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5D211474;
	Tue, 12 Dec 2023 05:48:51 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.82.227])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 62F0E3F738;
	Tue, 12 Dec 2023 05:48:04 -0800 (PST)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Subject: [PATCH v2 6/8] thermal/sysfs: Update instance->weight under tz lock
Date: Tue, 12 Dec 2023 13:48:42 +0000
Message-Id: <20231212134844.1213381-7-lukasz.luba@arm.com>
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

The user-space can change thermal instance weight value while the
throtte() callback is running for a governor. The IPA governor uses the
'weight' value for power calculation and also keeps it in 'total_weight'.
Therefore, the 'weight' value must not change during the throttle()
callback. Use 'tz->lock' mutex which also guards the throttle() to make
the update value safe.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/thermal_sysfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index eef40d4f3063..df85df7d4a88 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -961,6 +961,7 @@ ssize_t weight_store(struct device *dev, struct device_attribute *attr,
 		     const char *buf, size_t count)
 {
 	struct thermal_instance *instance;
+	struct thermal_zone_device *tz;
 	int ret, weight;
 
 	ret = kstrtoint(buf, 0, &weight);
@@ -968,7 +969,12 @@ ssize_t weight_store(struct device *dev, struct device_attribute *attr,
 		return ret;
 
 	instance = container_of(attr, struct thermal_instance, weight_attr);
+	tz = instance->tz;
+
+	/* Don't race with governors using the 'weight' value */
+	mutex_lock(&tz->lock);
 	instance->weight = weight;
+	mutex_unlock(&tz->lock);
 
 	return count;
 }
-- 
2.25.1

