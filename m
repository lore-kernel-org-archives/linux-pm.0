Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793747456;
	b=YwVFs1/7gy75E3crjMqhZFTSr/osLFsp18Bx0TtdS1y4GFxsplWFAS426TWlJ0qZzxhk
	 nZ3WydN7EuojtQ/OyCEa8NaXyw+LzV2V+GiLo+JxsKYxVbMT55J1w5YTcK8NVVyft6g7R
	 OFkNmmyZjBegg/aMXnmM0N4noNJTEVr37HfzfouiMXtL7aal/lYV2Ia1SwjcBAx0qSgZ9
	 0q8WIPQmOlUkzYEnVrN64/jKD9cdHntNj1G8Gj8yZex0vq1L/+jwWGxdIN6/bV23sIktQ
	 5htQIQoXiYUuU6LaxWB5NbeCHGXqcHHouW5hDIxOebAo0Wjf1xFtwcs4XerRVt9gBww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793747456;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=x+kZO4Tay9C0jJ+yb9iRj8DvxcoFl6IXR//TaaRaP+o=;
	b=KJNEND57xCBD5sQ40moGHsOrTiKah1as2SqOl4ts0k4aGo9Av1T5JfyFCWJMAsWL2FTD
	 vZApyyeqEl9joo94EsAb8YoXbC663wR4Udbv4c205SFyLIWGYl7182nymmNzBE7d+Fq1e
	 AIClEZRD+ZwZXj3WZeF63INacplT0WRVMca3g/7hrLfg5UQPI7Cj6B4uvivqY5MJFmnPU
	 XeXmdCuIYLti+3kQ46GJVV3gj3gTkwESxHWX6Sif/FPfvB6yBVMzXfXY2O4V23iG/zymz
	 TnVgRDOsEE/QOih8tQzVaiCwZXJMCq6bwPeVshKDmXlOkfn0wyG1QlKGbVWsr73mtlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=vNE0jBNW;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6FD606A326;
	Tue,  3 Nov 2026 23:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B6FD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=vNE0jBNW
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 510A61C2B;
	Tue,  3 Nov 2026 15:10:52 -0800 (PST)
