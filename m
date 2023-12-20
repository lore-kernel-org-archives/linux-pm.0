Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE674AF63;
	Wed, 20 Dec 2023 23:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2CFC1515;
	Wed, 20 Dec 2023 15:17:41 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.82.217])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 737A03F64C;
	Wed, 20 Dec 2023 15:16:55 -0800 (PST)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Subject: [PATCH v3 2/9] thermal: gov_power_allocator: Refactor check_power_actors()
Date: Wed, 20 Dec 2023 23:17:46 +0000
Message-Id: <20231220231753.1824364-3-lukasz.luba@arm.com>
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

In preparation for a subsequent change, rearrange check_power_actors().

No intentional functional impact.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/gov_power_allocator.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 785fff14223d..d9175d9f5e3f 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -581,8 +581,9 @@ static void allow_maximum_power(struct thermal_zone_device *tz, bool update)
  * power actor API. The warning should help to investigate the issue, which
  * could be e.g. lack of Energy Model for a given device.
  *
- * Return: 0 on success, -EINVAL if any cooling device does not implement
- * the power actor API.
+ * If all of the cooling devices currently attached to @tz implement the power
+ * actor API, return the number of them (which may be 0, because some cooling
+ * devices may be attached later). Otherwise, return -EINVAL.
  */
 static int check_power_actors(struct thermal_zone_device *tz,
 			      struct power_allocator_params *params)
@@ -597,8 +598,9 @@ static int check_power_actors(struct thermal_zone_device *tz,
 		if (!cdev_is_power_actor(instance->cdev)) {
 			dev_warn(&tz->device, "power_allocator: %s is not a power actor\n",
 				 instance->cdev->type);
-			ret = -EINVAL;
+			return -EINVAL;
 		}
+		ret++;
 	}
 
 	return ret;
@@ -631,7 +633,7 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 	}
 
 	ret = check_power_actors(tz, params);
-	if (ret) {
+	if (ret < 0) {
 		dev_warn(&tz->device, "power_allocator: binding failed\n");
 		kfree(params);
 		return ret;
-- 
2.25.1

