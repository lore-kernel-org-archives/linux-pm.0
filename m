Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BD445D917;
	Wed,  9 Sep 2026 22:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788991517; cv=none; b=OY5OcipvuFzpUPVNVQ/Cle/awhlyTjncTpcEHE2/7XD4RsRmYm17nsSdzp3xDrDYQog9pGtcQvFAoPHWFtAE5sR95veHPSz9LPUhxYeh51aR7gDBPAg3uOO0DaYvEbCiQSm8MH8t4ee0VMMFZAp02uFzBFCxxVMV1/U4rfr6FQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788991517; c=relaxed/simple;
	bh=ovY3D17i0dzC62cyd/v0yJIlVY4EtK0/HjoZ47MH1Xc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WPfDdUnXIMFdEQcxAQgz2MDHXM8DSVEiyu6E14/S+T3sY9bO9MN+P8Taj4dkFilnUehHJz9AHSb6m/hX9MKe4NrzzprSKVtIwbD0h9ACTJdB1Q/5nhNWZCp9RkpuPCmS8t17tcl8CN/qVRGVP0xfBPl05PqbeNULUT5cTzFMIHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=SenWt2di; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SenWt2di"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88A79169C;
	Wed,  9 Sep 2026 15:05:11 -0700 (PDT)
Received: from oss-apollo7005.lab.cambridge.arm.com (oss-apollo7005.lab.cambridge.arm.com [10.7.15.171])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18D433F7D8;
	Wed,  9 Sep 2026 15:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788991515; bh=ovY3D17i0dzC62cyd/v0yJIlVY4EtK0/HjoZ47MH1Xc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SenWt2diybd3TLYBfG9DVki/PK1URuv757wNGaKuBsoiZ8ft9KhLUN4O3YfuLgIG+
	 YdnoTd1UdgqeaPsMfW/Aq85Xp1Zh2JZM7BX/RoJRzwwT/jXMf16Enr8fwC0qzbmghP
	 khyHAO4LhvFNdIxeNYG9hxrBLfDiNwBQktV9R/yI=
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
	philip.radford@arm.com
Subject: [PATCH v9 11/13] powercap: arm_scmi: Create synthetic parent node for multi-instance
Date: Wed,  9 Sep 2026 22:04:35 +0000
Message-Id: <20260909220437.1254412-12-philip.radford@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260909220437.1254412-1-philip.radford@arm.com>
References: <20260909220437.1254412-1-philip.radford@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
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
V8->V9
- Removed redundant scmi_powercap_get_zone_height
- Added scmi_powercap_parent_name helper
- Replaced tiernary operator that checked empty parent->info->name
---
 drivers/powercap/arm_scmi_powercap.c | 110 +++++++++++++++++++++++----
 1 file changed, 96 insertions(+), 14 deletions(-)

diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
index bcd1ba0bde8c..b5397d7675e6 100644
--- a/drivers/powercap/arm_scmi_powercap.c
+++ b/drivers/powercap/arm_scmi_powercap.c
@@ -38,6 +38,7 @@ struct scmi_powercap_root {
 	struct scmi_powercap_zone *spzones;
 	struct list_head *registered_zones;
 	struct list_head scmi_zones;
+	struct scmi_powercap_zone instance_root;
 };
 
 static LIST_HEAD(scmi_powercap_roots);
@@ -443,29 +444,75 @@ static const struct powercap_zone_constraint_ops constraint_ops  = {
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
@@ -493,11 +540,14 @@ static int scmi_powercap_register_zone(struct scmi_powercap_root *pr,
 				   parent ? &parent->zone : NULL,
 				   &zone_ops, spz->info->num_cpli, &constraint_ops);
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
@@ -505,7 +555,7 @@ static int scmi_powercap_register_zone(struct scmi_powercap_root *pr,
 		dev_err(spz->dev,
 			"Error registering node:%s - parent:%s - h:%d - ret:%d\n",
 			spz->info->name,
-			parent ? parent->info->name : "ROOT",
+			scmi_powercap_parent_name(pr, parent),
 			spz->height, ret);
 	}
 
@@ -564,6 +614,8 @@ static int scmi_zones_register(struct device *dev,
 		struct scmi_powercap_zone *parent;
 
 		parent = scmi_powercap_get_parent_zone(spz);
+		if (!parent)
+			parent = &pr->instance_root;
 		if (parent && !parent->registered) {
 			zones_stack[sp++] = spz;
 			spz = parent;
@@ -604,8 +656,11 @@ static int scmi_powercap_probe(struct scmi_device *sdev)
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
@@ -633,7 +688,7 @@ static int scmi_powercap_probe(struct scmi_device *sdev)
 		return -ENOMEM;
 
 	/* Allocate for worst possible scenario of maximum tree height. */
-	pr->registered_zones = devm_kcalloc(dev, pr->num_zones,
+	pr->registered_zones = devm_kcalloc(dev, pr->num_zones + 1,
 					    sizeof(*pr->registered_zones),
 					    GFP_KERNEL);
 	if (!pr->registered_zones)
@@ -641,6 +696,9 @@ static int scmi_powercap_probe(struct scmi_device *sdev)
 
 	INIT_LIST_HEAD(&pr->scmi_zones);
 
+	for (i = 0; i <= pr->num_zones; i++)
+		INIT_LIST_HEAD(&pr->registered_zones[i]);
+
 	for (i = 0, spz = pr->spzones; i < pr->num_zones; i++, spz++) {
 		/*
 		 * Powercap domains are validate by the protocol layer, i.e.
@@ -660,7 +718,6 @@ static int scmi_powercap_probe(struct scmi_device *sdev)
 		spz->ph = ph;
 		spz->spzones = pr->spzones;
 		INIT_LIST_HEAD(&spz->node);
-		INIT_LIST_HEAD(&pr->registered_zones[i]);
 
 		list_add_tail(&spz->node, &pr->scmi_zones);
 		/*
@@ -678,19 +735,44 @@ static int scmi_powercap_probe(struct scmi_device *sdev)
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
2.25.1

