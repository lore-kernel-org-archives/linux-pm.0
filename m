Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED0F4CB2C;
	Wed, 20 Dec 2023 23:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D1922F4;
	Wed, 20 Dec 2023 15:17:49 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.82.217])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D87BB3F64C;
	Wed, 20 Dec 2023 15:17:02 -0800 (PST)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Subject: [PATCH v3 7/9] thermal/sysfs: Update instance->weight under tz lock
Date: Wed, 20 Dec 2023 23:17:51 +0000
Message-Id: <20231220231753.1824364-8-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231220231753.1824364-1-lukasz.luba@arm.com>
References: <20231220231753.1824364-1-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

User space can change the weight of a thermal instance via sysfs while the
.throttle() callback is running for a governor, because weight_store()
does not use the zone lock.

The IPA governor uses instance weight values for power calculations and
caches the sum of them as total_weight, so it gets confused when one of
them changes while its .throttle() callback is running.

To prevent that from happening, use thermal zone locking in
weight_store().

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/thermal_sysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index d8ff74a4338a..299c0fb16593 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -936,7 +936,11 @@ ssize_t weight_store(struct device *dev, struct device_attribute *attr,
 		return ret;
 
 	instance = container_of(attr, struct thermal_instance, weight_attr);
+
+	/* Don't race with governors using the 'weight' value */
+	mutex_lock(&instance->tz->lock);
 	instance->weight = weight;
+	mutex_unlock(&instance->tz->lock);
 
 	return count;
 }
-- 
2.25.1