Received: from e121740.manchester.arm.com (e121740.arm.com [10.33.8.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C11E63F673;
	Tue,  3 Nov 2026 15:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793747455; bh=qL14ZGnAna0yMQHapqWrG1chaA1r6QN1jqER4BCEjvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vNE0jBNWWL2HG7DfYF+KEMZnSAiTjgjD0jNYqsN+6EKeZpLtuGhV+AbqgFsh1KaqK
	 Rylb6B5ngOEs9dvZ2f/fZV96f00DupCN0TXAiNyYs92UpLocI9sSTLjrk/YlS9W6wP
	 MacCUTjfdDLm4tlXcqwcwCsVbCmw9RNWf3o6EikY=
From: Philip Radford <philip.radford@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: sudeep.holla@arm.com,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	etienne.carriere@st.com,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	quic_sibis@quicinc.com,
	dan.carpenter@linaro.org,
	d-gole@ti.com,
	souvik.chakravarty@arm.com,
	Philip Radford <philip.radford@arm.com>
Subject: [PATCH v10 11/13] powercap: arm_scmi: Create synthetic parent node for multi-instance
Date: Tue,  3 Nov 2026 23:10:05 +0000
Message-Id: <20261103231007.537082-12-philip.radford@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103231007.537082-1-philip.radford@arm.com>
References: <20261103231007.537082-1-philip.radford@arm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An SCMI powercap instance may expose a hierarchy of domains, or even a
forest of multiple domain trees rooted at SCMI_POWERCAP_ROOT_ZONE_ID.
Those hierarchies are valid within the namespace of a single SCMI instance.

Currently, the powercap framework has no notion of SCMI instances. If root
domains from multiple SCMI instances are registered directly under the same
Linux powercap control type, the per-instance boundaries are lost and the
resulting Linux hierarchy becomes a merge of otherwise independent SCMI
topologies.

Add a synthetic top-level powercap zone per SCMI instance and register that
instance's SCMI root domains beneath it. This keeps each instance's SCMI
hierarchy grouped together.

Signed-off-by: Philip Radford <philip.radford@arm.com>
---
 drivers/powercap/arm_scmi_powercap.c | 110 +++++++++++++++++++++++----
 1 file changed, 96 insertions(+), 14 deletions(-)

diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
index 0c2a20f06979..88003564581e 100644
--- a/drivers/powercap/arm_scmi_powercap.c
+++ b/drivers/powercap/arm_scmi_powercap.c
@@ -38,6 +38,7 @@ struct scmi_powercap_root {
 	struct scmi_powercap_zone *spzones;
 	struct list_head *registered_zones;
 	struct list_head scmi_zones;
+	struct scmi_powercap_zone instance_root;
 };
 
 static LIST_HEAD(scmi_powercap_roots);
@@ -421,29 +422,75 @@ static const struct powercap_zone_constraint_ops constraint_ops  = {
 	.get_name = scmi_powercap_get_name,
 };
 
+/*
+ * Multi-instance constraints to meet driver requrements due to the fact
+ * that full zone semantics aren't available for the synthetic zone.
+ */
+static int instance_root_release(struct powercap_zone *pz)
+{
+	return 0;
+}
+
+static int instance_root_get_power_uw(struct powercap_zone *pz, u64 *v)
+{
+	*v = 0;
+	return 0;
+}
+
+static int instance_root_set_constraint(struct powercap_zone *pz, int cid, u64 v)
+{
+	return -EOPNOTSUPP;
+}
+
+static int instance_root_get_constraint(struct powercap_zone *pz, int cid, u64 *v)
+{
+	return -EOPNOTSUPP;
+}
+
+static const struct powercap_zone_ops instance_root_ops = {
+	.get_max_power_range_uw = scmi_powercap_get_max_power_range_uw,
+	.get_power_uw = instance_root_get_power_uw,
+	.release = instance_root_release,
+};
+
+static const struct powercap_zone_constraint_ops instance_root_const_ops = {
+	.set_power_limit_uw = instance_root_set_constraint,
+	.get_power_limit_uw = instance_root_get_constraint,
+	.set_time_window_us = instance_root_set_constraint,
+	.get_time_window_us = instance_root_get_constraint,
+};
+
 static void scmi_powercap_unregister_all_zones(struct scmi_powercap_root *pr)
 {
 	int i;
 
 	/* Un-register children zones first starting from the leaves */
-	for (i = pr->num_zones - 1; i >= 0; i--) {
+	for (i = pr->num_zones; i >= 0; i--) {
 		if (!list_empty(&pr->registered_zones[i])) {
 			struct scmi_powercap_zone *spz;
 
-			list_for_each_entry(spz, &pr->registered_zones[i], node)
+			list_for_each_entry(spz, &pr->registered_zones[i], node) {
+				if (!spz->registered)
+					continue;
+
+				spz->registered = false;
 				powercap_unregister_zone(scmi_top_pcntrl,
 							 &spz->zone);
+			}
 		}
 	}
 }
 
-static inline unsigned int
-scmi_powercap_get_zone_height(struct scmi_powercap_zone *spz)
+static const char *scmi_powercap_parent_name(struct scmi_powercap_root *pr,
+					     struct scmi_powercap_zone *parent)
 {
-	if (spz->info->parent_id == SCMI_POWERCAP_ROOT_ZONE_ID)
-		return 0;
+	if (!parent)
+		return "ROOT";
 
-	return spz->spzones[spz->info->parent_id].height + 1;
+	if (parent == &pr->instance_root)
+		return "INSTANCE ROOT";
+
+	return parent->info->name;
 }
 
 static inline struct scmi_powercap_zone *
@@ -479,11 +526,14 @@ static int scmi_powercap_register_zone(struct scmi_powercap_root *pr,
 				   parent ? &parent->zone : NULL,
 				   &zone_ops, nr_constraints, &constraint_ops);
 	if (!IS_ERR(z)) {
-		spz->height = scmi_powercap_get_zone_height(spz);
+		if (parent)
+			spz->height = parent->height + 1;
+		else
+			spz->height = 0;
 		spz->registered = true;
 		list_move(&spz->node, &pr->registered_zones[spz->height]);
 		dev_dbg(spz->dev, "Registered node %s - parent %s - height:%d\n",
-			spz->info->name, parent ? parent->info->name : "ROOT",
+			spz->info->name, scmi_powercap_parent_name(pr, parent),
 			spz->height);
 	} else {
 		list_del(&spz->node);
@@ -491,7 +541,7 @@ static int scmi_powercap_register_zone(struct scmi_powercap_root *pr,
 		dev_err(spz->dev,
 			"Error registering node:%s - parent:%s - h:%d - ret:%d\n",
 			spz->info->name,
-			parent ? parent->info->name : "ROOT",
+			scmi_powercap_parent_name(pr, parent),
 			spz->height, ret);
 	}
 
@@ -550,6 +600,8 @@ static int scmi_zones_register(struct device *dev,
 		struct scmi_powercap_zone *parent;
 
 		parent = scmi_powercap_get_parent_zone(spz);
+		if (!parent)
+			parent = &pr->instance_root;
 		if (parent && !parent->registered) {
 			zones_stack[sp++] = spz;
 			spz = parent;
@@ -590,8 +642,11 @@ static int scmi_powercap_probe(struct scmi_device *sdev)
 	int ret, i;
 	struct scmi_powercap_root *pr;
 	struct scmi_powercap_zone *spz;
+	struct scmi_powercap_zone *ir;
 	struct scmi_protocol_handle *ph;
 	struct device *dev = &sdev->dev;
+	char *instance_name;
+	struct powercap_zone *z;
 
 	if (!sdev->handle)
 		return -ENODEV;
@@ -619,7 +674,7 @@ static int scmi_powercap_probe(struct scmi_device *sdev)
 		return -ENOMEM;
 
 	/* Allocate for worst possible scenario of maximum tree height. */
-	pr->registered_zones = devm_kcalloc(dev, pr->num_zones,
+	pr->registered_zones = devm_kcalloc(dev, pr->num_zones + 1,
 					    sizeof(*pr->registered_zones),
 					    GFP_KERNEL);
 	if (!pr->registered_zones)
@@ -627,6 +682,9 @@ static int scmi_powercap_probe(struct scmi_device *sdev)
 
 	INIT_LIST_HEAD(&pr->scmi_zones);
 
+	for (i = 0; i <= pr->num_zones; i++)
+		INIT_LIST_HEAD(&pr->registered_zones[i]);
+
 	for (i = 0, spz = pr->spzones; i < pr->num_zones; i++, spz++) {
 		/*
 		 * Powercap domains are validate by the protocol layer, i.e.
@@ -639,7 +697,6 @@ static int scmi_powercap_probe(struct scmi_device *sdev)
 		spz->ph = ph;
 		spz->spzones = pr->spzones;
 		INIT_LIST_HEAD(&spz->node);
-		INIT_LIST_HEAD(&pr->registered_zones[i]);
 
 		list_add_tail(&spz->node, &pr->scmi_zones);
 		/*
@@ -657,19 +714,44 @@ static int scmi_powercap_probe(struct scmi_device *sdev)
 		}
 	}
 
+	ir = &pr->instance_root;
+	ir->dev = dev;
+	INIT_LIST_HEAD(&ir->node);
+	instance_name = devm_kasprintf(dev, GFP_KERNEL, "instance_%s", dev_name(dev));
+	if (!instance_name)
+		return -ENOMEM;
+
+	z = powercap_register_zone(&ir->zone, scmi_top_pcntrl,
+				   instance_name, NULL, &instance_root_ops, 0,
+				   &instance_root_const_ops);
+
+	if (IS_ERR(z)) {
+		ret = PTR_ERR(z);
+		dev_err(dev, "Failed to register sysnthetic instance root: %d\n", ret);
+		return ret;
+	}
+
+	ir->registered = true;
+	ir->height = 0;
+	list_add_tail(&ir->node, &pr->registered_zones[0]);
+
 	/*
 	 * Scan array of retrieved SCMI powercap domains and register them
 	 * recursively starting from the root domains.
 	 */
 	ret = scmi_zones_register(dev, pr);
-	if (ret)
+	if (ret) {
+		scmi_powercap_unregister_all_zones(pr);
 		return ret;
+	}
 
 	INIT_LIST_HEAD(&pr->node);
 
 	ret = scmi_powercap_read_root_children_enable_state(pr, &pr->enabled);
-	if (ret)
+	if (ret) {
+		scmi_powercap_unregister_all_zones(pr);
 		return ret;
+	}
 
 	mutex_lock(&scmi_powercap_roots_lock);
 	list_add_tail(&pr->node, &scmi_powercap_roots);
-- 
2.34.1

